
nui.bps.locale="en_US";

if (nui.bps.SelectResource) {
	mini.copyTo(nui.bps.SelectResource.prototype, {
		selectText: "Select "
    });
}

if (nui.bps.SelectParticipant) {
	mini.copyTo(nui.bps.SelectParticipant.prototype, {
		selectText: "Select ",
		participantText : "Participant"
    });
}

if (nui.bps.SelectProcessAndActivity) {
	mini.copyTo(nui.bps.SelectProcessAndActivity.prototype, {
		selectText: "Select ",
		processAndActivityText : "Process And Activity"
    });
}

if (nui.bps.BPSPager) {
	mini.copyTo(nui.bps.BPSPager.prototype, {
		first : "← First",
	    last : "Last →",
	    previous : "← Previous",
	    next : "Next →",
	    pageInfoText:"Showing {start} to {end} of {total} entries",
	    noRecordPageInfoText:"No entries"
    });
}

if(nui.bps.FetchMessageList) {
	mini.copyTo(nui.bps.FetchMessageList.prototype, {
		headerLine : '<tr><th align="center" width="30%">Time</th><th align="center" width="20%">OperationType</th><th align="center" width="30%">Content</th><th align="center" width="20%">From</th></tr>'
	});
}

if(nui.bps.AppointActivity) {
	mini.copyTo(nui.bps.AppointActivity.prototype, {
		freeFlowTitle:"appoint step activity",
		freeFlowText:"choose step activity",
		appointParticipantTitle:"appoint step activity's participants",
		appointParticipantText:"choose step activity's participants"
	});
}
if(nui.bps.ProcessGraph) {
	mini.copyTo(nui.bps.ProcessGraph.prototype, {
		partiName:"Participants",
		startTime:"Start Time",
		endTime:"End Time",
		timeOutFlag:"Process Instance Is Timeout!",
		timeOut:"Timeout",
		Y:"Yes",
		N:"No"
	});
}