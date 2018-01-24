package com.hs.common.model;

public class RoleMembersModel {
	
	private Long memberId;
	private Long roleId;
	private Long memberSourceId;
	private String memberType;
	private String includeChild;
	
	public RoleMembersModel() {}

	public RoleMembersModel(Long memberId, Long roleId, Long memberSourceId,
			String memberType, String includeChild) {
		this.memberId = memberId;
		this.roleId = roleId;
		this.memberSourceId = memberSourceId;
		this.memberType = memberType;
		this.includeChild = includeChild;
	}

	public Long getMemberId() {
		return memberId;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public Long getMemberSourceId() {
		return memberSourceId;
	}

	public void setMemberSourceId(Long memberSourceId) {
		this.memberSourceId = memberSourceId;
	}

	public String getMemberType() {
		return memberType;
	}

	public void setMemberType(String memberType) {
		this.memberType = memberType;
	}

	public String getIncludeChild() {
		return includeChild;
	}

	public void setIncludeChild(String includeChild) {
		this.includeChild = includeChild;
	}

	@Override
	public String toString() {
		return "RoleMembersModel [memberId=" + memberId + ", roleId=" + roleId
				+ ", memberSourceId=" + memberSourceId + ", memberType="
				+ memberType + ", includeChild=" + includeChild + "]";
	}
	
}
