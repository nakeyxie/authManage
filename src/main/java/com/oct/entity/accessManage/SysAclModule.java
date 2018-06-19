package com.oct.entity.accessManage;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;

import lombok.*;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * sys_acl_module
 * @author 
 */
@Table(name="sys_acl_module")
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SysAclModule implements Serializable {
    /**
     * 权限模块id
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 权限模块名称
     */
    @NotEmpty
    private String name;

    /**
     * 上级权限模块id
     */
    @NotEmpty
    private Integer parentId;

    /**
     * 权限模块层级
     */
    @NotEmpty
    private String level;

    /**
     * 权限模块在当前层级下的顺序，由小到大
     */
    @NotEmpty
    private Integer seq;

    /**
     * 菜单图标
     */
    @NotEmpty
    private String icon;

    /**
     * 状态，1：正常，2：冻结
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
     * 最后一次操作时间
     */
    @NotEmpty
    private Date operateTime;

    /**
     * 最后一次更新操作者的ip地址
     */
    @NotEmpty
    private String operateIp;

    private String href;

    private static final long serialVersionUID = 1L;

}