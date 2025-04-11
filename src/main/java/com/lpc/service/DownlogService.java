package com.lpc.service;

import com.lpc.mapper.DownlogMapper;
import com.lpc.pojo.Downlog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DownlogService {
    @Autowired
    private DownlogMapper downlogMapper;
    public int insertDownlog(String title,String author){
        return downlogMapper.inserDownlog(title,author);
    }

    public List<Downlog> downStat(String author){
        return downlogMapper.downStat(author);
    }
    public List<Downlog> getAllDownlogs() {
        return downlogMapper.getAllDownlogs();
    }

    public int deleteByAuthor(String author) {
        return downlogMapper.deleteByAuthor(author);
    }
}
