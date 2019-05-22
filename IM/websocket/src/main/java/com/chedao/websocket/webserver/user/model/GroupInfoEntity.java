package com.chedao.websocket.webserver.user.model;

import com.chedao.websocket.webserver.base.model.BaseModel;

public class GroupInfoEntity  {
    private static final long serialVersionUID = 1L;

    //群id
    private Integer id;
    //群号
    private String groupNum;
    //群名称
    private String groupName;
    //群头像
    private String avatar;
    //群主id
    private Integer groupManId;
    //群主
    private String groupMan;
    //状态
    private Integer status;
    //备注
    private String remark;
    //创建人ID
    private Integer recorderId;
    //创建人
    private String recorder;
    //创建日期
    private String recordDate;
    //修改人ID
    private Integer modifierId;
    //修改人
    private String modifier;
    //修改日期
    private String modifierDate;

    @Override
    public String toString() {
        return null;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }


    public Integer getId() {
        return id;
    }


    public void setId(Integer id) {
        this.id = id;
    }

    public String getGroupNum() {
        return groupNum;
    }

    public void setGroupNum(String groupNum) {
        this.groupNum = groupNum;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public Integer getGroupManId() {
        return groupManId;
    }

    public void setGroupManId(Integer groupManId) {
        this.groupManId = groupManId;
    }

    public String getGroupMan() {
        return groupMan;
    }

    public void setGroupMan(String groupMan) {
        this.groupMan = groupMan;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getRecorderId() {
        return recorderId;
    }

    public void setRecorderId(Integer recorderId) {
        this.recorderId = recorderId;
    }

    public String getRecorder() {
        return recorder;
    }

    public void setRecorder(String recorder) {
        this.recorder = recorder;
    }

    public String getRecordDate() {
        return recordDate;
    }

    public void setRecordDate(String recordDate) {
        this.recordDate = recordDate;
    }

    public Integer getModifierId() {
        return modifierId;
    }

    public void setModifierId(Integer modifierId) {
        this.modifierId = modifierId;
    }

    public String getModifier() {
        return modifier;
    }

    public void setModifier(String modifier) {
        this.modifier = modifier;
    }

    public String getModifierDate() {
        return modifierDate;
    }

    public void setModifierDate(String modifierDate) {
        this.modifierDate = modifierDate;
    }
}
