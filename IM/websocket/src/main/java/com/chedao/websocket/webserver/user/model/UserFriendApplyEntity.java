package com.chedao.websocket.webserver.user.model;

import com.chedao.websocket.webserver.base.model.BaseModel;
import org.apache.commons.lang.builder.ReflectionToStringBuilder;

import java.io.Serializable;
import java.util.Map;

public class UserFriendApplyEntity extends BaseModel implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;

    private Long uid;

    private  String username;

    private Long from;

    private String from_name;

    private Long from_group;

    private Integer status;

    private String applyDate;

    private String remark;

    private String updateDate;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(String updateDate) {
        this.updateDate = updateDate;
    }

    private Map user;

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public Long getFrom() {
        return from;
    }

    public void setFrom(Long from) {
        this.from = from;
    }

    public Long getFrom_group() {
        return from_group;
    }

    public void setFrom_group(Long from_group) {
        this.from_group = from_group;
    }


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFrom_name() {
        return from_name;
    }

    public void setFrom_name(String from_name) {
        this.from_name = from_name;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(String applyDate) {
        this.applyDate = applyDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Map getUser() {
        return user;
    }

    public void setUser(Map user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return  ReflectionToStringBuilder.toString(this);
    }
}
