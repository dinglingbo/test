var queryForm;
var dgGrid;
var form1;
var form2;
var currGuest;

$(document).ready(function(v){
    queryForm = new nui.Form("#queryForm");
    form1 = new nui.Form("#form1");
    form2 = new nui.Form("#form2");
    dgGrid = nui.get("dgGrid");
    dgGrid.on("beforeload",function(e){
    	e.data.token = token;
    });
    init();
    query();
});

function init(){
    initCarBrand("carBrandId");//车辆品牌
    initInsureComp("insureCompCode");//保险公司
    initDicts({
        scoutMode: "DDT20130703000021",//跟踪方式
        visitStatus: "DDT20130703000081",//跟踪状态
        query_visitStatus: "DDT20130703000081"//跟踪状态
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

function onNodeDbClick(e){
    var node = e.node || currTypeNode;
    if(!node){
        return;
    }
    
    currTypeNode = node;
    query();    
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
    data.artType = tree1.getData();
    mini.open({
        url: webPath + crmDomain + "/com.hsweb.crm.basic.smsTpl_edit.flow",
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

//所在分店
function setCompName(e){
    
}


function setTypeName(e){
    var typeData = tree1.getData();
    var tmp;
    for (var i = 0; i < typeData.length; i++) {
        tmp = typeData[i];
        if (tmp.CUSTOMID == e.value) return tmp.NAME;
    }
    return "";
}

function setScoutForm(e){
    $(".saveGroup").show();
    form1.setData(e.record);
    form2.setData(e.record);
    currGuest = e.record;
    //触发选择事件
    nui.get("carBrandId").doValueChanged();
}

function changeTabs(e){
    
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
    if(!formValidate(form2)) return false;
    var url = "/com.hsapi.crm.telsales.crmTelsales.saveScout.biz.ext";
    doSave(form1, url, saveClientInfo);
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
                    tform.setData(currGuest);
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
   
}
//收藏话术
function colleTalkArt(){
    
}