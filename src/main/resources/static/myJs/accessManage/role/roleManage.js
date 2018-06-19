var roleId ;
layui.use(['form','layer','table','laytpl','element','tree'],function(){
    var form = layui.form;
    layer = parent.layer === undefined ? layui.layer : top.layer;
    var layer1 = layui.layer;
    $ = layui.jquery;
    var  table = layui.table;
    var element = layui.element;
    var laytpl = layui.laytpl;

    var roleTree = null;
    function loadTree(){
        $.ajax({
            url : webPath+'/role/list',
            type : 'GET',
            dataType : 'JSON',
            success : function (result){
                roleTree = layui.tree({
                    elem: '#roleTree'
                    ,nodes: result
                    ,click: function(node){
                        roleId = node.id;
                        $(".role_name_b").text(node.name);
                        loadRoleAclTree(roleId);
                        loadRoleUserTree(roleId);
                        $("#role_user_view_div").empty();
                        $("#role_acl_view_div").empty();
                        $("#role_acl_content_div").show();
                        $("#role_user_content_div").show();
                    }
                });
                $("#roleTree").on("mousedown",".layui-tree a cite",function(){
                    $(".layui-tree a cite").css('color','#336699');
                    $(this).css('color','red');

                })

            }
        });

    }
    loadTree();

    var aclTree = null;
    var userTree = null;
    //角色与权限
    function loadRoleAclTree(roleId){
        $.ajax({
            url : webPath+'/role/aclList?roleId='+roleId,
            type : 'GET',
            dataType : 'JSON',
            success : function (result){
                $("#role-acl-tree").empty();
                aclTree = layui.tree({
                    elem: '#role-acl-tree'
                    ,nodes: result
                    ,check : 'checkbox'
                    ,click: function(node){

                    }
                });
            }
        });

    }
    //角色与用户
    function loadRoleUserTree(roleId){
        $.ajax({
            url : webPath+'/role/userList?roleId='+roleId,
            type : 'GET',
            dataType : 'JSON',
            success : function (result){
                $("#role-user-tree").empty();
                userTree = layui.tree({
                    elem: '#role-user-tree'
                    ,nodes: result
                    ,check : 'checkbox'
                    ,click: function(node){

                    }
                });
            }
        });
    }



    //显示已选择
    $("#view_role_acl").click(function () {
        var data = aclTree.getChecked(true);
        $("#role_acl_view_div").empty();
        for(var i in data){
            if(data[i].type)
                $("#role_acl_view_div").append('<p>'+data[i].name+'</p>');
        }
    });
    $("#view_role_user").click(function () {
        var data = userTree.getChecked(true);
        $("#role_user_view_div").empty();
        for(var i in data){
            if(data[i].type)
                $("#role_user_view_div").append('<p>'+data[i].name+'</p>');
        }
    });
    //保存角色与权限
    $("#save_role_acl").click(function () {
        var data = aclTree.getChecked(true);

        var aclIds = $(data).map(function (i,d) {
            if(d.type) return d.id;
        }).get().join(",");

        getJsonDataByPost(webPath+"/role/saveRoleAcl",{"roleId":roleId,"aclIds":aclIds},function(result){
            if(result.code==0){
                layer.msg("保存成功！",{icon: 6});
            }else{
                layer.msg(result.msg,{icon:5});
            }
        },false);
    });

    //保存角色与用户
    $("#save_role_user").click(function () {
        var data = userTree.getChecked(true);

        var userIds = $(data).map(function (i,d) {
            if(d.type) return d.id;
        }).get().join(",");

        getJsonDataByPost(webPath+"/role/saveRoleUser",{"roleId":roleId,"userIds":userIds},function(result){
            if(result.code==0){
                layer.msg("保存成功！",{icon: 6});
            }else{
                layer.msg(result.msg,{icon:5});
            }
        },false);
    });
    
    

    $("#add_role_a").click(addRole);
    $("#edit_role_a").click(editRole);
    $("#delete_role_a").click(deleteRole);

    function loadSaveRoleForm(data){
        var rolehtml = "";
        laytpl($('#save_role_html').html()).render(data, function(html){
            rolehtml = html;
        });
        return rolehtml;
    }
    var thisLocation = location;
    function saveRole(index){

        getJsonDataByPost(webPath+"/role/save",$("#saveRoleForm",top.document).serialize(),function(result){
            if(result.code==0){
                layer.msg("保存成功！",{icon: 6});
                layer.close(index);
                //刷新父页面
                thisLocation.reload();

            }else{
                layer.msg(result.msg,{icon:5});
            }
        },false);
    }
    //添加角色
    function addRole(){
        if(!roleTree) return;
        layer.open({
            type: 1,
            title: false,
            title: '添加角色',
            shadeClose: true,
            shade: 0.5,
            skin:'demo-class',
            maxmin: true, //开启最大化最小化按钮
            area: ['50%'],
            shift: 2,
            content: loadSaveRoleForm({id:'',name:'',remark:''}),
            btn : ['保存','取消'],
            success: function (layero) {
                var btn = layero.find('.layui-layer-btn');
                btn.css('text-align', 'center');
                $("#role_name_input").focus();
            },
            yes : function (index) {
                saveRole(index);
            },
            btn2 : function (index) {
                layer.close(index);
            }
        });
    }
    //编辑角色
    function editRole() {
        if(!roleId){
            layer1.tips('请选择一个角色', '#edit_role_a', {
                tips: [1, '#FF5722'],
                time: 2000
            });
            return;
        }
        $.getJSON(webPath+"/role/"+roleId,null,function (result) {
            if(result.code == 0){
                console.log(result.data)
                layer.open({
                    type: 1,
                    title: false,
                    title: '编辑角色',
                    shadeClose: true,
                    shade: 0.5,
                    skin:'demo-class',
                    maxmin: true, //开启最大化最小化按钮
                    area: ['50%'],
                    shift: 2,
                    content: loadSaveRoleForm(result.data),
                    btn : ['保存','取消'],
                    success: function (layero) {
                        var btn = layero.find('.layui-layer-btn');
                        btn.css('text-align', 'center');
                        $("#role_name_input").focus();
                    },
                    yes : function (index) {
                        saveRole(index);
                    },
                    btn2 : function (index) {
                        layer.close(index);
                    }
                });
            }else {
                layer.msg("打开页面失败",{icon:5});
            }
        })


    }
    //删除角色
    function deleteRole(){
        if(!roleId){
            layer1.tips('请选择一个角色', '#delete_role_a', {
                tips: [1, '#FF5722'],
                time: 2000
            });
            return;
        }
        layer.confirm('您确认删除这个角色吗？', {
            btn: ['确认','取消'] //按钮
        }, function(index){
            $.deleteJSON(webPath+"/role/delete/"+roleId,null,function(result){
                if(result.code==0){
                    thisLocation.reload();
                    layer.close(index);
                }else{
                    layer.msg(result.msg,{icon : 5 });
                    layer.close(index);
                }
            })
        }, function(index){
            layer.close(index);
        });
    }
})
