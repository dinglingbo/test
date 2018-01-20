$(function(){
	nui.bps = nui.bps || {};
	nui.bps.locale="zh_CN";
	if (bps.components.Component) {
		mini.copyTo(bps.components.Component.prototype, {
			errorMessage: "提交失败，请联系管理员！",
			Participant: "参与者",
			AppointActivity4Freeflow:"指派后继活动",
			select:"选择"
		});
	}
});

