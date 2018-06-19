package com.oct.service.main.impl;

import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.oct.common.RequestHolder;
import com.oct.dto.query.sys.MenuQueryDto;
import com.oct.dto.response.accessManage.MenuTreeDTO;
import com.oct.entity.accessManage.SysAcl;
import com.oct.entity.accessManage.SysUser;
import com.oct.repository.accessManage.SysAclMapper;
import com.oct.repository.accessManage.SysAclModuleMapper;
import com.oct.repository.accessManage.SysRoleAclMapper;
import com.oct.repository.accessManage.SysRoleUserMapper;
import com.oct.service.main.MainService;
import com.oct.util.tree.MenuTreeUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.AntPathMatcher;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Slf4j
public class MainServiceImpl implements MainService {

    @Autowired
    private SysAclModuleMapper sysAclModuleMapper;
    @Autowired
    private SysAclMapper sysAclMapper;
    @Autowired
    private SysRoleUserMapper sysRoleUserMapper;
    @Autowired
    private SysRoleAclMapper sysRoleAclMapper;

    private AntPathMatcher antPathMatcher = new AntPathMatcher();

    @Override
    public List<MenuTreeDTO> getMenu(Integer id) {
        List<MenuQueryDto> menus  = sysAclModuleMapper.selectAll();
        if(!isSuperAdmin()){//判断是否是管理员
            List<MenuQueryDto> acls = sysAclModuleMapper.selectMenuByUserId(id);
            Set<Integer> parents = Sets.newConcurrentHashSet();
            for(MenuQueryDto m : acls){
                parents.add(m.getParentId());
            }
            for(Integer i : parents){
                List<MenuQueryDto> parentList = getParentList(i,menus);
                acls.addAll(parentList);
            }
            menus = acls;
        }
        List<MenuTreeDTO> tree = MenuTreeUtil.getMenuTree(menus);
        return tree;
    }

    //判断权限 true：有权限  false：没有权限
    @Override
    public boolean hasUrlAcl(String url) {
        if (isSuperAdmin()) {
            return true;
        }
        List<SysAcl> aclList = getCurrentUserAclList();
        if (CollectionUtils.isEmpty(aclList)) {
            return true;
        }

        //List<SysAcl> userAclList = getCurrentUserAclListFromCache();
        Set<String> urls = aclList.stream().map(acl -> acl.getUrl()).collect(Collectors.toSet());
        boolean hasValidAcl = false;
        for(String u : urls){
            if(antPathMatcher.match(u,url)){
                hasValidAcl = true;
                break;
            }
        }

        return hasValidAcl;
    }

    private List<MenuQueryDto> getParentList(Integer id,List<MenuQueryDto> menus) {
        List<MenuQueryDto> result = Lists.newArrayList();
        if(id != 0){
            for(MenuQueryDto m : menus){
                if(m.getId().equals(id)){
                    result.add(m);
                    List<MenuQueryDto> parentList = getParentList(m.getParentId(),menus);
                    result.addAll(parentList);
                }
            }
        }
        return result;
    }

    public boolean isSuperAdmin() {
        // 这里是我自己定义了一个假的超级管理员规则，实际中要根据项目进行修改
        // 可以是配置文件获取，可以指定某个用户，也可以指定某个角色
        SysUser sysUser = RequestHolder.getCurrentUser();
        if (sysUser.getMail().contains("admin")) {
            return true;
        }
        return false;
    }
    public List<SysAcl> getCurrentUserAclList() {
        int userId = RequestHolder.getCurrentUser().getId();
        return getUserAclList(userId);
    }

    public List<SysAcl> getRoleAclList(int roleId) {
        List<Integer> aclIdList = sysRoleAclMapper.selectAclListByRoleIds(Lists.<Integer>newArrayList(roleId));
        if (CollectionUtils.isEmpty(aclIdList)) {
            return Lists.newArrayList();
        }
        return sysAclMapper.getByIdList(aclIdList);
    }

    public List<SysAcl> getUserAclList(int userId) {

        List<Integer> userRoleIdList = sysRoleUserMapper.getRoleIdListByUserId(userId);
        if (CollectionUtils.isEmpty(userRoleIdList)) {
            return Lists.newArrayList();
        }
        List<Integer> userAclIdList = sysRoleAclMapper.getAclIdListByRoleIdList(userRoleIdList);
        if (CollectionUtils.isEmpty(userAclIdList)) {
            return Lists.newArrayList();
        }
        return sysAclMapper.getByIdList(userAclIdList);
    }
}
