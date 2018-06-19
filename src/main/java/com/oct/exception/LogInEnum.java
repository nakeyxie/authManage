package com.oct.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@AllArgsConstructor
public enum LogInEnum {
    ERROR(-1,"登陆失败"),
    PASSWORD_ERROR(1,"用户名或密码错误"),
    CODE_ERROE(2,"验证码错误"),
    ACCOUNT_STATUS_ERROR(3,"账号状态有误，请联系管理员"),
    ;
    private Integer code;
    private String message;

}
