package com.lpc.service;

import com.lpc.mapper.DocsMapper;
import com.lpc.pojo.Docs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class DocsService {
    @Resource
    private DocsMapper docsMapper;
    /**
     * 向数据库表中插入文档信息
     * @param title
     * @param type
     * @param url
     * @param author
     * @return
     */
    public int insertDocs(String title, String type, String parentPath, String url, String author, boolean isFolder) {
        return docsMapper.insertDocsExtended(title, type, parentPath, url, author, isFolder);
    }


    /**
     * 根据用户名查询自己对应的文档
     * @param author
     * @return
     */
    public List<Docs> search(String author){
        return docsMapper.search(author);
    }

    /**
     *
     */
    public List<Docs> showAllusers(){return docsMapper.showALlusers();}
    /**
     * 根据id删除文档记录
     * @param id
     * @return
     */
    public int delDocs(int id){
        return docsMapper.delDocs(id);
    }

    public Docs getDocById(int id) {
        return docsMapper.getDocById(id);
    }

    public void updateDoc(Docs doc) {
        docsMapper.updateDoc(doc);  // 更新文档数据
    }

    public List<Docs> searchByParent(String author, String parentPath){
        return docsMapper.searchByParent(author, parentPath);
    }
    public int updateTitleById(int id, String newTitle) {
        return docsMapper.updateTitle(id, newTitle);
    }
    public Docs findById(int id) {
        return docsMapper.findById(id);
    }

    public int updateFolderInfo(int id, String newTitle, String newUrl) {
        return docsMapper.updateFolderInfo(id, newTitle, newUrl);
    }

    public int updateChildrenPath(String oldPrefix, String newPrefix) {
        return docsMapper.updateChildrenPath(oldPrefix, newPrefix);
    }

    public List<String> getAllFolders(String author) {
        List<String> urls = docsMapper.findAllFolderUrls(author);
        Set<String> folderSet = new HashSet<String>();
        // 🔧 手动加入用户根目录（如 /npc/）
        String rootPath = "/" + author + "/";
        folderSet.add(rootPath);


        for (String url : urls) {
            if (url != null && !url.trim().isEmpty()) {
                String folderPath = url;
                // 统一格式为结尾带 / 的目录路径
                if (!folderPath.endsWith("/")) {
                    folderPath += "/";
                }
                folderSet.add(folderPath);
            }
        }

        List<String> sorted = new ArrayList<String>(folderSet);
        Collections.sort(sorted);
        return sorted;
    }

}
