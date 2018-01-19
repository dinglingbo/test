
nui.bps.locale="zh_CN";

if (nui.bps.SelectResource) {
	mini.copyTo(nui.bps.SelectResource.prototype, {
		selectText: "选择"
    });
}

if (nui.bps.SelectParticipant) {
	mini.copyTo(nui.bps.SelectParticipant.prototype, {
		selectText: "选择",
		participantText : "参与者"
    });
}

if (nui.bps.SelectProcessAndActivity) {
	mini.copyTo(nui.bps.SelectProcessAndActivity.prototype, {
		selectText: "选择",
		processAndActivityText : "流程和活动"
    });
}

if (nui.bps.BPSPager) {
	mini.copyTo(nui.bps.BPSPager.prototype, {
		first : "← 第一页",
	    last : "最后一页 →",
	    previous : "← 上一页",
	    next : "下一页 →",
	    pageInfoText:"显示{total}条记录中的第{start}到{end}条",
	    noRecordPageInfoText:"没有记录"
    });
}

if(nui.bps.FetchMessageList) {
	mini.copyTo(nui.bps.FetchMessageList.prototype, {
		headerLine : '<tr><th align="center" width="30%">时间</th><th align="center" width="20%">操作类型</th><th align="center" width="30%">内容</th><th align="center" width="20%">信息来源</th></tr>'
	});
}

if(nui.bps.AppointActivity) {
	mini.copyTo(nui.bps.AppointActivity.prototype, {
		freeFlowTitle:"指派后继活动",
		freeFlowText:"选择后继活动",
		appointParticipantTitle:"指派后继活动参与者",
		appointParticipantText:"选择后继活动参与者"
	});
}

if(nui.bps.ProcessGraph) {
	mini.copyTo(nui.bps.ProcessGraph.prototype, {
		partiName:"参与者",
		startTime:"开始时间",
		endTime:"结束时间",
		timeOutFlag:"流程实例已经超时！",
		timeOut:"超时",
		Y:"是",
		N:"否"
	});
}