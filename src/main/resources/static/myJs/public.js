function getJsonDataByPost(url,para,onLoadSuccess,isShowLoding){
	if(isShowLoding)showLoading();
	var type = "post";
	var async = true;
	var dataType = "Json";
	var timeout = 100000;
	var data=para;
	
	$.ajax({
		type : type,
		url : url,
		async : async,
		dataType : dataType,
		timeout : timeout,
		data : data,
		success : function(data, statu) {
			if(isShowLoding)hideLoading();
			onLoadSuccess(data); 
		},
		error : function(XMLHttpRequest, textStatus, errorThrown){
			if(isShowLoding)hideLoading();
		}
	});
}
/**
 * Ajax发送post请求，返回数据类型为html
 * @param url           请求地址
 * @param parameters    post参数
 * @param onLoadSuccess Ajax请求成功后回调函数
 */
function getHtmlDataByPost(url, parameters, onLoadSuccess,isShowLoding){
	if(isShowLoding)showLoading();
	var type = "POST";
	var async = true;
	var dataType = "html";
	var timeout = 10000;
	var data = parameters;
	
	$.ajax({
		type : type,
		url : url,
		async : async,
		dataType : dataType,
		timeout : timeout,
		data : data,
		success : function(data, statu){
			if(isShowLoding)hideLoading();
			onLoadSuccess(data);
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			hideLoading();
		}
	});
}
function getJsonByajaxForm(formId,url,onLoadSuccess,isShowLoding){
	if(typeof(url) == "undefined"||url=='')url=$('#'+formId).attr("action");
	if(isShowLoding)showLoading();
	$.ajax({
		type : "post",
		async : true,
		dataType : 'json',
		url : url,
		data: $('#'+formId).serialize(),
		timeout:10000,//0是没有时间显示
		success : function(data){
			if(isShowLoding)hideLoading();
			onLoadSuccess(data);
		},
		error:function(response,opts){
			if(isShowLoding)hideLoading();
			l.alert("系统故障，请联系管理员!");
			return false;
		}
	});
}
function getHTMLByajaxForm(formID,url,onLoadSuccess,isShowLoding){
	if(typeof(url) == "undefined"||url=='')url=$('#'+formId).attr("action");
	if(isShowLoding)showLoading();
	$.ajax({
		type : "post",
		async : true,
		dataType : 'html',
		url : url,
		data: $('#'+formId).serialize(),
		timeout:10000,//0是没有时间显示
		success : function(data){
			if(isShowLoding)hideLoading();
			onLoadSuccess(data);
		},
		error:function(response,opts){
			if(isShowLoding)hideLoading();
			l.alert("系统故障，请联系管理员!");
			return false;
		}
	});
}
function defined(para){
	return typeof(para)!="undefined"&&para!="";
}
//unicode解码
function reconvert(str){
	str = str.replace(/(\\u)(\w{4})/gi,function($0){ 
	return (String.fromCharCode(parseInt((escape($0).replace(/(%5Cu)(\w{4})/g,"$2")),16))); 
	});
	
	str = str.replace(/(&#x)(\w{4});/gi,function($0){ 
	return String.fromCharCode(parseInt(escape($0).replace(/(%26%23x)(\w{4})(%3B)/g,"$2"),16)); 
	});
	return str;
}

function openAwidow(url){
	var iWidth = 1200 ;
	var iHeight = 700 ;
	var iTop = ( window . screen . availHeight - 30 - iHeight ) / 2 ;
	var iLeft = ( window . screen . availWidth - 10 - iWidth ) / 2 ;
	window.open (url, "newwindow", "height="+iHeight+", width="+iWidth+", top="+iTop+",left="+iLeft+",toolbar=no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no");
}
//根据formId获取参数数组
function getFormArr(formId){
	var arr = {};
	$($('#'+formId).serializeArray()).each(function(i,v){
		arr[v.name]=v.value;
	});
	return arr;
}
/**
 * 自动填充表单
 * @param obj:json数据
 */
function fillForm(obj,id){
	  var key,value,tagName,type,arr;
	  for(x in obj){
	    key = x;
	    value = obj[x];
	    $("#"+id+" [name='"+key+"'],#"+id+" [name='"+key+"[]']").each(function(){
	      tagName = $(this)[0].tagName;
	      type = $(this).attr('type');
	      if(tagName=='INPUT'){
	        if(type=='radio'){
	          $(this).attr('checked',$(this).val()==value);
	        }else if(type=='checkbox'){
	          arr = value.split(',');
	          for(var i =0;i<arr.length;i++){
	            if($(this).val()==arr[i]){
	              $(this).attr('checked',true);
	              break;
	            }
	          }
	        }else{
	          $(this).val(value);
	        }
	      }else if(tagName=='SELECT' || tagName=='TEXTAREA'){
	        $(this).val(value);
	      }else if(tagName=='DIV'){
	        $(this).html(value);
	      }
	      
	    });
	  }
}
function getsuffix(file_name){
	var result = file_name.substr(file_name.lastIndexOf("."));
	return result;
}
function removeLastChar(str){
	return str.substring(0,str.length-1);
}
function showAlert(title){
	l.msg(title);
}
/**
 * 显示等待框
 * @param title
 * @returns
 */
function showLoading(title){
	layer.load();
}
/**
 * 关闭等待框
 * @param title
 * @returns
 */
function hideLoading(){
	//layer.close(layer.index);
	layer.closeAll('loading'); //关闭加载层
	
	
}

function getQueryString(name,url) {
	var str= new Array(); 
	str = url.split('?');
	if(str != null){
		  var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
		    var r = str[1].match(reg);
		    if (r != null) {
		    	return unescape(r[2]); 
		    }
	}
    return "";
 }

//百分比转小数
function per2num(per) {
    return per.replace(/([0-9.]+)%/, function (a, b) {return +b / 100;})
}
function copy(text2copy){
		var flashcopier = 'flashcopier'; 
		if(!document.getElementById(flashcopier)){   
			var divholder = document.createElement('div');  
			divholder.id = flashcopier;  
			document.body.appendChild(divholder); 
			} 
		document.getElementById(flashcopier).innerHTML = ''; 
		var divinfo = '<embed src="http://files.jb51.net/demoimg/200910/_clipboard.swf" FlashVars="clipboard='+text2copy+'" width="0" height="0" type="application/x-shockwave-flash"></embed>';//这里是关键   document.getElementById(flashcopier).innerHTML = divinfo; } 
}


/**
 * 获取数据ajax-get请求
 * @author laixm
 */
$.getJSON = function (url,data,callback){
    $.ajax({
        url:url,
        type:"get",
        //contentType:"application/json",
        dataType:"json",
        timeout:10000,
        data:data,
        success:function(data){
            callback(data);
        }
    });
};

/**
 * 提交json数据的post请求
 * @author laixm
 */
$.postJSON = function(url,data,callback){
    $.ajax({
        url:url,
        type:"post",
        //contentType:"application/json",
        dataType:"json",
        data:data,
        timeout:60000,
        success:function(msg){
            callback(msg);
        },
        error:function(xhr,textstatus,thrown){

        }
    });
};

/**
 * 修改数据的ajax-put请求
 * @author laixm
 */
$.putJSON = function(url,data,callback){
    $.ajax({
        url:url,
        type:"put",
        //contentType:"application/json",
        dataType:"json",
        data:data,
        timeout:20000,
        success:function(msg){
            callback(msg);
        },
        error:function(xhr,textstatus,thrown){

        }
    });
};
/**
 * 删除数据的ajax-delete请求
 * @author laixm
 */
$.deleteJSON = function(url,data,callback){
    $.ajax({
        url:url,
        type:"delete",
       // contentType:"application/json",
        dataType:"json",
        data:data,
        success:function(msg){
            callback(msg);
        },
        error:function(xhr,textstatus,thrown){

        }
    });
};