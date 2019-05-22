package com.chedao.websocket.webserver.user.model;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

import java.io.Serializable;

public class MessageInfoEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;

    private String type;

    private String avatar;

    private String username;

    private String content;

    private Long timestamp;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Long timestamp) {
        this.timestamp = timestamp;
    }

    @Override
    public String toString() {
        return  ReflectionToStringBuilder.toString(this);
    }
}
