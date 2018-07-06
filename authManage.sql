/*
Navicat MySQL Data Transfer

Source Database       : permission

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2018-06-19 16:14:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_acl
-- ----------------------------
DROP TABLE IF EXISTS `sys_acl`;
CREATE TABLE `sys_acl` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `code` varchar(20) NOT NULL DEFAULT '' COMMENT '权限码',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '权限名称',
  `acl_module_id` int(11) NOT NULL DEFAULT '0' COMMENT '权限所在的权限模块id',
  `url` varchar(100) NOT NULL DEFAULT '' COMMENT '请求的url, 可以填正则表达式',
  `type` int(11) NOT NULL DEFAULT '3' COMMENT '类型，1：菜单，2：按钮，3：其他',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1：正常，2：冻结',
  `seq` int(11) NOT NULL DEFAULT '0' COMMENT '权限在当前模块下的顺序，由小到大',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `operate_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一个更新者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_acl
-- ----------------------------
INSERT INTO `sys_acl` VALUES ('1', '20171015095130_26', '进入产品管理界面', '1', '/sys/product/product.page', '1', '1', '1', '', 'Admin', '2018-06-16 18:23:01', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl` VALUES ('5', '20171015212626_63', '进入订单页', '2', '/sys/order/order.page', '1', '1', '1', '', 'Admin', '2017-10-15 21:26:27', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl` VALUES ('6', '20171015212657_12', '查询订单列表', '2', '/sys/order/list.json', '2', '1', '2', '', 'Admin', '2017-10-15 21:26:57', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl` VALUES ('7', '20171015212907_36', '进入权限管理页', '7', '/menu/cal/preAclManage', '1', '1', '1', '', 'Kate', '2018-06-19 16:01:23', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl` VALUES ('8', '20171015212938_27', '进入角色管理页', '8', '/menu/role/preRoleManage', '1', '1', '1', '', 'Admin', '2017-10-16 17:49:38', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl` VALUES ('9', '20171015213009_0', '进入用户管理页', '9', '/menu/user/preUserList', '1', '1', '1', '', 'Admin', '2017-10-15 21:30:09', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl` VALUES ('10', '20171016230429_8', '进入权限更新记录页面', '11', '/sys/log/log.page', '1', '1', '1', '', 'Admin', '2017-10-16 23:04:49', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl` VALUES ('11', '', '进入产品', '1', '/perject/*', '2', '1', '2', '', 'Admin', '2018-06-17 11:22:47', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl` VALUES ('13', '', '添加或修改权限', '7', '/acl/save', '2', '1', '2', '', 'Admin', '2018-06-19 15:58:27', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl` VALUES ('14', '', '更改权限状态', '7', '/acl/status/*', '2', '1', '3', '', 'Admin', '2018-06-19 15:58:53', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl` VALUES ('15', '', '进入添加或编辑权限页', '7', '/acl/preAdd', '2', '1', '4', '', 'Admin', '2018-06-19 15:52:39', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl` VALUES ('16', '', '进入添加或编辑权限模块页', '7', '/aclModule/preAdd', '2', '1', '5', '', 'Admin', '2018-06-19 15:52:54', '0:0:0:0:0:0:0:1');

-- ----------------------------
-- Table structure for sys_acl_module
-- ----------------------------
DROP TABLE IF EXISTS `sys_acl_module`;
CREATE TABLE `sys_acl_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限模块id',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '权限模块名称',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级权限模块id',
  `level` varchar(200) NOT NULL DEFAULT '' COMMENT '权限模块层级',
  `seq` int(11) NOT NULL DEFAULT '0' COMMENT '权限模块在当前层级下的顺序，由小到大',
  `icon` varchar(32) NOT NULL DEFAULT '' COMMENT '菜单图标',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1：正常，2：冻结',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次操作时间',
  `operate_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一次更新操作者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_acl_module
-- ----------------------------
INSERT INTO `sys_acl_module` VALUES ('1', '产品管理', '0', '0', '1', '', '1', 'product', 'Admin', '2017-10-14 21:13:15', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl_module` VALUES ('2', '订单管理', '0', '0', '2', '', '1', '', 'Admin', '2017-10-14 20:17:11', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl_module` VALUES ('3', '公告管理', '0', '0', '3', '', '1', '', 'Admin', '2017-10-14 20:17:21', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl_module` VALUES ('4', '出售中产品管理', '1', '0.1', '1', '', '1', '', 'Admin', '2017-10-14 21:13:39', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl_module` VALUES ('5', '下架产品管理', '1', '0.1', '2', '', '1', '', 'Admin', '2017-10-14 20:18:02', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl_module` VALUES ('6', '权限管理', '0', '0', '4', '', '1', '', 'Admin', '2017-10-15 21:27:37', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl_module` VALUES ('7', '权限管理', '6', '0.6', '1', '', '1', '', 'Admin', '2017-10-15 21:27:57', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl_module` VALUES ('8', '角色管理', '6', '0.6', '2', '', '1', '', 'Admin', '2017-10-15 21:28:22', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl_module` VALUES ('9', '用户管理', '6', '0.6', '2', '', '1', '', 'Admin', '2017-10-15 21:28:36', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl_module` VALUES ('10', '运维管理', '0', '0', '6', '', '1', '', 'Admin', '2017-10-16 23:03:37', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_acl_module` VALUES ('11', '权限更新记录管理', '6', '0.6', '4', '', '1', '', 'Admin', '2017-10-16 23:04:07', '0:0:0:0:0:0:0:1');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '部门名称',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级部门id',
  `level` varchar(200) NOT NULL DEFAULT '' COMMENT '部门层级',
  `seq` int(11) NOT NULL DEFAULT '0' COMMENT '部门在当前层级下的顺序，由小到大',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次操作时间',
  `operate_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一次更新操作者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', '技术部', '0', '0', '1', '', 'Admin', '2018-06-14 17:44:46', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_dept` VALUES ('2', '后端开发', '1', '0.1', '1', '后端', 'system-update', '2017-10-12 07:56:16', '127.0.0.1');
INSERT INTO `sys_dept` VALUES ('3', '前端开发', '1', '0.1', '2', '', 'system-update', '2017-10-14 11:29:45', '127.0.0.1');
INSERT INTO `sys_dept` VALUES ('4', 'UI设计', '1', '0.1', '3', '', 'system', '2017-10-12 07:55:43', '127.0.0.1');
INSERT INTO `sys_dept` VALUES ('12', '客服部', '0', '0', '4', '', 'Admin', '2017-10-17 00:22:55', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_dept` VALUES ('18', '产品部', '0', '', '2', '', 'Admin', '2018-06-17 18:25:01', '0:0:0:0:0:0:0:1');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '权限更新的类型，1：部门，2：用户，3：权限模块，4：权限，5：角色，6：角色用户关系，7：角色权限关系',
  `target_id` int(11) NOT NULL COMMENT '基于type后指定的对象id，比如用户、权限、角色等表的主键',
  `old_value` text COMMENT '旧值',
  `new_value` text COMMENT '新值',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新的时间',
  `operate_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip地址',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '当前是否复原过，0：没有，1：复原过',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('2', '1', '12', '', '{\"id\":12,\"name\":\"客服部\",\"parentId\":0,\"level\":\"0\",\"seq\":3,\"operator\":\"Admin\",\"operateTime\":1508166002610,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-16 23:00:03', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('3', '1', '12', '{\"id\":12,\"name\":\"客服部\",\"parentId\":0,\"level\":\"0\",\"seq\":3,\"operator\":\"Admin\",\"operateTime\":1508166003000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":12,\"name\":\"客服部\",\"parentId\":0,\"level\":\"0\",\"seq\":4,\"operator\":\"Admin\",\"operateTime\":1508166009313,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-16 23:00:09', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('4', '2', '4', '', '{\"id\":4,\"username\":\"Kate\",\"telephone\":\"13144445555\",\"mail\":\"kate@qq.com\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1508166166297,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-16 23:02:46', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('5', '2', '4', '{\"id\":4,\"username\":\"Kate\",\"telephone\":\"13144445555\",\"mail\":\"kate@qq.com\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1508166166000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":4,\"username\":\"Kate\",\"telephone\":\"13144445555\",\"mail\":\"kate@qq.com\",\"deptId\":1,\"status\":1,\"remark\":\"sss\",\"operator\":\"Admin\",\"operateTime\":1508166171320,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-16 23:02:51', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('6', '3', '10', '', '{\"id\":10,\"name\":\"运维管理\",\"parentId\":0,\"level\":\"0\",\"seq\":5,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1508166212527,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-16 23:03:33', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('7', '3', '10', '{\"id\":10,\"name\":\"运维管理\",\"parentId\":0,\"level\":\"0\",\"seq\":5,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1508166213000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":10,\"name\":\"运维管理\",\"parentId\":0,\"level\":\"0\",\"seq\":6,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1508166217376,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-16 23:03:37', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('8', '3', '11', '', '{\"id\":11,\"name\":\"权限更新记录管理\",\"parentId\":6,\"level\":\"0.6\",\"seq\":4,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1508166246805,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-16 23:04:07', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('9', '4', '10', '', '{\"id\":10,\"code\":\"20171016230429_8\",\"name\":\"进入权限更新记录页面\",\"aclModuleId\":1,\"url\":\"/sys/log/log.page\",\"type\":1,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1508166269419,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-16 23:04:29', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('10', '4', '10', '{\"id\":10,\"code\":\"20171016230429_8\",\"name\":\"进入权限更新记录页面\",\"aclModuleId\":1,\"url\":\"/sys/log/log.page\",\"type\":1,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1508166269000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":10,\"name\":\"进入权限更新记录页面\",\"aclModuleId\":11,\"url\":\"/sys/log/log.page\",\"type\":1,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1508166288589,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-16 23:04:49', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('11', '5', '5', '', '{\"id\":5,\"name\":\"运维管理员\",\"type\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1508166301130,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-16 23:05:01', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('12', '5', '5', '{\"id\":5,\"name\":\"运维管理员\",\"type\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1508166301000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":5,\"name\":\"运维管理员\",\"type\":1,\"status\":1,\"remark\":\"运维\",\"operator\":\"Admin\",\"operateTime\":1508166307317,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-16 23:05:07', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('13', '6', '4', '[7,8,9]', '[7,8,9,10]', 'Admin', '2017-10-16 23:34:39', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('14', '7', '4', '[1]', '[1,4]', 'Admin', '2017-10-16 23:34:44', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('15', '2', '5', '', '{\"id\":5,\"username\":\"服务员A\",\"telephone\":\"18677778888\",\"mail\":\"service@qq.com\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":12,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1508170918338,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-17 00:21:58', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('16', '2', '5', '{\"id\":5,\"username\":\"服务员A\",\"telephone\":\"18677778888\",\"mail\":\"service@qq.com\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":12,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1508170918000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":5,\"username\":\"服务员B\",\"telephone\":\"18677778888\",\"mail\":\"service@qq.com\",\"deptId\":12,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1508170924698,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-17 00:22:05', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('17', '2', '5', '{\"id\":5,\"username\":\"服务员B\",\"telephone\":\"18677778888\",\"mail\":\"service@qq.com\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":12,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1508170925000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":5,\"username\":\"服务员A\",\"telephone\":\"18677778888\",\"mail\":\"service@qq.com\",\"password\":\"25D55AD283AA400AF464C76D713C07AD\",\"deptId\":12,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1508170934791,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-17 00:22:15', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('18', '1', '12', '{\"id\":12,\"name\":\"客服部\",\"parentId\":0,\"level\":\"0\",\"seq\":4,\"operator\":\"Admin\",\"operateTime\":1508166009000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":12,\"name\":\"客服部A\",\"parentId\":0,\"level\":\"0\",\"seq\":4,\"operator\":\"Admin\",\"operateTime\":1508170966051,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-17 00:22:46', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('19', '1', '12', '{\"id\":12,\"name\":\"客服部A\",\"parentId\":0,\"level\":\"0\",\"seq\":4,\"operator\":\"Admin\",\"operateTime\":1508170966000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":12,\"name\":\"客服部\",\"parentId\":0,\"level\":\"0\",\"seq\":4,\"operator\":\"Admin\",\"operateTime\":1508170975242,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-17 00:22:55', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('20', '5', '5', '{\"id\":5,\"name\":\"运维管理员\",\"type\":1,\"status\":1,\"remark\":\"运维\",\"operator\":\"Admin\",\"operateTime\":1508166307000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":5,\"name\":\"运维管理员A\",\"type\":1,\"status\":1,\"remark\":\"运维\",\"operator\":\"Admin\",\"operateTime\":1508170997531,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-17 00:23:18', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('21', '5', '5', '{\"id\":5,\"name\":\"运维管理员A\",\"type\":1,\"status\":1,\"remark\":\"运维\",\"operator\":\"Admin\",\"operateTime\":1508170998000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":5,\"name\":\"运维管理员\",\"type\":1,\"status\":1,\"remark\":\"运维\",\"operator\":\"Admin\",\"operateTime\":1508171007651,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2017-10-17 00:23:28', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('22', '7', '4', '[1,4]', '[1,4,2,3,5]', 'Admin', '2017-10-17 00:23:53', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('23', '7', '4', '[1,4,2,3,5]', '[1,4]', 'Admin', '2017-10-17 00:24:04', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('24', '6', '5', '[]', '[7,8,9,10]', 'Admin', '2017-10-17 00:24:23', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('25', '6', '5', '[7,8,9,10]', '[]', 'Admin', '2017-10-17 00:24:34', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('26', '3', '12', '', '{\"id\":12,\"name\":\"11\",\"parentId\":1,\"level\":\"0.1\",\"seq\":3,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1526972251104,\"operateIp\":\"127.0.0.1\"}', 'Admin', '2018-05-22 14:57:31', '127.0.0.1', '1');
INSERT INTO `sys_log` VALUES ('27', '7', '1', '[]', '[1,2,3,5]', 'Admin', '2018-05-22 15:01:55', '127.0.0.1', '1');
INSERT INTO `sys_log` VALUES ('28', '7', '1', '[1,2,3,5]', '[]', 'Admin', '2018-05-22 15:02:04', '127.0.0.1', '1');
INSERT INTO `sys_log` VALUES ('29', '1', '13', '', '{\"id\":13,\"name\":\"测试阅读\",\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1528966611029,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-14 16:56:51', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('30', '1', '14', '', '{\"id\":14,\"name\":\"测试阅读\",\"parentId\":13,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1528966744094,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-14 16:59:04', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('31', '1', '14', '{\"id\":14,\"name\":\"测试阅读\",\"parentId\":13,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1528966744000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":14,\"name\":\"ceshi\",\"parentId\":13,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1528966950249,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-14 17:02:30', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('32', '1', '1', '{\"id\":1,\"name\":\"技术部\",\"parentId\":0,\"level\":\"0\",\"seq\":1,\"remark\":\"技术部\",\"operator\":\"system\",\"operateTime\":1507677700000,\"operateIp\":\"127.0.0.1\"}', '{\"id\":1,\"name\":\"技术部\",\"parentId\":0,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1528969485610,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-14 17:44:46', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('33', '1', '15', '', '{\"id\":15,\"name\":\"问问\",\"parentId\":13,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1529023933653,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 08:52:14', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('34', '1', '16', '', '{\"id\":16,\"name\":\"ceshi\",\"parentId\":13,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1529023976708,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 08:52:57', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('35', '1', '15', '{\"id\":15,\"name\":\"问问\",\"parentId\":13,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1529023934000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":15,\"name\":\"问问\",\"parentId\":13,\"seq\":3,\"operator\":\"Admin\",\"operateTime\":1529023984315,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 08:53:04', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('36', '2', '6', '', '{\"id\":6,\"username\":\"wwss\",\"telephone\":\"12345678911\",\"mail\":\"123@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"sss\",\"operator\":\"Admin\",\"operateTime\":1529032727126,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 11:18:47', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('37', '2', '6', '{\"id\":6,\"username\":\"wwss\",\"telephone\":\"12345678911\",\"mail\":\"123@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"sss\",\"operator\":\"Admin\",\"operateTime\":1529032727000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":6,\"username\":\"wwssy\",\"telephone\":\"12345678911\",\"mail\":\"123@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"sssf\",\"operator\":\"Admin\",\"operateTime\":1529032900678,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 11:21:41', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('38', '2', '6', '{\"id\":6,\"username\":\"wwssy\",\"telephone\":\"12345678911\",\"mail\":\"123@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":2,\"remark\":\"sssf\",\"operator\":\"Admin\",\"operateTime\":1529043400000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":6,\"username\":\"wwssy\",\"telephone\":\"12345678911\",\"mail\":\"123@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"sssf\",\"operator\":\"Admin\",\"operateTime\":1529043408025,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:16:48', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('39', '2', '7', '', '{\"id\":7,\"username\":\"ff\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529043650296,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:20:50', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('40', '2', '7', '{\"id\":7,\"username\":\"ff\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529043650000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529043660056,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:21:00', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('41', '2', '7', '{\"id\":7,\"username\":\"ffa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529043660000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ff\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529043694006,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:21:34', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('42', '2', '7', '{\"id\":7,\"username\":\"ff\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529043694000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529043989709,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:26:30', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('43', '2', '7', '{\"id\":7,\"username\":\"ffa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529043990000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffav\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529044013873,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:26:54', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('44', '2', '7', '{\"id\":7,\"username\":\"ffav\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529044014000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529044050786,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:27:31', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('45', '2', '7', '{\"id\":7,\"username\":\"ffa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529044051000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffav\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529044087059,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:28:07', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('46', '2', '7', '{\"id\":7,\"username\":\"ffav\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529044087000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529044436099,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:33:56', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('47', '2', '7', '{\"id\":7,\"username\":\"ffa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529044436000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffav\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529044470947,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:34:31', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('48', '2', '7', '{\"id\":7,\"username\":\"ffav\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529044513000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529044517463,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:35:18', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('49', '2', '7', '{\"id\":7,\"username\":\"ffa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529044517000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529044545024,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:35:45', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('50', '2', '7', '{\"id\":7,\"username\":\"ffa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529044545000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffav\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529044564648,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:36:05', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('51', '2', '7', '{\"id\":7,\"username\":\"ffav\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529044565000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffavc\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529044924908,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:42:05', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('52', '2', '7', '{\"id\":7,\"username\":\"ffavc\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529044925000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffav\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529044957161,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:42:37', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('53', '2', '7', '{\"id\":7,\"username\":\"ffav\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529044957000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffavd\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529045098441,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:44:58', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('54', '2', '7', '{\"id\":7,\"username\":\"ffavd\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529045098000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffavdc\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529045171880,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:46:12', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('55', '2', '7', '{\"id\":7,\"username\":\"ffavdc\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529045172000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffavdca\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529045260941,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:47:41', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('56', '2', '7', '{\"id\":7,\"username\":\"ffavdca\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529045261000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ff\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529045339866,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:49:00', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('57', '2', '7', '{\"id\":7,\"username\":\"ff\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529045340000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529045471989,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:51:12', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('58', '2', '7', '{\"id\":7,\"username\":\"ffa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529045472000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffac\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529045743610,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 14:55:44', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('59', '2', '7', '{\"id\":7,\"username\":\"ffac\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529045744000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffacv\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046229754,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 15:03:50', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('60', '2', '7', '{\"id\":7,\"username\":\"ffacv\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046230000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffac\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046340904,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 15:05:41', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('61', '2', '7', '{\"id\":7,\"username\":\"ffac\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046341000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffacn\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046390721,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 15:06:31', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('62', '2', '7', '{\"id\":7,\"username\":\"ffacn\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046391000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffac\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046476744,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 15:07:57', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('63', '2', '7', '{\"id\":7,\"username\":\"ffac\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046477000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffaca\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046500071,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 15:08:20', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('64', '2', '7', '{\"id\":7,\"username\":\"ffaca\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046500000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffacaa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046535483,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 15:08:56', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('65', '2', '7', '{\"id\":7,\"username\":\"ffacaa\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046535000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffaca\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046614091,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 15:10:14', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('66', '2', '7', '{\"id\":7,\"username\":\"ffaca\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046614000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffacae\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046638582,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 15:10:39', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('67', '2', '7', '{\"id\":7,\"username\":\"ffacae\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046639000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffac\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046728306,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 15:12:08', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('68', '2', '7', '{\"id\":7,\"username\":\"ffac\",\"telephone\":\"11111111111\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046728000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffac\",\"telephone\":\"11111111111\",\"mail\":\"12@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046833748,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 15:13:54', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('69', '2', '7', '{\"id\":7,\"username\":\"ffac\",\"telephone\":\"11111111111\",\"mail\":\"12@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046834000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffacq\",\"telephone\":\"11111111111\",\"mail\":\"12@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046882339,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 15:14:42', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('70', '2', '7', '{\"id\":7,\"username\":\"ffacq\",\"telephone\":\"11111111111\",\"mail\":\"12@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046882000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ffacqa\",\"telephone\":\"11111111111\",\"mail\":\"12@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046928522,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 15:15:29', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('71', '2', '7', '{\"id\":7,\"username\":\"ffacqa\",\"telephone\":\"11111111111\",\"mail\":\"12@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529046929000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ff\",\"telephone\":\"11111111111\",\"mail\":\"12@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529047094700,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 15:18:15', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('72', '2', '8', '', '{\"id\":8,\"username\":\"ss\",\"telephone\":\"11155554444\",\"mail\":\"s@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"fsfs\",\"operator\":\"Admin\",\"operateTime\":1529051274472,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 16:27:55', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('73', '2', '9', '', '{\"id\":9,\"username\":\"fsd\",\"telephone\":\"11111111112\",\"mail\":\"rr@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"fsdf\",\"operator\":\"Admin\",\"operateTime\":1529051478590,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 16:31:19', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('74', '2', '10', '', '{\"id\":10,\"username\":\"dsds\",\"telephone\":\"12211111111\",\"mail\":\"eee@a.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"fdsfds\",\"operator\":\"Admin\",\"operateTime\":1529051573436,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 16:32:53', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('75', '2', '11', '', '{\"id\":11,\"username\":\"dsad\",\"telephone\":\"15200001111\",\"mail\":\"dd@dff.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"sdfsd\",\"operator\":\"Admin\",\"operateTime\":1529051649881,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 16:34:10', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('76', '2', '12', '', '{\"id\":12,\"username\":\"dwaeda\",\"telephone\":\"15511112222\",\"mail\":\"ww@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529051744413,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 16:35:44', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('77', '2', '13', '', '{\"id\":13,\"username\":\"fff\",\"telephone\":\"15211114444\",\"mail\":\"qq@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"vxcv\",\"operator\":\"Admin\",\"operateTime\":1529051920053,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 16:38:40', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('78', '2', '13', '{\"id\":13,\"username\":\"fff\",\"telephone\":\"15211114444\",\"mail\":\"qq@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"vxcv\",\"operator\":\"Admin\",\"operateTime\":1529051920000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":13,\"username\":\"fffaa\",\"telephone\":\"15211114444\",\"mail\":\"qq@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"vxcv\",\"operator\":\"Admin\",\"operateTime\":1529051937804,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 16:38:58', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('79', '2', '13', '{\"id\":13,\"username\":\"fffaa\",\"telephone\":\"15211114444\",\"mail\":\"qq@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"vxcv\",\"operator\":\"Admin\",\"operateTime\":1529051938000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":13,\"username\":\"fffaadd\",\"telephone\":\"15211114444\",\"mail\":\"qq@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"vxcv\",\"operator\":\"Admin\",\"operateTime\":1529052015552,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 16:40:16', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('80', '2', '13', '{\"id\":13,\"username\":\"fffaadd\",\"telephone\":\"15211114444\",\"mail\":\"qq@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"vxcv\",\"operator\":\"Admin\",\"operateTime\":1529052016000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":13,\"username\":\"fffa\",\"telephone\":\"15211114444\",\"mail\":\"qq@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"vxcv\",\"operator\":\"Admin\",\"operateTime\":1529052145293,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 16:42:25', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('81', '2', '14', '', '{\"id\":14,\"username\":\"adminff\",\"telephone\":\"11111111122\",\"mail\":\"1@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"ff\",\"operator\":\"Admin\",\"operateTime\":1529052905332,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 16:55:05', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('82', '2', '7', '{\"id\":7,\"username\":\"ff\",\"telephone\":\"11111111111\",\"mail\":\"12@qq.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":2,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529067635000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":7,\"username\":\"ff\",\"telephone\":\"11111111111\",\"mail\":\"12@qq.com\",\"sex\":\"m\",\"deptId\":12,\"status\":1,\"remark\":\"dddd\",\"operator\":\"Admin\",\"operateTime\":1529067639103,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-15 21:00:39', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('83', '2', '10', '{\"id\":10,\"username\":\"dsds\",\"telephone\":\"12211111111\",\"mail\":\"eee@a.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":2,\"remark\":\"fdsfds\",\"operator\":\"Admin\",\"operateTime\":1529051573000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":10,\"username\":\"dsds\",\"telephone\":\"12211111111\",\"mail\":\"eee@a.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"fdsfds\",\"operator\":\"Admin\",\"operateTime\":1529157038547,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-16 21:50:39', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('84', '2', '11', '{\"id\":11,\"username\":\"dsad\",\"telephone\":\"15200001111\",\"mail\":\"dd@dff.com\",\"password\":\"49447a6c4f76782b436e763557592f576142355873413d3d\",\"sex\":\"m\",\"deptId\":12,\"status\":2,\"remark\":\"sdfsd\",\"operator\":\"Admin\",\"operateTime\":1529051650000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":11,\"username\":\"dsad\",\"telephone\":\"15200001111\",\"mail\":\"dd@dff.com\",\"sex\":\"m\",\"deptId\":12,\"status\":0,\"remark\":\"sdfsd\",\"operator\":\"Admin\",\"operateTime\":1529157044574,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-16 21:50:45', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('85', '4', '11', '', '{\"id\":11,\"name\":\"进入产品\",\"aclModuleId\":1,\"url\":\"/perject/*\",\"type\":2,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1529205767050,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-17 11:22:47', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('86', '3', '12', '', '{\"id\":12,\"name\":\"ces\",\"seq\":1,\"remark\":\"ss\",\"operator\":\"Admin\",\"operateTime\":1529210448725,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-17 12:40:49', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('87', '3', '13', '', '{\"id\":13,\"name\":\"cesss\",\"parentId\":12,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1529210474459,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-17 12:41:15', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('88', '3', '13', '{\"id\":13,\"name\":\"cesss\",\"parentId\":12,\"seq\":1,\"status\":1,\"operator\":\"Admin\",\"operateTime\":1529210474000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":13,\"name\":\"cesss\",\"parentId\":12,\"seq\":1,\"remark\":\"ssd\",\"operator\":\"Admin\",\"operateTime\":1529210500270,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-17 12:41:40', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('89', '4', '12', '', '{\"id\":12,\"name\":\"ces\",\"aclModuleId\":13,\"url\":\"/perject/*\",\"type\":1,\"status\":1,\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1529210523707,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-17 12:42:04', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('90', '1', '17', '', '{\"id\":17,\"name\":\"ss\",\"seq\":1,\"operator\":\"Admin\",\"operateTime\":1529210612015,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-17 12:43:32', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('91', '3', '14', '', '{\"id\":14,\"name\":\"rr\",\"seq\":22,\"operator\":\"Admin\",\"operateTime\":1529210683262,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-17 12:44:43', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('92', '3', '15', '', '{\"id\":15,\"name\":\"ces\",\"parentId\":1,\"seq\":4,\"operator\":\"Admin\",\"operateTime\":1529210696486,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-17 12:44:57', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('93', '1', '18', '', '{\"id\":18,\"name\":\"产品部\",\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1529231101130,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-17 18:25:01', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('94', '5', '6', '', '{\"id\":6,\"name\":\"ceshi\",\"remark\":\"c\",\"operator\":\"Admin\",\"operateTime\":1529376398333,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-19 10:46:38', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('95', '5', '7', '', '{\"id\":7,\"name\":\"xc\",\"remark\":\"c\",\"operator\":\"Admin\",\"operateTime\":1529376436508,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-19 10:47:17', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('96', '5', '8', '', '{\"id\":8,\"name\":\"cc \",\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529376550206,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-19 10:49:10', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('97', '5', '8', '{\"id\":8,\"name\":\"cc \",\"type\":1,\"status\":1,\"remark\":\"dd\",\"operator\":\"Admin\",\"operateTime\":1529376550000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":8,\"name\":\"cc ff\",\"remark\":\"ddff\",\"operator\":\"Admin\",\"operateTime\":1529376625497,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-19 10:50:26', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('98', '7', '1', '[]', '[2]', 'Admin', '2018-06-19 13:22:38', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('99', '4', '13', '', '{\"id\":13,\"name\":\"添加权限\",\"aclModuleId\":7,\"url\":\"/acl/save\",\"type\":2,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1529391594192,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-19 14:59:54', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('100', '4', '14', '', '{\"id\":14,\"name\":\"编辑权限\",\"aclModuleId\":7,\"url\":\"/acl/save/*\",\"type\":2,\"status\":1,\"seq\":3,\"operator\":\"Admin\",\"operateTime\":1529391624749,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-19 15:00:25', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('101', '6', '4', '[7,8,9]', '[5,7,13]', 'Admin', '2018-06-19 15:01:49', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('102', '5', '9', '', '{\"id\":9,\"name\":\"用户管理员\",\"operator\":\"Admin\",\"operateTime\":1529391754335,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-19 15:02:34', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('103', '7', '4', '[1,4]', '[3]', 'Admin', '2018-06-19 15:02:48', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('104', '6', '9', '[]', '[7,14,9]', 'Admin', '2018-06-19 15:03:15', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('105', '7', '9', '[]', '[4]', 'Admin', '2018-06-19 15:03:31', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('106', '4', '15', '', '{\"id\":15,\"name\":\"进入添加权限页\",\"aclModuleId\":7,\"url\":\"/acl/preAdd\",\"type\":2,\"status\":1,\"seq\":4,\"operator\":\"Admin\",\"operateTime\":1529393330630,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-19 15:28:51', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('107', '6', '4', '[5,7,13]', '[5,7,13,15]', 'Admin', '2018-06-19 15:37:43', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('108', '4', '16', '', '{\"id\":16,\"name\":\"进入添加权限模块页\",\"aclModuleId\":7,\"url\":\"/aclModule/preAdd\",\"type\":2,\"status\":1,\"seq\":5,\"operator\":\"Admin\",\"operateTime\":1529394019723,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-19 15:40:20', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('109', '4', '15', '{\"id\":15,\"name\":\"进入添加权限页\",\"aclModuleId\":7,\"url\":\"/acl/preAdd\",\"type\":2,\"status\":1,\"seq\":4,\"operator\":\"Admin\",\"operateTime\":1529393331000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":15,\"name\":\"进入添加或编辑权限页\",\"aclModuleId\":7,\"url\":\"/acl/preAdd\",\"type\":2,\"status\":1,\"seq\":4,\"operator\":\"Admin\",\"operateTime\":1529394759124,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-19 15:52:39', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('110', '4', '16', '{\"id\":16,\"name\":\"进入添加权限模块页\",\"aclModuleId\":7,\"url\":\"/aclModule/preAdd\",\"type\":2,\"status\":1,\"seq\":5,\"operator\":\"Admin\",\"operateTime\":1529394020000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":16,\"name\":\"进入添加或编辑权限模块页\",\"aclModuleId\":7,\"url\":\"/aclModule/preAdd\",\"type\":2,\"status\":1,\"seq\":5,\"operator\":\"Admin\",\"operateTime\":1529394773531,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-19 15:52:54', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('111', '6', '9', '[7,14,9]', '[7,14,15,9]', 'Admin', '2018-06-19 15:53:33', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('112', '4', '13', '{\"id\":13,\"name\":\"添加权限\",\"aclModuleId\":7,\"url\":\"/acl/save\",\"type\":2,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1529391594000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":13,\"name\":\"添加或修改权限\",\"aclModuleId\":7,\"url\":\"/acl/save\",\"type\":2,\"status\":1,\"seq\":2,\"operator\":\"Admin\",\"operateTime\":1529395107354,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-19 15:58:27', '0:0:0:0:0:0:0:1', '1');
INSERT INTO `sys_log` VALUES ('113', '4', '14', '{\"id\":14,\"name\":\"编辑权限\",\"aclModuleId\":7,\"url\":\"/acl/save/*\",\"type\":2,\"status\":1,\"seq\":3,\"operator\":\"Admin\",\"operateTime\":1529391625000,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', '{\"id\":14,\"name\":\"更改权限状态\",\"aclModuleId\":7,\"url\":\"/acl/status/*\",\"type\":2,\"status\":1,\"seq\":3,\"operator\":\"Admin\",\"operateTime\":1529395133134,\"operateIp\":\"0:0:0:0:0:0:0:1\"}', 'Admin', '2018-06-19 15:58:53', '0:0:0:0:0:0:0:1', '1');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(20) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '角色的类型，1：管理员角色，2：其他',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，1：可用，0：冻结',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新的时间',
  `operate_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '产品管理员', '1', '1', '', 'Admin', '2017-10-15 12:42:47', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role` VALUES ('2', '订单管理员', '1', '1', '', 'Admin', '2017-10-15 12:18:59', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role` VALUES ('3', '公告管理员', '1', '1', '', 'Admin', '2017-10-15 12:19:10', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role` VALUES ('4', '权限管理员', '1', '1', '', 'Admin', '2017-10-15 21:30:36', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role` VALUES ('5', '运维管理员', '1', '1', '运维', 'Admin', '2017-10-17 00:23:28', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role` VALUES ('9', '用户管理员', '1', '1', '', 'Admin', '2018-06-19 15:02:34', '0:0:0:0:0:0:0:1');

-- ----------------------------
-- Table structure for sys_role_acl
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_acl`;
CREATE TABLE `sys_role_acl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `acl_id` int(11) NOT NULL COMMENT '权限id',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新的时间',
  `operate_ip` varchar(200) NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_role_acl
-- ----------------------------
INSERT INTO `sys_role_acl` VALUES ('12', '3', '10', 'Admin', '2017-10-16 23:34:39', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role_acl` VALUES ('13', '1', '1', 'Admin', '2018-06-19 13:07:52', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role_acl` VALUES ('14', '1', '11', 'Admin', '2018-06-19 13:07:52', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role_acl` VALUES ('21', '4', '5', 'Admin', '2018-06-19 15:37:43', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role_acl` VALUES ('22', '4', '7', 'Admin', '2018-06-19 15:37:43', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role_acl` VALUES ('23', '4', '13', 'Admin', '2018-06-19 15:37:43', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role_acl` VALUES ('24', '4', '15', 'Admin', '2018-06-19 15:37:43', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role_acl` VALUES ('25', '9', '7', 'Admin', '2018-06-19 15:53:33', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role_acl` VALUES ('26', '9', '14', 'Admin', '2018-06-19 15:53:33', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role_acl` VALUES ('27', '9', '15', 'Admin', '2018-06-19 15:53:33', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role_acl` VALUES ('28', '9', '9', 'Admin', '2018-06-19 15:53:33', '0:0:0:0:0:0:0:1');

-- ----------------------------
-- Table structure for sys_role_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_user`;
CREATE TABLE `sys_role_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新的时间',
  `operate_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_role_user
-- ----------------------------
INSERT INTO `sys_role_user` VALUES ('18', '1', '2', 'Admin', '2018-06-19 13:22:38', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role_user` VALUES ('19', '4', '3', 'Admin', '2018-06-19 15:02:48', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_role_user` VALUES ('20', '9', '4', 'Admin', '2018-06-19 15:03:31', '0:0:0:0:0:0:0:1');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名称',
  `telephone` varchar(13) NOT NULL DEFAULT '' COMMENT '手机号',
  `mail` varchar(64) NOT NULL DEFAULT '' COMMENT '邮箱',
  `password` varchar(64) NOT NULL DEFAULT '' COMMENT '加密后的密码',
  `job` varchar(255) NOT NULL DEFAULT '' COMMENT '职位',
  `sex` varchar(1) NOT NULL DEFAULT 'm' COMMENT '性别',
  `headImage` varchar(64) NOT NULL DEFAULT '' COMMENT '头像',
  `dept_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户所在部门的id',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态，0：正常，1：冻结状态，2：删除',
  `remark` varchar(200) DEFAULT '' COMMENT '备注',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作者',
  `operate_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后一次更新时间',
  `operate_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后一次更新者的ip地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'Admin', 'admin', 'admin@qq.com', '49447a6c4f76782b436e763557592f576142355873413d3d', '', 'm', '', '-1', '0', 'admin', 'system', '2017-10-13 08:46:16', '127.0.0.1');
INSERT INTO `sys_user` VALUES ('2', 'Jimin', '13188889999', 'jimin@qq.com', '49447a6c4f76782b436e763557592f576142355873413d3d', '', 'f', '', '1', '0', 'jimin.zheng', 'Admin', '2017-10-14 14:45:19', '127.0.0.1');
INSERT INTO `sys_user` VALUES ('3', 'Jimmy', '13812344311', 'jimmy@qq.com', '49447a6c4f76782b436e763557592f576142355873413d3d', '', 'f', '', '2', '0', '', 'Admin', '2017-10-16 12:57:35', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_user` VALUES ('4', 'Kate', '123', 'kate@qq.com', '49447a6c4f76782b436e763557592f576142355873413d3d', '', 'f', '', '1', '0', 'sss', 'Admin', '2017-10-16 23:02:51', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_user` VALUES ('5', '服务员A', '18677778888', 'service@qq.com', '49447a6c4f76782b436e763557592f576142355873413d3d', '', 'm', '', '12', '0', '', 'Admin', '2017-10-17 00:22:15', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_user` VALUES ('6', 'wwssy', '12345678911', '123@qq.com', '49447a6c4f76782b436e763557592f576142355873413d3d', '', 'm', '', '12', '0', 'sssf', 'Admin', '2018-06-15 14:16:48', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_user` VALUES ('7', 'ff', '11111111111', '12@qq.com', '49447a6c4f76782b436e763557592f576142355873413d3d', '', 'm', '', '12', '1', 'dddd', 'Admin', '2018-06-15 21:00:39', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_user` VALUES ('10', 'dsds', '12211111111', 'eee@a.com', '49447a6c4f76782b436e763557592f576142355873413d3d', '', 'm', '', '12', '0', 'fdsfds', 'Admin', '2018-06-16 21:50:39', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_user` VALUES ('11', 'dsad', '15200001111', 'dd@dff.com', '49447a6c4f76782b436e763557592f576142355873413d3d', '', 'm', '', '12', '0', 'sdfsd', 'Admin', '2018-06-16 21:50:45', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_user` VALUES ('12', 'dwaeda', '15511112222', 'ww@qq.com', '49447a6c4f76782b436e763557592f576142355873413d3d', '', 'm', '', '12', '0', 'dd', 'Admin', '2018-06-15 16:35:44', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_user` VALUES ('13', 'fffa', '15211114444', 'qq@qq.com', '49447a6c4f76782b436e763557592f576142355873413d3d', '', 'm', '', '12', '2', 'vxcv', 'Admin', '2018-06-15 17:11:34', '0:0:0:0:0:0:0:1');
INSERT INTO `sys_user` VALUES ('14', 'adminff', '11111111122', '1@qq.com', '49447a6c4f76782b436e763557592f576142355873413d3d', '', 'm', '', '12', '0', 'ff', 'Admin', '2018-06-15 16:55:05', '0:0:0:0:0:0:0:1');
