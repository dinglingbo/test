$(function(){
	nui.bps = nui.bps || {};
	nui.bps.locale="zh_CN";
	if (bps.components.Component) {
		mini.copyTo(bps.components.Component.prototype, {
			notification: {
				title: "发送通知"
			}
		});
	}
});

