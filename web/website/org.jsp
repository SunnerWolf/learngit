<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/layout.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/simpleAjax.js"></script>
<script type="text/javascript" src="js/tools.js"></script>
<script type="text/javascript" src="js/index.js"></script>
<script type="text/javascript">
function _init() {
	
	var _xmlDoc='<%=request.getAttribute("xmlData")%>';
	createTable(varToXml(_xmlDoc));
}
function setPicTitle(fMenuName){
	document.getElementById('picTitle').innerHTML=fMenuName;
}
function clickTitle(fID){

	window.open('<%=request.getContextPath()%>/control?method=loadContentPage&fID='+ fID, '_parent');
}
function openApplication(){
		
	window.open('<%=request.getContextPath()%>/ApplicationList.jsp', '_parent');
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
}
function createTable(xmlDoc){
debugger
	var datas=xmlDoc.getElementsByTagName("fMenuCode");
	if(datas.length>0){
		var data =	datas[0];
		var _new =	data.getElementsByTagName('new')[0];
		var title =	_new.getAttribute('fNewsTitle');
		var fMenuName = _new.getAttribute('fMenuName');
		var fCreateDate =	_new.getAttribute('fCreateDate');
		var content=_new.getAttribute('content');
		setPicTitle(fMenuName);
		document.getElementById('title').innerHTML=title;
		document.getElementById('fCreateDate').innerHTML=fCreateDate;
		document.getElementById('content').innerHTML="<P class="+'"'+"articleMain"+'"'+">"+content+"</p>";
	}	
};
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
						<span  class="navListSpan" id='oneg6' style="cursor:pointer" onMouseMove="setSpanStyle('oneg6');" onMouseOut="clearSpanStyle('oneg6');"><span id='oneg' style="cursor:pointer" onMouseMove="setSpanStyle();" onMouseOut="clearSpanStyle();">测评审批</span>
					</li>
					<li>
						|
					</li>
					<li onclick="openListPage('MENU006');">
						<span  class="navListSpan" id='oneg7' style="cursor:pointer" onMouseMove="setSpanStyle('oneg7');" onMouseOut="clearSpanStyle('oneg7');">服务保障</span>
					</li>
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
				<h2 class="locationTxt"><span class="yourLocation">您的位置</span> <span class="pl42"><a href="<%=request.getContextPath()%>/index.jsp">首页>></a> 组织机构</span><span class="pl40" id="picTitle"></span></h2>
			</div>
			<div class="articleBox">
				<h2 class="articleTlt" id="title">机构职能</h2>
				<!-- <h3 class="articleTime">文章发布时间：<span id="fCreateDate"></span></h3>
				 -->
			</div>
			<div class="articleMain" id="content" >
			<p class="articleMain">新疆维吾尔自治区国家保密局设4个职能处：秘书综合处、检查指导处、宣传法规处、保密科技处。</p>
			<p class="articleMain"><strong>秘书综合处：</strong>负责制定全自治区保密工作计划并组织实施；组织、指导各市地和自治区直机关保密工作协作组开展保密活动；负责机关政务工作的组织协调、对外联络、会务和印信管理工作；负责起草委、办、局的重要文稿、领导讲话、工作总结和文电处理工作；负责委、办、局决定事项落实情况的督办、检查和大事记的编写工作；负责人事、组织、党务、工会、老干部等工作；负责机关的接待、财务和行政事务管理等项工作；负责全自治区保密工作情况综合和《新疆维吾尔自治区保密》简报编辑工作；负责编辑《保密信息专报》，完成局领导交办事项。 </p>
		    <p class="articleMain"><strong>检查指导处：</strong>检查指导处工作职能：负责检查、指导、协调全自治区党、政、军、人民团体及企事业单位的保密工作；查处重大泄密事件；组织对重大项目、重要活动和重要会议进行保密检查；监督、检查、指导印刷、复印行业的保密管理工作，核发印制密品《许可证》；负责对涉及国家秘密文件、资料、物品出境的保密审查工作，核发《出境许可证》；负责制定和组织协调全自治区党政电话专网规划和建设工作，并负责对其进行保密技术检查、验收和保密管理。 </p>
		    <p class="articleMain"><strong> 宣传法规处：</strong>负责全自治区保密宣传教育工作；负责制定全自治区领导干部和保密专兼职干部及涉密人员保密教育培训规划并组织实施；负责全自治区经管国家秘密事项人员审查登记管理工作；负责组织编写、审查保密宣传教育材料及保密干部、涉密人员培训教材；组织、指导全自治区党校、干校开展保密教育；组织、指导全自治区保密工作理论、政策研究；负责利用现代手段开展保密电化教育；负责保密宣传教育材料和《保密工作》杂志通联发行及新疆维吾尔自治区通联站日常工作；负责起草地方性保密法规及保密规章制度，监督、检查全自治区保密法规的贯彻执行情况；检查指导各地、各部门确定密级工作，对有争议定密事项进行仲裁。</p> 
		    <p class="articleMain"><strong>保密科技处：</strong>负责全自治区保密科技发展规划的制订及督查落实；负责全自治区保密技术检查工作； 负责全自治区涉密信息系统的审查、审批及日常检查、监督、管理工作； 负责全自治区涉密信息系统集成资质单位的监督管理工作；负责全自治区保密技术培训工作；负责全自治区重要涉密会议、活动、场所的保密技术检查及安全保障工作；负责保密科学技术研究及保密科技产品的选型工作。 </p>
			<p class="articleMain"><strong>新疆维吾尔自治区国家保密局工作职责 </strong></p>
			<p class="articleMain">
			    	<li class="articleMain">承办中共新疆维吾尔自治区保密委员会日常工作，依法履行全自治区保密行政管理职能。</li>
			    	<li class="articleMain">贯彻党中央、国务院和自治区委、自治区政府有关保密工作的方针、政策、决定、指示。 </li>
			    	<li class="articleMain">制定全自治区保密工作计划并组织实施，提出改革和加强保密工作的全局性、政策性建议。</li>
			    	<li class="articleMain">拟定地方性保密法规，经自治区人大常委会或自治区人民政府审定颁布；会同自治区有关部门制定保密规章制度；负责地方性保密法规的解释。</li>
			    	<li class="articleMain">指导、协调全自治区党、政、军、人民团体及企事业单位的保密工作；监督、检查全自治区范围《保密法》及其它保密法规制度的实施情况。</li>
			    	<li class="articleMain">组织开展保密检查，督促有关市地和部门对泄密事件进行查处，参与或组织有关部门对重大的或涉及几个地区、部门的泄密事件的查处工作；组织、协调有关部门对泄露的国家秘密采取补救措施。</li>
			    	<li class="articleMain">组织、指导全自治区保密宣传教育工作，制定保密宣传教育规划并负责组织实施，组织编写和审定宣传教育材料，利用现代化手段开展形式多样的保密宣传教育活动。</li>
			    	<li class="articleMain">制定全自治区领导干部保密知识教育和保密干部培训规划并组织实施，指导管理全自治区经管国家秘密事项人员培训教育；指导全自治区党校、干校等开展保密教育。</li>
			    	<li class="articleMain">制定全自治区保密科学技术发展规划并具体组织实施，组织推广、开发、应用保密技术设备；对涉及国家秘密的通信、办公自动化和计算机信息系统的建设项目进行检查、审批、管理，对涉密信息系统的设计、施工单位进行保密技术资格审查。</li>
			    	<li class="articleMain">负责制定全自治区党政电话专网建设的发展规划，审批协调和组织实施党政专用电话的安装，并负责对其进行保密技术性能检查验收和保密管理。</li>
			    	<li class="articleMain">组织、指导各市地和自治区直机关、军工保密资格单位保密工作协作组工作。</li>
			    	<li class="articleMain">代表自治区政府处理有关涉外保密工作事务。</li>
			    	<li class="articleMain">承办自治区区委、区政府交办的其它有关工作。</li>
			    </p>
			</div>
		</div>
		<div class="clear"></div>
	</div>
</body>
</html>
