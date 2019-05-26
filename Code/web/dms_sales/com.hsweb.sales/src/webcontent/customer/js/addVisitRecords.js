var baseUrl = window._rootSysUrl || "http://127.0.0.1:8080/default/";
var guestComeUrl = apiPath + saleApi +  "/sales.custormer.saveGuestCome.biz.ext";
var queryUrl = apiPath + saleApi + "/sales.custormer.queryGuestComeAndGuest.biz.ext";
var levelOfIntent = null;
var important = null;
var frameColorIdHash = {};
var saleAdvisorIdEl = null;
var memList = [];
var saleAdvisorList = [];
var intentLevelList = []; 
var guestComeForm = null;
var asaleAdvisorHash = {};
$(document).ready(function ()
{
	levelOfIntent = nui.get("levelOfIntent");
	specialCareId = nui.get("specialCareId");
	intentLevelId = nui.get("intentLevelId");
	saleAdvisorIdEl = nui.get("saleAdvisorId");
	guestComeForm = new nui.Form("#guestComeForm");
	 //车身颜色
	 initDicts({
		 frameColorId:"DDT20130726000003",
		 interialColorId:"10391",
		 comeTypeId:'DDT20130731000003',
		 specialCare:"DDT20130703000049",
		 intentLevel:"DDT20130703000050"
     },function(data){
    	 asaleAdvisorList = nui.get('specialCare').getData();
    	 intentLevelList = nui.get('intentLevel').getData();
    	 //specialCareId.setData(asaleAdvisorList);
    	 getServiceTypeList(asaleAdvisorList,function(data){
    			specialCareId.setData(data);
    			//levelOfIntent.setData(data);
    	 });
    	 getServiceTypeList(intentLevelList,function(data){
    		 intentLevelId.setData(data);
 			//levelOfIntent.setData(data);
 	    });
     });
	
	initMember("saleAdvisorId",function(){
        memList = saleAdvisorIdEl.getData();
    });
	/*saleAdvisorIdEl.on("valueChanged",function(e){
        var text = saleAdvisorIdEl.getText();
        nui.get("saleAdvisor").setValue(text);
    });*/
	
});


var serviceTypeUrl = baseUrl + "com.hsapi.repair.common.common.getBusinessType.biz.ext";
function getServiceTypeList(data,callback){
	var serviceTypeList = [];
	var list = data;
    /*var params = {sortField:'id',sortOrder:'asc',isDisabled:0};
    nui.ajax({
		url : serviceTypeUrl,
        type : "post",
        async:false,
		data : JSON.stringify({
			params : params,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
            data = data || {};
            var list = data.list;
			if (list && list.length>0) {
				for(var i=0; i<list.length; i++){
                    var type = list[i];
                    var serviceTypeObj = {id:(i+1), text:type.name};
                    serviceTypeList.push(serviceTypeObj);
                    callback && callback(serviceTypeList);
                }
			} else {
				parent.showMsg("工单设置信息读取失败,请联系管理员!","W");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});*/
	if (list && list.length>0) {
		for(var i=0; i<list.length; i++){
            var type = list[i];
            var serviceTypeObj = {id:type.id, text:type.name};
            serviceTypeList.push(serviceTypeObj);
            callback && callback(serviceTypeList);
        }
	}
}


function add2(){
	/*nui.open({
		url : webPath + contextPath + "/com.hsweb.repair.potentialCustomer.addVisitRecords.flow?token=" + token,
		title : "新增来访记录",
		width : 1000,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
            iframe.contentWindow.updatRowSetData(params);//显示该显示的功能
           // iframe.contentWindow.setViewData(dock, dodelck, docck);
		},
		ondestroy : function(action) {
			
			
		}
	});*/
	var part={};
    part.id = "addVisitors";
    part.text = "新增来访记录";
    part.url = webPath + contextPath + "/com.hsweb.repair.potentialCustomer.addVisitRecords.flow?token="+token;
    part.iconCls = "fa fa-file-text";
    var params = {};
    window.parent.activeTabAndInit(part,params);
}

function addFollowUpRecord(){
	nui.open({
		url : webPath + contextPath + "/com.hsweb.repair.potentialCustomer.FollowUpRecord.flow?token=" + token,
		title : "新增跟进记录",
		width : 600,
		height : 360,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			/*var iframe = this.getIFrameEl();
            iframe.contentWindow.updatRowSetData(params);//显示该显示的功能
           // iframe.contentWindow.setViewData(dock, dodelck, docck);
*/		},
		ondestroy : function(action) {
			
			
		}
	});
}

function potentialCustomer(){
	nui.open({
		url : webPath + contextPath + "/com.hsweb.repair.potentialCustomer.check.flow?token=" + token,
		title : "审核",
		width : 600,
		height : 360,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			/*var iframe = this.getIFrameEl();
            iframe.contentWindow.updatRowSetData(params);//显示该显示的功能
           // iframe.contentWindow.setViewData(dock, dodelck, docck);
*/		},
		ondestroy : function(action) {
			
			
		}
	});
}

function chooseCarModelType(){
	nui.open({
        url: webPath + contextPath + "/sales/base/sCarModelType.jsp?token="+token,
        title: '选择意向车型',
        width: 1200, height: 700,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {};	
            params.guestId=guestId;
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
       	 var iframe = this.getIFrameEl();
       	 var row = iframe.contentWindow.getData();
       	 
        }
    });
}

function onButtonEdit(e) {
	nui.open({
	url: webPath + contextPath + '/sales/base/selectCarModel.jsp',
	title: '选择车型',
	width: 1000,
	height: 500,
	onload: function () {
	var iframe = this.getIFrameEl();
	//iframe.contentWindow.setData(row);
	},
	ondestroy: function (action) {
	var iframe = this.getIFrameEl();
	if(action == 'ok'){
	var row = iframe.contentWindow.getRow();
	nui.get("carModelId").setValue(row.id);
	nui.get("carModelName").setValue(row.name);
	nui.get("carModelName").setText(row.name);
	 }
    }
  });
}
var requiredField = {
		fullName : "客户名称",
		mobile : "手机号",
		carModelId : "意向车型"
};
function save(){
	var guestCome = guestComeForm.getData("true");
	var text = saleAdvisorIdEl.getText();
	guestCome.saleAdvisor = text;
	for ( var key in requiredField) {
		if (!guestCome[key] || $.trim(guestCome[key]).length == 0) {
            //nui.get(key).focus();
            showMsg(requiredField[key] + "不能为空!","W");
			return;
		}
    }
 //获取到关注重点的name
	var list = nui.get("specialCareId").O0ll00;
	var strName = "";
	if(list.length>0){
		for(var i = 0;i<list.length;i++){
			if(strName==""){
				strName = list[i].text;
			}else{
				strName = strName +","+list[i].text;
			}
		}
	}
	if(guestCome.comeDate) {
		guestCome.comeDate = format(guestCome.comeDate, 'yyyy-MM-dd HH:mm:ss');
	}
    if(guestCome.nextVisitDate) {
    	guestCome.nextVisitDate = format(guestCome.nextVisitDate, 'yyyy-MM-dd HH:mm:ss');
	}
	guestCome.specialCare = strName;
	var saleAdvisor = nui.get("saleAdvisorId").text;
	guestCome.saleAdvisor = saleAdvisor;
	var guest = {};
	guest.fullName = guestCome.fullName;
	guest.shortName = guestCome.fullName;
	guest.guestProperty = guestCome.guestProperty;
	guest.mobile = guestCome.mobile;
	guest.id = guestCome.guestId;
	var json = nui.encode({
		 guest:guest,
		 guestCome:guestCome,
		 token:token
	  });
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
	nui.ajax({
		url : guestComeUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			if(text.errCode=="S"){
		    	var guestCome = text.guestCome;
		    	var guest = text.rguest;
		    	guestComeForm.setData(guestCome);
		    	$("#serviceCodeEl").html(guestCome.serviceCode);
		    	$("#carModelNameEl").html(guestCome.carModelName);
		    	$("#nameEl").html(guest.fullName);
		    	showMsg("保存成功","S");
		    }else{
		    	showMsg("保存失败","E");
		    }
			nui.unmask(document.body);
		}
	 });
}

function add(){
	var guestCome = [];
	guestComeForm.setData(guestCome);
	nui.get("saleAdvisorId").setValue(currEmpId);
    nui.get("saleAdvisor").setValue(currUserName);
    nui.get("comeDate").setValue(now);
    $("#serviceCodeEl").html("");
	$("#carModelNameEl").html("");
	$("#nameEl").html("");
	nui.get("carModelId").setValue("");
	nui.get("carModelName").setValue("");
	nui.get("carModelName").setText("");
	$("#statustable").find("span[name=statusvi]").attr("class", "nvstatusview");
}

function setInitData(params){
   // fserviceId = params.id;
    if(!params.id){
        add();
    }else{
     var json = nui.encode({
   		 guestCome:params,
   		 token:token
   	  });
	  nui.mask({
	     el: document.body,
	     cls: 'mini-mask-loading',
	     html: '数据加载中...'
	  });
	  nui.ajax({
		url : queryUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			if(text.errCode=="S"){
		    	var guestCome = text.data.guestCome;
		    	var guest = text.data.guest;
		    	guestComeForm.setData(guestCome);
		    	$("#serviceCodeEl").html(guestCome.serviceCode);
		    	$("#carModelNameEl").html(guestCome.carModelName);
		    	$("#nameEl").html(guest.fullName);
		    	nui.get("carModelId").setValue(guestCome.carModelId);
		    	nui.get("carModelName").setValue(guestCome.carModelName);
		    	nui.get("carModelName").setText(guestCome.carModelName);
		    }
			nui.unmask(document.body);
		}
	  });
	  
    }
}

function buyCarCount(){
	var main = guestComeForm.getData();
	var status = main.status || 0;
	if(status > 1){
		showMsg("登记记录已归档，不能修改！","W");
		return;
	}
	if(status == 2){
		showMsg("登记记录已转销售，不能修改！","W");
		return;
	}
	if(main.id !="" && main.id !=null){
		nui.open({
			url: webPath + contextPath + '/sales/sales/caCalculation.jsp',
			title: '购车预算',
			width: 1000,
			height: 500,
			onload: function () {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setShowSave(main.id);
			},
			ondestroy: function (action) {
			var iframe = this.getIFrameEl();
			
		    }
		 });
	}else{
		showMsg("请先保存来访登记!","W");
		return;
	}
	
}
//精品加装：sales/customer/guestComeGift.jsp

function addGift(){
	var main = guestComeForm.getData();
	var status = main.status || 0;
	if(status > 1){
		showMsg("登记记录已归档，不能修改！","W");
		return;
	}
	if(status == 2){
		showMsg("登记记录已转销售，不能修改！","W");
		return;
	}
	if(main.id !="" && main.id !=null){
		nui.open({
			url: webPath + contextPath + '/sales/customer/guestComeGift.jsp',
			title: '精品加装',
			width: 1200,
			height: 500,
			onload: function () {
			var iframe = this.getIFrameEl();
			//iframe.contentWindow.setShowSave(main.id);
			},
			ondestroy: function (action) {
			var iframe = this.getIFrameEl();
			
		    }
		 });
	}else{
		showMsg("请先保存来访登记!","W");
		return;
	}
}