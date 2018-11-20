var baseUrl = apiPath + crmApi + "/"; 
var getScoutGuestListUrl = baseUrl+"com.hsapi.crm.telsales.crmTelsales.getScoutGuestList.biz.ext";
var queryForm;
var dgGrid;
//var dgScoutDetail;
var currGuest;
var memList = [];
var memHash={};
var carModelHash = [];

$(document).ready(function(v){
    queryForm = new nui.Form("#queryForm");
    dgGrid = nui.get("dgGrid");
    dgGrid.setUrl(getScoutGuestListUrl);
    //dgScoutDetail = nui.get("dgScoutDetail");
    dgGrid.on("beforeload",function(e){
    	e.data.token = token;
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
            e.cellHtml = setColVal('visitStatus', 'customid', 'name', e.value);
        }else if(field == "visitManId"){//营销员
            if(memHash[e.value]){
            	e.cellHtml = memHash[e.value].empName || "";
            }
        }
    });
   /* dgScoutDetail.on("drawcell", function (e) { //表格绘制
        var field = e.field;
        if(field == "scoutResult"){//跟踪结果
            e.cellHtml = setColVal('scoutResult', 'value', 'text', e.value);
        }else if(field == "scoutMode"){//跟踪方式
            e.cellHtml = setColVal('scoutMode', 'customid', 'name', e.value);
        }
    });*/
    
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
    initInsureComp("insureCompCode");//保险公司
    initDicts({
        scoutMode: "DDT20130703000021",//跟踪方式
        visitStatus: "DDT20130703000081",//跟踪状态
        query_visitStatus: "DDT20130703000081",//跟踪状态
        artType: "DDT20130725000001"//话术类型        
    });

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

function setScoutForm(e){
  /*  $(".saveGroup").show();
    form1.setData(e.record);
    form2.setData(e.record);
    currGuest = e.record;
    //触发选择事件
    nui.get("carBrandId").doValueChanged();
    
    var params = {
        "p":{
            "def":{
                "ds":"DB10_MYSQL_WB_CRM", //数据源 必填
                "url":"com.hsapi.crm.data.crmTelsales.getScoutDetail",  //命名SQL路径 必填
                "page":true
            },
            "orgid": currOrgId,
            "guestId": currGuest.guestId
        },
        token:token
    }
    dgScoutDetail.load(params);*/
}

function clearQueryForm(){
    queryForm.setData({});
}

function newClient(){
    mini.open({
        url: webPath + contextPath + "/com.hsweb.crm.manage.clientInfo_edit.flow?token="+ token,
        title: "新增客户", width: 520, height: 550,
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

//保存跟踪
function saveScout(){
    var url =baseUrl+ "/com.hsapi.crm.telsales.crmTelsales.saveScout.biz.ext";
    doSave(form1, url);
}
//保存客户信息
function saveClientInfo(){
    var url = baseUrl+"/com.hsapi.crm.telsales.crmTelsales.saveGuest.biz.ext";
    doSave(form2, url);    
}

function doSave(tform, url, callBack){
    //验证
    if(!formValidate(tform)){
        showMsg("请完善信息!","W");
        return ;
    }

    var paramData = form2.getData();
    if(!paramData.id){
        showMsg("未选中客户资料!","W");
        return false;
    }
    
    try {
        nui.ajax({
            url: url,
            type: 'post',
            data: nui.encode({
                data: tform.getData()
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                    showMsg("保存成功！","S");
                    if(callBack){
                        callBack();
                    }
                    //tform.setData(currGuest);
                    dgGrid.reload();
                }else {
                    showMsg(data.errMsg,"E");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                showMsg(jqXHR.responseText);
            }
		});
    }
    finally {        
    }  
}
//选择话术
function selTalkArt(){
   var data = {action: "sel"};
   data.url = webPath + contextPath+"/basic/talkArtTpl.jsp";
   data.width = 680;
   data.height = 520;
   openTalkArt(data, "选择话术")
}
//收藏话术
function colleTalkArt(){
    var data = {action: "new"};
    data.artType = nui.get("artType").getData();
    data.url = webPath + contextPath +"/com.hsweb.crm.basic.talkArtTpl_edit.flow?token="+token;
    data.width = 480;
    data.height = 420;
    data.content = nui.get("scoutContent").getValue();
    openTalkArt(data, "收藏话术")
}

function openTalkArt(data, title){
    mini.open({
        url: data.url,
        title: title, width: data.width, height: data.height,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(data);
        },
        ondestroy: function (action) {
            if(action == "ok"){
                nui.get("scoutContent").setValue(this.getIFrameEl().contentWindow.getData().content);
            }
        }
    });
}