package com.oct.service.accessManage.impl;

import com.github.pagehelper.PageHelper;
import com.google.common.base.Preconditions;
import com.google.common.base.Splitter;
import com.google.common.collect.Lists;
import com.oct.common.RequestHolder;
import com.oct.dto.request.accessManage.UserParam;
import com.oct.entity.accessManage.SysUser;
import com.oct.exception.LogInEnum;
import com.oct.exception.LoginException;
import com.oct.exception.ParamException;
import com.oct.repository.accessManage.SysUserMapper;
import com.oct.service.accessManage.SysLogService;
import com.oct.service.accessManage.SysUserService;
import com.oct.util.BeanValidator;
import com.oct.util.DigestUtil;
import com.oct.util.IpUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Transformer;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service("sysUserService")
@Slf4j
public class SysUserServiceImpl implements SysUserService {
    @Autowired
    private SysUserMapper sysUserMapper;
    @Autowired
    private SysLogService sysLogService;



    /**
     * 添加或修改用户
     */
    @Override
    public void saveUser(UserParam param) {
        BeanValidator.check(param);
        if(checkTelephoneExist(param.getTelephone(), param.getId())) {
            throw new ParamException("电话已被占用");
        }
        if(checkEmailExist(param.getMail(), param.getId())) {
            throw new ParamException("邮箱已被占用");
        }
        String password = "111111";//TODO  暂时默认

        SysUser user = SysUser.builder().username(param.getUsername()).telephone(param.getTelephone()).mail(param.getMail())
                .deptId(param.getDeptId()).sex(param.getSex()).status(param.getStatus()).remark(param.getRemark()).build();
        user.setOperator(RequestHolder.getCurrentUser().getUsername());
        user.setOperateIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()));
        user.setOperateTime(new Date());
        if(param.getId() == null){//添加
            user.setPassword(DigestUtil.md5(password));
            sysUserMapper.insertSelective(user);
            sysLogService.saveUserLog(null, user);
        }else {//修改
            SysUser before = sysUserMapper.selectByPrimaryKey(param.getId());
            Preconditions.checkNotNull(before, "待更新的用户不存在");
            user.setId(param.getId());
            sysUserMapper.updateByPrimaryKeySelective(user);
            sysLogService.saveUserLog(before, user);
        }

    }

    /**
     * 登陆
     */
    @Override
    public SysUser login(String account, String password) {
        SysUser user =null;
        try {
            user = sysUserMapper.login(account,DigestUtil.md5(password));
        }catch (Exception e){
            log.error("登陆失败",e);
            throw new LoginException(LogInEnum.ERROR);
        }
        if(user==null){
            throw new LoginException(LogInEnum.PASSWORD_ERROR);
        }
        if(user.getStatus() != 0){
            throw new LoginException(LogInEnum.ACCOUNT_STATUS_ERROR);
        }
        return user;
    }

    /**
     * 查询全部用户
     */
    @Override
    public List<SysUser> selectAll(){
        return sysUserMapper.selectAll();
    }

    /**
     * 根据部门Id查询用户
     */
    @Override
    public List<SysUser> listByDeptId(String deptId,Integer page,Integer limit) {
        String[] s = deptId.split(",");
        Integer[] ids = new Integer[s.length];
        for(int i=0;i<s.length;i++){
            ids[i] = Integer.parseInt(s[i]);
        }

        //分页插件
        PageHelper.startPage(page,limit);
        List<SysUser> list = sysUserMapper.selectByDeptId(ids);
        return list;
    }

    @Override
    public SysUser selectById(Integer id) {
        return sysUserMapper.selectByPrimaryKey(id);
    }

    @Override
    public void update(SysUser user) {
        user.setOperator(RequestHolder.getCurrentUser().getUsername());
        user.setOperateIp(IpUtil.getRemoteIp(RequestHolder.getCurrentRequest()));
        user.setOperateTime(new Date());
        sysUserMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public void delete(String userIds) {
        if(StringUtils.isBlank(userIds)){
            throw new ParamException("请选择要删除的员工");
        }
        String[] s = userIds.split(",");
        Integer[] ids = new Integer[s.length];
        for(int i=0;i<s.length;i++){
            ids[i] = Integer.parseInt(s[i]);
        }
        //修改为删除状态
        sysUserMapper.deleteStatusManyByPrimaryKeys(ids);
    }

    @Override
    public List<SysUser> query(String param, Integer page, Integer limit) {
        if(StringUtils.isBlank(param)){
            return new ArrayList<SysUser>();
        }
        //分页插件
        PageHelper.startPage(page,limit);
        List<SysUser> list = sysUserMapper.queryByKeyWords(param);
        return list;
    }

    private boolean checkEmailExist(String mail, Integer userId) {
        return sysUserMapper.countByMail(mail, userId) > 0;
    }

    private boolean checkTelephoneExist(String telephone, Integer userId) {
        return sysUserMapper.countByTelephone(telephone, userId) > 0;
    }
}
