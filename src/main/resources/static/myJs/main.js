var url = window.location.pathname;
var webPath = url.substring(0,url.indexOf("/",2));
/*$(function () {
    if($("#contextPath")){
        webPath = $("#contextPath").val()? $("#contextPath").val():'';
    }
    console.log(webPath)
});*/
layui.config({
    base : webPath+"/myJs/modules/"
}).extend({
    "bodyTab" : "bodyTab",
    "treeselect" : "treeselect"
});
/**
 * 设置未来(全局)的AJAX请求默认选项
 * 主要设置了AJAX请求遇到Session过期的情况
 */
$.ajaxSetup({
    contentType:"application/x-www-form-urlencoded;charset=utf-8",
    complete: function(xhr,status) {
        var sessionStatus = xhr.getResponseHeader('sessionstatus');
        if(sessionStatus == 'timeout') {
            var top = getTopWinow();

            layer.confirm('由于您长时间没有操作, 请重新登录。', {
                btn: ['确定','取消'] //按钮
            }, function(index){
                layer.close(index);
                top.location.href=webPath+'/preLogin';
            }, function(index){
                layer.close(index);
            });
        }
    }
});

/**
 * 在页面中任何嵌套层次的窗口中获取顶层窗口
 * @return 当前页面的顶层窗口对象
 */
function getTopWinow(){
    var p = window;
    while(p != p.parent){
        p = p.parent;
    }
    return p;
}

