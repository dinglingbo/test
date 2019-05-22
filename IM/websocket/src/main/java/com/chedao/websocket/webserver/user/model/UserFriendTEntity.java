package com.chedao.websocket.webserver.user.model;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

import java.io.Serializable;
import java.util.List;

public class UserFriendTEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private String online;
    private String groupname;
    private List<ImFriendUserInfoData> list;

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

    public String getOnline() {
        return online;
    }

    public void setOnline(String online) {
        this.online = online;
    }

    public String getGroupname() {
        return groupname;
    }

    public void setGroupname(String groupname) {
        this.groupname = groupname;
    }

    public List<ImFriendUserInfoData> getList() {
        return list;
    }

    public void setList(List<ImFriendUserInfoData> list) {
        this.list = list;
    }
}
