package com.oct.entity.accessManage;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

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
public class SysLogWithBLOBs extends SysLog implements Serializable {
    /**
     * 旧值
     */
    private String oldValue;

    /**
     * 新值
     */
    private String newValue;

    private static final long serialVersionUID = 1L;

}