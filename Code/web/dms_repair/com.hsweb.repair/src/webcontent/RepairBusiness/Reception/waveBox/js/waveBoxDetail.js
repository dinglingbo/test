function changeBoxService(e){//业务类型切换触发
	if(nui.get("boxServiceTypeId").value == 2){
		nui.get("js").setVisible(false);
		nui.get("warehousing").setVisible(true);
	}else{
		nui.get("warehousing").setVisible(false);
		nui.get("js").setVisible(true);
	}
}

function warehousing(){
		nui.get("msg").setValue("3");
		var data = billForm.getData();
		if(!data.id){
			save();
		}else{
			if(data.status != 2 ){
	        	 nui.mask({
	        	        el: document.body,
	        	        cls: 'mini-mask-loading',
	        	        html: '数据加载中...'
	        	 });
	            //showMsg("工单未完工,不能结算!","W");
	            //return;
	        	var params = {
	        	        data:{
	        	            id:data.id||0,
	        	            "drawOutReport":""
	        	        }
	        	    };
	        	    svrRepairAudit(params, function(data1){
	        	        data1 = data1||{};
	        	        var errCode = data1.errCode||"";
	        	        var errMsg = data1.errMsg||"操作失败,请重新操作";
	        	        if(errCode == 'S'){
	        	        	//成功之后，重新设置表单值*******************
	                        var olddata = billForm.getData();
	                        olddata.status = 2;
	                        billForm.setData([]);
	                        billForm.setData(olddata);
	                        changeBoxService(1);
	                        nui.get("contactorName").setText(olddata.contactorName);
	                        var status = 2;
	                        var isSettle = olddata.isSettle||0;
	                        doSetStyle(status, isSettle);
	                        //重新加载界面
	                        var p1 = {
	                        }
	                        var p2 = {
	                            interType: "item",
	                            data:{
	                                serviceId: data.id||0
	                            }
	                        }
	                        var p3 = {
	                            interType: "part",
	                            data:{
	                                serviceId: data.id||0
	                            }
	                        }
	                        loadDetail(p1, p2, p3,status);
	                        settlement(data.id);
	                        nui.unmask(document.body);
	        	        }else{
	        	        	nui.unmask(document.body)
	        	        	showMsg(errMsg,"E");
	        	        }
	        	    }, function(){
	        	    });
	        }else{
	        	settlement(data.id);
	        }
			 /*var item={};
		    item.id = "9001";
		    item.text = "入库单";
		    item.url = webPath + contextPath + "/com.hsweb.part.manage.purchaseOrderEnter.flow";
		    item.iconCls = "fa fa-file-text";
		    //window.parent.activeTab(item);
		    var params = {};
		    params.serviceId =formData.id;
		    window.parent.activeTabAndInit(item,params);*/
		}
}

function settlement(serviceId){
	 nui.ajax({
         url: baseUrl+"com.hsapi.repair.repairService.settlement.receiveSettleBX.biz.ext",
         type: "post",
         cache: false,
         async: false,
         data: {
            serviceId : serviceId
         },
         success: function(text) {
         	if(text.errCode == "S"){
         		showMsg(text.errMsg,"S");
         	}else{
         		showMsg(text.errMsg,"W");
         	}
         }
	});
}

function bxOnPrint(e){
	var formData = billForm.getData();
	var print = null;
	var serviceId = formData.id;
	if(serviceId){
		if(e==1){
			print = 0;
		}else if(e == 2){
			print = 1;
		}
		if(e == 2 && !formData.isSettle){
			showMsg("工单未结算不能打印","W");
			return;
		}
		nui.open({
	        url: webPath + contextPath+"/com.hsweb.repair.repoart.quotationPrint.flow",
	        title: "打印",
			width: "100%",
			height: "100%",
	        onload: function () {
	            var iframe = this.getIFrameEl();
	           iframe.contentWindow.SetData(serviceId,print);
	        },
	        ondestroy: function (action){
	        }
	    });
	}else{
		showMsg("请先保存工单","W");
	}
}