var baseUrl = window._rootSysUrl || "http://127.0.0.1:8080/default/";
var guestComeUrl = apiPath + saleApi +  "/sales.custormer.saveGuestCome.biz.ext";
var queryUrl = apiPath + saleApi + "/sales.custormer.queryGuestComeAndGuest.biz.ext";
var saleUrl = apiPath + saleApi + "/sales.custormer.insSaleMain.biz.ext";
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
            var serviceTypeObj = {customid:type.customid, text:type.name};
            serviceTypeList.push(serviceTypeObj);
            callback && callback(serviceTypeList);
        }
	}
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
	nui.get("carModelName").setValue(row.fullName);
	nui.get("carModelName").setText(row.fullName);
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
	guestComeForm.validate();
	if (guestComeForm.isValid() == false) return;
	if(guestCome.status==1){
		showMsg("来访登记已归档，不能修改","W");
		return;
	}
	if(guestCome.status==2){
		showMsg("来访登记已转销售，不能修改","W");
		return;
	}
	if(guestCome.status==3){
		showMsg("来访登记已作废，不能修改","W");
		return;
	}
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
	guest.guestProperty = nui.get("guestProperty").value;
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
		    	doSetStyle(guestCome.status);
		    }else{
		    	showMsg(text.errMsg || "保存失败","E");
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
		    	nui.get("guestProperty").setValue(guest.guestProperty);
		    	nui.get("carModelId").setValue(guestCome.carModelId);
		    	nui.get("carModelName").setValue(guestCome.carModelName);
		    	nui.get("carModelName").setText(guestCome.carModelName);
		    	doSetStyle(guestCome.status);
		    }
			nui.unmask(document.body);
		}
	  });
	  
    }
}

var saleTypeF = null;
function buyCarCount(){
	var main = guestComeForm.getData();
	var status = main.status || 0;
	/*if(status == 1){
		showMsg("来访登记已归档，不能修改！","W");
		return;
	}
	if(status == 2){
		showMsg("来访登记已转销售，不能修改！","W");
		return;
	}*/
	if(main.id !="" && main.id !=null){
		nui.open({
			url: webPath + contextPath + '/sales/sales/caCalculation.jsp',
			title: '购车预算',
			width: 1000,
			height:650,
			onload: function () {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setShowSave(main);
			},
			ondestroy: function (action) {
			 var iframe = this.getIFrameEl();
			 saleTypeF = iframe.contentWindow.getSaleType();
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
	/*if(status > 1){
		showMsg("登记记录已归档，不能修改！","W");
		return;
	}
	if(status == 2){
		showMsg("登记记录已转销售，不能修改！","W");
		return;
	}*/
	if(main.id !="" && main.id !=null){
		nui.open({
			url: webPath + contextPath + '/sales/customer/guestComeGift.jsp',
			title: '精品加装',
			width: 1200,
			height: 500,
			onload: function () {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setData(main);
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
//归档
var statusUrl = apiPath + saleApi + "/sales.custormer.changStatus.biz.ext";
function changStatus(){
	var guestCome = guestComeForm.getData("true");
	var status = guestCome.status;
	if(guestCome.id == "" && guestCome.id == null){
		showMsg("请先保存来访登记!","W");
		return;
	}
	if(status == 1){
		showMsg("来访登记已归档！","W");
		return;
	}
	if(status == 2){
		showMsg("来访登记已转销售！","W");
		return;
	}
	if(guestCome.status==3){
		showMsg("来访登记已作废，不能归档","W");
		return;
	}
	var json = nui.encode({
         id:guestCome.id,
		 token:token
	  });
	nui.mask({
       el: document.body,
       cls: 'mini-mask-loading',
       html: '保存中...'
   });
	nui.ajax({
		url : statusUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			if(text.errCode=="S"){
				showMsg(text.errMsg || "归档成功","S");
				guestCome.status = 1;
				guestComeForm.setData(guestCome);
				doSetStyle(1);
		    }else{
		    	showMsg(text.errMsg ||"归档失败","E");
		    }
			nui.unmask(document.body);
		}
	 });
}

function doSetStyle(status){
	status = status||0;
	$("#statustable").find("span[name=statusvi]").attr("class", "nvstatusview");
	if(status==0){
		$("#addStatus").attr("class", "statusview");
	}else if(status==1){
		$("#repairStatus").attr("class", "statusview");
	}else if(status==2){
		$("#finishStatus").attr("class", "statusview");
	}
}

function saveSaleMain(){
	var guestCome = guestComeForm.getData("true");
	var status = guestCome.status;
	if(guestCome.id == "" && guestCome.id == null){
		showMsg("请先保存来访登记!","W");
		return;
	}
	if(status == 0){
		showMsg("来访登记未归档,不能转销售","W");
		return;
	}
	if(status == 2){
		showMsg("来访登记已转销售","W");
		return;
	}
	if(status == 3){
		showMsg("来访登记已作废,不能转销售","W");
		return;
	}
	var json = nui.encode({
		 guestCome:guestCome,
		 token:token
	  });
	nui.mask({
       el: document.body,
       cls: 'mini-mask-loading',
       html: '保存中...'
   });
	nui.ajax({
		url : saleUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			if(text.errCode=="S"){
				showMsg(text.errMsg || "转销售成功","S");
				guestCome.status=2;
				guestComeForm.setData(guestCome);
				doSetStyle(2);
		    }else{
		    	showMsg(text.errMsg || "转销售失败","E");
		    }
			nui.unmask(document.body);
		}
	 });
}


function salesOnPrint(){
	var p = null;
	if(saleTypeF){
		if(saleTypeF.saleType=="1558580770894"){
			p=1;
		}else{
			p=2;
		}
		var billFormData = guestComeForm.getData(true); //主表信息
	    var params = {};
	    params.serviceId = billFormData.id;
	    params.billType = 1;
	    params.guestFullName = billFormData.fullName;
	    params.carModelName	= billFormData.carModelName; 
	    params.carModelId = billFormData.carModelId;
	    var url = webPath + contextPath;
	    switch (p) {
	        case 1:
	            url = url + "/sales/sales/print/cashPurchases.jsp";
	            break;
	        case 2:
	            url = url + "/sales/sales/print/printLoanDetail .jsp";
	            break;
	    }
	    nui.open({
	        url: url,
	        title: "打印",
	        width: "100%",
	        height: "100%",
	        onload: function() {
	            var iframe = this.getIFrameEl();
	            iframe.contentWindow.SetData(params);
	        },
	        ondestroy: function(action) {

	        }
	    });
	}else{
		return;
	}
}

function onMobileValidation(e)
{
    if (e.isValid) {
        var pattern = /^1(3|4|5|6|7|8|9)\d{9}$/;;
        if (e.value.length != 11 || pattern.test(e.value) == false) {
            e.errorText = "必须输入正确的手机号码";
            e.isValid = false;
        }
    }
}

function onDrawDate(e) {
    var date = e.date;
    var d = new Date();
    if (date.getTime() < (d.getTime() - 24*60*60*1000)) {
    	e.allowSelect = false;
        
    }
}
var queryGuestListUrl =  apiPath + saleApi + "/sales.custormer.queryCustomerListByMobile.biz.ext";
var mobileF = null;
var n = 1;
function queryByMobile(e){
	var mobile = e.value;
	mobile = mobile.replace(/\s*/g,"");
	if(mobileF == mobile && n==0){
		return;
	}else{
		mobileF = mobile;
		n = 0;
	}
	var params = 
	      {
	        "mobile":mobile
	      };
	if(mobile.length==11){
		nui.mask({
	        el : document.body,
		    cls : 'mini-mask-loading',
		    html : '加载中...'
	    });
		nui.ajax({
			url : queryGuestListUrl,
			type : "post",
			data : JSON.stringify({
				params:params,
				token: token
			}),
		success:function(data) {
			nui.unmask(document.body);
			var list = data.list;
			if(list.length){
				var guestCome = guestComeForm.getData("true");
				var temp = list[0];
				guestCome.fullName = temp.fullName;
				guestCome.guestId = temp.id;
				guestComeForm.setData(guestCome);
			  }
			 },
			error:function(jqXHR, textStatus, errorThrown) {
				nui.unmask(document.body);
				console.log(jqXHR.responseText);
			}
	  });
    }
}

