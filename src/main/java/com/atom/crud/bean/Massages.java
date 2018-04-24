package com.atom.crud.bean;

import java.util.HashMap;
import java.util.Map;

public class Massages {
//    状态码
    private int code;
//    提示信息
    private String msg;
//用户需要返回的数据
    private Map<String,Object> extend = new HashMap<String, Object>();

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    public static Massages Success(){
            Massages result = new Massages();
            result.setCode(100);
            result.setMsg("处理成功");
            return result;
    }

    public static Massages fail(){
        Massages result = new Massages();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }

    public Massages add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }

}
