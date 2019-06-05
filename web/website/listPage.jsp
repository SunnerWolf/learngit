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
<style type="text/css">
.pageMore{margin:2em auto; width:50%;}
.pageMore a{text-decoration:none;display:inline-block;line-height:14px;padding:2px 5px;color:#333;border:1px solid #ccc;margin:0 2px;}
.pageMore a:hover,.page a.on{background:#999;color:#fff;border:1px solid #333;}
.pageMore a.unclick,.page a.unclick:hover{background:none;border:1px solid #eee;color:#999;cursor:default;}
.pageMore a.pageSelected{ background:#eee; border:1px solid #333;}
</style>
<script type="text/javaScript">
function _init() {
	onloadTable();
	var totalPage = '<%=request.getAttribute("totalPage")%>';
	if(totalPage == 0){
	    setPage(document.getElementById('lll'),1,1);
	} else{
	    setPage(document.getElementById('lll'),totalPage,1);
	}
}

function openListPage(fMenuCode) {
	window.open('<%=request.getContextPath()%>/control?method=loadListPage&fMenuCode='+fMenuCode+'&action=firstPage&isDirect=true', '_parent');
}

function setPicTitle(fMenuName){
	document.getElementById('picTitle').innerHTML=fMenuName;
	document.getElementById('leftPicTitle').innerHTML=fMenuName;
	
}

function changePage(action){
	simpleAjax('control', 'method=loadListPage&name='+_name+'&action='+action,function(xmlHttp) {
		createTable(varToXml(xmlHttp.responseText));
	});
}
function openApplication(){
		
	window.open('<%=request.getContextPath()%>/ApplicationList.jsp', '_parent');
}
function onloadTable(){
		var _xmlDoc='<%=request.getAttribute("xmlData")%>';
		createTable(varToXml(_xmlDoc));
	}
	var _name='';
function createTable(xmlDoc){
	var datas=xmlDoc.getElementsByTagName("fMenuCode");
	
	if(datas.length>0){
		var data=datas[0];
		var table=document.getElementById('listTable');
		//取子模块名称
		var childMenu=null;
		var fMenuCode = data.getAttribute('fMenuCode');
		var menu1 = data.getAttribute('menu');
		if(menu1){
			if(menu1=='MENU001'){
				_name="保密宣传";
			}else if (menu1=='MENU002'){
				_name="保密科技";
			}else if (menu1=='MENU003'){
				_name="政策法规";
			}else if (menu1=='MENU004'){
				_name="监督检查";
			}else if (menu1=='MENU005'){
				_name="测评审批";
			}else if (menu1=='MENU006'){
				_name="服务保障";
			}else if (menu1=='MENU007'){
				_name="保密工作";
			}else if (menu1=='MENU008'){
				_name="工作动态";
			}else if (menu1=='MENU009'){
				_name="公告";
			}else if (menu1=='MENU010'){
				_name="图片新闻";
			}else if (menu1=='MENU013'){
				_name="改革最强音";
			}else if (menu1=='MENU014'){
				_name="党建工作专栏";
			}else if (menu1=='MENU015'){
				_name="精神文明专栏";
			}else if (menu1=='MENU016'){
				_name="群众路线专栏";
			}
			setPicTitle(_name);		
		}
		var childTable=document.getElementById('childMenu');
		if(fMenuCode=='MENU008' || fMenuCode=='MENU111' || fMenuCode=='MENU112'){
		var childLi ="<li onclick="+'"'+"openListPage("+"'"+"MENU008"+"'"+");"+'"'+"target='_parent'><a href="+'"'+"javaScript:void(0)"+'"'+"> >> 最新动态</a></li>"+"<li onclick="+'"'+"openListPage("+"'"+"MENU111"+"'"+");"+'"'+"target='_parent'><a href="+'"'+"javaScript:void(0)"+'"'+"> >> 自治区动态</a></li>"+"<li onclick="+'"'+"openListPage("+"'"+"MENU112"+"'"+");"+'"'+"target='_parent'><a href="+'"'+"javaScript:void(0)"+'"'+"> >> 地州市动态</a></li>"; 
				childTable.innerHTML = childLi;
		}
		var lis = ""; 
		if(null!=table){
			removeAllTr();
			var news=data.getElementsByTagName('new');
			var _count=news.length>15?15:news.length;
			
			for(var j=0;j<_count;j++){
				_name=news[j].getAttribute('fMenuName');
				if(fMenuCode=='MENU111' || fMenuCode=='MENU112'){
				_name="工作动态";
				}
				setPicTitle(_name);
				var fNewsTitle = news[j].getAttribute('fNewsTitle');
				var titleSize=38;
				var shortTitle = fNewsTitle;									//要展示的字符串
					//标题超过30个字要进行省略
					if(fNewsTitle.length > titleSize){ 
						shortTitle = fNewsTitle.substring(0,titleSize)+" "+"...";
						}
				var fCreateDate = news[j].getAttribute('fCreateDate');
				var shortDate = fCreateDate.substring(0,19);
				//title=title+' ('+getSafeLevel(news[j].getAttribute('fSafeLevelCode'))+')';
				var fID=news[j].getAttribute('fID');
				var li = '<li><a href="javaScript:void(0)" target="_parent" title='+fNewsTitle+' onclick="clickTitle(\''+fID+'\')">'+shortTitle+'</a><span class='+'"'+'pl43'+'"'+'>'+shortDate+'</span>';
				lis+=li;
				
				table.innerHTML = lis;
			}
		}else{
			if (menu1=='MENU001'){
				_name="保密宣传";
				}else if (menu1=='MENU002'){
				_name="保密科技";
				}else if (menu1=='MENU003'){
				_name="政策法规";
				}
				setPicTitle(_name);
		}
		
	}
}

function getSafeLevel(level){
	if('1'==level){
		return '普通';
	}else if('2'==level){
		return '秘密';
	}else if('3'==level){
		return '机密';
	}
}
function removeAllTr(){
	var table=document.getElementById('listTable');
	var tempTr=table.firstChild;
	while(tempTr!=null){
		table.removeChild(tempTr);
		tempTr=table.firstChild;
	}
}

function clickTitle(fID){
	window.open('<%=request.getContextPath()%>/control?method=loadContentPage&fID='+fID, '_parent');
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
};
//container 容器，count 总页数 pageindex 当前页数
function setPage(container, count, pageindex) {
debugger
var container = container;
var count = count;
var pageindex = pageindex;
var a = [];
  //总页数少于10 全部显示,大于10 显示前3 后3 中间3 其余....
  if (pageindex == 1) {
    a[a.length] = "<a href=\"#\" class=\"prev unclick\">上一页</a>";
  } else {
    a[a.length] = "<a href=\"#\" class=\"prev\">上一页</a>";
  }
  debugger;
  function setPageList() {
    if (pageindex == i) {
      a[a.length] = "<a href=\"#\" class=\"on\">" + i + "</a>";
    } else {
      a[a.length] = "<a href=\"#\">" + i + "</a>";
    }
  }
  //总页数小于10
  if (count <= 10) {
    for (var i = 1; i <= count; i++) {
      setPageList();
    }
  }
  //总页数大于10页
  else {
    if (pageindex <= 4) {
      for (var i = 1; i <= 5; i++) {
        setPageList();
      }
      a[a.length] = "...<a href=\"#\">" + count + "</a>";
    } else if (pageindex >= count - 3) {
      a[a.length] = "<a href=\"#\">1</a>...";
      for (var i = count - 4; i <= count; i++) {
        setPageList();
      }
    }
    else { //当前页在中间部分
      a[a.length] = "<a href=\"#\">1</a>...";
      for (var i = pageindex - 2; i <= pageindex + 2; i++) {
        setPageList();
      }
      a[a.length] = "...<a class='pageSelected' href=\"#\">" + count + "</a>";
    }
  }
  if (pageindex == count) {
    a[a.length] = "<a href=\"#\" class=\"next unclick\">下一页</a>";
  } else {
    a[a.length] = "<a href=\"#\" class=\"next\">下一页</a>";
  }
  container.innerHTML = a.join("");
  //事件点击
  var pageClick = function() {
    var oAlink = container.getElementsByTagName("a");
    var inx = pageindex; //初始的页码
    oAlink[0].onclick = function() { //点击上一页
      if (inx == 1) {
        return false;
      }
      inx--;
      changePage('previousPage');
      setPage(container, count, inx);
      return false;
    }
    for (var i = 1; i < oAlink.length - 1; i++) { //点击页码
      oAlink[i].onclick = function() {
        inx = parseInt(this.innerHTML);
         changePage(inx);
        setPage(container, count, inx);
        return false;
      }
    }
    oAlink[oAlink.length - 1].onclick = function() { //点击下一页
      if (inx == count) {
        return false;
      }
      inx++;
      changePage('nextPage');
      setPage(container, count, inx);
      return false;
    }
  } ()
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
			<div class="clear"></div>
		</div>
	</div>
	<div class="clear"></div>
	<div class="content">
		<!-- <div class="welcomeBox">
			<p class="left">您好,欢迎登陆新疆保密综合业务网！</p>
	</div>
	 -->
		<div class="clear"></div>
		<div class="pageList_nav">
			<h2 class="pagenavTlt" id="leftPicTitle"></h2>
			<ul class="pageNav" id="childMenu" >
			</ul>
		</div>
		<div class="pageList_content">
			<div class="location">
				<h2 class="locationTxt"><span class="yourLocation">您的位置 </span><span class="pl41"><a href="<%=request.getContextPath()%>/index.jsp">首页>></a></span><span class="pl40" id="picTitle"></span></h2>
			</div>
			<ul class="pageList" id="listTable">
			</ul>
			<div class="clear"></div>
			<div class="pageMore" id="lll"></div>
			
		</div>
		<div class="clear"></div>
	</div>
	<div class="page"></div>
	<div class="clear"></div>
	
</body>
</html>
