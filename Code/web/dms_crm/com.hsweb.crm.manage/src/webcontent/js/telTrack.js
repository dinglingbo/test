var baseUrl = apiPath + crmApi + "/"; 
var getScoutGuestListUrl = baseUrl+"com.hsapi.crm.telsales.crmTelsales.getScoutGuestList.biz.ext";
var hisUrl = apiPath + crmApi+ "/com.hsapi.crm.svr.visit.queryCrmVisitRecordSql.biz.ext";
var queryForm;
var dgGrid;
var currGuest;
var memList = [];
var memHash={};  
var carModelHash = [];
var visitHis = null; //回访历史
var serviceTypeList = [{},{ id: 1, text: '电销' }, { id: 2, text: '预约' }, { id: 3, text: '客户回访' }, { id: 4, text: '流失回访' }, { id: 5, text: '保养提醒' }, { id: 6, text: '商业险到期' }, { id: 7, text: '交强险到期' }, { id: 8, text: '驾照年审' }, { id: 9, text: '车辆年检' }, { id: 10, text: '生日' }];

$(document).ready(function(v){
    queryForm = new nui.Form("#queryForm"); 
    visitHis = nui.get("visitHis"); 
    visitHis.setUrl(hisUrl);
    dgGrid = nui.get("dgGrid");
    dgGrid.setUrl(getScoutGuestListUrl);
    dgGrid.on("beforeload",function(e){ 
        e.data.token = token;
    });
    dgGrid.on("select", function (e) {
        loadVisitHis(e.record.id);
    }); 

    dgGrid.on("drawcell", function (e) { //表格绘制
     var field = e.field;
     if(field == "orgid"){ 
        e.cellHtml = setColVal('query_orgid', 'orgid', 'orgname', e.value);
        }else if(field == "carBrandId"){//品牌
            e.cellHtml = setColVal('carBrandId', 'id', 'nameCn', e.value);
        }else if(field == "carModelId"){//车型
            e.cellHtml = setColVal('carModelId', 'carModelId', 'carModel', e.value);
        }else if(field == "visitStatus"){//跟踪状态
            e.cellHtml = setColVal('query_visitStatus', 'customid', 'name', e.value);
        }else if(field == "visitManId"){//营销员
            if(memHash[e.value]){
                e.cellHtml = memHash[e.value].empName || "";
            }
        }
    });
      
    visitHis.on("drawcell", function (e) {
        if (e.field == "serviceType") {
            e.cellHtml = serviceTypeList[e.value].text;
        } else if(e.field == "visitMode"){//跟踪方式
            e.cellHtml = setColVal('visitMode', 'customid', 'name', e.value);
        }
    });

    var filter = new HeaderFilter(dgGrid, {
        columns: [
            { name: 'carModel' },
            { name: 'recorder' },
            { name: 'guestName' }
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
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        if ((keyCode == 13)) { // F9
            query();
        }
    }
    
    initMember("member",function(){
        memList = nui.get('member').getData();
        memList.forEach(function(v) {
            memHash[v.empId] = v;
        });

    });
    init();
    query();
});

function init(){
    initComp("query_orgid");//公司组织
    initCarBrand("carBrandId");//车辆品牌
    //initInsureComp("insureCompCode");//保险公司
    initDicts({
        visitMode: "DDT20130703000021",//跟踪方式
        //visitStatus: "DDT20130703000081",//跟踪状态
        query_visitStatus: "DDT20130703000081",//跟踪状态
        //artType: "DDT20130725000001"//话术类型    
    });

}

function loadVisitHis(id) {
    var params = {
        mainId: id,
        serviceType:1,//电销回访
        token:token
    };
    visitHis.load({ params:params });
}

function onCarBrandChange(e){     
    initCarModel("carModelId", e.value,"", function () {
        var data = nui.get("carModelId").getData();
        data.forEach(function (v) {
            carModelHash[v.id] = v;
        });
    });
}

/*
 *查询
 **/
 function query(){ 
    var data = queryForm.getData();
    var params = {}; 
    params.p = data;
    dgGrid.load(params,null,function(){
        //失败;
        showMsg("数据加载失败！","E");
    });
}

function add(){
    editWin("新增模板", {});
}

function edit(){
    var row = dgGrid.getSelected();
    if (row) {
        editWin("修改模板", row);
    } else {
        showMsg("请选中一条记录","W");
    }
}

function editWin(title, data){
   // data.artType = tree1.getData();
   mini.open({
    url: webPath + contextPath + "/com.hsweb.crm.basic.smsTpl_edit.flow?token="+ token,
    title: title, width: 500, height: 420,
    onload: function () {
        var iframe = this.getIFrameEl();
            //var data = { action: "edit", id: row.id };
            iframe.contentWindow.setData(data);
        },
        ondestroy: function (action) {
            //var iframe = this.getIFrameEl();
            dgGrid.reload();
        }
    });
}
function clearQueryForm(){
    queryForm.setData({});
}

function newClient(){
    mini.open({
        url: webPath + contextPath + "/com.hsweb.crm.manage.clientInfo_edit.flow?token="+ token,
        title: "新增客户资料", width: 520, height: 550,
        onload: function () { 
            var iframe = this.getIFrameEl();
            //var data = { action: "edit", id: row.id };
            iframe.contentWindow.setData({});
        },
        ondestroy: function (action) {
            //var iframe = this.getIFrameEl();
            dgGrid.reload();
        }
    });
}

function editClient(){
    var row = dgGrid.getSelected();
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    mini.open({
        url: webPath + contextPath + "/com.hsweb.crm.manage.clientInfo_edit.flow?token="+ token,
        title: "修改客户资料", width: 520, height: 550,
        onload: function () { 
            var iframe = this.getIFrameEl();
            //var data = { action: "edit", id: row.id };
            iframe.contentWindow.setData(row);
        },
        ondestroy: function (action) {
            //var iframe = this.getIFrameEl();
            dgGrid.reload();
        }
    });
}



/*function onEditClick(){
    //var data = investGrid.getSelected();
    if(data == null){
        showMsg("请先选择一条数据","W");
        return;
    }
    nui.open({
        url: webPath + contextPath+ "/com.hsweb.crm.manage.investDetail.flow?token="+ token,
        title: "业绩修改",
        allowResize:false,
        width: 400,
        height: 300,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(data);
         },
         ondestroy: function (action) {
             if(action == "ok"){
                 search();
             }
         }
    });
}
*/


function sendInfo(){
    var row = dgGrid.getSelected()||{};
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return; 
    }
    if (!row.tel) {
        showMsg("该数据没有客户手机号码，无法发送短信","W");
        return; 
    }
    row.mobile = row.tel;
    row.guestId = '';
    row.serviceType = 1;//电销
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
            visitHis.reload();
        }
    });

}

function telInfo(e){
    var row = dgGrid.getSelected();
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    if(e){
        var data=e.record;
    }else{

        var data =row;
    }
    nui.open({
        url: webPath + contextPath  + "/manage/telTrack_info.jsp?token="+token,
        title: "电话跟踪", width: 650, height:350,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setScoutForm(data);
        },
        ondestroy: function (action) {
            //重新加载
            visitHis.reload();
        }
    });

}


function addRow() {
        var row = dgGrid.getSelected();
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    nui.open({
        url: webPath + contextPath + "/repair/RepairBusiness/BookingManagement/BookingManagementEdit.jsp?token="+token,
        title: "新增预约", width: 750, height: 400,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {};
            data.mtAdvisorId = currEmpId;
            data.mtAdvisor = currUserName;
            data.contactorName = row.guestName;
            data.contactorTel = row.mobile;
            data.carBrandId = row.carBrandId;
            data.carNo = row.carNo;
            var param = { action: "add", data: data };
            iframe.contentWindow.SetData(param);
        },
        ondestroy: function (action) {
            dgGrid.reload();
        }
    });
}


