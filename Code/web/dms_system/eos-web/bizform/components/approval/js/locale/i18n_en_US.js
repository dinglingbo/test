$(function(){
	nui.bps = nui.bps || {};
	nui.bps.locale="en_US";
	if (bps.components.Component) {
		mini.copyTo(bps.components.Component.prototype, {
			approval: {
				title: "Approval Message",cannotSubmit: "The work item non-operational state,can not be approved"
			}
		});
	}
});

