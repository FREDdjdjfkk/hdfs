package com.lpc.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lpc.pojo.Docs;
import com.lpc.service.DocsService;
import com.lpc.service.DownlogService;
import com.lpc.service.HDFSService;
import com.lpc.util.EncryptionUtil;
import com.lpc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.SpinnerUI;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;


@Controller
public class DocsController {
    @Autowired
    DocsService docsService;
    @Autowired
    private HDFSService hdfsService;
    @Autowired
    private DownlogService downlogService;

    @RequestMapping("upload")
    public String upload(@RequestParam("myfile") MultipartFile multipartFile,
                         String title,
                         String type,
                         String parentPath,
                         HttpSession session) {
        String account = (String) session.getAttribute("account");

        System.out.println("🎯 当前登录账号: " + account);
        System.out.println("📂 表单上传 parentPath = " + parentPath);

        // 1. 获取原始文件名
        String originalFilename = multipartFile.getOriginalFilename();
        if (originalFilename == null || originalFilename.isEmpty()) {
            System.out.println("❌ 上传失败：文件名为空！");
            return "search";
        }

        // 2. 加密后文件名
        String encryptedFilename = originalFilename + ".enc";

        // 3. 清洗路径：确保标准化
        if (parentPath == null || parentPath.trim().isEmpty()) {
            parentPath = "/";
        }
        if (!parentPath.startsWith("/")) {
            parentPath = "/" + parentPath;
        }
        if (!parentPath.endsWith("/")) {
            parentPath += "/";
        }

        // ✅ 输出清洗后的路径
        System.out.println("🧹 清洗后的 parentPath = " + parentPath);

        // 4. 拼接完整 HDFS 路径
        String hdfsPath = parentPath + encryptedFilename;
        System.out.println("📤 最终上传到 HDFS 路径: " + hdfsPath);

        try {
            InputStream in = multipartFile.getInputStream();
            InputStream encrypted = EncryptionUtil.encrypt(in);
            hdfsService.upload(hdfsPath, encrypted);
            System.out.println("✅ 文件加密上传成功");
        } catch (Exception e) {
            System.out.println("❌ 附件文档上传到HDFS文件系统时发生异常: " + e);
        }

        // 5. 拼接数据库路径
        String url = "/" + account + parentPath + encryptedFilename;
        String docParentPath = "/" + account + parentPath;

        System.out.println("📝 存入数据库的 docParentPath = " + docParentPath);
        System.out.println("📝 存入数据库的 url = " + url);

        docsService.insertDocs(title, type, docParentPath, url, account, false);

        // 6. 重定向回当前目录
        String redirectPath = "redirect:search?parentPath=" + parentPath;
        System.out.println("🔁 跳转路径: " + redirectPath);
        return redirectPath;
    }


    /**
     *
     * @param session
     * @param currentPath
     * @return
     */
    @RequestMapping("toUpload")
    public ModelAndView toUpload(HttpSession session,
                                 @RequestParam(required = false) String currentPath) {
        String account = (String) session.getAttribute("account");

        if (currentPath == null || currentPath.isEmpty()) {
            currentPath = "/" + account + "/";
        }

        List<String> pathList = docsService.getAllFolders(account);

        ModelAndView mv = new ModelAndView();
        mv.addObject("pathList", pathList);
        mv.addObject("currentPath", currentPath);
        mv.setViewName("upload.jsp");
        return mv;
    }

    /**
     * 查询文档
     * @param page
     * @param session
     * @return
     */
    @RequestMapping("search")
    public ModelAndView search(@RequestParam(required = false) String parentPath,
                               @RequestParam(defaultValue = "1") int page,
                               HttpSession session) {
        ModelAndView mv = new ModelAndView();
        String author = (String) session.getAttribute("account");

        // ✅ 动态构造 parentPath 默认值为 /账号/
        if (parentPath == null || parentPath.trim().isEmpty()) {
            parentPath = "/" + author + "/";
        }

        PageHelper.startPage(page, 10);
        List<Docs> docsList = docsService.searchByParent(author, parentPath);
        PageInfo<Docs> pageInfo = new PageInfo<Docs>(docsList);
        mv.addObject("list", docsList);
        mv.addObject("pageInfo", pageInfo);
        mv.addObject("currentPath", parentPath); // 用于分页时传回路径
        mv.setViewName("docList.jsp");
        return mv;
    }

    @RequestMapping("show")
    public ModelAndView showAllusers(@RequestParam(defaultValue = "1")int page,HttpSession session){
        ModelAndView mv=new ModelAndView();
        PageHelper.startPage(page,10);
        String author=(String) session.getAttribute("account");
        List<Docs>  docsList=docsService.showAllusers();
        PageInfo<Docs> pageInfo=new PageInfo<Docs>(docsList);
        mv.addObject("list",docsList);
        mv.addObject("pageInfo",pageInfo);
        mv.setViewName("docListadmin.jsp");
        return mv;
    }

    /**
     * 文档下载
     * @param filePath
     * @param response
     * @param session
     */
    @RequestMapping("down")
    public void down(String filePath, HttpServletResponse response,HttpSession session)  {
    //1.首先得到一个输入流
        InputStream in= hdfsService.down(filePath);

    //2.分批次读取输入流
        try {
            InputStream decrypted = EncryptionUtil.decrypt(in);  // ✅ 解密流
            byte[] b =  EncryptionUtil.readAllBytes(decrypted);
            //3获取文件的真实名字
            String fn = filePath.substring(filePath.lastIndexOf("/") + 1);
            // 移除 .enc 后缀
            String downloadName = fn.endsWith(".enc") ? fn.substring(0, fn.length() - 4) : fn;
            //4处理中文乱码
            String nfn = new String(downloadName.getBytes("UTF-8"), "ISO-8859-1");
            response.setHeader("Content-Disposition","attachment;filename="+nfn);
            //5.生成输出流
            ServletOutputStream out=response.getOutputStream();
            out.write(b);
            String author=(String) session.getAttribute("account");
            downlogService.insertDownlog(fn.substring(0,fn.indexOf(".")),author);
        }catch (Exception e){
            System.out.println("DocsController读取输入流发生异常"+e.toString());
        }
    }

    /**
     * 删除
     * @param id
     * @param filePath
     * @return
     */
    @RequestMapping("delete")
    public String delDocs(String id,String filePath){
        //1.先执行hdfs文件系统的删除
        hdfsService.delFile(filePath);
        //2.后执行数据库删除
        docsService.delDocs(Integer.parseInt(id));
        return "search";
    }

    @RequestMapping("deleteA")
    public String delDocsadmin(String id,String filePath){
        //1.先执行hdfs文件系统的删除
        hdfsService.delFile(filePath);
        //2.后执行数据库删除
        docsService.delDocs(Integer.parseInt(id));
        return "show";
    }

    @RequestMapping("updateDocument")
    @ResponseBody
    public String updateDocument(@RequestParam("id") int id,
                                 @RequestParam("title") String title,
                                 @RequestParam("type") String type) {
        Docs doc = docsService.getDocById(id);
        if (doc == null) {
            return "fail"; // 或返回 JSON 错误信息
        }

        doc.setTitle(title);
        doc.setType(type);
        docsService.updateDoc(doc);
        return "success";
    }


    @RequestMapping("editDocument")
    @ResponseBody
    public Docs editDocument(@RequestParam("id") int id) {
        return docsService.getDocById(id);
    }

    /**
     * 创建文件夹
     * @param folderName
     * @param parentPath
     * @param session
     * @return
     */
    @RequestMapping("createFolder")
    @ResponseBody
    public String createFolder(String folderName, String parentPath, HttpSession session){
        String account = (String) session.getAttribute("account");
        String fullPath = parentPath + folderName;
        try {
            hdfsService.createDir(fullPath);
            docsService.insertDocs(folderName, "文件夹", parentPath, fullPath, account, true); // isFolder=true
            return "<script>alert('The folder has been created successfully!');location.href='search';</script>";
        } catch (Exception e) {
            return "<script>alert('Creation failed:" + e.getMessage() + "');history.back();</script>";
        }
    }

    @RequestMapping("renameFolder")
    @ResponseBody
    public String renameFolder(int id, String newTitle) {
        try {
            // 1. 查询原始信息
            Docs oldDoc = docsService.findById(id);
            String oldUrl = oldDoc.getUrl();     // e.g. /npc/资料/
            String parentPath = oldDoc.getParentPath(); // e.g. /npc/

            String newUrl = parentPath + newTitle + "/";  // 新路径 e.g. /npc/新建文件夹/

            // 2. 重命名 HDFS 目录
            hdfsService.renameDir(oldUrl, newUrl);

            // 3. 更新当前记录 title 和 url
            docsService.updateFolderInfo(id, newTitle, newUrl);

            // 4. 更新子内容的 parent_path 和 url（前缀替换）
            docsService.updateChildrenPath(oldUrl, newUrl);

            return "ok";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
}
