<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/layout.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/simpleAjax.js"></script> 
<script type="text/javascript" src="js/tools.js"></script>
<script type="text/javascript" src="js/jquery-1.8.2.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/md5.js"></script>
<title>登录界面</title>
<script language="javascript" type="text/javascript">  
      
     var code ; //在全局 定义验证码  
     function createCode()  
     {   
       code = "";  
       var codeLength = 4;//验证码的长度  
       var checkCode = document.getElementById("checkCode");  
       var selectChar = new Array(0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');//所有候选组成验证码的字符，当然也可以用中文的  
          
       for(var i=0;i<codeLength;i++)  
       {  
	       var charIndex = Math.floor(Math.random()*36);  
	       code +=selectChar[charIndex];  
       }  
       
       if(checkCode)  
       {  
         checkCode.className="code";  
         checkCode.value = code;  
       }  
         
     }  
       
    function enterkey() { 
		e = event.keyCode; 
		if (e==13||e==32) 
		{ 
			ensure();
			event.returnValue= false; // 取消此事件的默认操作 
		} 
	} 
    </script>
</head>

<body class="loginBg" onload="createCode()" > 
	<div class="loginBox">
		<div class="loginContent">
			<h1 class="loginMain_top">新疆维吾尔自治区国家保密局</h1>
			<div class="loginMain">
				<h1 class="logo"><img src="images/loginBigLogo.png" alt="新疆维吾尔自治区国家保密局" /></h1>
				<b class="loginLine"><img src="images/loginLine.jpg" alt="" /></b>
				<div class="login">
					<h2 class="loginName"><img src="images/loginLogo.png" alt="" /></h2>
					<div class="loginInput"><label>用户名 </label><input class="nameInputBox" type="text" id="userName" value="" /></div>
					<div class="loginInput"><label>密&nbsp;&nbsp;码 </label><input class="nameInputBox" type="password" id="password" value="" onkeydown="enterkey()"/></div>
					&nbsp;&nbsp;&nbsp;
					</div>
					<div class="loginButton"><a href="#" onclick="ensure();"><img src="images/loginButton.png" alt="" /></a></div>
				</div>
					<h2 class="loginMain_bottom">版权所有：新疆维吾尔自治区国家保密局</h2>
			</div>
			
		</div>
</body>
</html>
