此项目是 springboot + druid + mybatis + layUi 搭建的后台管理系统，实现了其中的权限管理部分。

访问路径  ： http://localhost:8080/preLogin
   用户名 ： admin 密码：111111
   
   权限管理：包含权限模块和权限点
   用户管理：包含部门和用户
   角色管理：包含角色、角色与权限和角色与用户
   
   在权限模块下 创建权限点 分菜单和按钮，菜单控制左侧菜单栏的显示
   
   权限控制拦截器在com\oct\filter\AuthInterceptor.java类中
