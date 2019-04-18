var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var queryRemindSUrl = baseUrl + "com.hsapi.repair.repairService.query.queryRemindByDate.biz.ext";

var reminding = null; //保养提醒
var business = null; //商业险
var compulsoryInsurance = null; //交强险
var drivingLicense = null; //驾照年审
var car = null; //车辆年检提醒
var guestBirthday = null; //客户生日
var visitHis = null; //回访历史
var serviceType = null; //5保养提醒 //6商业险到期   7; //交强险到期   8; //驾照到期   9; //车检到期   10; //客户生日  
var params = {};
var tabs = {};
var sortTypeList = [ {id : "2",text : "到期日期↓"}, {id : "1",text : "到期日期↑"}, {id : "4",text : "客户名称↓"},{id : "3",text : "客户名称↑"}, 
    { id: "6", text: "车牌号↓" }, { id: "5", text: "车牌号↑" }, { id: "8", text: "客户类型↓" }, { id: "7", text: "客户类型↑" }];

var sortTypeList2 = [ {id : "2",text : "距离天数↓"}, {id : "1",text : "距离天数↑"}, {id : "4",text : "客户名称↓"},{id : "3",text : "客户名称↑"}, 
{id : "6",text : "车牌号↓"}, {id : "5",text : "车牌号↑"}, {id : "8",text : "客户类型↓"}, {id : "7",text : "客户类型↑"} ];
$(document).ready(function (v) {
    tabs = nui.get("tabs");
    reminding = nui.get("reminding");
    business = nui.get("business");
    compulsoryInsurance = nui.get("compulsoryInsurance"); 
    drivingLicense = nui.get("drivingLicense");
    car = nui.get("car");
    guestBirthday = nui.get("guestBirthday"); 
    visitHis = nui.get("visitHis"); 

    reminding.setUrl(queryRemindSUrl);
    business.setUrl(queryRemindSUrl);
    compulsoryInsurance.setUrl(queryRemindSUrl);
    drivingLicense.setUrl(queryRemindSUrl);
    car.setUrl(queryRemindSUrl);
    guestBirthday.setUrl(queryRemindSUrl);
    visitHis.setUrl(hisUrl);

    var startTime =new Date();
    var today = nui.formatDate(startTime, 'yyyy-MM-dd');

    var tday = new Date(startTime);
    tday.setDate(tday.getDate() + 30);
    var thirdty = nui.formatDate(new Date(tday), 'yyyy-MM-dd');
    nui.get('startDate0').setValue(today);
    nui.get('startDate').setValue(today);
    nui.get('startDate2').setValue(today);
    nui.get('startDate3').setValue(today);
    nui.get('startDate4').setValue(today);
    nui.get('endDate0').setValue(thirdty);
    nui.get('endDate').setValue(thirdty);
    nui.get('endDate2').setValue(thirdty); 
    nui.get('endDate3').setValue(thirdty);
    nui.get('endDate4').setValue(thirdty);
    nui.get('sortType0').setData(sortTypeList); 
    nui.get('sortType').setData(sortTypeList); 
    nui.get('sortType2').setData(sortTypeList); 
    nui.get('sortType3').setData(sortTypeList); 
    nui.get('sortType4').setData(sortTypeList); 
    nui.get('sortType5').setData(sortTypeList2); 
    
    initInsureComp("insureCompCode");//保险公司
    initDicts({
        visitMode: "DDT20130703000021",//跟踪方式
        // visitStatus: "DDT20130703000081",//跟踪状态
        //query_visitStatus: "DDT20130703000081",//跟踪状态
        //artType: "DDT20130725000001"//话术类型        
    });

    reminding.on("select", function (e) {
        visitHistoryList(e.record,5);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
        $("#showMonile0").show();
        document.getElementById("mobileText0").innerHTML = e.record.mobile;
     
    }); 
    business.on("select", function (e) {
        visitHistoryList(e.record,6);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
        $("#showMonile").show();
        document.getElementById("mobileText").innerHTML = e.record.mobile;
    }); 
    compulsoryInsurance.on("select", function (e) {
        visitHistoryList(e.record,7);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
        $("#showMonile2").show();
        document.getElementById("mobileText2").innerHTML = e.record.mobile;
    }); 
    drivingLicense.on("select", function (e) {
        visitHistoryList(e.record,8);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
        $("#showMonile3").show();
        document.getElementById("mobileText3").innerHTML = e.record.mobile;
    }); 
    car.on("select", function (e) {
        visitHistoryList(e.record,9);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
        $("#showMonile4").show();
        document.getElementById("mobileText4").innerHTML = e.record.mobile;
    }); 
    guestBirthday.on("select", function (e) {
        visitHistoryList(e.record,10);
        isButtonEnable(e.record.wechatOpenId, tabs.getActiveTab());
        $("#showMonile5").show();
        document.getElementById("mobileText5").innerHTML = e.record.mobile;
    }); 

    reminding.on("drawcell", function (e) {
        if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        } else if (e.field == 'guestType') {
            if (e.value == 0) {
                e.cellHtml = '系统客户';
            } else {
                e.cellHtml = '电销客户';
            }
        }else if(e.field == "carNo" && e.record.guestType == 0 ){
    		e.cellHtml ='<a href="##" onclick="WindowrepairHistory()">'+e.record.carNo+'</a>';
    	}
    });

    business.on("drawcell", function (e) {
        if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        } else if (e.field == 'guestType') {
            if (e.value == 0) {
                e.cellHtml = '系统客户';
            } else {
                e.cellHtml = '电销客户';
            }
        }else if(e.field == "carNo" && e.record.guestType == 0){
    		e.cellHtml ='<a href="##" onclick="WindowrepairHistory()">'+e.record.carNo+'</a>';
        } else if (e.field == "annualInspectionCompCode") {
            e.cellHtml = setColVal('insureCompCode', 'code', 'fullName', e.value);
        }
    });
    compulsoryInsurance.on("drawcell", function (e) {
        if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        } else if (e.field == 'guestType') {
            if (e.value == 0) {
                e.cellHtml = '系统客户';
            } else {
                e.cellHtml = '电销客户';
            }
        }else if(e.field == "carNo" && e.record.guestType == 0){
    		e.cellHtml ='<a href="##" onclick="WindowrepairHistory()">'+e.record.carNo+'</a>';
    	}else if (e.field == "insureCompCode") {
            e.cellHtml = setColVal('insureCompCode', 'code', 'fullName', e.value);
        }
    });
    drivingLicense.on("drawcell", function (e) {
        if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        } else if (e.field == 'guestType') {
            if (e.value == 0) {
                e.cellHtml = '系统客户';
            } else {
                e.cellHtml = '电销客户';
            }
        }else if(e.field == "carNo" && e.record.guestType == 0){
    		e.cellHtml ='<a href="##" onclick="WindowrepairHistory()">'+e.record.carNo+'</a>';
    	}
    });
    car.on("drawcell", function (e) {
        if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        } else if (e.field == 'guestType') {
            if (e.value == 0) {
                e.cellHtml = '系统客户';
            } else {
                e.cellHtml = '电销客户';
            }
        }else if(e.field == "carNo" && e.record.guestType == 0){
    		e.cellHtml ='<a href="##" onclick="WindowrepairHistory()">'+e.record.carNo+'</a>';
    	}
    });
    guestBirthday.on("drawcell", function (e) {
        if (e.field == "mobile") {
            e.cellHtml = changedTel(e);
        } else if (e.field == 'guestType') {
            if (e.value == 0) {
                e.cellHtml = '系统客户';
            } else {
                e.cellHtml = '电销客户';
            }
        }else if(e.field == "carNo" && e.record.guestType == 0){
    		e.cellHtml ='<a href="##" onclick="WindowrepairHistory()">'+e.record.carNo+'</a>';
    	}
    });
    visitHis.on("drawcell", function (e) {
        if (e.field == "serviceType") {
            e.cellHtml = serviceTypeList[e.value].text;
        } else if(e.field == "visitMode"){//跟踪方式
            e.cellHtml = setColVal('visitMode', 'customid', 'name', e.value);
        }
    });

    var filter = new HeaderFilter(reminding, {
        columns: [
            { name: 'carNo' },
            { name: 'guestName' }, 
            { name: 'carModel' }
            //{ name: 'annualInspectionCompCode' }
        ],
        callback: function (column, filtered) {
        },
        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
        	}
        	return value;
        }
    });
    
    var filter = new HeaderFilter(business, {
        columns: [
            { name: 'carNo' },
            { name: 'guestName' }, 
            { name: 'carModel' }
           // { name: 'annualInspectionCompCode' }
        ],
        callback: function (column, filtered) {
        },
        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
        	}
        	return value;
        }
    });
    var filter = new HeaderFilter(compulsoryInsurance, {
        columns: [
            { name: 'carNo' },
            { name: 'guestName' }, 
            { name: 'carModel' }
           // { name: 'insureCompCode' }
        ],
        callback: function (column, filtered) {
        },
        tranCallBack: function (field) {
        	var value = null;
        	switch(field){	
        	}
        	return value;
        }
    });
    var filter = new HeaderFilter(drivingLicense, {
        columns: [
            { name: 'carNo' },
            { name: 'guestName' }, 
            { name: 'carModel' }
            //{ name: 'annualInspectionCompCode' }
        ],
        callback: function (column, filtered) {
        },
        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
        	}
        	return value;
        }
    });
    var filter = new HeaderFilter(car, {
        columns: [
            { name: 'carNo' },
            { name: 'guestName' }, 
            { name: 'carModel' }
            //{ name: 'annualInspectionCompCode' }
        ],
        callback: function (column, filtered) {
        },
        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
        	}
        	return value;
        }
    });
    var filter = new HeaderFilter(guestBirthday, {
        columns: [
            { name: 'carNo' },
            { name: 'guestName' }, 
            { name: 'carModel' }
            //{ name: 'annualInspectionCompCode' }
        ],
        callback: function (column, filtered) {
        },
        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
        	}
        	return value;
        }
    });
    
});

function changedTel(e) {
    var uid = e.record._uid;
    var value = e.value
    var res = {};
    value = "" + value;
    var reg=/(\d{3})\d{4}(\d{4})/;
    value = value.replace(reg, "$1****$2");
    if(e.value){
        if(e.record.wechatOpenId){
            res =  '<a href="javascript:bindWechat(\'' + uid + '\')" id="showA" ><span id="wechatTag" class="fa fa-wechat fa-lg"></span></a>&nbsp;'+value;
                /*e.cellHtml = "<span id='wechatTag' class='fa fa-wechat fa-lg'></span>"+value;*/
        }else{
            res =  '<a href="javascript:bindWechat(\'' + uid + '\')" id="showA1" ><span id="wechatTag1" class="fa fa-wechat fa-lg"></span></a>&nbsp;'+value;
        }
    }else{
        res="";
    }
    return res;
}

function visitHistoryList(row,serviceType) {
    if (row.guestType == 0) {
        var params = {
            carNo:row.carNo,
            //guestId: row.conId,
            //serviceType:serviceType,
            guestSource: 0,
            token:token
        };
    }
    if (row.guestType == 1) {
        var params = {
            mainId: row.crmGuestId,
            //serviceType:serviceType,
            guestSource: 1,
            token:token
        };
    }
    loadVisitHis(params);
}


function isButtonEnable(openId,tab) {
    if (openId) {
        if (tab.name == 'bytx') {
            nui.get("wcBtn13").enable();
            nui.get("wcBtn14").enable();
            nui.get("wcBtn15").enable();
        } else if(tab.name == 'syx'){
            nui.get("wcBtn23").enable();
            nui.get("wcBtn24").enable();
            nui.get("wcBtn25").enable();
        }else if(tab.name == 'jqx'){
            nui.get("wcBtn33").enable();
            nui.get("wcBtn34").enable();
            nui.get("wcBtn35").enable();
        }else if(tab.name == 'jzns'){
            nui.get("wcBtn43").enable();
            nui.get("wcBtn44").enable();
            nui.get("wcBtn45").enable();
        }else if(tab.name == 'clnj'){
            nui.get("wcBtn53").enable();
            nui.get("wcBtn54").enable();
            nui.get("wcBtn55").enable();
        }else if(tab.name == 'khsr'){
            nui.get("wcBtn63").enable();
            nui.get("wcBtn64").enable();
            nui.get("wcBtn65").enable();
        }
    } else {
        if (tab.name == 'bytx') {
            nui.get("wcBtn13").disable();
            nui.get("wcBtn14").disable();
            nui.get("wcBtn15").disable();
        } else if(tab.name == 'syx'){
            nui.get("wcBtn23").disable();
            nui.get("wcBtn24").disable();
            nui.get("wcBtn25").disable();
        }else if(tab.name == 'jqx'){
            nui.get("wcBtn33").disable();
            nui.get("wcBtn34").disable();
            nui.get("wcBtn35").disable();
        }else if(tab.name == 'jzns'){
            nui.get("wcBtn43").disable();
            nui.get("wcBtn44").disable();
            nui.get("wcBtn45").disable();
        }else if(tab.name == 'clnj'){
            nui.get("wcBtn53").disable();
            nui.get("wcBtn54").disable();
            nui.get("wcBtn55").disable();
        }else if(tab.name == 'khsr'){
            nui.get("wcBtn63").disable();
            nui.get("wcBtn64").disable();
            nui.get("wcBtn65").disable();
        }
    }
}


function setInitData(params) {
    var params = {};
    var tab = tabs.getTab(params.id - 1);
    tabs.activeTab(tabs.getTab(params.id - 1));
    query(tab);
}

function change(e) {
    var tab = tabs.getActiveTab();
    query(tab);

}

function query(tab) {
    if (tab) {
        if (tab.title == "保养提醒") {
            params = {
                startDate:nui.get('startDate0').getFormValue(),
                endDate: nui.get('endDate0').getFormValue(),
                carNo:nui.get("carNo0").value,
                dateType:'bytx'
            };
            var sortValue = nui.get("sortType0").value;
            if (sortValue) {
                var sort = getSort(sortValue, 'bytx');
                params.sortField = sort.sortField;
                params.sortOrder = sort.sortOrder;
            }
            reminding.load({
                params: params,
                token: token
            });
        }else if (tab.title == "商业险到期提醒") {
            params = {
                startDate:nui.get('startDate').getFormValue(),
                endDate: nui.get('endDate').getFormValue(),
                carNo:nui.get("carNo").value,
                dateType:'syx'
            };
            var sortValue = nui.get("sortType").value;
            if (sortValue) {
                var sort = getSort(sortValue, 'syx');
                params.sortField = sort.sortField;
                params.sortOrder = sort.sortOrder;
            }
            business.load({
                params: params,
                token: token
            });
        } else if (tab.title == "交强险到期提醒") {
            params = {
                isInsureRemind: 1,
                insureStatus: 0,
                startDate:nui.get('startDate2').getFormValue(),
                endDate: nui.get('endDate2').getFormValue(),
                carNo:nui.get("carNo2").value,
                dateType:'jqx'
            };
            var sortValue = nui.get("sortType2").value;
            if (sortValue) {
                var sort = getSort(sortValue, 'jqx');
                params.sortField = sort.sortField;
                params.sortOrder = sort.sortOrder;
            }
            compulsoryInsurance.load({
                params: params,
                token: token
            });

        } else if (tab.title == "驾照年审提醒") {
            params = {
                startDate:nui.get('startDate3').getFormValue(),
                endDate: nui.get('endDate3').getFormValue(),
                carNo:nui.get("carNo3").value,
                dateType:'jzns'
            };
            var sortValue = nui.get("sortType3").value;
            if (sortValue) {
                var sort = getSort(sortValue, 'jzns');
                params.sortField = sort.sortField;
                params.sortOrder = sort.sortOrder;
            }
            drivingLicense.load({
                params: params,
                token: token
            });

        } else if (tab.title == "车辆年检提醒") {
            params = {
                startDate:nui.get('startDate4').getFormValue(),
                endDate: nui.get('endDate4').getFormValue(),
                carNo:nui.get("carNo4").value,
                dateType:'clnj'
            };
            var sortValue = nui.get("sortType4").value;
            if (sortValue) {
                var sort = getSort(sortValue, 'clnj');
                params.sortField = sort.sortField;
                params.sortOrder = sort.sortOrder;
            }
            car.load({
                params: params,
                token: token
            });

        } else if (tab.title == "客户生日提醒") {
            params = {
                bir:nui.get('bir').value,
                carNo:nui.get("carNo5").value,
                dateType:'khsr'
            };
            var sortValue = nui.get("sortType5").value;
            if (sortValue) {
                var sort = getSort(sortValue, 'khsr');
                params.sortField = sort.sortField;
                params.sortOrder = sort.sortOrder;
            }
            guestBirthday.load({
                params: params,
                token: token
            });

        }
    }
}
function getSort(sortTypeValue,type){
	var data = {
			sortField:'',
			sortOrder:''
	};
	if (sortTypeValue == 1) {
		data.sortField = getSortDateText(type);
		data.sortOrder = "desc";
	} else if (sortTypeValue == 2) {
		data.sortField = getSortDateText(type);
		data.sortOrder = "asc";
	} else if (sortTypeValue == 3) {
		data.sortField = "guestName";
		data.sortOrder = "desc";
	} else if (sortTypeValue == 4) {
		data.sortField = "guestName";
		data.sortOrder = "asc";
	} else if (sortTypeValue == 5) {
		data.sortField = "carNo";
		data.sortOrder = "desc";
	} else if (sortTypeValue == 6) {
		data.sortField = "carNo";
		data.sortOrder = "asc";
    } else if (sortTypeValue == 7) {
    	data.sortField = "guestType";
    	data.sortOrder = "desc";
    } else if (sortTypeValue == 8) {
    	data.sortField = "guestType";
    	data.sortOrder = "asc";
    }
    return data;
}

function getSortDateText(type) {
    var dateText = '';
    if (type == 'bytx') {
        dateText = 'careDueDate';
    }else if (type == 'syx') {
        dateText = 'annualInspectionDate';
    }else if (type == 'jqx') {
        dateText = 'insureDueDate';
    }else if (type == 'jzns') {
        dateText = 'licenseOverDate';
    }else if (type == 'clnj') {
        dateText = 'dueDate';
    }else if (type == 'khsr') {
        dateText = 'birComeDay';
    }
    return dateText;
}


function setInitData(params) {
    if (params.id == '' || params.id == null) {
        tabs.activeTab(0);
    } else if (isNaN(params.id) == true) {
        tabs.activeTab(0);
    } else {
        tabs.activeTab(tabs.getTab(params.id - 1 - 2));
    }
}

function remind() {
    var row = getRow();
    if (row) {
        mini.open({
            url: webPath + contextPath + "/manage/maintainRemind/maintainRemMainDetail.jsp?token=" + token,
            title: "提醒信息",
            width: 600,
            height: 300,
            onload: function () {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData(row);
            },
            ondestroy: function (action) {
                //change();
                visitHis.reload();
            }
        });
    } else {
        showMsg("请选中一条数据", "W");
    }
}

function sendInfo(){
    var row = getRow();
    if (row.guestType == 1) {
        row.id = row.crmGuestId;
    }
    if (!row) {
        showMsg("请选中一条数据","W");
        return;
    }
    nui.open({
        url: webPath + contextPath  + "/com.hsweb.crm.manage.sendInfo.flow?token="+token,
        title: "发送短信", width: 655, height: 280,
        onload: function () {
        var iframe = this.getIFrameEl();
        iframe.contentWindow.setData(row);
    },
    ondestroy: function (action) {
            //重新加载
            //query(tab);
        // change();
    	visitHis.reload();
        }
    });
}

function sendWcText(){//发送微信消息
    var row = getRow();
    if (!row) {
    showMsg("请选中一条数据","W");
    return;
    }
    // var tit = "发送微信[" + row.guestName + '/' + row.mobile + '/' + row.carModel + ']';
    var tit = "发送微信";
    nui.open({
        url: webPath + contextPath  + "/"+row.sendWcUrl+"?token="+token,
        title: tit, width: 800, height: 350,
        onload: function () {
        var iframe = this.getIFrameEl();
        iframe.contentWindow.setData(row);
    },
    ondestroy: function (action) {
            //重新加载 
            // query(tab);
            // change();
    	visitHis.reload();
        }
    });
}


function sendWcCoupon() {
    var row = getRow();
    row.userNickname = row.guestName;
    row.userMarke = row.wechatServiceId;
    row.storeName = currOrgName;
    row.userOpid = row.wechatOpenId;
    var list = [];
    list.push(row);

    nui.open({                        
        url: webPath + contextPath  + "/manage/sendWechatWindow/sWcInfoCoupon.jsp?token="+token,
        title: "发送卡券", width: 800, height: 350,
        onload: function () {
        var iframe = this.getIFrameEl();
        iframe.contentWindow.setData(list);
    },
    ondestroy: function (action) {
            //重新加载
            //query(tab);
    	visitHis.reload();
        }
    });
}


function getRow() {
    var sRow = {};
    var tab = tabs.getActiveTab();
    if (tab.name == "bytx") {
        sRow = reminding.getSelected();
        if (sRow != null) {
            sRow.serviceType = 5;
            sRow.sendWcUrl = "com.hsweb.crm.manage.sWcInfoRemind.flow";
            sRow.updateUrl = 'manage/maintainRemind/updateCarInfo.jsp';//修改信息页面用-车
        }
    } else if (tab.name == "syx") {
        sRow = business.getSelected();
        if (sRow != null) {
            sRow.serviceType = 6;
            sRow.sendWcUrl = "manage/sendWechatWindow/sWcInfoInsurces.jsp";
            sRow.updateUrl = 'manage/maintainRemind/updateCarInfo.jsp';//修改信息页面用-车
        }
    } else if (tab.name == "jqx") {
        sRow = compulsoryInsurance.getSelected();
        if (sRow != null) {
            sRow.serviceType = 7;
            sRow.sendWcUrl = "manage/sendWechatWindow/sWcInfoInsurces.jsp";
            sRow.updateUrl = 'manage/maintainRemind/updateCarInfo.jsp';//修改信息页面用-车
        }
    } else if (tab.name == "jzns") {
        sRow = drivingLicense.getSelected();
        if (sRow != null) {
            sRow.serviceType = 8;
            sRow.sendWcUrl = 'manage/sendWechatWindow/sWcInfoLicense.jsp'
            sRow.updateUrl = 'manage/maintainRemind/updateConInfo.jsp';//修改信息页面用
        }
    } else if (tab.name == "clnj") {
        sRow = car.getSelected();
        if (sRow != null) {
            sRow.serviceType = 9;
            sRow.sendWcUrl = "manage/sendWechatWindow/sWcYearCheck.jsp";
            sRow.updateUrl = 'manage/maintainRemind/updateCarInfo.jsp';//修改信息页面用-车
        }
    } else if (tab.name == "khsr") {
        sRow = guestBirthday.getSelected();
        if (sRow != null) {
            sRow.serviceType = 10;
            sRow.sendWcUrl = "";
            sRow.updateUrl = 'manage/maintainRemind/updateConInfo.jsp';//修改信息页面用
        }
    }
    sRow.title = tab.title;
    sRow.name = sRow.guestName;//发送微信界面用到
    sRow.trueGuestId = sRow.guestId;//真正的guestId
    sRow.guestId = sRow.conId;//电话回访界面用到 联系表id
    sRow.contactorId = sRow.conId;//点击车牌号弹窗用到 联系表id
    sRow.annualVerificationDueDate = sRow.dueDate;//车辆年检发送微信界面用到
    sRow.guestSource = sRow.guestType;//保存历史用到
    sRow.mainId = sRow.crmGuestId ;//电销保存用到

    return sRow||0;
}


function quickSearch(type,gridType) {
    var params = {};
    var queryname = "本日";
    switch (type) {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;

        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            queryname = "上年";
            break;
        default:
            break;
    }
    switch (gridType) {
        case 'bytx'://保养提醒
            var menunamedate0 = nui.get("menunamedate0");
            var startDateEl0 = nui.get("startDate0");
            var endDateEl0 = nui.get("endDate0");
            startDateEl0.setValue(params.startDate);
            endDateEl0.setValue(addDate(params.endDate, -1));
            menunamedate0.setText(queryname);
            params.isNeedRemind = 1;
            params.remindStatus = 0;
            params.dateType = gridType;
            params.endDate = addDate(params.endDate, -1);
            reminding.load({params:params});
        break;
        case 'syx'://商业险
            var menunamedate = nui.get("menunamedate");
            var startDateEl = nui.get("startDate");
            var endDateEl = nui.get("endDate");
            startDateEl.setValue(params.startDate);
            endDateEl.setValue(addDate(params.endDate, -1));
            menunamedate.setText(queryname);
            params.isAnnualRemind = 1;
            params.annualStatus = 0;
            params.dateType = gridType;
            params.endDate = addDate(params.endDate, -1);
            business.load({params:params});
            break;
            case 'jqx'://交强险
            var menunamedate2 = nui.get("menunamedate2");
            var startDateEl2 = nui.get("startDate2");
            var endDateEl2 = nui.get("endDate2");
            startDateEl2.setValue(params.startDate);
            endDateEl2.setValue(addDate(params.endDate, -1));
            menunamedate2.setText(queryname);
            params.isInsureRemind = 1;
            params.insureStatus = 0;
            params.dateType = gridType;
            params.endDate = addDate(params.endDate, -1);
            compulsoryInsurance.load({params:params});
            break;
            case 'jzns'://驾照年审
            var menunamedate3 = nui.get("menunamedate3");
            var startDateEl3 = nui.get("startDate3");
            var endDateEl3 = nui.get("endDate3");
            startDateEl3.setValue(params.startDate);
            endDateEl3.setValue(addDate(params.endDate, -1));
            menunamedate3.setText(queryname);
            params.isLicenseRemind = 1;
            params.licenseStatus = 0;
            params.dateType = gridType;
            params.endDate = addDate(params.endDate, -1);
            drivingLicense.load({params:params});
            break;
            case 'clnj'://车辆年检 
            var menunamedate4 = nui.get("menunamedate4");
            var startDateEl4 = nui.get("startDate4");
            var endDateEl4 = nui.get("endDate4");
            startDateEl4.setValue(params.startDate);
            endDateEl4.setValue(addDate(params.endDate, -1));
            menunamedate4.setText(queryname);
            params.isVeriRemind = 1;
            params.veriStatus = 0;
            params.endDate = addDate(params.endDate, -1);
            params.dateType = gridType;
            car.load({params:params});
            break;
            case 'khsr'://客户生日
            params.isBirRemind = 1;
            params.birStatus = 0;
            params.bir = nui.get("bir").value;
            params.dateType = gridType;
            guestBirthday.load({params:params});
            break;
        default:
            break;
    }

}

function updateDate() {
    var row = getRow();
    if (row) {
        var tit = '修改信息';
        var turl = {};
        var hei = 500;
        var wid = 800;
        if (row.guestType == 0) {
            turl = webPath + contextPath + '/' + row.updateUrl + "?token=" + token;
            // if (row.serviceType != 10 && row.serviceType != 8) {
            //     hei = 500;
            // }
        } else {
            turl = webPath + contextPath + "/com.hsweb.crm.manage.clientInfo_edit.flow?token=" + token;
            hei = 550;
            wid = 520;
            row.id = row.crmGuestId;
        }
        nui.open({
            url: turl,
            title: tit, width: wid, height: hei,
            onload: function () {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData(row);
            },
            ondestroy: function (action) {
                gridReload(row.serviceType);
            }
        });
    } else {
        showMsg("请选中一条数据", "W");
    }
}

function gridReload(e) {
    if (e == 5) {
        reminding.reload();
    } else if(e == 6){
        business.reload();
    } else if(e == 7){
        compulsoryInsurance.reload();
    } else if(e == 8){
        drivingLicense.reload();
    } else if(e == 9){
        car.reload();
    } else if(e == 10){
        guestBirthday.reload();
    }
}



function WindowrepairHistory(){
	var row = getRow();
	var params = {
		carId : row.carId,
		carNo : row.carNo,
        guestId: row.trueGuestId,
        contactorId:row.contactorId
	};
		doShowCarInfo(params);
}