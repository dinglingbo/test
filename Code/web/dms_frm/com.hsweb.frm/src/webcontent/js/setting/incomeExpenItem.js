var queryForm;
var dgGrid;
var currGuest;

$(document).ready(function(v){
    queryForm = new nui.Form("#queryForm");
    dgGrid = nui.get("dgGrid");
    dgGrid.on("beforeload",function(e){
    	e.data.token = token;
        if(!e.data.p){
            e.data.p = {};
        }
        e.data.p.parentId = e.data.id;
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

function onDictTypeDrawNode(e) {//节点加载完清空参数，避免影响查询和翻页
    dgGrid._dataSource.loadParams.id = null;
    dgGrid._dataSource.loadParams.p = {};
}

function add(){
    editWin("收支项目设置", {});
}

function addSub(){
    var row = dgGrid.getSelected();
    if (row) {
        var data={};
        data.parentId = row.id;
        data.parentName = row.name;
        editWin("收支项目设置", data);
    } else {
        alert("请选中一条记录");
    }
}

function edit(){
    var row = dgGrid.getSelected();
    if (row) {
        if(row.parentId){
            row.parentId
        }
        editWin("收支项目设置", row);
    } else {
        alert("请选中一条记录");
    }
}

function editWin(title, data){
    data.itemType = nui.get("itemTypeId").getData();
    nui.open({
        url: webPath + frmDomain + "/com.hsweb.frm.setting.incomeExpenItem_edit.flow",
        title: title, width: 380, height: 280,
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

function del(){
    var rows = dgGrid.getSelecteds();
    if (rows) {
        if (confirm("确定删除此记录？")) {
            dgGrid.loading("删除中，请稍后......");
            var params = [];
            var obj;
            for(var i=0; i<rows.length; i++){
                obj = {};
                obj.id = rows[i].id;
                obj.isDisabled = 1;
                params.push(obj);
            }
            nui.ajax({
                url: apiPath + frmApi + "/com.hsapi.frm.setting.updataIncomeExpItem.biz.ext",
                data:{data:params},
                success: function (text) {
                    dgGrid.reload();
                },
                error: function () {
                }
            });
        }
    }
}

function clearQueryForm(){
    queryForm.setData({});
}