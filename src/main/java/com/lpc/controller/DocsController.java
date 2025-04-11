package com.lpc.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lpc.pojo.Docs;
import com.lpc.service.DocsService;
import com.lpc.service.DownlogService;
import com.lpc.service.HDFSService;
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

    public String upload(@RequestParam("myfile")MultipartFile multipartFile,String title,String type,HttpSession session) {
        //先从session中获取当前用户
        String account=(String) session.getAttribute("account");
        //获取附件文件名称
        String filename=multipartFile.getOriginalFilename();
        //把附件文档上传到HDFS文件系统
        try {
            InputStream in=multipartFile.getInputStream();
            hdfsService.upload("/"+account+"/"+filename,in);
        }catch (Exception e){
            System.out.println("附件文档上传到HDFS文件系统时发生异常"+e.toString());
        }

        //把记录信息写入mysql
        docsService.insertDocs(title,type,"/"+account+"/"+filename,account);

        return "search";
    }

    /**
     * 查询文档
     * @param page
     * @param session
     * @return
     */
    @RequestMapping("search")
    public ModelAndView search(@RequestParam(defaultValue = "1")int page,HttpSession session){
        ModelAndView mv=new ModelAndView();
        PageHelper.startPage(page,10);
        String author=(String) session.getAttribute("account");
        List<Docs>  docsList=docsService.search(author);
        PageInfo<Docs> pageInfo=new PageInfo<Docs>(docsList);
        mv.addObject("list",docsList);
        mv.addObject("pageInfo",pageInfo);
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
            byte[] b=new byte[in.available()];
            //3获取文件的真实名字
            String fn=filePath.substring(filePath.lastIndexOf("/")+1);
            //4处理中文乱码
            String nfn=new String(fn.getBytes("UTF-8"),"ISO-8859-1");
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


}
