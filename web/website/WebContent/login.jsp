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
<script type="text/javascript" src="js/DD_belatedPNG.js" ></script>
<title>登录界面</title>
<script language="javascript" type="text/javascript">  
	
	DD_belatedPNG.fix('.loginBox');
    
	function KeyDown()
	{
	    if (event.keyCode == 13)
	    {
	       ensure();
	    }
	}
</script>
</head>

<body class="loginBg" > 
	<div class="loginBox">
		<div class="loginContent">
			<h1 class="loginMain_top">新疆维吾尔自治区国家保密局</h1>
			<div class="loginMain">
				<h1 class="logo"><img src="images/loginBigLogo.png" alt="新疆维吾尔自治区国家保密局" /></h1>
				<b class="loginLine"><img src="images/loginLine.jpg" alt="" /></b>
				<div class="login">
					<h2 class="loginName"><img src="images/loginLogo.png" alt="" /></h2>
					<div class="loginInput"><label>用户名 </label><input class="nameInputBox" type="text" id="userName" value="" /></div>
					<div class="loginInput"><label>密&nbsp;&nbsp;码 </label><input class="nameInputBox" type="password" id="password"value="" onkeydown="KeyDown()"/></div>
					&nbsp;&nbsp;&nbsp;
					</div>
					<div class="loginButton"><a href="#" onclick="ensure();"><img src="images/loginButton.png" alt="" /></a></div>
				</div>
					<h2 class="loginMain_bottom">版权所有：新疆维吾尔自治区国家保密局</h2>
			</div>
			
		</div>
</body>
</html>
