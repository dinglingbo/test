package com.chedao.websocket.webserver.user.model;

import com.chedao.websocket.webserver.base.model.BaseModel;

public class GroupUserEntity extends BaseModel {
    private static final long serialVersionUID = 1L;

    //id
    private Long id;
    //用户id
    private Integer userId;
    //用户名
    private String userName;
    //群id
    private Long groupId;
    //加入时间
    private String joinTime;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Long getGroupId() {
        return groupId;
    }

    public void setGroupId(Long groupId) {
        this.groupId = groupId;
    }

    public String getJoinTime() {
        return joinTime;
    }

    public void setJoinTime(String joinTime) {
        this.joinTime = joinTime;
    }

    @Override
    public String toString() {
        return null;
    }
}
