function _init(){
	loadNews();
}

//var addressIP='http://localhost:8080';

function loadNews(){
	//url,pramas,callback
	simpleAjax('control','method=loadNews',function(xmlHttp){
		debugger;
		var xmlDoc=xmlHttp.responseXML;
		var datas=xmlDoc.getElementsByTagName("fMenuCode");
		//一共设立几个新闻快
		var count=datas.length;
		
		var menuCode ="";
	
		for(var i=0;i<count;i++){
			var data=datas[i];
			menuCode = data.getAttribute('fMenuCode');
			
			if(menuCode == 'MENU010'){
				 var idSliderDiv = document.getElementById('idSlider');
			}
			var table=	document.getElementById(menuCode);
			
			var picDiv='';
			
			var picDivs='';
			
			if(null!=table){
				//登录后重新生成
				//取出每个<firstMenu>中的所有<new>
				var news=data.getElementsByTagName('new');
				//每个新闻快包含最多9条新闻
				var _count =news.length>6?6:news.length;
				
				//公告只能加载5条 动态9条 其余7条
				if(""!= menuCode && null!= menuCode && menuCode=='MENU009' ){
					_count = news.length>8?8:news.length;
				} else if(""!= menuCode && null!= menuCode && menuCode=='MENU008'){
					_count = news.length>8?8:news.length;
				} else if(""!= menuCode && null!= menuCode && menuCode=='MENU010'){
					_count = news.length>4?4:news.length;
				}
				var lis = "";
				for(var j=0;j<_count;j++){
					var shortTitle=news[j].getAttribute('shortTitle');
					var fNewsTitle = news[j].getAttribute('fNewsTitle');
					var fCreateDate=news[j].getAttribute('fCreateDate');
					var shortDate = fCreateDate.substring(0,19);
					var fIsTop=news[j].getAttribute('picSrc');
					var a=news[j].getAttribute('fNewsContent');
					
					var fID=news[j].getAttribute('fID');
					var li ;
					if(menuCode=='MENU010'){
						li = "<li ><img src=" + '"'+ addressIP + fIsTop + '"'+" width=61px height=45px></li>";
						//picDiv =  "<div class=" + '"'+ "pr" +'"' +"><div class=txtbg></div><span>"+shortTitle+"\</span> <img alt="+'"'+shortTitle+'"' +" src=" + '"' + addressIP+ fIsTop + '"'+" width=245 height=240 onclick='clickTitle(" + fID + ")'/></div>"
						picDiv =  "<div class=" + '"'+ "pr" +'"' +"><div class=txtbg></div><span>"+shortTitle+"\</span> <img alt="+'"'+shortTitle+'"' +" src=" + '"' + addressIP+ fIsTop + '"'+" width=245 height=240 onclick="+'"'+"clickTitle("+"'"+fID+"'"+");"+'"'+"/></div>"
					} else if (menuCode=='MENU008' || menuCode=='MENU111' || menuCode=='MENU112'){
						li = "<li onclick="+'"'+"clickTitle("+"'"+fID+"'"+");"+'"'+"target='_parent'><a href="+'"'+"javaScript:void(0)"+'"'+" title="+"'"+fNewsTitle+"   "+shortDate+"'"+">"+shortTitle+"<span class='right mt_6'>"+shortDate+"</span></a></li>";
					} else {
						li = "<li onclick="+'"'+"clickTitle("+"'"+fID+"'"+");"+'"'+"target='_parent'><a href="+'"'+"javaScript:void(0)"+'"'+" title="+"'"+fNewsTitle+"   "+shortDate+"'"+">"+shortTitle+"</a></li>";
					}
					
					lis += li;
					if(picDiv){
						picDivs += picDiv;
					}
					
				}
				
				if(menuCode=='MENU008'){
					lis += "<li class='panelLast'><a class='more' href='#' onclick=" + '"' +"openListPage('MENU008')"+'"'+">更多 > ></a></li>";
					
				} else if(menuCode=='MENU111'){
					lis += "<li class='panelLast'><a class='more' href='#' onclick=" + '"' +"openListPage('MENU111')"+'"'+">更多 > ></a></li>";
				} else if(menuCode=='MENU112'){
					lis += "<li class='panelLast'><a class='more' href='#' onclick=" + '"' +"openListPage('MENU112')"+'"'+">更多 > ></a></li>";
				}
				
				table.innerHTML = lis;
				if( idSliderDiv && picDivs ){
					idSliderDiv.innerHTML = picDivs;
				}
			}
		}
	});
}

function getSafeLevel(level){
	
	if('1'==level){
		return '非密';
	}else if('2'==level){
		return '秘密';
	}else if('3'==level){
		return '机密';
	}
}

function float() { 
		var x = 50,y = 60 ;
		var xin = true, yin = true ;
		var step = 1 ;
		var delay = 10 ;
		var obj=document.getElementById("codefans_net") ;
		
		var itl= setInterval("float()", delay) ;
		obj.onmouseover=function(){clearInterval(itl)} ;
		obj.onmouseout=function(){itl=setInterval("float()", delay)} ;
		var L=T=0;
		var R= document.body.clientWidth-obj.offsetWidth ;
		var B = document.body.clientHeight-obj.offsetHeight ;
		obj.style.left = x + document.body.scrollLeft ;
		obj.style.top = y + document.body.scrollTop ;
		x = x + step*(xin?1:-1) ;
		if (x < L) { xin = true; x = L} ;
		if (x > R){ xin = false; x = R} ;
		y = y + step*(yin?1:-1) ;
		if (y < T) { yin = true; y = T } ;
		if (y > B) { yin = false; y = B } ;
} 

function Addme() {
	var  url = document.URL;  
	var title = "新疆维吾尔自治区国家保密局网站";  
    window.external.AddFavorite(url, title);
}

function SetHome(obj,vrl){
    try{
            obj.style.behavior='url(#default#homepage)';obj.setHomePage(vrl);
    }
    catch(e){
            if(window.netscape) {
                    try {
                            netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
                    }
                    catch (e) {
                            alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。");
                    }
                    var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
                    prefs.setCharPref('browser.startup.homepage',vrl);
             }
    }
}

function getDate(){   
	var date=new Date();   
	var month=date.getMonth()+1;   
	var day=date.getDate();   
	  
	if(month.toString().length == 1){  //或者用if (eval(month) <10) {month="0"+month}   
	  
	month='0'+month;   
	}   
	if(day.toString().length == 1){   
	day='0'+day;   
	}   
	return date.getYear()+'/'+month+'/'+day+'  '+date.toLocaleString().substring(date.toLocaleString().length-10)+'  '+'星期'+'日一二三四五六'.charAt(date.getDay());   
	}  