$(function(){
	nui.bps = nui.bps || {};
	nui.bps.locale="zh_CN";
	if (bps.components.Component) {
		mini.copyTo(bps.components.Component.prototype, {
			approval: {
				title: "审批意见",cannotSubmit: "该工作项非运行状态，无法进行审批"
			}
		});
	}
});

