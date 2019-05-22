package com.chedao.websocket.webserver.user.model;

import com.chedao.websocket.webserver.base.model.BaseModel;

import java.io.Serializable;
import java.util.Date;

public class UserTypeEntity extends BaseModel implements Serializable {
    private static final long serialVersionUID = 1L;

    //用户id
    private Long id;
    //用户id
    private Long userid;
    //组别名称
    private String name;
    //分组时间
    private Date buildtime;

    public UserTypeEntity() {
    }

    public UserTypeEntity(Long id, Long userid, String name, Date buildtime) {
        this.id = id;
        this.userid = userid;
        this.name = name;
        this.buildtime = buildtime;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setUserid(Long userid) {
        this.userid = userid;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setBuildtime(Date buildtime) {
        this.buildtime = buildtime;
    }

    public Long getId() {
        return id;
    }

    public Long getUserid() {
        return userid;
    }

    public String getName() {
        return name;
    }

    public Date getBuildtime() {
        return buildtime;
    }

    @Override
    public String toString() {
        return "UserTypeEntity{" +
                "id=" + id +
                ", userid=" + userid +
                ", name='" + name + '\'' +
                ", buildtime=" + buildtime +
                '}';
    }
}
