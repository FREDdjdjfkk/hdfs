package com.lpc.controller;

import com.lpc.pojo.Downlog;
import com.lpc.service.DownlogService;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DownlogController {
    @Autowired
    private DownlogService downlogService;

    @RequestMapping("chart")
    @ResponseBody
    public Map chart(HttpSession session){
        String author=(String)session.getAttribute("account");
        List<Downlog> list=downlogService.downStat(author);

        //将横纵坐标放到数组

        String[] btArr=new String[list.size()];
        Integer[] numArr=new Integer[list.size()];

        int i=0;
        for(Downlog dl:list){
            btArr[i]=dl.getTitle();
            numArr[i]=dl.getNum();
            i++;
        }
        //定义一个map对象将两个数组存入
        Map<String,Object> map=new HashMap<String, Object>();
        map.put("bts",btArr);
        map.put("nums",numArr);
        return map;
    }

    @RequestMapping("downlogAll")
    @ResponseBody
    public List<Downlog> downlogAll() {
        return downlogService.getAllDownlogs();
    }

}
