package com.chedao.websocket.webserver.user.model;

import com.chedao.websocket.webserver.base.model.BaseModel;
import org.apache.commons.lang.builder.ReflectionToStringBuilder;

import java.util.Map;

public class UserFriendApplyEntity extends BaseModel {
    private static final long serialVersionUID = 1L;

    private Long id;

    private Long uid;

    private Long from;

    private Long from_group;

    private Integer status;

    private String applyDate;

    private String remark;

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
