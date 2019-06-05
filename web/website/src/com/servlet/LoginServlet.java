package com.servlet;

import java.io.IOException;
import java.net.InetAddress;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.james.user.lib.util.DigestUtil;

import com.DB.oracle.OracleUtil;
import com.DB.oracle.OracleUtilOrg;
import com.tools.Md5Encrypt;

public class LoginServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		
		String method	= request.getParameter("method");
		if(method.equalsIgnoreCase("login")){
			
			this.login(request,response);
		}else if(method.equalsIgnoreCase("logout")){
			this.logout(request,response);
		}else if(method.equalsIgnoreCase("singleLogin")){
			this.singleLogin(request, response);
		}else if(method.equalsIgnoreCase("changePassword")){
			this.changePassword(request,response);
		}else if (method.equalsIgnoreCase("recordThreeTimeWrong")) {
			this.recordThreeTimeWrong(request, response);
		}
	}

	private void changePassword(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			String userName	= request.getParameter("userName");
			String password = request.getParameter("password");
			System.out.println("userName ==== "+userName);
			String sName = (String) request.getSession().getAttribute("sName");
			String newPassword = request.getParameter("newPassword");
			String shaPassword = DigestUtil.digestString(newPassword, "SHA");
			Connection con	= OracleUtilOrg.createConnection();
			Statement stat	= con.createStatement();
			String sql =	"update  sa_opperson set sPassword = '"+password+"' , sHAPassword='" + shaPassword + "' where sLoginName='"+userName+"' or sLoginName = '"+userName.toUpperCase()+"'"; 
			stat.executeUpdate(sql);
			response.setContentType("text/html;UTF-8");
			response.getWriter().print("1");
			response.getWriter().flush();
			String ip = InetAddress.getLocalHost().getHostAddress();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date = df.format(new Date());
			String insertSql = "insert into sys_log(fid,version,fLoginDeptName,fLoginUserName,fLoginDateTime,fLoginType,fLoginState,fLoginIPAddress,fSysLogID,fFunName,fRemark)" +
								"select sys_guid(),0 , sName,'" + sName + "',TO_DATE(sysdate, 'YYYY-MM-DD HH:MI:SS'),'修改','完成','"+ ip +"','','更改密码','' from sa_oporg  where sid=(select sParent from sa_oporg where sName='" + sName + "')";
			stat.execute(insertSql);
			stat.close();
			con.close();
		}catch (SQLException e) {
			e.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
	}

	public void recordThreeTimeWrong(HttpServletRequest request, HttpServletResponse response) throws UnknownHostException{
			try {
				String userName = request.getParameter("userName");
				String realIP = InetAddress.getLocalHost().getHostAddress();
				Connection con	= OracleUtilOrg.createConnection();
				Statement stat	= con.createStatement();
				String sql = "insert into sys_log(FID,fLoginDeptName,fLoginUserName,fLoginDateTime,fLoginType,fLoginState ,fLoginIPAddress,fFunName,fRemark)"
						   + "select sys_guid(),'','"+userName+"',sysdate,'登录','失败','"+realIP+"','内网网站','登录内网网站连续失败三次，登录用户名为"+userName+"'";
				stat.execute(sql);
				stat.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
				
	}
	
	private void logout(HttpServletRequest request, HttpServletResponse response) {
		try {
			String realIP = InetAddress.getLocalHost().getHostAddress();
			String userName = (String) request.getSession().getAttribute("userName");
			Connection con	= OracleUtilOrg.createConnection();
			Statement stat = con.createStatement();
			String sName = (String) request.getSession().getAttribute("sName");
			String logoutSql = getSysLogSql(userName,sName, "0",realIP);
			System.out.println("logoutSql===="+logoutSql);
			stat.execute(logoutSql);
			request.getSession().invalidate();
//			request.getSession().setAttribute("bsessionid", null);
//			request.getSession().setAttribute("userName",null);
//			request.getSession().setAttribute("realName", null);
//			request.getSession().setAttribute("currentLevel",-1);
//			request.getSession().removeAttribute("bsessionid");
			System.out.println("logout bsessionid == " + request.getSession().getAttribute("bsessionid"));
			response.setContentType("text/html;UTF-8");
			response.getWriter().print("1");
			response.getWriter().flush();
			stat.close();
			con.close();
		}catch (SQLException e1) {
			e1.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	//获取真实IP地址
	public  String getIpAddr(HttpServletRequest request) {  
	    String ip = request.getHeader("x-forwarded-for");  
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("Proxy-Client-IP");  
	    }  
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getHeader("WL-Proxy-Client-IP");  
	    }  
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	        ip = request.getRemoteAddr();  
	    }  
	    
	    return ip;  
	} 
	
	private void login(HttpServletRequest request, HttpServletResponse response){

		try {
			String realIP = InetAddress.getLocalHost().getHostAddress();
			String bsessionid = request.getParameter("bsessionid");
			String userName	= request.getParameter("userName");
			//这里需要给密码加密,或者前台给密码加密也行
			String _password =	request.getParameter("password");
			String  password =	Md5Encrypt.md5Encrypt(_password);
			String newPassword = convertMD5(_password);
			String flag	= "org";
			Connection con	= OracleUtilOrg.createConnection();
			Statement stat	= con.createStatement();
			
			String sql =	"select * from sa_opperson where sLoginName='"+userName+"' or sLoginName = '"+userName.toUpperCase()+"'"; 
			
			System.out.println("userName-->"+userName);
			System.out.println("password-->"+password);
			
			ResultSet rs =	stat.executeQuery(sql);
			
			if(rs.next()){
				response.setContentType("text/html;UTF-8");
				
				if(rs.getString("sPassword").equalsIgnoreCase(password)){
					
					String sSafeLevelID	=	rs.getString("smsn");
					String sName = rs.getString("sName");
					int level=1;//普通
					
					if(sSafeLevelID!=null && !sSafeLevelID.equalsIgnoreCase("")){
						
						level=Integer.parseInt(rs.getString("smsn"));
					}
					
					request.getSession().setMaxInactiveInterval(10*60);	// 设置session失效时间（timeout），单位为秒
					request.getSession().setAttribute("userName",userName);
					request.getSession().setAttribute("_password",newPassword);
					request.getSession().setAttribute("sName",sName);
					request.getSession().setAttribute("password",password);
					request.getSession().setAttribute("realName", rs.getString("SNAME"));
					request.getSession().setAttribute("currentLevel",level);
					request.getSession().setAttribute("bsessionid", bsessionid);
					//request.getRequestDispatcher("index.jsp").forward(request, response);
					response.getWriter().print("1");
					//写日志
					String loginSql = getSysLogSql(userName,sName,"1",realIP);
					System.out.println(loginSql);
					System.out.println("login bsessionid == " + request.getSession().getAttribute("bsessionid"));
					stat.execute(loginSql);
				} else {
					//前台提示密码不正确
					System.out.println("//前台提示密码不正确");
					response.getWriter().print("2");
				}
			} else {
				System.out.println("///前台提示用户名不存在");
				//前台提示用户名不存在
				response.getWriter().print("3");
			}
			response.getWriter().flush();
			rs.close();
			stat.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private String getSysLogSql(String loginName, String sName, String flag ,String realIP){
		
		String sql = "insert into sys_log(FID,fLoginDeptName,fLoginUserName,fLoginDateTime,fLoginType,fLoginState ,fLoginIPAddress,fFunName)";
		
		//0 退出 1登录TO_DATE(sysdate, 'YYYY-MM-DD HH:MI:SS') 
		if("0".equals(flag)){
			sql += "select sys_guid(), sName,'" + sName + "',sysdate,'网站','注销', '"+ realIP +"','内网网站' from sa_oporg  where sid=(select sParent from sa_oporg where sName='" + sName + "')";
		}else{
			sql += "select sys_guid(), sName,'" + sName + "',sysdate,'网站','登录' ,'"+ realIP +"','内网网站' from sa_oporg  where sid=(select sParent from sa_oporg where sName='" + sName + "')";
		}
		
		return sql;
		
	}
	/**
	*加密解密算法执行一次加密，两次解密
	*/
	public static String convertMD5(String inStr) {
		char[] a = inStr.toCharArray();
		for (int i = 0; i < a.length; i++) {
			a[i] = (char) (a[i] ^ 't');
		}
		String s = new String(a);
		return s;
	}
 	private void singleLogin(HttpServletRequest request, HttpServletResponse response){
 		
 		String userName = request.getParameter("userName");
 		String token = request.getParameter("token");
 		//验证token有效性的方法
 		
 		if(token.contains("32ur")){
 			//以获取到用户身份登录
 		
 			try {
 				Connection con	= OracleUtil.createConnection();
 				Statement stat	= con.createStatement();
 	 			String sql="select * from sa_opperson where sLoginName='"+userName+"' or sLoginName = '"+userName.toUpperCase()+"'"; 
 	 	 		ResultSet rs=stat.executeQuery(sql);
 	 	 		if(rs.next()){
 	 	 		int level =Integer.parseInt(rs.getString("smsn"));
 	 			request.getSession().setAttribute("userName",userName);
 	 			request.getSession().setAttribute("realName", rs.getString("SNAME"));
 	 			request.getSession().setAttribute("currentLevel",level);
				request.getRequestDispatcher("/index.jsp").forward(request, response);}
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
 		}else{
 			//已游客身份进入首页
 			try {
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
 		}

 		
 		
 	}

}
