package com.DB.oracle;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class OracleUtil {
	
	static String url; //orcl为数据库的SID
	static String userName;
	static String password;
	static String driver;
	
	static {
		try {
			SAXReader reader = new SAXReader();
			
			//本地Application测试
			//Document document = reader.read(System.getProperty("user.dir")+"\\src\\dataSource.xml");
			java.net.URL pathUrl = OracleUtil.class.getResource("../../../dataSource.xml");
			Document document = reader.read(pathUrl);
			Element driverElement=(Element)document.selectNodes("//driver").get(0);
			Element urlElement=(Element)document.selectNodes("//url").get(0);
			Element usernameElement=(Element)document.selectNodes("//username").get(0);
			Element passwordElement=(Element)document.selectNodes("//password").get(0);
			driver=driverElement.getText();

			System.out.println("driver==="+driver);
			
			url=urlElement.getText();
			
			System.out.println("url==="+url);
			
			userName=usernameElement.getText(); 
			
			System.out.println("userName==="+userName);
			password=passwordElement.getText();
			System.out.println("password=="+password);
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}
	}
	

	
	public static Connection createConnection(){
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
			return DriverManager.getConnection(url,userName,password);
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	
	//测试程序
	public static void main(String[] args) throws SQLException {
		
		OracleUtil oracle=new OracleUtil();
		Connection con=OracleUtil.createConnection();
		Statement stat=con.createStatement();
		ResultSet rs=stat.executeQuery("select count(*) as c from sa_oprole");
		if(rs.next()){
			
		}
		
	}
}
