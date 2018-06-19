package com.oct.service.accessManage.impl;

import com.github.pagehelper.PageHelper;
import com.google.common.base.Preconditions;
import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;
import com.oct.common.RequestHolder;
import com.oct.dto.request.accessManage.AclParam;
import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.entity.accessManage.SysAcl;
import com.oct.exception.ParamException;
import com.oct.repository.accessManage.SysAclMapper;
import com.oct.repository.accessManage.SysAclModuleMapper;
import com.oct.repository.accessManage.SysRoleAclMapper;
import com.oct.service.accessManage.SysAclService;
import com.oct.service.accessManage.SysLogService;
import com.oct.util.BeanValidator;
import com.oct.util.IpUtil;
import com.oct.util.tree.LayUiTreeUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
@Slf4j
public class SysAclServiceImpl implements SysAclService {

    @Autowired
    private SysAclMapper sysAclMapper;
    @Autowired
    private SysLogService sysLogService;


    @Override
    public List<SysAcl> listByAclModuleId(Integer aclModuleId, Integer page, Integer limit) {
        PageHelper.startPage(page,limit);
        List<SysAcl> list = sysAclMapper.selectByAclModuleId(aclModuleId);
        return list;
    }

    @Override
    public void update(SysAcl acl) {
        acl.setOperator(RequestHolder.getCurrentUser().getUsername());
        acl.setOperateIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()));
        acl.setOperateTime(new Date());
        sysAclMapper.updateByPrimaryKeySelective(acl);
    }

    @Override
    public SysAcl selectById(Integer aclId) {
        return sysAclMapper.selectByPrimaryKey(aclId);
    }

    @Override
    public void saveAcl(AclParam param) {
        BeanValidator.check(param);
        if (checkExist(param.getAclModuleId(), param.getName(), param.getId())) {
            throw new ParamException("当前权限模块下面存在相同名称的权限点");
        }
        SysAcl acl = SysAcl.builder().name(param.getName()).aclModuleId(param.getAclModuleId()).url(param.getUrl())
                .type(param.getType()).status(param.getStatus()).seq(param.getSeq()).remark(param.getRemark()).build();
        acl.setOperator(RequestHolder.getCurrentUser().getUsername());
        acl.setOperateTime(new Date());
        acl.setOperateIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()));


        if(param.getId() == null){//添加
            sysAclMapper.insertSelective(acl);
            sysLogService.saveAclLog(null, acl);
        }else {//修改
            SysAcl before = sysAclMapper.selectByPrimaryKey(param.getId());
            Preconditions.checkNotNull(before, "待更新的权限点不存在");
            acl.setId(param.getId());
            sysAclMapper.updateByPrimaryKeySelective(acl);
            sysLogService.saveAclLog(before, acl);
        }
    }

    @Override
    public void delete(String aclIds) {
        if(StringUtils.isBlank(aclIds)){
            throw new ParamException("请选择要删除的员工");
        }
        String[] s = aclIds.split(",");
        Integer[] ids = new Integer[s.length];
        for(int i=0;i<s.length;i++){
            ids[i] = Integer.parseInt(s[i]);
        }
        sysAclMapper.deleteManyByPrimaryKeys(ids);
    }


    private boolean checkExist(Integer aclModuleId, String name, Integer id) {
        return sysAclMapper.countByNameAndAclModuleId(aclModuleId, name, id) > 0;
    }
}
