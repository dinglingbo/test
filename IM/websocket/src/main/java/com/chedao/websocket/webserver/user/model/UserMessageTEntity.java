package com.chedao.websocket.webserver.user.model;

import com.chedao.websocket.webserver.base.model.BaseModel;
import org.apache.commons.lang.builder.ReflectionToStringBuilder;

public class UserMessageTEntity {
    private static final long serialVersionUID = 1L;

    private Long id;

    private String content;

    private String uid;

    private String from;

    private Long from_group;

    private Integer type;

    private String remark;

    private String href;

    private  Integer read;

    private String time;

    private  UserInfoExtendEntity user;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public Long getFrom_group() {
        return from_group;
    }

    public void setFrom_group(Long from_group) {
        this.from_group = from_group;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public Integer getRead() {
        return read;
    }

    public void setRead(Integer read) {
        this.read = read;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public UserInfoExtendEntity getUser() {
        return user;
    }

    public void setUser(UserInfoExtendEntity user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return  ReflectionToStringBuilder.toString(this);
    }
}
