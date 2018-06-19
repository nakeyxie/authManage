package com.oct.entity.accessManage;

import lombok.*;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * sys_user
 * @author 
 */
@Table(name="sys_user")
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SysUser implements Serializable {
    /**
     * 用户id
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 用户名称
     */
    @NotEmpty
    private String username;

    /**
     * 手机号
     */
    @NotEmpty
    private String telephone;

    /**
     * 邮箱
     */
    @NotEmpty
    private String mail;

    /**
     * 加密后的密码
     */
    @NotEmpty
    private String password;

    /**
     * 职位
     */
    @NotEmpty
    private String job;

    /**
     * 性别
     */
    @NotEmpty
    private String sex;

    /**
     * 头像
     */
    @NotEmpty
    private String headimage;

    /**
     * 用户所在部门的id
     */
    @NotEmpty
    private Integer deptId;

    /**
     * 状态，0：正常，1：冻结状态，2：删除
     */
    @NotEmpty
    private Integer status;

    /**
     * 备注
     */
    private String remark;

    /**
     * 操作者
     */
    @NotEmpty
    private String operator;

    /**
     * 最后一次更新时间
     */
    @NotEmpty
    private Date operateTime;

    /**
     * 最后一次更新者的ip地址
     */
    @NotEmpty
    private String operateIp;

    private static final long serialVersionUID = 1L;


    private String deptname;
}