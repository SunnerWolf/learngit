package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class EncodingFilter implements Filter{

	protected FilterConfig filterConfig = null; 
    protected String encoding = ""; 

	public void init(FilterConfig config) throws ServletException {
	 	 this.filterConfig = config; 
		 this.encoding = this.filterConfig.getInitParameter("encoding"); 
		 if(this.encoding.equalsIgnoreCase("")){
			this.encoding="UTF-8";
		 }
}
    
	public void doFilter(ServletRequest request, ServletResponse response,FilterChain chain) throws IOException, ServletException {
		//请求过滤
		request.setCharacterEncoding(encoding);
		response.setCharacterEncoding(encoding);
		//如果后台向前台传了别的类型,如xml,则自己覆盖为("xml/html;UTF-8");
		response.setContentType("text/html;"+encoding);
		chain.doFilter(request, response);
		
		//响应过滤
	}
	
	public void destroy() {
		 filterConfig = null; 
	     encoding = null; 
	}
}
