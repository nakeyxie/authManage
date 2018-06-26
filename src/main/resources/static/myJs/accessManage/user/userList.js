var deptId = null;//被点击的部门Id
var deptIdAll = null;//被点击的部门Id和所有子部门Id
layui.use(['form','layer','table','laytpl','tree'],function(){
    var form = layui.form;
        layer = parent.layer === undefined ? layui.layer : top.layer;
    var layer1 = layui.layer;
        $ = layui.jquery;
    var table = layui.table;


   function loadDeptTree(){
        $.ajax({
            url : webPath+'/dept/tree',
            type : 'GET',
            dataType : 'JSON',
            success : function (result){
                layui.tree({
                    elem: '#deptTree'
                    ,nodes: result
                    ,click: function(node){
                        deptId = node.id;
                        var deptIds = node.id;
                        if(node.children){
                            deptIds +=getDeptIDs(node.children);
                        }
                        //点击加载用户列表
                        loadUser(deptIds);
                        deptIdAll = deptIds;
                    }
                });
                $("body").on("mousedown",".layui-tree a cite",function(){
                    $(".layui-tree a cite").css('color','#336699');
                    $(this).css('color','red');

                })
            }
        });

        var getDeptIDs = function (data){
            var deptIds = "";
            for(var i = 0;i<data.length;i++){
                deptIds += ",";
                deptIds += data[i].id;
                if(data.children){
                    deptIds +=getDeptIDs(data[i].children);
                }
            }
            return deptIds;
        }

    }
    loadDeptTree();
    var tableIns = null;

    function loadUser(deptId) {
        //用户列表
        tableIns = table.render({
            elem: '#userList',
            url : webPath+'/user/list/'+deptId,
            cellMinWidth: 60,
            page : true,
            width : $("#user_table_div").width()-30,
            height : "full-170",
            limits : [10,15,20,25],
            limit : 10,
            id : "userListTable",
            cols : [[
                {type: "checkbox", fixed:"left"},
                {field: 'id', title: 'ID',  align:"center", sort: true},
                {field: 'username', title: '姓名', align:"center", sort: true,minWidth:80},
                {field: 'telephone', title: '手机号', align:"center",minWidth:120, sort: true},
                {field: 'mail', title: '用户邮箱',minWidth:175,  align:'center', sort: true,templet:function(d){
                        return '<a class="layui-blue" href="mailto:'+d.mail+'">'+d.mail+'</a>';
                    }},
                {field: 'sex', title: '用户性别', align:'center', sort: true,templet:function(d){
                        return d.sex == "f" ? "女" : "男";
                    }},
                {field: 'status', title: '用户状态',  align:'center', sort: true,templet:function(d){
                        if(d.status == "1"){
                            return '<button class="layui-btn layui-btn-xs layui-btn-danger">冻结</button>';
                        }else if(d.status == "0"){
                            return '<button class="layui-btn layui-btn-xs layui-btn-normal">正常</button>';
                        }else if(d.status == "2"){
                            return '<button class="layui-btn layui-btn-xs layui-btn-disabled">删除</button>';
                        }
                    }},
                {field: 'job', title: '职位',  align:"center", sort: true},
                {field: 'deptname', title: '部门',  align:"center", sort: true},
                {title: '操作', minWidth:175,fixed:"right",align:"center",templet:function(d){
                        if(d.status == "1"){
                            return '<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>' +
                                '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="usable">已禁用</a>' +
                                '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>';
                        }else if(d.status == "0"){
                            return '<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>' +
                                '<a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="usable">已启用</a>' +
                                '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>';
                        }else if(d.status == "2"){
                            return '<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>';
                        }
                    }}
            ]]
        });
    }


    //搜索【此功能需要后台配合，所以暂时没有动态效果演示】
    $(".search_btn").on("click",function(){
        if($(".searchVal").val() != ''){
            tableIns = table.render({
                elem: '#userList',
                url : webPath+"/user/query/"+$(".searchVal").val(),
                cellMinWidth: 60,
                page : true,
                width : $("#user_table_div").width()-20,
                height : "full-170",
                limits : [10,15,20,25],
                limit : 10,
                id : "userListTable",
                cols : [[
                    {type: "checkbox", fixed:"left"},
                    {field: 'id', title: 'ID',  align:"center", sort: true},
                    {field: 'username', title: '姓名', align:"center", sort: true},
                    {field: 'telephone', title: '手机号', align:"center", sort: true},
                    {field: 'mail', title: '用户邮箱',minWidth:175,  align:'center', sort: true,templet:function(d){
                            return '<a class="layui-blue" href="mailto:'+d.mail+'">'+d.mail+'</a>';
                        }},
                    {field: 'sex', title: '用户性别', align:'center', sort: true,templet:function(d){
                            return d.sex == "f" ? "女" : "男";
                        }},
                    {field: 'status', title: '用户状态',  align:'center', sort: true,templet:function(d){
                            if(d.status == "1"){
                                return '<button class="layui-btn layui-btn-xs layui-btn-danger">冻结</button>';
                            }else if(d.status == "0"){
                                return '<button class="layui-btn layui-btn-xs layui-btn-normal">正常</button>';
                            }else if(d.status == "2"){
                                return '<button class="layui-btn layui-btn-xs layui-btn-disabled">删除</button>';
                            }
                        }},
                    {field: 'job', title: '职位',  align:"center", sort: true},
                    {field: 'deptname', title: '部门',  align:"center", sort: true},
                    {title: '操作', minWidth:175,fixed:"right",align:"center",templet:function(d){
                            if(d.status == "1"){
                                return '<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>' +
                                    '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="usable">已禁用</a>' +
                                    '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>';
                            }else if(d.status == "0"){
                                return '<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>' +
                                    '<a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="usable">已启用</a>' +
                                    '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>';
                            }else if(d.status == "2"){
                                return '<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>';
                            }
                        }}
                ]]
            });

        }else{
            layer.msg("请输入搜索的内容");
        }
    });

    //添加用户
    function addUser(edit){
        var title = "添加用户";
        if(edit){
            title = "编辑用户";
        }

        layer.open({
            type: 2,
            title: title,
            shadeClose: true,
            shade: 0.5,
            skin:'demo-class',
            maxmin: true, //开启最大化最小化按钮
            area: ['80%', '80%'],
            content: webPath+'/user/preAdd?userId='+(edit?edit.id:''), //iframe的url，
           /* btn : ['保存','取消'],
            yes : function(index, layero){
                var body = layer.getChildFrame("body", index);
                body.find("#add_user_btn").click();
            },
            btn2 : function(index, layero){
                return false;
            },
            cancel : function() {
                if ($(".layui-laypage-btn")) {
                    $(".layui-laypage-btn")[0].click();
                }
            }*/
        });
    }
    $(".addNews_btn").click(function(){
        addUser();
    })

    //批量删除
    $(".delAll_btn").click(function(){
        var checkStatus = table.checkStatus('userListTable'),
            data = checkStatus.data,
            newsId = [];
        if(data.length > 0) {
           /* for (var i in data) {
                newsId.push(data[i].newsId);
            }*/
           console.log(data)
            var userIds = $(data).map(function(key,values){
                return values.id;
            }).get().join(",");
            layer.confirm('确定删除选中的用户？', {icon: 3, title: '提示信息'}, function (index) {
                $.deleteJSON(webPath+"/user/delete/"+userIds,null,function(result){
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
    table.on('tool(userList)', function(obj){
        var layEvent = obj.event,
            data = obj.data;

        if(layEvent === 'edit'){ //编辑
            addUser(data);
        }else if(layEvent === 'usable'){ //启用禁用
            var type = 0;
            var _this = $(this),
                usableText = "是否确定禁用此用户？";
                type = 1;
                btnText = "已禁用";
            if(_this.text()=="已禁用"){
                usableText = "是否确定启用此用户？";
                type = 0;
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
                $.putJSON(webPath+"/user/status/"+data.id,{status : type},function(result){
                    if(result.code == 0){

                        if(type==1){
                            _this.removeClass("layui-btn-warm").addClass("layui-btn-danger")
                        }
                        if(type==0){
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
            layer.confirm('确定删除此用户？',{icon:3, title:'提示信息'},function(index){
                $.putJSON(webPath+'/user/status/'+data.id,{status : 2},function(){
                    $(".layui-laypage-btn")[0].click();
                    layer.close(index);
                });
            });
        }
    });

    $("#add_dept_a").click(addDept);
    $("#edit_dept_a").click(editDept);
    $("#delete_dept_a").click(deleteDept);

    //添加部门
    function addDept(){

        layer.open({
            type: 2,
            title: false,
            title: '添加部门',
            shadeClose: true,
            shade: 0.5,
            skin:'demo-class',
            maxmin: true, //开启最大化最小化按钮
            area: ['80%', '80%'],
            shift: 2,
            content: webPath+'/dept/preAdd', //iframe的url，
        });
    }
//编辑部门
    function editDept() {
        if(!deptId){
            layer1.tips('请选择一个部门', '#edit_dept_a', {
                tips: [1, '#FF5722'],
                time: 2000
            });
            return;
        }
        layer.open({
            type: 2,
            title: false,
            title: '编辑部门',
            shadeClose: true,
            shade: 0.5,
            skin:'demo-class',
            maxmin: true, //开启最大化最小化按钮
            area: ['80%', '80%'],
            shift: 2,
            content: webPath+'/dept/preAdd?deptId='+deptId, //iframe的url，
        });
    }
//删除部门
    function deleteDept(){
        if(!deptId){
            layer1.tips('请选择一个部门', '#delete_dept_a', {
                tips: [1, '#FF5722'],
                time: 2000
            });
            return;
        }
        layer.confirm('您确认删除这个部门吗？', {
            btn: ['确认','取消'] //按钮
        }, function(index){
            console.log(deptIdAll)
            $.deleteJSON(webPath+"/dept/delete/"+deptIdAll,null,function(result){
                if(result.code==0){
                    location.reload();
                    layer.close(index);
                }else{
                    layer.msg(result.msg,{icon : 5 })
                    layer.close(index);
                }
            })
        }, function(index){
            layer.close(index);
        });
    }
})
