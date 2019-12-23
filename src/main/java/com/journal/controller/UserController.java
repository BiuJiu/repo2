package com.journal.controller;

import com.github.pagehelper.PageInfo;
import com.journal.bean.InfoDTO;
import com.journal.bean.Log;
import com.journal.bean.User;
import com.journal.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;

@Controller
public class UserController {
    @Autowired
    private UserService userService;
    private InfoDTO infodto = new InfoDTO();
    @ResponseBody
    @RequestMapping("/tologin")
    public InfoDTO login(@RequestParam(value = "name",required=false) String  name,
                         @RequestParam(value = "password",required=false) String password, HttpSession session, ModelMap map) throws NoSuchAlgorithmException {

        User user = userService.getUser(name);
        System.out.println(user+user.getName()+"呵呵呵呵呵呢广东省分散的");
        Date date = new Date(); //获取当前的系统时间。

        long daytime = date.getTime();

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd") ;
        String today = dateFormat.format(date);
        String time = dateFormat.format(user.getLast_login_error_time());

        MessageDigest md = MessageDigest.getInstance("md5");
        byte[] bytes = md.digest(password.getBytes());
        password = Base64.getEncoder().encodeToString(bytes);

        int id = user.getId();

        long times = 0;

        System.out.println(password+"password"+user.getPassword()+(password.equals(user.getPassword())));
        System.out.println("哈哈哈哈");
        if(user==null){
            infodto.setCode("101");
            infodto.setMsg("用户名不存在");
        }else if(user.getLast_login_error_times()>10&&time.equals(today)){
            infodto.setCode("102");
            infodto.setMsg("今日错误已达上限");
        }else if(!password.equals(user.getPassword())){
            if(time.equals(today)){
                times = user.getLast_login_error_times()+1;
            }else{
                times = 0;
            }
            System.out.println(times+"sdfdsf"+time+"sdf"+today);
            int res = userService.updateLoginInfo(id,times,daytime,0);

            infodto.setCode("103");
            infodto.setMsg("密码错误");
            if(res>0){
                System.out.println("密码错误,更新错误时间错误次数成功");
            }

        }else{
            long last_login_time = daytime;
            session.setAttribute("USER",user);
            int res = userService.updateLoginInfo(id,times,0,daytime);
            if(res>0){
                System.out.println("用户登录成功,更新登录时间成功");
            }
            infodto.setCode("200");
            infodto.setMsg("登录成功");
        }
       return infodto;
    }


    @RequestMapping(value={"/login","/"})
    public String loginPage(ServletRequest request, ServletResponse response){
        HttpServletRequest req=(HttpServletRequest)request;
//        HttpServletResponse resp = (HttpServletResponse)response;
        HttpSession session = req.getSession();
        User user=(User) session.getAttribute("USER");
        if(user==null){
            return "admin/user/login";
        }else{
            return "admin/log/index";
        }

    }


    @RequestMapping("/toUser")
    public ModelAndView getUserlist(@RequestParam(value = "pageNumber",defaultValue = "1") Integer pageNumber,
                         @RequestParam(value = "pageSize",defaultValue = "5") Integer pageSize,
                         @RequestParam String username){
        PageInfo<User> userinfo = userService.getUserList(pageNumber,pageSize,username);

        ModelAndView modelAndView = new ModelAndView("admin/user/user");
        modelAndView.addObject("pageinfo",userinfo);
        return modelAndView;
    }


    @RequestMapping("/toAddUser")
    public String toAddUser(ServletRequest request, ServletResponse response){
       return "admin/user/addUser";
    }
    @ResponseBody
    @RequestMapping("/addUser")
    public InfoDTO addUser(ServletRequest request, ServletResponse response,User user) throws NoSuchAlgorithmException, IOException {
        User userinfo = userService.getUser(user.getName());
        InfoDTO infoDTO = new InfoDTO();
        System.out.println(user.getName());
        if(userinfo!=null){
            infoDTO.setCode("101");
            infoDTO.setMsg("用户名已存在");
            System.out.println("用户名已存在");
            return infoDTO;
        }else{
            int num =  (int)((Math.random()*9+1)*100000);
            String pwd = String.valueOf(num);
            MessageDigest md = MessageDigest.getInstance("md5");
            byte[] bytes = md.digest(pwd.getBytes());
            String password = Base64.getEncoder().encodeToString(bytes);
            user.setAdd_time(new Date().getTime());
            user.setPassword(password);
            int res = userService.addUser(user);
            System.out.println("哈哈哈哈哈");
            if(res>0){
                infoDTO.setCode("200");
                infoDTO.setMsg("添加成功，密码为:"+num);
                return infoDTO;
            }else{
                infoDTO.setCode("102");
                infoDTO.setMsg("添加失败,请立即联系管理员");
                return infoDTO;
            }
        }
    }
    @RequestMapping("/delUser")
    public String delUser(ServletRequest request, ServletResponse response,@RequestParam String id,@RequestParam Integer pageNumber, @RequestParam String username) throws NoSuchAlgorithmException {
        int res = userService.delUser(id);

        if(res>0){
            return "redirect:/toUser?pageNumber="+pageNumber+"&username="+username;
        }else{
            return "redirect:/toUser?pageNumber="+pageNumber+"&username="+username;
        }
    }
    @RequestMapping("/cleanError")
    public String clearError(ServletRequest request, ServletResponse response,@RequestParam String id,@RequestParam Integer pageNumber, @RequestParam String username) {
        int res = userService.cleanError(id);

        if(res>0){
            return "redirect:/toUser?pageNumber="+pageNumber+"&username="+username;
        }else{
            return "redirect:/toUser?pageNumber="+pageNumber+"&username="+username;
        }
    }

    @RequestMapping("/toUpdatePwd")
    public String toUpdatePwd(ServletRequest request, ServletResponse response, User user){
      return "admin/user/updatePwd";
    }

    @RequestMapping("/updatePwd")
    @ResponseBody
    public InfoDTO updatePwd(ServletRequest request, ServletResponse response, @RequestParam String password,@RequestParam String new_password) throws NoSuchAlgorithmException {
        InfoDTO info = new InfoDTO();
        HttpServletRequest req=(HttpServletRequest)request;
        HttpSession session = req.getSession();

        User userinfo=(User) session.getAttribute("USER");

        MessageDigest md = MessageDigest.getInstance("md5");

        byte[] bytes = md.digest(password.getBytes());
        password = Base64.getEncoder().encodeToString(bytes);
        System.out.println(userinfo.getPassword()+"密码"+password);

        System.out.println("password"+password+"newPassword");
        if(userinfo.getPassword().equals(password)){

            byte[] new_bytes = md.digest(new_password.getBytes());
            new_password = Base64.getEncoder().encodeToString(new_bytes);
            userinfo.setPassword(new_password);

            int res = userService.updatePwd(userinfo);
            if(res>0){
                info.setCode("200");
                info.setMsg("更新密码成功");
                return info;
            }else{
                info.setCode("100");
                info.setMsg("更新密码失败");
                return info;
            }
        }else{
            info.setCode("101");
            info.setMsg("原始密码错误");
            return info;
        }

    }

    @RequestMapping("/logout")
    public String logout(ServletRequest request, ServletResponse response, Log log){
        HttpServletRequest req=(HttpServletRequest)request;
        HttpSession session = req.getSession();
        session.removeAttribute("USER");

        return "redirect:login";
    }
}
