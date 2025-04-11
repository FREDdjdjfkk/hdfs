package com.lpc.mapper;

import com.lpc.pojo.Downlog;
import com.lpc.pojo.User;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface Usermapper {
    //用户注册
    @Insert("insert into user(account,pwd,name) value(#{account},#{pwd},#{name})")
    public int register(@Param("account") String acount,@Param("pwd") String pwd,@Param("name") String name);
    //账号唯一性
    @Select("select * from user where account=#{account}")
    public List<User> checkAccount(@Param("account")String account);
    //用户登录
    @Select("select * from user where account=#{account} and pwd=#{pwd}")
    public User login(@Param("account")String account,@Param("pwd") String pwd);

    /**
     * 根据账号获取用户信息
     * @param account 用户账号
     * @return 用户对象
     */
    @Select("SELECT * FROM user WHERE account = #{account}")
    User getUserByAccount(@Param("account") String account);

    /**
     * 更新用户信息（包括密码）
     * @param user 用户对象
     */
    @Update("UPDATE user SET account = #{account}, pwd = #{pwd}, name = #{name} WHERE id = #{id}")
    void updateUser(User user);

    // 查询所有用户
    @Select("SELECT * FROM user")
    List<User> getAllUsers();

    // 根据ID查询单个用户
    @Select("SELECT * FROM user WHERE id = #{id}")
    User findById(@Param("id") int id);


    // 删除用户
    @Delete("DELETE FROM user WHERE id = #{id}")
    int deleteUser(@Param("id") int id);


}
