layui.use(['form','layer','treeselect'],function(){
    var form = layui.form,
        element = layui.element;
        $ = layui.$;
        layer = parent.layer === undefined ? layui.layer : top.layer;
    var treeselect = layui.treeselect;

    treeselect.render({
            elem: "#aclModule_select_tree",
            data: webPath+'/aclModule/tree',//可以是treedata，也可以是 获取treedata的URL地址
            method: "GET"
        });

    form.on("submit(addaclModule)",function(data){
       getJsonDataByPost(webPath+"/aclModule/save",data.field,function(result){
            if(result.code==0){
                layer.msg("保存成功！",{icon: 6});
                layer.closeAll("iframe");
                top.document.getElementById("refresh_btn").click();
            }else{
                layer.msg(result.msg,{icon:5});
            }
        },false);

        /*$.post(webPath+"/dept/save",data.field,function(result){
            if(result.code==0){
                layer.msg("添加部门成功！");
                layer.closeAll("iframe");
                //刷新父页面
                parent.location.reload();
            }else{
                layer.msg(result.msg,{icon:5});
            }
        })*/
        return false;
    });

});