package com.oct.service.accessManage.impl;

import com.google.common.base.Preconditions;
import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;
import com.oct.common.RequestHolder;
import com.oct.dto.request.accessManage.RoleParam;
import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.entity.accessManage.SysRole;
import com.oct.repository.accessManage.*;
import com.oct.service.accessManage.SysLogService;
import com.oct.service.accessManage.SysRoleService;
import com.oct.util.BeanValidator;
import com.oct.util.IpUtil;
import com.oct.util.tree.LayUiTreeUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
@Slf4j
public class SysRoleServiceImpl implements SysRoleService {

    @Autowired
    private SysRoleMapper sysRoleMapper;
    @Autowired
    private SysRoleAclMapper sysRoleAclMapper;
    @Autowired
    private SysAclModuleMapper sysAclModuleMapper;
    @Autowired
    private SysDeptMapper sysDeptMapper;
    @Autowired
    private SysRoleUserMapper sysRoleUserMapper;
    @Autowired
    private SysLogService sysLogService;

    @Override
    public List<LayUITreeDto> list() {
        return sysRoleMapper.selectAll();
    }

    @Override
    public List<LayUITreeDto> aclList(Integer roleId) {
        List<LayUITreeDto> aclModuleList = sysAclModuleMapper.selectAllForTree();
        List<LayUITreeDto> aclList = sysRoleAclMapper.selectByRoleId(roleId);
        Multimap<Integer, LayUITreeDto> moduleIdAclMap = getIntegerLayUITreeDtoMultimap(aclList);
        return LayUiTreeUtil.getAclTree(aclModuleList,moduleIdAclMap);
    }

    @Override
    public List<LayUITreeDto> userList(Integer roleId) {
        List<LayUITreeDto> deptList = sysDeptMapper.selectAll();
        List<LayUITreeDto> userList = sysRoleUserMapper.selectByRoleId(roleId);
        Multimap<Integer, LayUITreeDto> moduleIdAclMap = getIntegerLayUITreeDtoMultimap(userList);
        return LayUiTreeUtil.getAclTree(deptList,moduleIdAclMap);
    }

    @Override
    public void save(RoleParam param) {
        BeanValidator.check(param);
        SysRole role = SysRole.builder().name(param.getName()).remark(param.getRemark())
                                .operator(RequestHolder.getCurrentUser().getUsername())
                                .operateIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()))
                                .operateTime(new Date()).build();
        if(param.getId() == null){//添加
            sysRoleMapper.insertSelective(role);
            sysLogService.saveRoleLog(null, role);
        }else{//修改
            role.setId(param.getId());
            SysRole before = sysRoleMapper.selectByPrimaryKey(param.getId());
            Preconditions.checkNotNull(before, "待更新的角色不存在");
            sysRoleMapper.updateByPrimaryKeySelective(role);
            sysLogService.saveRoleLog(before, role);
        }

    }

    @Override
    public SysRole getById(Integer id) {
        return sysRoleMapper.selectByPrimaryKey(id);
    }

    @Override
    public void delete(Integer id) {
        sysRoleMapper.deleteByPrimaryKey(id);
    }

    private Multimap<Integer, LayUITreeDto> getIntegerLayUITreeDtoMultimap(List<LayUITreeDto> list) {
        Multimap<Integer, LayUITreeDto> moduleIdAclMap = ArrayListMultimap.create();
        for(LayUITreeDto user : list) {
            if(user.getCheckedNumber() == 1){
                user.setChecked(true);
            }
            String name = user.getName();
            user.setName("<span style='color:#336699;'>"+name+"</span>");
            user.setType(1);
            moduleIdAclMap.put(user.getParentId(), user);
        }
        return moduleIdAclMap;
    }
}
