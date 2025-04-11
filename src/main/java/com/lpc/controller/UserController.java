package com.lpc.controller;

import com.lpc.pojo.User;
import com.lpc.service.DownlogService;
import com.lpc.service.HDFSService;
import com.lpc.service.UserService;
import com.lpc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
//@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private HDFSService hdfsService;
    @Autowired
    private DownlogService downlogService;
    @RequestMapping("reg")
    @ResponseBody
    public  String regiser(String account,String pwd,String repwd,String name){
        String msg="<script>alert('Success!');location.href='login.jsp'</script>";
        if (pwd.equals(repwd)){
            hdfsService.createDir(account);
            userService.register(account, pwd, name);
        }else{
            msg="<script>alter('Please check your password!');location.href='reg.jsp'</script>";
        }
        return msg;
    }

    /**
     * 账号唯一性检测
     * @param account
     * @return
     */
    @RequestMapping("checkAccount")
    @ResponseBody
    public  String checkAccount(String account){
        return userService.checkAccount(account);
    }

    /**
     * 用户登录
     * @param account
     * @param pwd
     * @param session
     * @return
     */
    @PostMapping("login")
    @ResponseBody
    public String login(String account, String pwd, HttpSession session){
        String msg="<script>alert('Login Success!');location.href='main.jsp';</script>";
        User user=userService.login(account,pwd);
        //判断user是否为空
        if(user!=null){
            session.setAttribute("account",user.getAccount());
            session.setAttribute("name",user.getName());
        }else{
            msg="<script>alert('Login Failure!');location.href='login.jsp';</script>";
        }
        return msg;
    }

    /**
     * 退出登录
     * @param session
     * @return
     */
    @RequestMapping("logout")
    @ResponseBody
    public String logout(HttpSession session){
        session.invalidate();
        String msg="<script>alert('Loginout Success!');location.href='login.jsp';</script>";
        return msg;
    }
    @RequestMapping("updatePassword")
    @ResponseBody
    public String updatePassword(@RequestParam("currentPassword") String currentPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 HttpSession session, Model model) {

        String account = (String) session.getAttribute("account");
        String msg = "<script>alert('Password modification successful!');window.top.location.href = 'login.jsp';</script>";
        // 获取当前用户
        User user = userService.getUserByAccount(account);

        // 检查当前密码是否正确
        if (!StringUtil.md5(currentPassword).equals(user.getPwd())) {
            model.addAttribute("error", "当前密码不正确！");
            msg="<script>alert('The current password is incorrect!');location.href='editPwd.jsp';</script>";
            return msg; // 当前密码不正确，返回修改密码页面
        }

        // 检查新密码和确认密码是否一致
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "新密码和确认密码不一致！");
            msg="<script>alert('The two passwords do not match!');location.href='editPwd.jsp';</script>";
            return msg; // 如果不一致，返回修改密码页面
        }

        // 更新密码
        user.setPwd(StringUtil.md5(newPassword)); // 加密存储新密码
        user.setId(user.getId());
        user.setName(user.getName());
        user.setAccount(user.getAccount());
        userService.updateUser(user);


        // 修改成功，跳转到登录页面，重新加载整个页面
        return msg;
    }


    /**
     * 查询用户列表，跳转到 userList.jsp
     */
    @RequestMapping("/list")
    public ModelAndView listAllUsers() {
        List<User> list = userService.getAllUsers();
        ModelAndView mv = new ModelAndView();
        // 相当于 request.setAttribute("userList", list)
        mv.addObject("userList", list);
        // 配合视图解析器时，只需写视图名即可，如 "userList"
        // 假设没有视图解析器，想直接转发到 /userList.jsp，可以写:
         mv.setViewName("forward:/userList.jsp");
        return mv;
    }

    /**
     * 添加新用户
     */
    @PostMapping("/add")
    public String addUser(String account, String pwd, String name) {
        userService.addUser(account, pwd, name);
        return "list";
    }

    /**
     * 删除用户
     */
    @RequestMapping("/deleteUser")
    public String deleteUser(int id) {
        userService.deleteUser(id);
        return "list";
    }

    /**
     * 获取用户
     */

    @RequestMapping("/getUserById")
    @ResponseBody
    public User getUserById(int id) {
        return userService.findById(id);
    }


    @PostMapping("/ajaxUpdateUser")
    @ResponseBody
    public String ajaxUpdateUser(@RequestBody User user) {
        if (user.getPwd() != null && !user.getPwd().isEmpty()) {
            user.setPwd(StringUtil.md5(user.getPwd()));
        } else {
            user.setPwd(null); // 忽略密码不更新
        }
        userService.updateUser(user);
        return "ok";
    }

}
