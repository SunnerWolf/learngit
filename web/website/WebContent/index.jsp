<%@ page language="java"  contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新疆保密局</title>
<script type=text/javascript src="js/lrtk.js"></script>
<script type=text/javascript src="js/jquery-1.10.1.js"></script>
<script type=text/javascript src="js/slideshow.js"></script>
<script type=text/javascript src="js/linkTab.js"></script>
<script type="text/javascript" src="js/simpleAjax.js"></script>
<script type="text/javascript" src="js/index.js"></script>
<script type="text/javascript" src="js/jquery-1.8.2.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/tools.js"></script>
<link href="css/layout.css" rel="stylesheet" type="text/css" />
<script language=javascript>

	//var addressIP = 'http://83.2.80.133:8080'; //x5链接地址
	
	//var addressIPa = 'http://83.2.80.133:9001';	//邮件链接地址
	
	var titleFlag = false;

	var orgFlag = false;

	var currentLogoutFlag = false;
	
	function load(){
		changePic();
		_init();
		setTimeout("changePicDiv()",1000);
		getYear();
		
		//  mytv("idNum","idTransformView","idSlider",240,4,true,4000,4,true,"onmouseover");
   }
	   
	function  changePicDiv(){
		mytv("MENU010","idTransformView","idSlider",240,4,true,2000,5,true,"onmouseover");
 	}
  	
  	$(document).ready(function () {
		//set the default location (fix ie 6 issue)
		$('.lava').css({left:$('span.item:first').position()['left']});		
		$('.item').mouseover(function () {
			//scroll the lava to current item position
		$('.lava').stop().animate({left:$(this).position()['left']}, {duration:200});
			
			//scroll the panel to the correct content
		$('.panel').stop().animate({left:$(this).position()['left'] * (-3.7)}, {duration:200});
		});
		SlideShow(1000);	
	});
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

<script type="text/javascript">
	var x5_session_id = null;

	var username="";
	
	function clickTitle(fID){
		titleFlag = true;
		setLogoutFlag();
		window.open('<%=request.getContextPath()%>/control?method=loadContentPage&fID='+ fID, '_self');
	}
	
	function openEmail(){
		username ='<%=session.getAttribute("userName")%>';
		var password ='<%=session.getAttribute("_password")%>';
		var url= addressIPa+"/email";
	    //user/login.action?username=" + username + "&password="+ password + "&flag=true";
		window.open(url);
	}
	
	function openListPage(fMenuCode) {
		setLogoutFlag();
		window.open('<%=request.getContextPath()%>/control?method=loadListPage&fMenuCode='+fMenuCode+'&action=firstPage&isDirect=true', '_self');
	}
	
	function openApplication(){
		setLogoutFlag();
		window.open('<%=request.getContextPath()%>/ApplicationList.jsp', '_self');
	}
	
	function openPlatform(){
	    var username ='<%=session.getAttribute("userName")%>';
		var password ='<%=session.getAttribute("password")%>';
		var url = addressIP + "/x5";
	    //portal/directLogin.w?username=" + username + "&password=" + password;
	  	window.open(url);
	}

	// 登录按钮click
	function btnLoginClick() {
		// 从页面获取用户名、密码
		username ='<%=session.getAttribute("userName")%>';
		var password ='<%=session.getAttribute("password")%>';
		var _x5_session_id = x5Login(username, password, null);
		$('#x5SessionID').val(_x5_session_id);
		
	}
	
	// 打开一个X5功能页面
	function openWebNews() {
		// 从X5功能页面URL
		var bsessionid = '<%=session.getAttribute("bsessionid")%>';
		x5_session_id = bsessionid;
		var url = '/x5/web/webNews/process/editNews/mainActivity.w';
		url = (url.indexOf('?') == -1) ? url + '?bsessionid=' + bsessionid : url + '&bsessionid=' + bsessionid;
		window.open(url);
	}
	
	function openSuggestion() {
		// 从X5功能页面URL
		var bsessionid = '<%=session.getAttribute("bsessionid")%>';
		x5_session_id = bsessionid;
		var url = '/x5/web/webNews/process/webSuggestion/mainActivity.w';
			url = (url.indexOf('?') == -1) ? url + '?bsessionid=' + bsessionid : url + '&bsessionid=' + bsessionid;
			window.open(url);
	}
	
	function openAddressList() {
		// 从X5功能页面URL
		var bsessionid = '<%=session.getAttribute("bsessionid")%>';
		x5_session_id = bsessionid;
		var url = '/x5/secretSystemForXJ/addressList/process/queryAddressList/mainActivity.w';
		url = (url.indexOf('?') == -1) ? url + '?bsessionid=' + bsessionid : url + '&bsessionid=' + bsessionid;
		window.open(url);
	}
	
	function getYear(){
		var year = (new Date().getYear() < 1900) ? (1900 + new Date().getYear()) : new Date().getYear()
		document.getElementById('day1').innerHTML="今天是"+ year +"年"+(new Date().getMonth()+1)+"月"+new Date().getDate()+"日"+', 星期'+'日一二三四五六'.charAt(new Date().getDay());
	} 
	
	function orgJsp(){
		orgFlag = true;
		setLogoutFlag();
		window.location.href="<%=request.getContextPath()%>/org.jsp";
	}
	
	function returnIndexJsp(){
		setLogoutFlag();
		window.location.href="<%=request.getContextPath()%>/index.jsp";
	}

	function webLogout(){
		currentLogoutFlag = true;
		setLogoutFlag();
		var bsessionid = '<%=session.getAttribute("bsessionid")%>';
		logout(bsessionid);
	}

	window.onbeforeunload = function() {  
		debugger;
		if(titleFlag){
			return;
		}

		if(orgFlag){
			return;
		}

		if(currentLogoutFlag){
			return;
		}
		
		if(logoutFlag){
			return "";
		}
	}

	window.onunload = function(){
		if(logoutFlag){
			var bsessionid = '<%=session.getAttribute("bsessionid")%>';
			logout(bsessionid);
			window.opener=null 
			window.open("","_self") 
			window.close(); 
		}else{
			logoutFlag = true;
		}
	}
	
</script>
</head>

<body onload="load()">
	<div class="header">
		<div class="HomewelcomeBox">
			<p class="left">您好，<%=session.getAttribute("sName")%> 同志【<a href="#" onclick="openApplication()">修改密码</a> , <a href="#" onclick="webLogout()">退出</a>】，欢迎来到新疆维吾尔自治区国家保密局内网网站!</p>
			<p class="right"><a href="#" onclick="Addme()">收藏本站</a><span> | </span><a href="#" onclick="SetHome(this,window.location)" >设为首页</a> </p>
		</div>
		<h1><img id="image" src="" alt="新疆保密局" width="980px" /></h1>
		<div class="nav">
			<a href="#" onclick='returnIndexJsp();'><b class="emblem"></b> </a>
			<ul class="navList"> 
					<li >
						<a href="#" onclick='orgJsp();'>机构职能</a>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU008');" target="_self">
						<span  class="navListSpan" id='oneg1' onMouseMove="setSpanStyle('oneg1');" onMouseOut="clearSpanStyle('oneg1');">工作动态</span>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU001');" target="_self">
						<span class="navListSpan" id='oneg2' onMouseMove="setSpanStyle('oneg2');" onMouseOut="clearSpanStyle('oneg2');">保密宣传</span>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU002');" target="_self">
						<span  class="navListSpan" id='oneg3' style="cursor:pointer" onMouseMove="setSpanStyle('oneg3');" onMouseOut="clearSpanStyle('oneg3');">保密科技</span>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU003');" target="_self">
						<span  class="navListSpan" id='oneg4' style="cursor:pointer" onMouseMove="setSpanStyle('oneg4');" onMouseOut="clearSpanStyle('oneg4');">政策法规</span>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU004');" target="_self">
						<span  class="navListSpan" id='oneg5' style="cursor:pointer" onMouseMove="setSpanStyle('oneg5');" onMouseOut="clearSpanStyle('oneg5');">监督检查</span>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU005');" target="_self">
						<span  class="navListSpan" id='oneg6' style="cursor:pointer" onMouseMove="setSpanStyle('oneg6');" onMouseOut="clearSpanStyle('oneg6');">测评审批</span>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU006');" target="_self">
						<span  class="navListSpan" id='oneg7' style="cursor:pointer" onMouseMove="setSpanStyle('oneg7');" onMouseOut="clearSpanStyle('oneg7');">服务保障</span>
					</li>
			</ul>
			<div class="clear"></div>
		</div>
		<div class="searchBox">
			<p class="left" id="day1">
				
			</p>
			<div class="right">
				<span>站内搜索:</span>
				<input type="text" value="" class="searchInput" />
				<input type="button" value="" class="searcheButton" />
				<span class="advancedSearch"><a href="#">【高级搜索】</a></span>
			</div>
		</div>
	</div>
	<div class="clear"></div>
	<div class="content">
		<div class="Trends">
			<b class="TrendsLeftCorner"></b>
			<b class="TrendsRightCorner"></b>
			<div class="TransformView">
				<!-- 代码 开始 -->      
				<div id="idTransformView">
					<div id=idSlider class="slider">
					 
					</div>
				</div>
				
				 <ul id="MENU010" class=hdnum>
					</ul>
								
				<!-- 代码 结束 -->
			</div>
			<div class="trendsTab">
				<div id="moving_tab">
					<div class="tabs">
						<div class="lava"></div>
						<span class="item">最新动态</span>
						<span class="item">自治区动态</span>	
						<span class="item">地州市动态</span>	
					</div>									
					<div class="panelMain">						
						<div class="panel">
								<ul  id="MENU008">
								</ul>
								<ul id="MENU111">
								</ul>
								<ul id="MENU112">
								</ul>
							</div>
					</div>	
				</div>
			</div>
		</div>
		<div class="notice">
			<b class="TrendsLeftCorner"></b>
			<b class="TrendsRightCorner"></b>
			<div class="noticeTlt"><h2 class="left"><b class="noticeIcon"></b>公告</h2><span class="more"><a href="#"
						onclick="openListPage('MENU009')">|更多</a> </span></div>
			<ul class="noticeList" id="MENU009">
				
			</ul>
		</div>
		<div class="clear pb5"></div>
		<div class="adBox">
			<div class="comiis_wrapad" id="slideContainer">
       		 	<div id="frameHlicAe" class="slideBlock">
					 <ul class="slideshow" id="slidesImgs">
						 <li><img src="images/ad.png"  alt="严格保守国家秘密" width="978" height="88"/></li>
						 <li><a href="#" onclick="openListPage('MENU013')" ><img src="images/ad2.png" alt="严格保守国家秘密" width="978" /></a></li>
						 <li><a href="#" onclick="openListPage('MENU014')" ><img src="images/ad1.png" alt="严格保守国家秘密" width="978" /></a></li> 
						 <li><a href="#" onclick="openListPage('MENU015')" ><img src="images/ad3.png" alt="严格保守国家秘密" width="978" /></a></li>
						 <li><a href="#" onclick="openListPage('MENU016')" ><img src="images/ad4.png" alt="严格保守国家秘密" width="978" /></a></li>
					 </ul>
					<div class="slidebar" id="slideBar">
						<ul>
							<li class="on">1</li>
							<li>2</li>
							<li>3</li>
							<li>4</li>
							<li>5</li>
						</ul>
					</div>
       		  </div>
   		   </div>
		</div>
		<div class="columnBox">
				<h2 class="columnTlt">
					<b class="publicityIcon"></b><span class="left">保密宣传</span><span
						class="more"><a href="#" onclick="openListPage('MENU001')">|更多</a>
					</span>
				</h2>
				<div class="clear"></div>
				<ul class="columnList" id="MENU001">
				</ul>
			</div>
			<div class="columnBox">
				<h2 class="columnTlt">
					<b class="technologyIcon"></b><span class="left">保密科技</span><span
						class="more"><a href="#" onclick="openListPage('MENU002')">|更多</a>
					</span>
				</h2>
				<div class="clear"></div>
				<ul class="columnList" id="MENU002">
					<li>
						<a href="#"></a>
					</li>
				</ul>
			</div>
			<div class="columnBox">
				<h2 class="columnTlt">
					<b class="lawIcon"></b><span class="left">政策法规</span><span
						class="more"><a href="#" onclick="openListPage('MENU003')">|更多</a>
					</span>
				</h2>
				<div class="clear"></div>
				<ul class="columnList" id="MENU003">
					<li>
						<a href="#"></a>
					</li>
				</ul>
			</div>
		<div class="columnButtonBox">
			<h2 class="columnTlt"><b class="yellowIcon"></b><span class="left">专项工作</span><span class="more"><a href="#">|更多</a></span></h2>
			<div class="clear"></div>
			<a href="#"><p class="buttonBox"><b class="buttonIcon"></b>保密普查</p></a>
			<a href="#"><p class="buttonBox"><b class="buttonIcon"></b>定密管理</p></a>
			<a href="#"><p class="buttonBox"><b class="buttonIcon"></b>网络保密管理</p></a>
		</div>
		<div class="clear pb5"></div>
			<div class="columnBox">
				<h2 class="columnTlt">
					<b class="checkIcon"></b><span class="left">监督检查</span><span
						class="more"><a href="#" onclick="openListPage('MENU004')">|更多</a>
					</span>
				</h2>
				<div class="clear"></div>
				<ul class="columnList" id="MENU004">
					<li>
						<a href="#"></a>
					</li>
				</ul>
			</div>
			<div class="columnBox">
				<h2 class="columnTlt">
					<b class="appraisalIcon"></b><span class="left">测评审批</span><span
						class="more"><a href="#" onclick="openListPage('MENU005')">|更多</a>
					</span>
				</h2>
				<div class="clear"></div>
				<ul class="columnList" id="MENU005">
					<li>
						<a href="#"></a>
					</li>
				</ul>
			</div>
			<div class="columnBox">
				<h2 class="columnTlt">
					<b class="serviceIcon"></b><span class="left">服务保障</span><span
						class="more"><a href="#" onclick="openListPage('MENU006')">|更多</a>
					</span>
				</h2>
				<div class="clear"></div>
				<ul class="columnList" id="MENU006">
					<li>
						<a href="#"></a>
					</li>
				</ul>
			</div>
			<div class="columnButtonBox">
				<h2 class="columnTlt"><b class="yellowIcon"></b><span class="left">应用服务</span><span class="more"><a href="#" onclick="openPlatform()">|更多</a></span></h2>
				<div class="clear"></div>
				<a href="#" onclick="openEmail()"><img class="pb3" src="images/email.jpg" width="232px" alt="邮件"  /></a>
				<a href="#" onclick="openAddressList()"><img class="pb3" src="images/addressBook.jpg" width="232px"  alt="通讯录" /></a>
				<a href="#" onclick="openWebNews()"><img src="images/informationPublish.jpg"  width="232px" alt="信息发布" /></a>
			</div>
			<div class="clear pb5"></div>
			<div class="picShow">
				<div class="left"  style=" height:127px; width:34px;">
					<img src="images/link.png" alt="" />
				</div>
				<div class="linkMain">
					<div class="linkMenu">
						<ul>
							<li><a href="#" onmouseover="easytabs('1', '1');" onfocus="easytabs('1', '1');" onclick="return false;"  title="" id="tablink1">国家机关</a></li>
							<li><a href="#" onmouseover="easytabs('1', '2');" onfocus="easytabs('1', '2');" onclick="return false;"  title="" id="tablink2">各省区市</a></li>
							<li><a href="#" onmouseover="easytabs('1', '3');" onfocus="easytabs('1', '3');" onclick="return false;"  title="" id="tablink3">各地州市 </a></li>
							<li><a href="#" onmouseover="easytabs('1', '4');" onfocus="easytabs('1', '4');" onclick="return false;"  title="" id="tablink4">新疆生产建设兵团</a></li>
							<!--<li><a href="#" onmouseover="easytabs('1', '3');" onfocus="easytabs('1', '3');" onclick="return false;"  title="" id="tablink3">Tab 3 </a></li>
							<li><a href="#" onmouseover="easytabs('1', '4');" onfocus="easytabs('1', '4');" onclick="return false;"  title="" id="tablink4">Tab 4 </a>-->
							</li>
						</ul>
						<div class="clear"></div>
					</div>
					<div id="tabcontent1">
						<a href="http://111.97.0.3:6888/serviceweb/zblongin.jsp" target='_blank'>国家保密局</a><span class="p10">|</span>
						<a href="#" target='_blank'>国家保密技术研究所</a>   <span class="p10">|</span>
						<a href="#" target='_blank'>涉密信息系统安全保密测评中心</a>	
					</div>
					<div id="tabcontent2">
						<a href="#" target='_blank'>上海市国家保密局</a>		 <span class="p10">|</span>
						<a href="#" target='_blank'>广东市国家保密局</a>		 <span class="p10">|</span>
						<a href="#" target='_blank'>黑龙江省国家保密局</a>		 <span class="p10">|</span>
						<a href="#" target='_blank'>山东省国家保密局</a>		 <span class="p10">|</span>
						<a href="#" target='_blank'>辽宁省国家保密局</a>		 <span class="p10">|</span>
						<a href="#" target='_blank'>吉林省国家保密局</a>		 <span class="p10">|</span>
						<a href="#" target='_blank'>江苏市国家保密局</a>	
						
					</div>	
					<div id="tabcontent3">
						<a href="#" target='_blank'>伊犁哈萨克自治州</a>  <span class="p10">|</span>
						<a href="#" target='_blank'>塔城地区</a>  <span class="p10">|</span>
						<a href="#" target='_blank'>阿勒泰地区</a>  <span class="p10">|</span>
						<a href="#" target='_blank'>博尔塔拉蒙古自治州</a>  <span class="p10">|</span>  
						<a href="#" target='_blank'>克拉玛依市</a>  <span class="p10">|</span>  
						<a href="#" target='_blank'>乌鲁木齐市昌吉回族自治州</a>  <span class="p10">|</span>  
						<a href="#" target='_blank'>吐鲁番地区</a>  <span class="p10">|</span>  
						<a href="#" target='_blank'>哈密地区</a>  <span class="p10">|</span>  
						<a href="#" target='_blank'>巴音郭楞蒙古族自治州</a>  <span class="p10">|</span>  
						<a href="#" target='_blank'>阿克苏地区</a>  <span class="p10">|</span>  
						<a href="#" target='_blank'>喀什地区克孜勒苏柯尔克孜自治州</a> <span class="p10">|</span> 
						<a href="#" target='_blank'>和田地区</a>
					</div>				
					<div id="tabcontent4">
						
					</div>				
					<!--<div id="tabcontent4">Tabcontent 4</div>-->
				</div>
		</div>
		<div class="linkPicBox left">
				<a href="#" class="pb4"><img src="images/serWork.png"  alt="" width="240px" height="64px"/></a>
				<a href="#"onclick="openSuggestion()"><img src="images/advice.png" alt="" width="240px" height="60px"/></a>
			</div>
			<!--<div class="advice">
			<a href="#"><img src="images/opinions.gif" alt="" /></a>
		</div>-->
		<div class="clear"></div>
	</div>
	<div class="footer">
		
		<div class="contantUsBox">
			<a href="#">联系我们</a><span class="p10">|</span>
			<a href="#">网站声明</a><span class="p10">|</span>
			<a href="#">网站地图</a>
		</div>
		<p class="aboutUs">新疆维吾尔自治区国家保密局&nbsp;&nbsp;版权所有@2013<br />主办：新疆维吾尔自治区国家保密局 </p>
	</div>
	
</body>
</html>
