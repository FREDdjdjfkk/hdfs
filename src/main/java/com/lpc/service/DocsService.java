package com.lpc.service;

import com.lpc.mapper.DocsMapper;
import com.lpc.pojo.Docs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

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
    public int insertDocs(String title,String type,String url,String author){
        int i=docsMapper.insertDocs(title, type, url, author);
        return i;
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

}
