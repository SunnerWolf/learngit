
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
		
		login(userName,password);
	}
}

function login(userName,password){
	
	new_element =	document.createElement("script");
	
	 new_element.setAttribute("type","text/javascript");
	 new_element.setAttribute("src","js/simpleAjax.js");
	 document.body.appendChild(new_element);
	simpleAjax('login', 'method=login&userName='+userName+'&password='+password,function(xmlHttp){
		
		var value=xmlHttp.responseText;
		
		if('1'==value){//登录成功
			window.location.href='index.jsp';
		}else if('2'==value){//密码不正确
			alert('您输入的密码错误');
		}else{//用户名不存在value=3;
			alert('用户名不存在');
		}
	});
}

function createSession(bsessionid){

	simpleAjax('login', 'method=setSession&bsessionid='+bsessionid,function(xmlHttp){	
var value=xmlHttp.responseText;
	});
}

function setSpanStyle(){
	var oneg = document.getElementById('oneg');
	oneg.style.display = "block";
	oneg.className = "navListSpanHover";
}

function clearSpanStyle(){
	var oneg = document.getElementById('oneg');
	oneg.className="navListSpan";
}
