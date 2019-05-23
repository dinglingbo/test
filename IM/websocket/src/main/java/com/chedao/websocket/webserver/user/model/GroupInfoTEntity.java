package com.chedao.websocket.webserver.user.model;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

import java.io.Serializable;

public class GroupInfoTEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;
    private String groupname;
    private String avatar;

    @Override
    public String toString() {
        return  ReflectionToStringBuilder.toString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getGroupname() {
        return groupname;
    }

    public void setGroupname(String groupname) {
        this.groupname = groupname;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}
