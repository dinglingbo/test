var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";

var mainGrid = null; 
var repairOutGrid = null; 
var mid = null;//主表ID
var tid = null;

var mtAdvisorIdEl = null;   
var searchKeyEl = null;  
var servieIdEl = null;   
var searchNameEl = null;
var billForm = null;
var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";
var fserviceId = 0;
var actionType = null;

$(document).ready(function(){ 

	tid = nui.get("tid").value;
	mid = nui.get("mid").value;
	mainGrid = nui.get("mainGrid");
	repairOutGrid = nui.get("repairOutGrid");
	actionType = nui.get("actionType").value;
	billForm = new nui.Form("#billForm");
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	servieIdEl = nui.get("servieIdEl");
	searchKeyEl = nui.get("search_key");
	searchNameEl = nui.get("search_name");
/*	if(actionType == "ll"){
		mainGrid.load({serviceId:mid});
	}
	if(actionType == "th"){

	}*/
	var par = {
		id:parseInt(mid)
	};
	setInitData(par);

	initMember("mtAdvisorId",function(){
		memList = mtAdvisorIdEl.getData();
	});

	mtAdvisorIdEl.on("valueChanged",function(e){
		var text = mtAdvisorIdEl.getText();
		nui.get("mtAdvisor").setValue(text);
	});

	searchKeyEl.on("valuechanged",function(e){
		var item = e.selected;

		if(fserviceId){
			return;
		}  
		if (item) { 
			var carNo = item.carNo||"";
			var tel = item.guestMobile||"";
			var guestName = item.guestFullName||"";
			var carVin = item.vin||"";



			if(tel){
				tel = "/"+tel;
			}
			if(guestName){
				guestName = "/"+guestName;
			}
			if(carVin){
				carVin = "/"+carVin;
			}
			var t = carNo + tel + guestName + carVin;

			var sk = document.getElementById("search_key");
			sk.style.display = "none";
			searchNameEl.setVisible(true);


			searchNameEl.setValue(t);
            //searchNameEl.setEnabled(false);

        }
    });
});





function setInitData(params){
	if(!params.id){
        //add(); 
    }else{
    	nui.mask({
    		el: document.body, 
    		cls: 'mini-mask-loading',
    		html: '数据加载中...'
    	});

    	var mparams = {  
    		data: {
    			id: params.id
    		}
    	};
    	getMaintain(mparams, function(text){
    		var errCode = text.errCode||"";
    		var data = text.maintain||{};
    		if(errCode == 'S'){
    			var p = {
    				data:{
    					guestId: data.guestId||0,
    					contactorId: data.contactorId||0
    				}
    			};
    			getGuestContactorCar(p, function(text){
    				var errCode = text.errCode||"";
    				var guest = text.guest||{};
    				var contactor = text.contactor||{};
    				if(errCode == 'S'){
    					$("#servieIdEl").html(data.serviceCode);
    					var carNo = data.carNo||"";
    					var tel = guest.mobile||"";
    					var guestName = guest.fullName||"";
    					var carVin = data.carVin||"";
    					if(tel){
    						tel = "/"+tel;
    					}
    					if(guestName){
    						guestName = "/"+guestName;
    					}
    					if(carVin){
    						carVin = "/"+carVin;
    					}
    					var t = carNo + tel + guestName + carVin;

    					var sk = document.getElementById("search_key");
    					sk.style.display = "none";
    					searchNameEl.setVisible(true);

    					searchNameEl.setValue(t);
    					searchNameEl.setEnabled(false);

    					data.guestFullName = guest.fullName;
    					data.guestMobile = guest.mobile;
    					data.contactorName = contactor.name;
    					data.mobile = contactor.mobile;

                        //$("#guestNameEl").html(guest.guestFullName);
                        //$("#showCarInfoEl").html(data.carNo);
                        //$("#guestTelEl").html(guest.mobile);

                        //fguestId = data.guestId||0;
                        //fcarId = data.carId||0; 

                       // doSearchCardTimes(fguestId); 
                        //doSearchMemCard(fguestId); 

                        billForm.setData(data);
                        //mainGrid.setUrl("com.hsapi.repair.baseData.query.QueryRpsCheckDetailList.biz.ext");
                        //mainGrid.load({mainId:params.id});
                        mainGrid.load({serviceId:params.id});
                        repairOutGrid.load({serviceId:params.id});

                    }else{ 
                    	showMsg("数据加载失败,请重新打开工单!","W");
                    }

                }, function(){});
    		}else{
    			showMsg('数据加载失败!','W');
    		}
    	}, function(){
    		nui.unmask(document.body);
    	});
    }
}


function LLSave(argument) {
	var rows = mainGrid.getSelecteds();
	if (rows.length > 0) {
		for (var i = 0, l = rows.length; i < l; i++) {
			var r = rows[i].partId;
			var c = rows[i].partCode;
			if(r){
				openPartSelect(r,"Id");
			}else if(c){
				openPartSelect(c,"Code");
			}else{
				showMsg('部分配件需单独领取!','W');
				return;
			}
		}
		
	}else{
		showMsg('请先选择配件!','W');
	}
}


function openPartSelect(par,type){
	nui.open({
		url:"com.hsweb.RepairBusiness.partSelect.flow",
		title:"选择配件",
		height:"400px",
		width:"900px",
		onload:function(){
			var iframe = this.getIFrameEl();
			iframe.contentWindow.SetData(par,type);
		},
		ondestroy:function(action){

		}

	});
}




function partOutRtn(){
	var rows = repairOutGrid.getSelecteds();
	if (rows.length > 0) {
		for (var i = 0, l = rows.length; i < l; i++) {
			var r = rows[i].partId;
			var c = rows[i].partCode;
			if(r){
				openPartSelect(r,"Id");
			}else if(c){
				openPartSelect(c,"Code");
			}else{
				showMsg('部分配件需单独领取!','W');
				return;
			}
		}
		
	}else{
		showMsg('请先选择需要归库的配件!','W');
	}

}


function memberSelect(){
	nui.open({
		url:"com.hsweb.RepairBusiness.partSelectMember.flow",
		title:"选择归库人",
		height:"300px",
		width:"600px",
		onload:function(){ 
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData("th");
        },
        ondestroy:function(action){
        	if (action == "ok") {  
                    //savePartOut();     //如果点击“确定”
                    //CloseWindow("close");
                }

            }

        });

}


