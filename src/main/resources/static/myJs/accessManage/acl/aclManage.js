var aclModuleId = null;//被点击的部门Id
var aclModuleIdAll = null;//被点击的部门Id和所有子部门Id
layui.use(['form','layer','table','laytpl','tree'],function(){
    var form = layui.form;
    layer = parent.layer === undefined ? layui.layer : top.layer;
    var layer1 = layui.layer;
    $ = layui.jquery;
    var  table = layui.table;


    function loadAclModuleTree(){
        $.ajax({
            url : webPath+'/aclModule/tree',
            type : 'GET',
            dataType : 'JSON',
            success : function (result){
                layui.tree({
                    elem: '#aclModuleTree'
                    ,nodes: result
                    ,click: function(node){
                        aclModuleId = node.id;
                        var aclModuleIds = node.id;
                        if(node.children){
                            aclModuleIds +=getaclModuleIds(node.children);
                        }
                        //点击加载用户列表
                        loadAcl(aclModuleId);
                        aclModuleIdAll = aclModuleIds;
                    }
                });
                $("body").on("mousedown",".layui-tree a cite",function(){
                    $(".layui-tree a cite").css('color','#336699')
                    $(this).css('color','red')

                })
            }
        });

        var getaclModuleIds = function (data){
            var aclModuleIds = "";
            for(var i = 0;i<data.length;i++){
                aclModuleIds += ",";
                aclModuleIds += data[i].id;
                if(data.children){
                    aclModuleIds +=getaclModuleIds(data[i].children);
                }
            }
            return aclModuleIds;
        }

    }
    loadAclModuleTree();
    var tableIns = null;

    function loadAcl(aclModuleId) {
        //权限列表
        tableIns = table.render({
            elem: '#aclList',
            url : webPath+'/acl/list/'+aclModuleId,
            cellMinWidth: 60,
            page : true,
            width : $("#acl_table_div").width()-30,
            height : "full-170",
            limits : [10,15,20,25],
            limit : 10,
            id : "aclListTable",
            cols : [[
                {type: "checkbox", fixed:"left"},
                {field: 'id', title: 'ID',  align:"center", sort: true,style:'display:none;'},
                {field: 'name', title: '名称', align:"center",sort: true,minWidth:200},
                {field: 'aclModuleName', title: '模块', align:"center", sort: true},
                {field: 'url', title: '请求Url',minWidth:200,  align:'center'},
                {field: 'type', title: '类型',  align:'center', sort: true,templet:function(d){
                        if(d.type == "2"){
                            return '<button class="layui-btn layui-btn-xs layui-btn-danger">按钮</button>';
                        }else if(d.type == "1"){
                            return '<button class="layui-btn layui-btn-xs layui-btn-normal">菜单</button>';
                        }
                    }},
                {field: 'status', title: '状态',  align:'center', sort: true,templet:function(d){
                        if(d.status == "2"){
                            return '<button class="layui-btn layui-btn-xs layui-btn-danger">禁用</button>';
                        }else if(d.status == "1"){
                            return '<button class="layui-btn layui-btn-xs layui-btn-normal">启用</button>';
                        }
                    }},
                {field: 'job', title: '职位',  align:"center", sort: true},
                {field: 'deptname', title: '部门',  align:"center", sort: true},
                {title: '操作', minWidth:175,fixed:"right",align:"center",templet:function(d){
                        if(d.status == "2"){
                            return '<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>' +
                                '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="usable">已禁用</a>' +
                                '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>';
                        }else if(d.status == "1"){
                            return '<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>' +
                                '<a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="usable">已启用</a>' +
                                '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>';
                        }
                    }}
            ]],
            done: function(res, curr, count){
                $("[data-field='id']").css('display','none');
            }
        });
    }




    //添加用户
    function addAcl(edit){
        var title = "添加权限";
        if(edit){
            title = "编辑权限";
        }

        layer.open({
            type: 2,
            title: title,
            shadeClose: true,
            shade: 0.5,
            skin:'demo-class',
            maxmin: true, //开启最大化最小化按钮
            area: ['80%', '80%'],
            content: webPath+'/acl/preAdd?aclId='+(edit?edit.id:''), //iframe的url，
            /*btn : ['保存','取消'],
            yes : function(index, layero){
                var body = layer.getChildFrame("body", index);
                body.find("#add_user_btn").click();
            },
            btn2 : function(index, layero){
                return false;
            },
            cancel : function(){
                if($(".layui-laypage-btn")){
                    $(".layui-laypage-btn")[0].click();
                }
            }*/
        });
    }
    $(".addAcl_btn").click(function(){
        addAcl();
    })

    //批量删除
    $(".delAll_btn").click(function(){
        var checkStatus = table.checkStatus('aclListTable'),
            data = checkStatus.data;
        if(data.length > 0) {
            /* for (var i in data) {
                 newsId.push(data[i].newsId);
             }*/
            var aclIds = $(data).map(function(key,values){
                return values.id;
            }).get().join(",");
            layer.confirm('确定删除选中的权限？', {icon: 3, title: '提示信息'}, function (index) {
                $.deleteJSON(webPath+"/acl/delete/"+aclIds,null,function(result){
                    if(result.code == 0){
                        tableIns.reload();
                        layer.close(index);
                    }else{
                        layer.msg(result.msg,{icon : 5 });
                        layer.close(index);
                    }
                })


            })
        }else{
            layer.msg("请选择需要删除的用户");
        }
    })

    //列表操作
    table.on('tool(aclList)', function(obj){
        var layEvent = obj.event,
            data = obj.data;

        if(layEvent === 'edit'){ //编辑
            addAcl(data);
        }else if(layEvent === 'usable'){ //启用禁用
            var type = 1;
            var _this = $(this),
                usableText = "是否确定禁用此权限？";
            type = 2;
            btnText = "已禁用";
            if(_this.text()=="已禁用"){
                usableText = "是否确定启用此权限？";
                type = 1;
                btnText = "已启用";
            }
            layer.confirm(usableText,{
                icon: 3,
                title:'系统提示',
                cancel : function(index){
                    layer.close(index);
                }
            },function(index){

                //修改用户状态
                $.putJSON(webPath+"/acl/status/"+data.id,{status : type},function(result){
                    if(result.code == 0){

                        if(type==2){
                            _this.removeClass("layui-btn-warm").addClass("layui-btn-danger")
                        }
                        if(type==1){
                            _this.removeClass("layui-btn-danger").addClass("layui-btn-warm")
                        }
                        _this.text(btnText);
                        layer.close(index);
                        /* var curr = parseInt($(".layui-laypage-btn").parent().children("input").eq(0).val());
                         data.status = type;
                         table.reload('userListTable', {
                             where: data
                             ,page: {
                                 curr: curr
                             }
                         });*/
                        $(".layui-laypage-btn")[0].click();

                    }else{
                        layer.msg(result.msg,{icon : 5 })
                    }
                });


            },function(index){
                layer.close(index);
            });
        }else if(layEvent === 'del'){ //删除
            layer.confirm('确定删除此权限？',{icon:3, title:'提示信息'},function(index){
                $.deleteJSON(webPath+"/acl/delete/"+data.id,null,function(result){
                    if(result.code == 0){
                        $(".layui-laypage-btn")[0].click();
                        layer.close(index);
                    }else{
                        layer.msg(result.msg,{icon : 5 });
                        layer.close(index);
                    }
                })
            });
        }
    });

    $("#add_aclModule_a").click(addAclModule);
    $("#edit_aclModule_a").click(editAclModule);
    $("#delete_aclModule_a").click(deleteAclModule);

    //添加权限模块
    function addAclModule(){

        layer.open({
            type: 2,
            title: false,
            title: '添加权限模块',
            shadeClose: true,
            shade: 0.5,
            skin:'demo-class',
            maxmin: true, //开启最大化最小化按钮
            area: ['80%', '80%'],
            shift: 2,
            content: webPath+'/aclModule/preAdd', //iframe的url，
        });
    }
    //编辑权限模块
    function editAclModule() {
        if(!aclModuleId){
            layer1.tips('请选择一个权限模块', '#edit_aclModule_a', {
                tips: [1, '#FF5722'],
                time: 2000
            });
            return;
        }
        layer.open({
            type: 2,
            title: false,
            title: '编辑权限模块',
            shadeClose: true,
            shade: 0.5,
            skin:'demo-class',
            maxmin: true, //开启最大化最小化按钮
            area: ['80%', '80%'],
            shift: 2,
            content: webPath+'/aclModule/preAdd?aclModuleId='+aclModuleId, //iframe的url，
        });
    }
    //删除权限模块
    function deleteAclModule(){
        if(!aclModuleId){
            layer1.tips('请选择一个权限模块', '#delete_aclModule_a', {
                tips: [1, '#FF5722'],
                time: 2000
            });
            return;
        }
        layer.confirm('您确认删除这个权限模块吗？', {
            btn: ['确认','取消'] //按钮
        }, function(index){
            console.log(aclModuleIdAll)
            $.deleteJSON(webPath+"/aclModule/delete/"+aclModuleIdAll,null,function(result){
                if(result.code==0){
                    location.reload();
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
