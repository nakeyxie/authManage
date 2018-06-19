layui.use(['form','layer','treeselect'],function(){
    var form = layui.form;
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery;
    var treeselect = layui.treeselect;

    treeselect.render({
        elem: "#dept_select_tree",
        data: webPath+'/dept/tree',//可以是treedata，也可以是 获取treedata的URL地址
        method: "GET"
    });

    /*$("#add_user_btn").click(function(){
        getJsonDataByPost(webPath+"/user/save",$("#addUserForm").serialize(),function(result){
            if(result.code==0){
                layer.msg("保存成功！",{icon: 6});
                layer.closeAll("iframe");
            }else{
                layer.msg(result.msg,{icon:5});
            }
        },false);
    });*/
    form.on("submit(addUser)",function(data){
        getJsonDataByPost(webPath+"/user/save",data.field,function(result){
            if(result.code==0){
                layer.msg("保存成功！",{icon: 6});
                layer.closeAll("iframe");
                //刷新父页面
                parent.location.reload();

            }else{
                layer.msg(result.msg,{icon:5});
            }
        },false);
        return false;
    })

})