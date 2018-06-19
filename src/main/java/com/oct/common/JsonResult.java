package com.oct.common;

import com.github.pagehelper.Page;
import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
public class JsonResult {

    private Integer code = 0;

    private String msg;

    private Object data;

    private Integer count = 0;

    public JsonResult() {

    }

    public static JsonResult success(Object object, String msg) {
        JsonResult JsonResult = new JsonResult();
        JsonResult.data = object;
        JsonResult.msg = msg;
        return JsonResult;
    }

    public static JsonResult success(Object object) {
        JsonResult JsonResult = new JsonResult();
        JsonResult.data = object;
        return JsonResult;
    }
    public static JsonResult successPage(Object object) {
        JsonResult JsonResult = new JsonResult();
        JsonResult.data = object;
        JsonResult.count = object == null ? 0 : (int)(((Page) object).getTotal());
        return JsonResult;
    }

    public static JsonResult success() {
        return new JsonResult();
    }

    public static JsonResult fail(Integer code,String msg) {
        JsonResult JsonResult = new JsonResult();
        JsonResult.code = code;
        JsonResult.msg = msg;
        return JsonResult;
    }

    public Map<String, Object> toMap() {
        HashMap<String, Object> result = new HashMap<String, Object>();
        result.put("ret", code);
        result.put("msg", msg);
        result.put("data", data);
        return result;
    }
}
