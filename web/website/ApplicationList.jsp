<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="jquery.form.js"></script>
		<script type="text/javascript" src="js/simpleAjax.js"></script>
		<script type="text/javascript" src="js/index.js"></script>
		<script type="text/javascript" src="js/tools.js"></script>
		<script type=text/javascript src="js/lrtk.js"></script>
		<script type=text/javascript src="js/md5.js"></script>
		<script type="text/javascript" src="js/index.js"></script>
<link href="css/layout.css" rel="stylesheet" type="text/css" />
<script language=javascript>

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
}
  function check()  {
	var oldPassword = document.getElementById("oldPassword");
	var newPassword = document.getElementById("newPassword");
	var checkPassword = document.getElementById("checkPassword");
	var password	='<%=session.getAttribute("password")%>';
	var userName	='<%=session.getAttribute("userName")%>';
	//md5加密
   	var oldPasswordMD5 = hex_md5(oldPassword.value).toUpperCase();
   	var newPasswordMD5 = hex_md5(newPassword.value).toUpperCase();
   	var checkPasswordMD5 = hex_md5(checkPassword.value).toUpperCase();
   	
	if(password!=oldPasswordMD5){
	  alert("原密码不正确");  
	  return ;
	}
	if(newPassword.value==""){
	 alert("新密码不能空");  
	  return ;
	}
	if(newPassword.value != checkPassword.value){
	 alert("两次输入的密码不一致");  
	  return ;
	}
	if(!/[a-z|A-Z|0-9]{6,12}/.test(newPassword.value)){
		alert( "密码不符合规则.字母有大小写之分;6-12位(包括6、12);密码必须由英文字母(a-z)、(A-Z)和数字(0-9)组成");
		
		return ;
	}
	if(!/[a-z,A-Z]/.test(newPassword.value)){
		alert( "密码必须包含英文");
		return ;
		}
	if(!/[0-9]/.test(newPassword.value)){
		alert( "密码必须包含数字");
		return ;
		}
	simpleAjax('login', 'method=changePassword&userName='+userName+'&password='+newPasswordMD5+'&newPassword='+newPassword.value,function(xmlHttp){
		
		var value=xmlHttp.responseText;
		
		if('1'==value){//修改成功
			alert("修改成功");
			logout();
		}
	});
  }
function reset(){
	document.getElementById("oldPassword").value="";
	document.getElementById("newPassword").value="";
	document.getElementById("checkPassword").value="";
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

<body>
		
	<div class="header">
	<div class="HomewelcomeBox">
			<p class="left">您好，<%=session.getAttribute("sName")%> 同志【<a href="#" onclick="openApplication()">修改密码</a> , <a href="#" onclick="logout()">退出</a>】，欢迎来到新疆维吾尔自治区国家保密局内网网站!</p>
			<p class="right"><a href="#" onclick="Addme()">收藏本站</a><span> | </span><a href="#" onclick="SetHome(this,window.location)" >设为首页</a> </p>
		</div>
		<h1><img src="images/banner.gif" alt="新疆保密局" width="980px"/></h1>
		<div class="nav">
				<a href="<%=request.getContextPath()%>/index.jsp"><b
					class="emblem"></b> </a>
				<ul class="navList">
					<li target="_parent">
						<a href="<%=request.getContextPath()%>/org.jsp">机构职能</a>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU008');" >
						<span  class="navListSpan" id='oneg1' style="cursor:pointer" onMouseMove="setSpanStyle('oneg1');" onMouseOut="clearSpanStyle('oneg1');">工作动态</span>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU001');">
						<span  class="navListSpan" id='oneg2' style="cursor:pointer" onMouseMove="setSpanStyle('oneg2');" onMouseOut="clearSpanStyle('oneg2');">保密宣传</span>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU002');">
						<span  class="navListSpan" id='oneg3' style="cursor:pointer" onMouseMove="setSpanStyle('oneg3');" onMouseOut="clearSpanStyle('oneg3');">保密科技</span>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU003');">
						<span  class="navListSpan" id='oneg4' style="cursor:pointer" onMouseMove="setSpanStyle('oneg4');" onMouseOut="clearSpanStyle('oneg4');">政策法规</span>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU004');">
						<span  class="navListSpan" id='oneg5' style="cursor:pointer" onMouseMove="setSpanStyle('oneg5');" onMouseOut="clearSpanStyle('oneg5');">监督检查</span>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU005');">
						<span  class="navListSpan" id='oneg6' style="cursor:pointer" onMouseMove="setSpanStyle('oneg6');" onMouseOut="clearSpanStyle('oneg6');">测评审批</span>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU006');">
						<span  class="navListSpan" id='oneg7' style="cursor:pointer" onMouseMove="setSpanStyle('oneg7');" onMouseOut="clearSpanStyle('oneg7');">服务保障</span>
					</li>
				</ul>
				<div class="clear"></div>
			</div>
	</div>
	<div class="clear"></div>
	<div class="content">
		<div class="clear"></div>
		<div class="pageList_nav">
			<h2 class="pagenavTlt" >修改密码</h2>
		</div>
		<div class="pageList_content">
			<div class="location">
				<h2 class="locationTxt"><span class="yourLocation">您的位置</span> <span class="pl42">首页>>修改密码</span></h2>
			</div>
			<div class="changewordsBox">
				<div class="loginInput"><label class="changewordsTlt">旧密码:</label><input class="nameInputBox left" type="password" id="oldPassword" value="" /><strong class="left red pl10">*</strong>
					<div class="clear"></div>
				</div>
				<div class="loginInput"><label class="changewordsTlt">新密码:</label><input class="nameInputBox left" type="password" id="newPassword" value="" /><strong class="left red pl10">*</strong>
					<div class="clear"></div>
				</div>
				<div class="loginInput"><label class="changewordsTlt">确认密码:</label><input class="nameInputBox left" type="password" id="checkPassword" value="" /><strong class="left red pl10">*</strong>
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
				 <input type="button" class="changewordButton ml110" value="重&nbsp;&nbsp;置" onclick="reset()"/> 
				 <input type="button" class="changewordButton ml20" value="修&nbsp;&nbsp;改" onclick="check()"/> 
			</div>
		</div>
		<div class="clear"></div>
	</div>
	<div class="clear"></div>
	<div class="footer">
		
		<div class="clear mb5"></div>
	</div>
</body>
</html>
