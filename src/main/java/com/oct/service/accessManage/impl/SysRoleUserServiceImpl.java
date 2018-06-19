package com.oct.service.accessManage.impl;

import com.google.common.base.Splitter;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.oct.common.LogType;
import com.oct.common.RequestHolder;
import com.oct.entity.accessManage.SysLogWithBLOBs;
import com.oct.entity.accessManage.SysRoleUser;
import com.oct.exception.ParamException;
import com.oct.repository.accessManage.SysLogMapper;
import com.oct.repository.accessManage.SysRoleUserMapper;
import com.oct.service.accessManage.SysRoleUserService;
import com.oct.util.IpUtil;
import com.oct.util.JsonMapper;
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
public class SysRoleUserServiceImpl implements SysRoleUserService {

    @Autowired
    private SysRoleUserMapper sysRoleUserMapper;
    @Autowired
    private SysLogMapper sysLogMapper;

    @Override
    public void save(Integer roleId, String userIds) {
        if(StringUtils.isBlank(userIds) ){
            userIds="";
        }
        if(roleId==null){
            throw new ParamException("参数错误");
        }
        List<String> userIdStrList = Splitter.on(",").trimResults().omitEmptyStrings().splitToList(userIds);
        List<Integer> userIdList = Lists.newArrayList();
        CollectionUtils.collect(userIdStrList, new Transformer() {
            @Override
            public Object transform(Object o) {
                return Integer.parseInt(o.toString());
            }
        },userIdList);

        //查询全部现在的
        List<Integer> nowUserList = sysRoleUserMapper.selectUserListByRoleIds(Lists.newArrayList(roleId));
        if(nowUserList.size() == userIdList.size()){
            Set<Integer> nowUserSet = Sets.newHashSet(nowUserList);
            Set<Integer> userSet = Sets.newHashSet(userIdList);
            nowUserSet.removeAll(userSet);
            if(CollectionUtils.isEmpty(nowUserSet)) return;
        }

        updateRoleUsers(roleId, userIdList);
        saveRoleUserLog(roleId, nowUserList, userIdList);
    }

    private void saveRoleUserLog(Integer roleId, List<Integer> before, List<Integer> after) {
        SysLogWithBLOBs sysLog = new SysLogWithBLOBs();
        sysLog.setType(LogType.TYPE_ROLE_USER);
        sysLog.setTargetId(roleId);
        sysLog.setOldValue(before == null ? "" : JsonMapper.obj2String(before));
        sysLog.setNewValue(after == null ? "" : JsonMapper.obj2String(after));
        sysLog.setOperator(RequestHolder.getCurrentUser().getUsername());
        sysLog.setOperateIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()));
        sysLog.setOperateTime(new Date());
        sysLog.setStatus(1);
        sysLogMapper.insertSelective(sysLog);
    }

    @Transactional
    public void updateRoleUsers(Integer roleId, List<Integer> userIdList) {
        sysRoleUserMapper.deleteByRoleId(roleId);

        if (CollectionUtils.isEmpty(userIdList)) {
            return;
        }
        List<SysRoleUser> roleUserList = Lists.newArrayList();
        for (Integer userId : userIdList) {
            SysRoleUser roleUser = SysRoleUser.builder().roleId(roleId).userId(userId).operator(RequestHolder.getCurrentUser().getUsername())
                    .operateIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest())).operateTime(new Date()).build();
            roleUserList.add(roleUser);
        }
        sysRoleUserMapper.batchInsert(roleUserList);
    }
}
