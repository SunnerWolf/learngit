var logoutFlag = true;

//var addressIP = 'http://83.2.80.133:8080'; //x5链接地址

//var addressIPa = 'http://83.2.80.133:9001';	//邮件链接地址

var addressIP = 'http://localhost:8080'; //x5链接地址

var addressIPa = 'http://localhost:8080';	//邮件链接地址

function setLogoutFlag(){
	if(logoutFlag){
		logoutFlag = false;
	}
}

function setWelcomeWord(currentUser) {
	var today = new Date();
	var day;
	var date;
	if (today.getDay() == 0)
		day = " 星期日";
	if (today.getDay() == 1)
		day = " 星期一";
	if (today.getDay() == 2)
		day = " 星期二";
	if (today.getDay() == 3)
		day = " 星期三";
	if (today.getDay() == 4)
		day = " 星期四";
	if (today.getDay() == 5)
		day = " 星期五";
	if (today.getDay() == 6)
		day = " 星期六";
	document.fgColor = "000000";
	date = "今天的日期为：" + (1900+today.getYear()) + "年" + (today.getMonth() + 1) + "月"
			+ today.getDate() + "日" + day + "";
	if(null==currentUser || 'null'==currentUser || ""==currentUser){
		document.getElementById('welcomeWord').innerHTML = '&nbsp;&nbsp;欢迎您访问黑龙江省国家保密局网站。'+ date;
	}else{
		document.getElementById('welcomeWord').innerHTML = '&nbsp;&nbsp;欢迎您  '+currentUser+' 登录黑龙江省国家保密局网站。'+ date;
	}
	
}

function varToXml(xmlString) {
	if (window.ActiveXObject) {// for IE
		var xmlobject = new ActiveXObject("Microsoft.XMLDOM");
		xmlobject.async = "false";
		xmlobject.loadXML(xmlString);
		return xmlobject;
	} else {// for other browsers
		var parser = new DOMParser();
		var xmlobject = parser.parseFromString(xmlString, "text/xml");
		return xmlobject;
	}
}


function cancel(){
	var loginDiv=document.getElementById('loginDiv');
	loginDiv.style.display='none';
	var zheZhao=document.getElementById('zheZhao');
	zheZhao.style.display='none';
}

function ensure(){
	var userName=document.getElementById('userName').value;
	var password=document.getElementById('password').value;
	if(''==userName){
		alert('请输入用户名!');
		return;
	}else if(''==password){
		alert('请输入密码!');
		return;
	}else{
		setLogoutFlag();
		login(userName,password);
	}
}

var _x5_session_id = null;
var wrongTime = 0 ;
function login(userName,password){
	 new_element =	document.createElement("script");
	 new_element.setAttribute("type","text/javascript");
	 new_element.setAttribute("src","js/simpleAjax.js");
	 document.body.appendChild(new_element);
 	 var _password = hex_md5(password).toUpperCase();;
	 _x5_session_id = x5Login(userName, _password, _x5_session_id);
	 simpleAjax('login', 'method=login&userName='+userName+'&password='+password+'&bsessionid='+_x5_session_id,function(xmlHttp){
		var value=xmlHttp.responseText;
		if('1'==value){
			//登录成功
			window.location.href='index.jsp';
		}else if('2'==value){
			//密码不正确
			alert('您输入的密码错误');
			wrongTime = wrongTime + 1;
			if (wrongTime >= 3) {
				simpleAjax('login', 'method=recordThreeTimeWrong&userName='+userName,function(){});
				document.getElementById("userName").setAttribute("disabled", "disabled");
				document.getElementById("password").setAttribute("disabled", "disabled");
				document.getElementById("img").setAttribute("onclick", "");
				setTimeout("doSleep(10)", 100);
				wrongTime = 0;
			}
		}else{
			//用户名不存在value=3;
			alert('用户名不存在');
			wrongTime = wrongTime + 1;
			if (wrongTime >= 3) {
				simpleAjax('login', 'method=recordThreeTimeWrong&userName='+userName,function(){});
				document.getElementById("userName").setAttribute("disabled", "disabled");
				document.getElementById("password").setAttribute("disabled", "disabled");
				document.getElementById("img").setAttribute("onclick", "");
				setTimeout("doSleep(10)", 100);
				wrongTime = 0;
			}
		}
	});
}

function doSleep(n){
	var tips = "您已经连续3次登录错误，请等待"+n+"秒后重新登录！";
	count = n - 1;
	if (n >= 0) {
		document.getElementById("tips").innerHTML = tips;
		setTimeout("doSleep(count)", 1000);
	}else {
		document.getElementById("tips").innerHTML = "";
		document.getElementById("userName").removeAttribute("disabled");
		document.getElementById("password").removeAttribute("disabled");
		document.getElementById("img").setAttribute("onclick", "ensure();");
	}
}

function createSession(bsessionid){
	simpleAjax('setSession', 'method=setSession&bsessionid='+bsessionid,function(xmlHttp){
	});
}

var X5_LOGIN_URL = '/x5/demo/actions/process/integration/x5Login.j';
var X5_LOGOUT_URL = '/x5/demo/actions/process/integration/x5Logout.j';
var X5_BIZACTION_URL = '/x5/system/service/common/bizAction.j';

// 登录并返回bsessionid，判读前一个bsessionid是否过期，过期则重新登录
function x5Login(username, password, oldSessionID) {
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

//网站
function logout(bsessionid){
	simpleAjax('login', 'method=logout',function(xmlHttp) {
		var value=xmlHttp.responseText;
		if('1'==value){
			//注销成功
			if('null' != bsessionid && '' != bsessionid){
				x5Logout(bsessionid);
			}
			window.location.href="login.jsp";
		}else{
			//发生异常
		}
	});
}

// x5注销
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

// 登录按钮click
function btnLoginClick() {
	// 从页面获取用户名、密码
	username ='<%=session.getAttribute("userName")%>';
	var password ='<%=session.getAttribute("password")%>';
	var _x5_session_id = x5Login(username, password, null);
	$('#x5SessionID').val(_x5_session_id);	
}

function setSpanStyle(id){
	var oneg = document.getElementById(id);
	oneg.style.display = "block";
	oneg.className = "navListSpanHover";
}

function clearSpanStyle(id){
	var oneg = document.getElementById(id);
	oneg.className="navListSpan";
}

function changePic(){
	var obj = document.getElementById('image');
	var month = new Date().getMonth()+1;
	if (3<= parseInt(month) && parseInt(month) <=5) {
		obj.src = "images/spring.gif";
	}if (6<= parseInt(month) && parseInt(month) <=8) {
		obj.src = "images/summer.gif";
	}if (9<= parseInt(month) && parseInt(month) <=11) {
		obj.src = "images/autumn.png";
	}if (12<= parseInt(month) && parseInt(month) <=2) {
		obj.src = "images/banner.gif";
	}
}