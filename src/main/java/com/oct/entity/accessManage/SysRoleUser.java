package com.oct.entity.accessManage;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;

import lombok.*;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * sys_role_user
 * @author 
 */
@Table(name="sys_role_user")
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SysRoleUser implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 角色id
     */
    @NotEmpty
    private Integer roleId;

    /**
     * 用户id
     */
    @NotEmpty
    private Integer userId;

    /**
     * 操作者
     */
    @NotEmpty
    private String operator;

    /**
     * 最后一次更新的时间
     */
    @NotEmpty
    private Date operateTime;

    /**
     * 最后一次更新者的ip地址
     */
    @NotEmpty
    private String operateIp;

    private static final long serialVersionUID = 1L;

}