
function simpleAjax(url, param, callback) {
	
	var xmlHttp ; // 启动xmlhttprequest
	if (window.XMLHttpRequest) { // Mozilla, Safari,...火狐
		xmlHttp = new XMLHttpRequest();
		
	} else if (window.ActiveXObject) { 
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				//xmlHttp = new ActiveXObject("Microsoft.XMLDOM");
				//xmlHttp.async="false";
			} catch (e) {
			}
		}
	}
	// 浏览器不支持ajax
	if (!xmlHttp) {
		alert('无法创建XMLHttpRequest,请使用标准浏览器');
		return false;
	}
	xmlHttp.onreadystatechange = function() {
		// readyState的取值如下: 0 (未初始化) 1 (正在装载) 2(装载完毕) 3 (交互中) 4 (完成)
		if (xmlHttp.readyState == 4){
			if (xmlHttp.status == 200)
			{
				// responseText – 以文本字符串的方式返回服务器的响应
				// responseXML –以XMLDocument对象方式返回响应.处理XMLDocument对象可以用JavaScript DOM函数
				if (callback != null) {
					callback(xmlHttp);
				}
			} else {
				alert('请求失败');
			}
		}

	};
	xmlHttp.open('post', url, true);// 异步通信吗??
	// 定义传输的文件HTTP头信息
	xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xmlHttp.send(param);
}