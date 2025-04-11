package com.lpc.service;

import com.lpc.mapper.Usermapper;
import com.lpc.pojo.Docs;
import com.lpc.pojo.User;
import com.lpc.util.StringUtil;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private Usermapper usermapper;
    @Autowired
    private DocsService docsService;
    @Autowired
    private DownlogService downlogService;
    @Autowired
    private HDFSService hdfsService;

    /**
     * 用户注册
     * @param account
     * @param pwd
     * @param name
     * @return
     */

    public  int register(String account,String pwd,String name){
        return  usermapper.register(account, StringUtil.md5(pwd), name);
    }

    /**
     * 注册账号唯一性检测
     * @param account
     * @return
     */
    public String checkAccount(String account){
        List<User> list= usermapper.checkAccount(account);
        if ((list.size()>0)){
            return "no";
        }else {
            return "yes";
        }
    }

    public User login(String account,String pwd){
        return usermapper.login(account,StringUtil.md5(pwd));
    }

    /**
     * 根据账号获取用户信息
     * @param account 用户账号
     * @return 用户对象
     */
    public User getUserByAccount(String account) {
        return usermapper.getUserByAccount(account);
    }

    /**
     * 更新用户信息（包括密码）
     * @param user 用户对象
     */
    public void updateUser(User user) {
        usermapper.updateUser(user);

    }

    // 获取所有用户
    public List<User> getAllUsers(){
        return usermapper.getAllUsers();
    }

    // 根据id查询用户
    public User findById(int id){
        return usermapper.findById(id);
    }

    // 更新用户


    // 删除用户
    public void deleteUser(int id) {
        User user = usermapper.findById(id);
        if (user != null) {
            String account = user.getAccount();

            // 1. 删除下载记录
            downlogService.deleteByAuthor(account);

            // 2. 获取文档并删除文件和记录
            List<Docs> docsList = docsService.search(account);
            for (Docs doc : docsList) {
                hdfsService.delFile(doc.getUrl());
                docsService.delDocs(doc.getId());
            }

            // 3. 删除 HDFS 用户目录
            hdfsService.delFile("/" + account);

            // 4. 删除用户
            usermapper.deleteUser(id);
            usermapper.deleteUser(id);
        }
    }

    // 添加用户
    public int addUser(String account, String pwd, String name){
        return usermapper.register(account, StringUtil.md5(pwd), name);
    }

}
