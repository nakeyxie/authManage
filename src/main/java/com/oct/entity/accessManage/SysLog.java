package com.oct.entity.accessManage;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;

import lombok.*;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * sys_log
 * @author 
 */
@Table(name="sys_log")
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SysLog implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 权限更新的类型，1：部门，2：用户，3：权限模块，4：权限，5：角色，6：角色用户关系，7：角色权限关系
     */
    @NotEmpty
    private Integer type;

    /**
     * 基于type后指定的对象id，比如用户、权限、角色等表的主键
     */
    @NotEmpty
    private Integer targetId;

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

    /**
     * 当前是否复原过，0：没有，1：复原过
     */
    @NotEmpty
    private Integer status;

    private static final long serialVersionUID = 1L;

}