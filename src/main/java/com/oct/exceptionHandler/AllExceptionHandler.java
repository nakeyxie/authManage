package com.oct.exceptionHandler;

import com.oct.common.JsonResult;
import com.oct.exception.LoginException;
import com.oct.exception.ParamException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class AllExceptionHandler {


    @ExceptionHandler(LoginException.class)
    @ResponseBody
    public JsonResult LoginExceptionHandle(LoginException e){
        return JsonResult.fail(e.getCode(),e.getMessage());
    }

    @ExceptionHandler(ParamException.class)
    @ResponseBody
    public JsonResult ParamExceptionHandle(ParamException e){
        return JsonResult.fail(-1,e.getMessage());
    }


}
