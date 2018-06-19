package com.oct.service.accessManage.impl;

import com.google.common.base.Splitter;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.oct.common.LogType;
import com.oct.common.RequestHolder;
import com.oct.entity.accessManage.SysLogWithBLOBs;
import com.oct.entity.accessManage.SysRoleAcl;
import com.oct.exception.ParamException;
import com.oct.repository.accessManage.SysLogMapper;
import com.oct.repository.accessManage.SysRoleAclMapper;
import com.oct.service.accessManage.SysRoleAclService;
import com.oct.util.IpUtil;
import com.oct.util.JsonMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Transformer;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Set;

@Service
@Slf4j
public class SysRoleAclServiceImpl implements SysRoleAclService {

    @Autowired
    private SysRoleAclMapper sysRoleAclMapper;
    @Autowired
    private SysLogMapper sysLogMapper;

    @Override
    public void save(Integer roleId, String aclIds) {
        if(StringUtils.isBlank(aclIds) ){
            aclIds="";
        }
        if(roleId==null){
            throw new ParamException("参数错误");
        }
        List<String> aclIdList = Splitter.on(",").trimResults().omitEmptyStrings().splitToList(aclIds);
        List<Integer> aclids = Lists.newArrayList();
        CollectionUtils.collect(aclIdList, new Transformer() {
            @Override
            public Object transform(Object o) {
                return Integer.parseInt(o.toString());
            }
        },aclids);

        //查询全部现在的
        List<Integer> nowAclList = sysRoleAclMapper.selectAclListByRoleIds(Lists.newArrayList(roleId));
        if(nowAclList.size() == aclids.size()){
            Set<Integer> nowAclSet = Sets.newHashSet(nowAclList);
            Set<Integer> aclSet = Sets.newHashSet(aclids);
            nowAclSet.removeAll(aclSet);
            if(CollectionUtils.isEmpty(nowAclSet)) return;
        }

        updateRoleAcls(roleId, aclids);
        saveRoleAclLog(roleId, nowAclList, aclids);
    }

    @Transactional
    public void updateRoleAcls(Integer roleId, List<Integer> aclids) {
        //删除原有的
        sysRoleAclMapper.deleteByRoleId(roleId);

        if (CollectionUtils.isEmpty(aclids)) {
            return;
        }
        List<SysRoleAcl> roleAclList = Lists.newArrayList();
        for(Integer aclId : aclids) {
            SysRoleAcl roleAcl = SysRoleAcl.builder().roleId(roleId).aclId(aclId).operator(RequestHolder.getCurrentUser().getUsername())
                    .operateIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest())).operateTime(new Date()).build();
            roleAclList.add(roleAcl);
        }
        sysRoleAclMapper.batchInsert(roleAclList);

    }
    private void saveRoleAclLog(int roleId, List<Integer> before, List<Integer> after) {
        SysLogWithBLOBs sysLog = new SysLogWithBLOBs();
        sysLog.setType(LogType.TYPE_ROLE_ACL);
        sysLog.setTargetId(roleId);
        sysLog.setOldValue(before == null ? "" : JsonMapper.obj2String(before));
        sysLog.setNewValue(after == null ? "" : JsonMapper.obj2String(after));
        sysLog.setOperator(RequestHolder.getCurrentUser().getUsername());
        sysLog.setOperateIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()));
        sysLog.setOperateTime(new Date());
        sysLog.setStatus(1);
        sysLogMapper.insertSelective(sysLog);
    }
}
