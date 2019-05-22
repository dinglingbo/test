package com.chedao.websocket.webserver.user.model;

import java.util.Date;

public class UserFriendEntity {
    private Long id;
    private Long userid;
    private String username;
    private Long friendid;
    private String friendname;
    private Long typeid;
    private Date buildtime;

    public UserFriendEntity() {
    }

    @Override
    public String toString() {
        return "UserFriend{" +
                "id=" + id +
                ", userid=" + userid +
                ", username='" + username + '\'' +
                ", friendid=" + friendid +
                ", friendname='" + friendname + '\'' +
                ", typeid=" + typeid +
                ", buildtime=" + buildtime +
                '}';
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setUserid(Long userid) {
        this.userid = userid;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setFriendid(Long friendid) {
        this.friendid = friendid;
    }

    public void setFriendname(String friendname) {
        this.friendname = friendname;
    }

    public void setType(Long typeid) {
        this.typeid = typeid;
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

    public String getUsername() {
        return username;
    }

    public Long getFriendid() {
        return friendid;
    }

    public String getFriendname() {
        return friendname;
    }

    public Long getTypeid() {
        return typeid;
    }

    public Date getBuildtime() {
        return buildtime;
    }
}
