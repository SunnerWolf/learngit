<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/layout.css" rel="stylesheet" type="text/css" />
<script type=text/javascript src="js/lrtk.js"></script>
<script type=text/javascript src="js/jquery-1.10.1.js"></script>
<script type=text/javascript src="js/slideshow.js"></script>
<script type="text/javascript" src="js/simpleAjax.js"></script>
<script type="text/javascript" src="js/index.js"></script>
<script type="text/javascript" src="js/jquery-1.8.2.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/tools.js"></script>
<script type="text/javascript">
	function _init() {
		var _xmlDoc='<%=request.getAttribute("xmlData")%>';
		createTable(varToXml(_xmlDoc));
	}

	function openApplication(){
			
		window.open('<%=request.getContextPath()%>/ApplicationList.jsp', '_parent');
	}
	
	function setPicTitle(fMenuName){
		document.getElementById('picTitle').innerHTML=fMenuName;
	}
	
	function clickTitle(fID){
	
		window.open('<%=request.getContextPath()%>/control?method=loadContentPage&fID='+ fID, '_parent');
	}

	function openListPage(fMenuCode) {
		window.open('<%=request.getContextPath()%>/control?method=loadListPage&fMenuCode='+fMenuCode+'&action=firstPage&isDirect=true', '_parent');
	}
	
	function logout(){
		simpleAjax('login', 'method=logout',function(xmlHttp) {
			var value=xmlHttp.responseText;
			if('1'==value){//注销成功
				window.parent.location.href='login.jsp';
			}else{
				//发生异常
			}
		});
		var bsessionid = '<%=session.getAttribute("bsessionid")%>';
		x5Logout(bsessionid);
	}
	
	function createTable(xmlDoc){
		var datas=xmlDoc.getElementsByTagName("fMenuCode");
		if(datas.length>0){
			var data =	datas[0];
			var _new =	data.getElementsByTagName('new')[0];
			debugger
			var title =	_new.getAttribute('fNewsTitle');
			var fMenuName = _new.getAttribute('fMenuName');
			var fCreateDate =	_new.getAttribute('fCreateDate');
			var fCreatePerson =	_new.getAttribute('fCreatePerson');
			var shortDate = fCreateDate.substring(0,19);
			var content=_new.getAttribute('content');
			var fid=_new.getAttribute('fID');
			var contentPic=_new.getAttribute('contentPic');
			if(contentPic){
				var k=document.getElementById('attachmentEditor');
				k.style.display='block';
			}
			btnOpenClick(fid);
			setPicTitle(fMenuName);
			document.getElementById('title').innerHTML=title;
			document.getElementById('fCreateDate').innerHTML=shortDate;
			document.getElementById('fCreatePerson').innerHTML=fCreatePerson;
			document.getElementById('content').innerHTML="<P class="+'"'+"articleMain"+'"'+">"+content+"</p>";
		}	
	};
		
	var X5_LOGIN_URL = '/x5/demo/actions/process/integration/x5Login.j';
	var X5_LOGOUT_URL = '/x5/demo/actions/process/integration/x5Logout.j';
	var X5_BIZACTION_URL = '/x5/system/service/common/bizAction.j';
		
	// 登录并返回bsessionid，判读前一个bsessionid是否过期，过期则重新登录
	function x5Login(username, password, oldSessionID) {
		debugger
		var newSessionID = null;
		$.ajax({
			async: false,
			type: 'POST',
			dataType: 'json',
			url: X5_LOGIN_URL,
			data: {
				username: username,
				password: password,
				bsessionid: oldSessionID
			},
			error: function(error, status, text) {
				alert('登录失败：请联系管理员');
			},
			success: function(result){
				if (result.flag) {
					newSessionID = result.bsessionid;
				} else {
					alert('登录失败：请联系管理员');
				};
			}
		});
		return newSessionID;
	}
		
   // 全局变量，记录X5 bsessionid
	//var _x5_session_id = null;
	$(window).unload(function() {
		var bsessionid = '<%=session.getAttribute("bsessionid")%>';
		x5Logout(bsessionid);
	});
		
	function btnLoginClick() {
		// 从页面获取用户名、密码
		username ='<%=session.getAttribute("userName")%>';
		var password ='<%=session.getAttribute("password")%>';
		var _x5_session_id = x5Login(username, password, null);
		$('#x5SessionID').val(_x5_session_id);
		
	}
	
	// 注销
	function x5Logout(bsessionid) {
		$.ajax({
			async: false,
			type: 'POST',
			dataType: 'json',
			url: X5_LOGOUT_URL + '?bsessionid=' + bsessionid,
			data: {},
			error: function(error, status, text) {
			},
			success: function(result){
				if (result.flag) {
				
				} else {
				
				};
			}
		});
	}
	
	// 打开页面按钮click，在iFrame中打开一个X5功能页面
	function btnOpenClick(fid) {
		
		var bsessionid = '<%=session.getAttribute("bsessionid")%>';
		
		// 从X5功能页面URL
		var url = "/x5/web/webNews/process/editNews/attachmentEditor.w?fid="+fid;
		// 在页面URL的后面加上bsessionid
		url = (url.indexOf('?') == -1) ? url + '?bsessionid=' + bsessionid : url + '&bsessionid=' + bsessionid;
		// 在iFrame中打开
		$('#attachmentEditor').attr('src', url);
	}

</script>
<%
	if (session.getAttribute("userName") == null) {
%>
<script type="text/javascript" language="javascript">
		window.document.location.href="login.jsp";
	</script>
<%
	}
%>
<title>新疆维吾尔自治区国家保密局</title>
</head>

<body onload="_init();">
	
	<div class="header">
	<div class="HomewelcomeBox">
			<p class="left">您好，<%=session.getAttribute("sName")%> 同志【<a href="#" onclick="openApplication()">修改密码</a> , <a href="#" onclick="logout()">退出</a>】，欢迎来到新疆维吾尔自治区国家保密局内网网站!</p>
			<p class="right"><a href="#" onclick="Addme()">收藏本站</a><span> | </span><a href="#" onclick="SetHome(this,window.location)" >设为首页</a> </p>
		</div>
			<h1><img src="images/banner.gif" alt="新疆保密局" width="980px"/></h1>
			<div class="nav">
				<a href="<%=request.getContextPath()%>/index.jsp"><b class="emblem"></b></a>
				<ul class="navList"> 
					<li><a href="<%=request.getContextPath()%>/org.jsp" target="_parent">机构职能</a></li><li>|</li>
					<li onclick="openListPage('MENU008');" target="_parent"><a href="javaScript:void(0)">工作动态</a></li><li>|</li>
					<li onclick="openListPage('MENU001');" target="_parent"><a href="javaScript:void(0)">保密宣传</a></li><li>|</li>
					<li onclick="openListPage('MENU002');" target="_parent"><a href="javaScript:void(0)">保密科技</a></li><li>|</li>
					<li onclick="openListPage('MENU003');" target="_parent"><a href="javaScript:void(0)">政策法规</a></li><li>|</li>
					<li onclick="openListPage('MENU004');" target="_parent"><a href="javaScript:void(0)">监督检查</a></li><li>|</li>
					<li onclick="openListPage('MENU005');" target="_parent"><a href="javaScript:void(0)">测评审批</a></li><li>|</li>
					<li onclick="openListPage('MENU006');" target="_parent"><a href="javaScript:void(0)">服务保障</a></li>
				</ul>
				<p class="clear"></p>
			</div>
		</div>
	<div class="clear"></div>
	<div class="content">
		<!-- <div class="welcomeBox">
			<p class="left">您好,欢迎登陆新疆保密综合业务网！</p>
		</div>
	 -->
		<div class="clear"></div>
		<div class="articleContent">
			<div class="location mb10">
				<h2 class="locationTxt"><span class="yourLocation">您的位置</span> <span class="pl42"><a href="<%=request.getContextPath()%>/index.jsp">首页>></a></span><span class="pl40" id="picTitle"></span></h2>
			</div>
			<div class="articleBox">
				<h2 class="articleTlt" id="title"></h2>
				<h3 class="articleTime">文章发布时间：<span id="fCreateDate"></span>  发布人：<span id="fCreatePerson"></span></h3>
			</div>
			<div class="articleMain" id="content" ></div>
			<iframe style="display:none;" class="download" id="attachmentEditor" width="80%" frameborder="no" border="0" framespacing="0" scrolling="no" noresize="noresize" > 
				
			</iframe>
		</div>
		<div class="clear"></div>
	</div>

</body>
</html>
