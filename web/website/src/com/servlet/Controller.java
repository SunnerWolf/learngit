package com.servlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.Reader;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.DOMException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.DB.oracle.OracleUtil;
import com.DB.oracle.OracleUtilOrg;

public class Controller extends HttpServlet {
	private String result = "";
	
	private String div = "<div>";
	
	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String method = request.getParameter("method");

		if ("loadNews".equalsIgnoreCase(method)) {

			this.loadNews(request, response);
		} else if ("loadListPage".equalsIgnoreCase(method)) {
			this.loadListPage(request, response);
		} else if ("loadContentPage".equalsIgnoreCase(method)) {
			this.loadContentPage(request, response);
		}
	}
	  
	private void loadContentPage(HttpServletRequest request,
			HttpServletResponse response) {
		Connection con = OracleUtil.createConnection();
		int level = this.getCurrentLevel(request);
		String fID = request.getParameter("fID");
		result = "";
		try {
			Statement stat = con.createStatement();
//			String sql = "select * from WEB_NEWS where fid='" + fID // 改
//					+ "' and fSafeLevelCode <= " + level; // 改
			String sql = "select * from WEB_NEWS where fid='" + fID + "'" ; // 改
			ResultSet rs = stat.executeQuery(sql);
			String xmlData = this.returnFromRs(rs, stat, con, "content", null);
			request.setAttribute("xmlData", xmlData);
			request.getRequestDispatcher("contentPage.jsp").forward(request,
					response);
			rs.close();
			stat.close();
			con.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static int currentPage = 1;
	public static int totalPage = 0;

	private void loadListPage(HttpServletRequest request,
			HttpServletResponse response) {
		int level = getCurrentLevel(request);
		try {
				
			String fMenuCode = request.getParameter("fMenuCode");
			
			System.out.println("fMenuCode=="+fMenuCode);
			request.getSession().setAttribute("fMenuCode", fMenuCode); // 改
			String isDirect = request.getParameter("isDirect");
			if (null == isDirect || "".equalsIgnoreCase(isDirect)) {
				// 使用ajax或其他使用了转码的功能就能正确接到正确的值
				fMenuCode = request.getParameter("fMenuCode");
			} else {
				// 使用url直接传递中文,中文的编码会变成iso-8859-1编码
				fMenuCode = new String(request.getParameter("fMenuCode")
						.getBytes("iso-8859-1"), "utf-8");

			}
			System.out.println("fMenuCode=="+fMenuCode);
			String action = request.getParameter("action");
			String name = request.getParameter("name");
			if(null != name && !"".equalsIgnoreCase(name)){
				if("保密宣传".equals(name)){
					fMenuCode="MENU001";
				}else if ("保密科技".equals(name)){
					fMenuCode="MENU002";
				}else if ("政策法规".equals(name)){
					fMenuCode="MENU003";
				}else if ("监督检查".equals(name)){
					fMenuCode="MENU004";
				}else if ("测评审批".equals(name)){
					fMenuCode="MENU005";
				}else if ("服务保障".equals(name)){
					fMenuCode="MENU006";
				}else if ("保密工作".equals(name)){
					fMenuCode="MENU007";
				}else if ("工作动态".equals(name)){
					fMenuCode="MENU008";
				}else if ("公告".equals(name)){
					fMenuCode="MENU009";
				}else if ("图片新闻".equals(name)){
					fMenuCode="MENU010";
				}else if ("改革最强音".equals(name)){
					fMenuCode="MENU013";
				}else if ("党建工作专栏".equals(name)){
					fMenuCode="MENU014";
				}else if ("精神文明专栏".equals(name)){
					fMenuCode="MENU015";
				}else if ("群众路线专栏".equals(name)){
					fMenuCode="MENU016";
				}else if ("自治区动态".equals(name)){
					fMenuCode="MENU111";
				}else if ("地州市动态".equals(name)){
					fMenuCode="MENU112";
				}
			} 
			System.out.println("name=="+name);
			Connection con = OracleUtil.createConnection();
			System.out.println("action=="+action);
			totalPage = this.getCount(con, fMenuCode);
			System.out.println("totalPage=="+totalPage);
			if ("firstPage".equalsIgnoreCase(action)) {
				currentPage = 1;
			} else if ("lastPage".equalsIgnoreCase(action)) {
				currentPage = totalPage;
			} else if ("nextPage".equalsIgnoreCase(action)) {
				if (currentPage == totalPage) {
					return;
				} else {
					currentPage += 1;
				}
			} else if ("previousPage".equalsIgnoreCase(action)) {
				if (currentPage == 1) {

				} else {
					currentPage -= 1;
				}
			} else{
				currentPage = Integer.parseInt(action);
			}
			
			// 分页查询
			String pageSize = "15";
			String sql = " select n.* from "
				+ " (select news.*,rownum aa from WEB_NEWS news where news.fMenuCode='" // 改
				+ fMenuCode + "' " + " and news.fFlowState='已完成' " 
				+ " and rownum <= " + currentPage + "*" + pageSize
				+ " order by  FTOPCODE desc , FCREATEDATE desc) n" + " where n.aa > ("
				+ currentPage + "-1)*" + pageSize;


			// 改
			Statement stat = con.createStatement();
			System.out.println("此处此处此处sql====="+sql);
			ResultSet rs = stat.executeQuery(sql);
			String xmlData = this.returnFromRs(rs, stat, con, "list", fMenuCode);
			if (xmlData.length() == 60) {// 没取出新闻
				xmlData = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><xml><fMenuCode menu=\""
						+ fMenuCode + "\"></fMenuCode></xml>";
			}
			if (null != isDirect) {
				request.setAttribute("xmlData", xmlData);
				request.setAttribute("totalPage", totalPage);
				request.getRequestDispatcher("listPage.jsp").forward(request,
						response);
			} else {
				response.setContentType("xml/html;UTF-8");
				response.getWriter().print(xmlData);
				response.getWriter().flush();
			}
			rs.close();
			stat.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void loadNews(HttpServletRequest request,
			HttpServletResponse response) {

		Connection con = OracleUtil.createConnection();
		int level = this.getCurrentLevel(request);
		try {
			Statement stat = con.createStatement();
			String dbtype="";
			String sql ;
			if("mysql".equals(dbtype)){
				 sql = "SELECT  top 300 fID,FMENUNAME,FMENUCODE,FNEWSCONTENT,FNEWSTITLE,FSAFELEVELCODE,FCREATEDEPTID,FCREATEDEPTNAME,FCREATEPERSONNAME,FCREATEDATE,FNEWSID, FTOPCODE FROM WEB_NEWS  where  FSAFELEVELCODE <= "
					+ level + "  order by FTOPCODE desc ";
				
			} else {
				
//				 sql = "SELECT fID,FMENUNAME,FMENUCODE,FNEWSCONTENT,FNEWSTITLE,FSAFELEVELCODE,FCREATEDEPTID,FCREATEDEPTNAME,FCREATEPERSONNAME,FCREATEDATE,FNEWSID, FTOPCODE FROM WEB_NEWS  where ROWNUM <300 and fFlowState='已完成'and FSAFELEVELCODE <= "
//					+ level + "  order by FTOPCODE desc ,FCREATEDATE desc ";
				 sql = "SELECT fID,FMENUNAME,FMENUCODE,FNEWSCONTENT,FNEWSTITLE,FSAFELEVELCODE,FCREATEDEPTID,FCREATEDEPTNAME,FCREATEPERSONNAME,FCREATEDATE,FNEWSID, FTOPCODE FROM WEB_NEWS  where ROWNUM <300 and fFlowState='已完成'"
					  + "  order by FTOPCODE desc ,FCREATEDATE desc "; 
			}
			System.out.println("此处sql====="+sql);
			ResultSet rs = stat.executeQuery(sql);
			String xmlData = this.returnFromRs(rs, stat, con, "index", null);
			System.out.println("~~~~"+xmlData);
			response.setContentType("text/xml;charset=UTF-8");
			response.getWriter().print(xmlData);
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

	public Document createDoc() {
		try {
			DocumentBuilderFactory factory = DocumentBuilderFactory
					.newInstance();
			DocumentBuilder builder;
			builder = factory.newDocumentBuilder();
			Document doc = (Document) builder.newDocument();
			return doc;
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
			return null;
		}
	}

	public String docToString(Document doc) {
		// JDK中没有对doc.toString()方法进行详细重写,所以无法输出正确的字符串
		// 下面是document对象转化成为字符串的方法
		TransformerFactory tf = TransformerFactory.newInstance();
		Transformer t;
		try {
			t = tf.newTransformer();
			// 这个设置有时不起作用,生成的中文仍然是GBK的,导致xml无法被正确解析,还得用前台解析
			t.setOutputProperty("encoding", "UTF-8");
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			t.transform(new DOMSource(doc), new StreamResult(bos));
			return bos.toString();
		} catch (TransformerConfigurationException e) {
			e.printStackTrace();
		} catch (TransformerException e) {
			e.printStackTrace();
		}
		return null;
	}

	public String returnFromRs(ResultSet rs, Statement stat, Connection con,
			String action, String fMenuCode)  {
		Document doc = this.createDoc();
		Element news = doc.createElement("xml");
		try {
			if (rs.next()) {
				do {
					fMenuCode = rs.getString("fMenuCode"); // 改
					// 没找到简单方法,,,doc.getElementById()没用明白...等待简化方法
					org.w3c.dom.NodeList nodes = news
							.getElementsByTagName("fMenuCode");
					Element firstMenuElement = null;
					// 判读是否已经存在这个FirstMenu节点
					boolean exist = false;
					for (int i = 0; i < nodes.getLength(); i++) {
						Element temp = (Element) nodes.item(i);
						if ((temp.getAttribute("fMenuCode")).equals(fMenuCode)) {
							firstMenuElement = (Element) temp;
							exist = true;
							break;
						}
					}
					if (!exist) {// 不存在则新建一个
						firstMenuElement = doc.createElement("fMenuCode"); // 改
					}
					firstMenuElement.setAttribute("fMenuCode", fMenuCode);
					firstMenuElement.setIdAttribute("fMenuCode", true);
					String fIsTop = null;
					if("MENU010".equals(fMenuCode)){
						
						String a =	rs.getString("fNewsContent");
						Clob clob = rs.getClob("fNewsContent");
						// 使用getCharacterStream方法获得Clob列的数据.
						Reader reader = clob.getCharacterStream();
						StringWriter sWriter = new StringWriter();
						int j = -1;
						while ((j = reader.read()) != -1) {
							sWriter.write(j);
						}
						// 显示Clob列的数据.
						String finalClob = new String(sWriter.getBuffer());
						String src = finalClob;
						
						if(src.indexOf("src=\"") != -1){
							fIsTop = src.substring(src.indexOf("src=\"") + 5, src.indexOf("defaultDocNameSpace")+19);
						}
					}
					Element _new = doc.createElement("new");
					if ("content".equalsIgnoreCase(action)) {
							
						Clob clob = rs.getClob("fNewsContent");
						Clob clobPic = rs.getClob("fImageOrNot");
					
						if(null!=clobPic){
							Reader readerPic = clobPic.getCharacterStream();
							StringWriter sWriterPic = new StringWriter();
							int m = -1;
							while ((m = readerPic.read()) != -1) {
								sWriterPic.write(m);
							}
							String finalClobPic = new String(sWriterPic.getBuffer());
							_new.setAttribute("contentPic", finalClobPic); // 附件clob存到内容列
						}
						// 使用getCharacterStream方法获得Clob列的数据.
						Reader reader = clob.getCharacterStream();
						StringWriter sWriter = new StringWriter();
						int j = -1;
						while ((j = reader.read()) != -1) {
							sWriter.write(j);
						}
						// 显示Clob列的数据.
						String finalClob = new String(sWriter.getBuffer());
						//处理描述信息
						if(finalClob.indexOf("defaultDocNameSpace") != -1){
							finalClob = subStringStr(finalClob);
						_new.setAttribute("content", finalClob); // 将解析出来的clob存到内容列
						} else {
							_new.setAttribute("content", finalClob); // 将解析出来的clob存到内容列
						}
					}
					_new.setAttribute("fID", rs.getString("fID"));
					_new.setAttribute("picSrc", fIsTop); // 将解析出来的图片路径 存到内容列
					_new.setAttribute("fCreateDeptName", rs.getString("fCreateDeptName"));
					_new.setAttribute("fCreateDeptID", rs.getString("fCreateDeptID"));
					_new.setAttribute("fCreateDate", rs.getString("fCreateDate"));
					_new.setAttribute("fNewsTitle", rs.getString("fNewsTitle"));
					int titleSize = 0;
					String str = rs.getString("fNewsTitle");
					System.out.println(rs.getString("fCreateDate"));
					byte titleSizes [] = str.getBytes();
					String shortTitle = str;
					if("MENU010".equals(fMenuCode)){
						//图片新闻
						titleSize = 20;
					} else if ("MENU008".equals(fMenuCode) || "MENU111".equals(fMenuCode) || "MENU112".equals(fMenuCode)){
						//动态
						titleSize = 43;
					}else if("MENU009".equals(fMenuCode)){
						titleSize = 28;
					}else{
						//其他模块
						titleSize = 26;
					}
					
					if(titleSizes.length > titleSize){
						shortTitle = getShortTitleName(str,titleSize);
					}
					System.out.println("fNewsTitle标题==="+rs.getString("fNewsTitle"));
					_new.setAttribute("fNewTitle", rs.getString("fNewsTitle"));
					_new.setAttribute("shortTitle", shortTitle);
					_new.setAttribute("fCreatePerson", rs.getString("FCREATEPERSONNAME"));
					_new.setAttribute("fMenuName", rs.getString("fMenuName"));
//					int fNewsID = (Integer) rs.getInt("fNewsID");
//					_new.setAttribute("fNewsId", "" + fNewsID);
					_new.setAttribute("fSafeLevelCode", rs.getString("fSafeLevelCode"));
					firstMenuElement.appendChild(_new);
					news.appendChild(firstMenuElement);

				} while (rs.next());
					doc.appendChild(news);
					// doc对象转化成为字符串
					String xmlStr = docToString(doc);
	
					return xmlStr;
			} else {

				String xmlStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><xml><fMenuCode menu=\""
						+ fMenuCode + "\"/></xml>";

				return xmlStr;
			}

		} catch (DOMException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "";
	}
	
	public String subStringStr(String str) {
		String finalDescription = "";
		String contentPart = ""; // 正文片段
		String str1 = "";
		String imgPath = "";
		String index = "";
		Connection x5Conn = OracleUtilOrg.createConnection();

		try {
			Statement x5Stat = x5Conn.createStatement();
			String strGroup[] = str.split("<img ");
			for (int i = 0; i <= strGroup.length - 1; i++) {
				str1 = strGroup[i];
				int b = str1.indexOf("defaultDocNameSpace");
				if (i != 0) {
					str1 = "<img " + str1;
					int len = str1.indexOf("defaultDocNameSpace");
					String pre = str1.substring(0, len + 22);
					contentPart = str1.substring(len + 22, str1.length());// 取出的正文
					len = pre.lastIndexOf("<");

					imgPath = pre.substring(len, pre.length());// 截出来的img
					index = imgPath.substring(imgPath.lastIndexOf("=") + 1,
							imgPath.lastIndexOf("-")); // 截出来的数字
					// 执行查询描述
					String sql = "select sDescription from SA_DocNode where sFileID= '"
							+ index + "-defaultDocNameSpace'";
					ResultSet rs = x5Stat.executeQuery(sql);

					if (rs.next()) {
						Clob description = rs.getClob("sDescription");

						if (null != description && !"".equals(description)) {
							Reader readerFile = description
									.getCharacterStream();
							StringWriter sWriterFile = new StringWriter();
							int k = -1;

							while ((k = readerFile.read()) != -1) {
								sWriterFile.write(k);
							}
							// 显示Clob列的数据.
							finalDescription = new String(sWriterFile
									.getBuffer());
						}
					}
					String check = finalDescription.toUpperCase();

					if (check.indexOf(".JPG") != -1
							|| check.indexOf(".GIF") != -1
							|| check.indexOf(".PNG") != -1
							|| check.indexOf(".BMP") != -1
							|| check.indexOf(".JPE") != -1) {

						String ee = finalDescription.substring(finalDescription
								.indexOf(".") + 1, finalDescription
								.indexOf(".") + 4);

						if ("jpg".equalsIgnoreCase(ee)
								|| "gif".equalsIgnoreCase(ee)
								|| "png".equalsIgnoreCase(ee)
								|| "bmp".equalsIgnoreCase(ee)) {
							result += div + "<div style=" + '"'
									+ "text-align:center; text-indent:0em;"
									+ '"' + ">" + imgPath + "</div>"
									+ contentPart + "</div>";
							System.out.println();
						} else if ("jpe".equalsIgnoreCase(ee)) {

							String ff = finalDescription.substring(
									finalDescription.indexOf(".") + 1,
									finalDescription.indexOf(".") + 5);

							if ("jpeg".equalsIgnoreCase(ff)) {
								result += div + "<div style=" + '"'
										+ "text-align:center; text-indent:0em;"
										+ '"' + ">" + imgPath + "</div>"
										+ contentPart + "</div>";
							}
						}
					} else {
						result += div + "<div style=" + '"'
								+ "text-align:center; text-indent:0em;" + '"'
								+ ">" + imgPath + "<p>" + finalDescription
								+ "</p>" + "</div>" + contentPart + "</div>";
					}

					rs.close();
				} else {
					result += str1;
				}
			}

			x5Stat.close();
			x5Conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}

	
	public String getShortTitleName(String title,int titleByteSize) throws UnsupportedEncodingException{
		String shortTitle = "";
		int endByteSize = 0;
		for(int i=0;i<title.length();i++){
			String value = String.valueOf(title.charAt(i));
			byte [] values = value.getBytes("GBK");
			if(values.length == 2){
				endByteSize += 2;
			}else if(values.length == 1){
				endByteSize += 1;
			}
			if(endByteSize == titleByteSize ){
				shortTitle = title.substring(0, i);
				break;
			}else if(endByteSize > titleByteSize){
				shortTitle = title.substring(0, i-1);
				break;
			}else {
				shortTitle = title;
			}
		}
		if (endByteSize < titleByteSize){
			return shortTitle;
		} else{
			return shortTitle + " ...";
		}
	}
	
	public int getCount(Connection con, String fMenuCode) {
		// 获取firstmenu为给定值的总条数
		Statement countStat;
		try {
			countStat = con.createStatement();
			ResultSet countRs = countStat
					.executeQuery("select count(1) as AllNum from WEB_NEWS  where fMenuCode='"
							+ fMenuCode + "' order by fNewsId desc");
			int lastPagenum = 0;
			if (countRs.next()) {
				int AllNum = countRs.getInt("AllNum");
				if (AllNum == 0) {
					return 0;
				}
				if (AllNum % 15 == 0) {
					lastPagenum = AllNum / 15;
				} else {
					lastPagenum = (AllNum / 15 + 1);
				}
			}
			countRs.close();
			countStat.close();
			return lastPagenum;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;

	}

	public int getCurrentLevel(HttpServletRequest request) {
		return (Integer) request.getSession().getAttribute("currentLevel");
	}

}
