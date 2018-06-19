package com.oct.repository.accessManage;

import com.oct.entity.accessManage.SysUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SysUserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysUser record);

    int insertSelective(SysUser record);

    SysUser selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysUser record);

    int updateByPrimaryKey(SysUser record);

    /*登录*/
    SysUser login(@Param("account") String account, @Param("password") String password);

    List<SysUser> selectAll();

    List<SysUser> selectByDeptId(@Param("deptIds") Integer... deptIds);

    Integer selectCountByDeptId(@Param("deptIds") Integer... deptIds);

    int countByMail(@Param("mail") String mail, @Param("id") Integer id);

    int countByTelephone(@Param("telephone") String telephone, @Param("id") Integer id);

    /**
     * 修改为删除状态（假删除）
     */
    int deleteStatusManyByPrimaryKeys(@Param("ids")Integer[] ids);

    /**
     * 删除  （真删除）
     */
    int deleteManyByPrimaryKeys(@Param("ids")Integer[] ids);

    List<SysUser> queryByKeyWords(@Param("param") String param);
}