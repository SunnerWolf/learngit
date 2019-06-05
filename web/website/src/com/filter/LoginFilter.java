package com.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter{

    protected FilterConfig filterConfig = null; 
    private String redirectURL = null; 
    //如果某些网址不需要过滤,则写在这个list中或者写在initParam中,再用代码判断下
    //private List notCheckURLList = new ArrayList(); 

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) 
            throws IOException, ServletException { 
        HttpServletRequest request = (HttpServletRequest) servletRequest; 
        HttpServletResponse response = (HttpServletResponse) servletResponse; 
        HttpSession session = request.getSession(); 
        
        //不允许同一客户端登录多个用户
        String userName	= (String)session.getAttribute("userName");
       
        if(null==userName || "".equalsIgnoreCase(userName)){
        	if(request.getRequestURI().contains("/website/login")){//用户正在登陆
         		//验证密码
         		//正确则加入usersMap中
         		filterChain.doFilter(request, response); 
         	}else{
         		//用户未登录,不显示文档
            	session.setAttribute("currentLevel", -1);//没有权限
            	filterChain.doFilter(request, response); 
         	}
        }else{//已经登陆过
             	filterChain.doFilter(request, response); 
        }
    } 

    public void destroy() { 
    	
    } 

    public void init(FilterConfig filterConfig) throws ServletException { 
        this.filterConfig = filterConfig; 
    } 
}
