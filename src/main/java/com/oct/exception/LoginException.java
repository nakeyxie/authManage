package com.oct.exception;

import lombok.Getter;

@Getter
public class LoginException extends RuntimeException{

    private Integer code;


    public LoginException (LogInEnum logInEnum){
        super(logInEnum.getMessage());
        this.code = logInEnum.getCode();
    }
}
