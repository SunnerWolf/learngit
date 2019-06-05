package com.DB.access;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.UUID;

import com.DB.oracle.OracleUtil;

public class AccessUtil {

	String url = "jdbc:odbc:driver={Microsoft Access Driver (*.mdb)};DBQ=D:\\login.mdb";
	
	public Connection createConnection(){
		
		try {
			java.lang.Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			java.util.Properties pro = new java.util.Properties();
			pro.setProperty("charSet", "GB2312");//只有gb2312才能在这个login.mdb中取出正常的中文
			pro.setProperty("user", "admin");
			pro.setProperty("password", "baomijukejichu5366");
			java.sql.Connection con = java.sql.DriverManager.getConnection(url, pro);
			return con;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	//将login.mdb中news1表的数据导入oracle中的news1表
	public static void main(String[] args) throws Exception {
		
		AccessUtil access =new AccessUtil();
		Connection access_con=access.createConnection();
		Statement  access_stat=access_con.createStatement();
		ResultSet  access_rs=access_stat.executeQuery("select * from news1 ");
		
		OracleUtil oracle=new OracleUtil();
		Connection oracle_con=OracleUtil.createConnection();
		//为防止字符串字段的值中出现'',这里应该使用PrepareStatement;还好没报错,等勤快的人更新.
		while(access_rs.next()){
			String fid=UUID.randomUUID().toString();
			Statement oracle_stat=oracle_con.createStatement();
			String sql="insert into WEB_NEWS1 (fid, fNewsId , fTitle , fFirstMenu , fSecondMenu , fDepartment , fSource , fTime1 , fImageOrNot , fContent , fImage1 , fFlag, version ) " +
					"values ('"+fid+"',"+access_rs.getInt("NewsId")+",'"+access_rs.getString("Title")+"','"+access_rs.getString("FirstMenu")+"','"+access_rs.getString("SecondMenu")+"'" +
							",'"+access_rs.getString("Department")+"','"+access_rs.getString("Source")+"','"+access_rs.getString("Time1")+"','"+access_rs.getString("ImageOrNot")+"'," +
							"'"+access_rs.getString("Content")+"','"+access_rs.getString("Image1")+"','"+access_rs.getString("Flag")+"',0)";
			try{
				oracle_stat.execute(sql);
			}catch(SQLException e){
				//content内容太长的时候会导致整个sql语句报错:'字符串文字太长';
				//如果使用预编译,插入中文时又会出现LONG类型错误,原因不明
				e.printStackTrace(); 
			}
			oracle_stat.close();
		}
	} 
}

/**
 * 	create table news1
(
  fid        varchar2(100),
  NewsId     number,
  Title      varchar2(200),
  FirstMenu  varchar2(100),
  SecondMenu varchar2(100),
  Department varchar2(100),
  Source     varchar2(200),
  Time1      varchar2(100),
  ImageOrNot varchar2(100),
  Content    varchar2(4000),
  Image1     varchar2(200),
  Flag       varchar2(50),
  Version    number default 0
)
 */
