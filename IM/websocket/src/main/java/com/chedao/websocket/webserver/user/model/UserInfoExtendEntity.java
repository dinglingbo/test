package com.chedao.websocket.webserver.user.model;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

import java.io.Serializable;

public class UserInfoExtendEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    private  Long id;

    private String avatar;

    private String username;

    private String sign;

    @Override
    public String toString() {
        return  ReflectionToStringBuilder.toString(this);
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }
}
