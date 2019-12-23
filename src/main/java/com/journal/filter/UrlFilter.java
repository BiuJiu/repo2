package com.journal.filter;

import com.journal.bean.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class UrlFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // TODO Auto-generated method stub
        System.out.println("过滤器初始化");


    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // TODO 对全栈url进行过滤
        //将request和response对象强转为http类型
        HttpServletRequest req=(HttpServletRequest)request;
        HttpServletResponse resp = (HttpServletResponse)response;
        HttpSession session = req.getSession();


        //获取访问的地址
        String url = req.getRequestURI();

        //获取session中的对象判断是否登录
        //拦截所有的 .do 请求但不包含login
        //jsp文件已经放到web-inf下 不用过滤 只过滤 .do请求即可


        String[] urls = {"/login","/tologin","/json",".js",".css",".ico",".jpg",".png"};
        boolean flag = true;
        for (String str : urls) {
            if (url.indexOf(str) != -1) {
                flag =false;
                break;
            }
        }
        if(flag){
            //获取session
            User user=(User) session.getAttribute("USER");
            if(user==null){
                resp.sendRedirect("login");
                return;
            }
        }


        //继续执行过滤连的剩余部分
        chain.doFilter(req, resp);
    }

    @Override
    public void destroy() {
        // TODO Auto-generated method stub

    }


}
