package com.oct.dto.request.main;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.NotNull;

@Getter
@Setter
@ToString
public class LoginParam {
    @NotNull(message = "用户名不能为空")
    private String account;
    @NotNull(message = "密码不能为空")
    private String password;
    @NotNull(message = "验证码不能为空")
    private String imageCode;

}
