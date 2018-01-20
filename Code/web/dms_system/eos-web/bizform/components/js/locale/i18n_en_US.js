$(function(){
	nui.bps = nui.bps || {};
	nui.bps.locale="en_US";
	if (bps.components.Component) {
		mini.copyTo(bps.components.Component.prototype, {
			errorMessage: "Submit failure, please contact your administrator!",
			Participant: "Participant",
			AppointActivity4Freeflow:"Appoint Activity For Freeflow",
			select:"Select "
		});
	}
});

