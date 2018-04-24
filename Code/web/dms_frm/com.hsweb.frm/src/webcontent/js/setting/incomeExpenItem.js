var queryForm;
var dgGrid;
var currGuest;

$(document).ready(function(v){
    queryForm = new nui.Form("#queryForm");
    dgGrid = nui.get("dgGrid");
    dgGrid.on("beforeload",function(e){
    	e.data.token = token;
    });
    dgGrid.on("drawcell", function (e) { //表格绘制
        var field = e.field;
        if(field == "orgid"){
            //e.cellHtml = setColVal('query_orgid', 'orgid', 'orgname', e.value);
        }else if(field == "itemTypeId"){//收支类型
            e.cellHtml = setColVal('itemTypeId', 'customid', 'name', e.value);
        }else if(field == "isPrimaryBusiness"){//主营业务
            e.cellHtml = setColVal('isPrimaryBusiness', 'value', 'text', e.value);
        }
    });
    init();
    query();
});

function init(){
    //initComp("query_orgid");//公司组织
    initDicts({
        itemTypeId: "DDT20130703000032"//收支类型
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
        nui.alert("数据加载失败！");
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
        alert("请选中一条记录");
    }
}

function editWin(title, data){
    data.itemTypeId = nui.get("itemTypeId").getData();
    nui.open({
        url: webPath + frmDomain + "/com.hsweb.frm.setting.incomeExpenItem_edit.flow",
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
    $(".saveGroup").show();
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
    dgScoutDetail.load(params);
}

function clearQueryForm(){
    queryForm.setData({});
}

function newClient(){
    mini.open({
        url: webPath + crmDomain + "/com.hsweb.crm.telsales.clientInfo_edit.flow",
        title: "新增客户", width: 520, height: 520,
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
    var url = "/com.hsapi.crm.telsales.crmTelsales.saveScout.biz.ext";
    doSave(form1, url);
}
//保存客户信息
function saveClientInfo(){
    var url = "/com.hsapi.crm.telsales.crmTelsales.saveGuest.biz.ext";
    doSave(form2, url);    
}

function doSave(tform, url, callBack){
    //验证
    if(!formValidate(tform)) return false;

    var paramData = form2.getData();
    if(!paramData.id){
        nui.alert("未选中客户资料!");
        return false;
    }
    
    try {
        nui.ajax({
            url: webPath + crmDomain + url,
            type: 'post',
            data: nui.encode({
                data: tform.getData()
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                    nui.alert("保存成功！");
                    if(callBack){
                        callBack();
                    }
                    //tform.setData(currGuest);
                    dgGrid.reload();
                }else {
                    nui.alert(data.errMsg);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                nui.alert(jqXHR.responseText);
            }
		});
    }
    finally {        
    }  
}
//选择话术
function selTalkArt(){
   var data = {action: "sel"};
   data.url = "/basic/talkArtTpl.jsp";
   data.width = 680;
   data.height = 520;
   openTalkArt(data, "选择话术")
}
//收藏话术
function colleTalkArt(){
    var data = {action: "new"};
    data.artType = nui.get("artType").getData();
    data.url = "/com.hsweb.crm.basic.talkArtTpl_edit.flow";
    data.width = 480;
    data.height = 420;
    data.content = nui.get("scoutContent").getValue();
    openTalkArt(data, "收藏话术")
}

function openTalkArt(data, title){
    mini.open({
        url: webPath + crmDomain + data.url,
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