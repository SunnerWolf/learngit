<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/common.css" rel="stylesheet" type="text/css" />
<title>Insert title here</title>
</head>
<body onload="_init();">
	<div class="header_top">
		<div class="top_box">
			<p class="welcome left">欢迎进入黑龙江省保密局网站！</p>
			<p class="backIndex right"><a href="<%=request.getContextPath()%>/index.jsp">返回首页</a><span class="mlr10">|</span><a href="#">注销</a></p>
			<div class="clear"></div>
		</div>
	</div>
	<div class="header">
		<h1 class="mb10"><a href="#"><img alt="黑龙江省国家保密局" src="images/banner.png" width="960" height="150" /></a></h1>
		<div class="navBox">
			<ul class="navList">
				<li><a href="org.jsp">机构职能</a></li>
				<li onclick="openListPage('工作动态');" target="_parent"><a href="javaScript:void(0)">工作动态</a></li>
				<li onclick="openListPage('政策法规');" target="_parent"><a href="javaScript:void(0)">政策法规</a></li>
				<li onclick="openListPage('保密宣传');" target="_parent"><a href="javaScript:void(0)">保密宣传</a></li>
				<li onclick="openListPage('督导检查');" target="_parent"><a href="javaScript:void(0)">督导检查</a></li>
				<li onclick="openListPage('保密科技');" target="_parent"><a href="javaScript:void(0)">保密科技</a></li>
				<li onclick="openListPage('行政许可');" target="_parent"><a href="javaScript:void(0)">行政许可</a></li>
				<li onclick="openListPage('以案说法');" target="_parent"><a href="javaScript:void(0)">以案说法</a></li>
				<li onclick="openListPage('登录网站');" target="_parent"><a href="javaScript:void(0)">登录网站</a></li>
				<li><a href="#">更多</a></li>
			</ul>
		</div>
		<div class="clear"></div>
	</div><!--HEADER END-->
	<div class="pageContent">
		<div class="articleMain">
			<h2 class="articleTlt" id="title">222</h2>
			<div class="articlePrint" id="content">
				<div class="picNewsBox mb20">
					<img class="mb10" alt="" src="images/pic.gif">
					<p class="picNewsInfor">驻叙利亚大使访华</p>
				</div>
				<p class="orgArticle">黑龙江省国家保密局设4个职能处：秘书综合处、检查指导处、宣传法规处、保密科技处。</p> 
			    <p class="orgArticle"><strong>秘书综合处：</strong>负责制定全省保密工作计划并组织实施；组织、指导各市地和省直机关保密工作协作组开展保密活动；负责机关政务工作的组织协调、对外联络、会务和印信管理工作；负责起草委、办、局的重要文稿、领导讲话、工作总结和文电处理工作；负责委、办、局决定事项落实情况的督办、检查和大事记的编写工作；负责人事、组织、党务、工会、老干部等工作；负责机关的接待、财务和行政事务管理等项工作；负责全省保密工作情况综合和《黑龙江保密》简报编辑工作；负责编辑《保密信息专报》，完成局领导交办事项。 </p>
			    <p class="orgArticle"><strong>检查指导处：</strong>检查指导处工作职能：负责检查、指导、协调全省党、政、军、人民团体及企事业单位的保密工作；查处重大泄密事件；组织对重大项目、重要活动和重要会议进行保密检查；监督、检查、指导印刷、复印行业的保密管理工作，核发印制密品《许可证》；负责对涉及国家秘密文件、资料、物品出境的保密审查工作，核发《出境许可证》；负责制定和组织协调全省党政电话专网规划和建设工作，并负责对其进行保密技术检查、验收和保密管理。 </p>
			    <p class="orgArticle"><strong> 宣传法规处：</strong>负责全省保密宣传教育工作；负责制定全省领导干部和保密专兼职干部及涉密人员保密教育培训规划并组织实施；负责全省经管国家秘密事项人员审查登记管理工作；负责组织编写、审查保密宣传教育材料及保密干部、涉密人员培训教材；组织、指导全省党校、干校开展保密教育；组织、指导全省保密工作理论、政策研究；负责利用现代手段开展保密电化教育；负责保密宣传教育材料和《保密工作》杂志通联发行及黑龙江通联站日常工作；负责起草地方性保密法规及保密规章制度，监督、检查全省保密法规的贯彻执行情况；检查指导各地、各部门确定密级工作，对有争议定密事项进行仲裁。</p> 
			    <p class="orgArticle"><strong>保密科技处：</strong>负责全省保密科技发展规划的制订及督查落实；负责全省保密技术检查工作； 负责全省涉密信息系统的审查、审批及日常检查、监督、管理工作； 负责全省涉密信息系统集成资质单位的监督管理工作；负责全省保密技术培训工作；负责全省重要涉密会议、活动、场所的保密技术检查及安全保障工作；负责保密科学技术研究及保密科技产品的选型工作。 </p>
			    <p class="orgArticle"><strong>黑龙江省国家保密局工作职责 </strong></p>
			    <ol class="articleList">
			    	<li>承办中共黑龙江省委保密委员会日常工作，依法履行全省保密行政管理职能。</li>
			    	<li>贯彻党中央、国务院和省委、省政府有关保密工作的方针、政策、决定、指示。 </li>
			    	<li>制定全省保密工作计划并组织实施，提出改革和加强保密工作的全局性、政策性建议。</li>
			    	<li>拟定地方性保密法规，经省人大常委会或省人民政府审定颁布；会同省有关部门制定保密规章制度；负责地方性保密法规的解释。</li>
			    	<li>指导、协调全省党、政、军、人民团体及企事业单位的保密工作；监督、检查全省范围《保密法》及其它保密法规制度的实施情况。</li>
			    	<li>组织开展保密检查，督促有关市地和部门对泄密事件进行查处，参与或组织有关部门对重大的或涉及几个地区、部门的泄密事件的查处工作；组织、协调有关部门对泄露的国家秘密采取补救措施。</li>
			    	<li>组织、指导全省保密宣传教育工作，制定保密宣传教育规划并负责组织实施，组织编写和审定宣传教育材料，利用现代化手段开展形式多样的保密宣传教育活动。</li>
			    	<li>制定全省领导干部保密知识教育和保密干部培训规划并组织实施，指导管理全省经管国家秘密事项人员培训教育；指导全省党校、干校等开展保密教育。</li>
			    	<li>制定全省保密科学技术发展规划并具体组织实施，组织推广、开发、应用保密技术设备；对涉及国家秘密的通信、办公自动化和计算机信息系统的建设项目进行检查、审批、管理，对涉密信息系统的设计、施工单位进行保密技术资格审查。</li>
			    	<li>负责制定全省党政电话专网建设的发展规划，审批协调和组织实施党政专用电话的安装，并负责对其进行保密技术性能检查验收和保密管理。</li>
			    	<li>组织、指导各市地和省直机关、军工保密资格单位保密工作协作组工作。</li>
			    	<li>代表省政府处理有关涉外保密工作事务。</li>
			    	<li>承办省委、省政府交办的其它有关工作。</li>
			    </ol>				
			</div>
			
		</div>
	</div>
	<div class="footer">
		<div class="blogrollBox mb15">
			<h2 class="blogrollTlt">合作媒体</h2>
			<p class="blogroll">
				<a href="#">国家保密技术研究所</a>  
				<a href="#">涉密信息系统安全保密测评中心</a>
				<a href="#">电磁泄密发射防护产品检测中心</a><br />
				<a href="#">上海市国家保密局</a>
				<a href="#">广东市国家保密局</a>
				<a href="#">江苏市国家保密局</a>
				<a href="#">山东省国家保密局</a>
				<a href="#">辽宁省国家保密局</a>
				<a href="#">吉林省国家保密局</a>
				<a href="#">哈尔滨市国家保密局</a>
			</p>
		</div>
		<div class="contact">
			<ul>
				<li><a href="#">网站留言</a></li><li>|</li>
				<li><a href="#">隐私保护</a></li><li>|</li>
				<li><a href="#">版权声明</a></li><li>|</li>
				<li><a href="#">网站地图</a></li><li>|</li>
				<li><a href="#">网管中心</a></li><li>|</li>
				<li><a href="#">保密声明</a></li><li>|</li>
				<li><a href="#">检索中心</a></li><li>|</li>
				<li><a href="#">使用帮助</a></li><li>|</li>
				<li><a href="#">联系我们</a></li>
			</ul>
		</div>
		<div class="clear"></div>
		<p class="address">
			 黑ICP备07003540号<br /> 
版权所有：黑龙江省国家保密局<span class="pr80"></span>地址：哈尔滨市南岗区龙江街38号
		</p>
	</div><!--FOOTER END-->
</body>
</html>