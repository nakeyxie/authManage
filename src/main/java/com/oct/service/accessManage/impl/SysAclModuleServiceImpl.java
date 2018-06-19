package com.oct.service.accessManage.impl;

import com.google.common.base.Preconditions;
import com.oct.common.RequestHolder;
import com.oct.dto.request.accessManage.AclModuleParam;
import com.oct.dto.response.accessManage.LayUITreeDto;
import com.oct.entity.accessManage.SysAclModule;
import com.oct.exception.ParamException;
import com.oct.repository.accessManage.SysAclModuleMapper;
import com.oct.service.accessManage.SysAclModuleService;
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
public class SysAclModuleServiceImpl implements SysAclModuleService {

    @Autowired
    private SysAclModuleMapper sysAclModuleMapper;
    @Autowired
    private SysLogService sysLogService;

    @Override
    public List<LayUITreeDto> list() {
        List<LayUITreeDto> list = sysAclModuleMapper.selectAllForTree();
        return LayUiTreeUtil.getTree(list);
    }

    @Override
    public SysAclModule selectById(Integer aclModuleId) {
        return sysAclModuleMapper.selectByPrimaryKey(aclModuleId);
    }

    @Override
    public void save(AclModuleParam param) {
        BeanValidator.check(param);
        if(checkExist(param.getParentId(), param.getName(), param.getId())) {
            throw new ParamException("同一层级下存在相同名称的权限模块");
        }
        SysAclModule aclModule = SysAclModule.builder().name(param.getName()).parentId(param.getParentId()).seq(param.getSeq())
                .remark(param.getRemark()).build();
        aclModule.setOperator(RequestHolder.getCurrentUser().getUsername());
        aclModule.setOperateIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()));
        aclModule.setOperateTime(new Date());

        if(param.getId() == null ){//添加
            sysAclModuleMapper.insertSelective(aclModule);
            sysLogService.saveAclModuleLog(null, aclModule);
        }else{//修改
            aclModule.setId(param.getId());
            SysAclModule before = sysAclModuleMapper.selectByPrimaryKey(param.getId());
            Preconditions.checkNotNull(before, "待更新的权限模块不存在");

            sysAclModuleMapper.updateByPrimaryKeySelective(aclModule);
            sysLogService.saveAclModuleLog(before, aclModule);
        }
    }

    private boolean checkExist(Integer parentId, String aclModuleName, Integer id) {
        return sysAclModuleMapper.countByNameAndParentId(parentId, aclModuleName, id) > 0;
    }

    @Override
    public void delete(String aclModuleIds) {
        if(StringUtils.isBlank(aclModuleIds)){
            throw new ParamException("请选择要删除的权限模块");
        }
        String[] s = aclModuleIds.split(",");
        Integer[] ids = new Integer[s.length];
        for(int i=0;i<s.length;i++){
            ids[i] = Integer.parseInt(s[i]);
        }

        Integer n = sysAclModuleMapper.queryExistAclByAclModuleIds(ids);
        if(n>0){
            throw new ParamException("该权限模块下存在权限，无法被删除");
        }
        sysAclModuleMapper.deleteManyByPrimaryKeys(ids);
    }
}
