/*Layui变量初始化**/
//var $ = layui.jquery;
//var jQuery = layui.jquery;
var l = layui.layer;
var form = layui.form;
var laypage = layui.laypage;
var table = layui.table;
var laydate = layui.laydate;
/*//table全选
form.on('checkbox(allChoose)',function(data){
   var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]');
   child.each(function(index, item){
	   item.checked = data.elem.checked;
   });
  form.render('checkbox');
});
form.verify({
	number_: function(value, item){ //value：表单的值、item：表单的DOM对象
	    if(value!=""&&isNaN(value)){
	      return '只能填写数字';
	    }
	  }
});*/
//通用添加或者保存方法
function addOrUpdate(para){
	getHtmlDataByPost(para.url,defined(para.para)?para.para:'',function(form){
		var option={
				type: defined(para.type)?para.type:1,
				content: form,
				shade: false,
				maxmin: false,
				scrollbar:false,
				//shade:0.5//遮罩透明度
			}
		if(defined(para.bl)){
			option["area"]=[$(window).width()<500?$(window).width()+"px":($(window).width()*para.bl[0]+'px'),$(window).height()*para.bl[1]+"px"]
		}else{
			if(defined(para.area)){
				option["area"]=para.area;
			}else{
				option["area"]=[$(window).width()<500?$(window).width()+"px":($(window).width()/2+'px'),$(window).height()-50+"px"]
				/*option["maxWidth"]=$(window).width();
				 option["maxHeight"]=$(window).height()-50;*/
				//option["area"]=[$(window).width()<500?$(window).width():($(window).width()/2+'px')];
			}
		}
		if(defined(para.id)){
			option["id"]=para.id;
		}else{
			option["id"]=para.url.replace(".","").replace("!","").replace("?","").replace("=","").replace("&","");
		}
		if(defined(para.title)){
			option["title"]=para.title;
		}else{
			option["title"]=false;
		}
		if(defined(para.skin)){
			option["skin"]=para.skin;
		}else{
			option["skin"]='layui-layer-molv layui-layer-rim';
		}
		if(defined(para.btnOK)){
			option["btn"]=[para.btnOK, '取消'];
			option['yes']=function(index){//点击保存按钮
				if(defined(para.submit)){
					$(para.submit).click();
				}else{
					$('button[lay-submit]').click();
				}
				//触发表单的提交事件
			}
		}
		option["success"] =function(layero, index){
			if(defined(para.success)){
				para.success(layero, index);
				/*option["success"]=function(layero, index){
					setTimeout(function(){
					layui.layer.tips('点击此处关闭窗口', '.layui-layer-setwin .layui-layer-close', {
						tips: 3
					});
				},500)
				};*/
			}
			$('[lay-verify="required"]').parent().prev().append("<font color='red'>*</font>");
		}
		
		var index = layer.open(option);
		if(defined(para.full)){
			layer.full(index);
		}
		
	},true);
}
function getTableIds(tableId,opt){
	//获取所有选择的列
	var data_ids = "";
	$(table.checkStatus(tableId).data).each(function(i,v){
		if(typeof(opt) == "undefined")
		data_ids+=v.id+",";
		else data_ids+=v[opt]+",";
	});
	if(data_ids){
		return removeLastChar(data_ids);
	}else{
		layer.msg("未勾选任何记录!");
		return false;
	}
}
//根据data-opt 获取所选择的数据
function getdataIds(data_opt){
	//获取所有选择的列
	var data_ids = "";
	$('[data-opt='+data_opt+']').each(function(){
		if($(this).next("div").hasClass("layui-form-checked")){
			data_ids+=$(this).attr("data-id")+",";
		}
	});
	if(data_ids!=""){
		return removeLastChar(data_ids);
	}else{
		layer.msg("未勾选任何记录!");
		return false;
	}
}
//重载layUi表格
function reloadTable(tableId,formId){
	//如果tableId为空，则取当前页面默认的第一个table
	if(typeof(formId) == "undefined"){
		formId = $('form').eq(0).attr("id");
	}
	showLoading();
	table.reload(tableId,{
		  where: getFormArr(formId)//获取form的参数
	});
	$('#'+tableId+' .layui-table-view').width($(window).width()-70);
	hideLoading();
}