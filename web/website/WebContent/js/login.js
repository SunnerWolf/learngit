//验证用户名密码 
function login(){
	var userName = document.getElementById("userName");
	var password = document.getElementById("password");
	alert(userName.Value);
	if(userName.value==""){

		alert("用户名不能为空");
		userName.focus();
		return;
	}
	if(password.value=="" ){
	
		alert("密码不能为空");
		password.focus();
		return;
	}else if( password.value.length <6 || password.value.length >15){
		alert("密码必需有6~15的字符");
		return;
	}
 }