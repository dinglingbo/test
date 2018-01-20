$(function(){
	nui.bps = nui.bps || {};
	nui.bps.locale="en_US";
	if (bps.components.Component) {
		mini.copyTo(bps.components.Component.prototype, {
			back: {
				title: "Back Activity Strategy"
			}
		});
	}
});

