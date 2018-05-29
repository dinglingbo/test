var queryForm; //查询表单
var dgGrid; //列表

var tracker;
var tree1;
var tree2;
var currType1Node;//品牌
var currType2Node;//营销员

var assignStatus;

$(document).ready(function(v){
    queryForm = new nui.Form("#queryForm");
    assignStatus = nui.get("assignStatus");
    tracker = nui.get("tracker");
    
    tree1 = nui.get("tree1");
    tree2 = nui.get("tree2");
    dgGrid = nui.get("dgGrid");
    dgGrid.on("beforeload",function(e){
    	e.data.token = token;
    });
    dgGrid.on("drawcell", function (e) { //表格绘制
        var field = e.field;
        if(field == "orgid"){
            e.cellHtml = setColVal('query_orgid', 'orgid', 'orgname', e.value);
        }else if(field == "carBrandId"){//品牌
            e.cellHtml = setColVal('tree1', 'id', 'nameCn', e.value);
        //}else if(field == "carModelId"){//车型
            //e.cellHtml = setColVal('carModelId', 'carModelId', 'carModel', e.value);
        }else if(field == "visitManId"){//营销员
            e.cellHtml = setColVal('tracker', 'empId', 'empName', e.value);
        }else if(field == "visitStatus"){//跟踪状态
            e.cellHtml = setColVal('visitStatus', 'customid', 'name', e.value);
        }
    });
    
    tracker.setData(tree2.getData());//设置营销员下拉数据
    init();
    query();
});

function init(){
    initComp("query_orgid");//公司组织
    initCarBrand("tree1");//车辆品牌
    //initInsureComp("insureCompCode");//保险公司
    initDicts({
        //isCome: "DDT20150303000004",//来厂状态
        visitStatus: "DDT20130703000081"//跟踪状态
    });
    initRoleMembers({
        tree2: "010815",
        tracker: "010815"
    })
}

/*
 *查询
 **/
function query(){
    var data = getQueryValue();
    var params = {};
    params.p = data;

    dgGrid.load(params,null,function(){
        //失败;
        nui.alert("数据加载失败！");
    });
}

function clearQueryForm(){
    queryForm.setData({});
    currType1Node = null;//品牌
    currType2Node = null;//营销员
    setMenu1(nui.get("typeAll"), assignStatus, -1);
}

/*
 *设置菜单
 **/
function setMenu1(obj, target, value){
    target.setValue(value);
    target.setText(obj.getText());   
    query();    
}

/*
 *快速查询参数
 **/
function getQueryValue(){
    var params = queryForm.getData();
    params.assignStatus = assignStatus.getValue();
    
    if(currType1Node){//品牌
        params.carBrandId = currType1Node.id;
    }
    
    if(currType2Node){//营销员
        params.visitManId = currType2Node.empId;
    }
    
    return params;
}

//品牌
function onType1DbClick(e){
    var node = e.node || currType1Node;
    if(!node){
        return;
    }
    
    currType1Node = node;
    query();    
}

//营销员
function onType2DbClick(e){
    var node = e.node || currType2Node;
    if(!node){
        return;
    }
    
    currType2Node = node;
    query();    
}

//设置跟踪状态、营销员
function updateField(field, value){
    var rows = dgGrid.getSelecteds();
    if(rows.length==0){
        nui.alert("请选择记录数据！");
        return;
    }
    var params = [];
    for(var i=rows.length - 1; i>=0; i--){
        var obj={id: rows[i].id};
        obj[field] = value;
        params.push(obj);
    }
    
    var url = _crmApiRoot + "/com.hsapi.crm.telsales.crmTelsales.updateGuest.biz.ext";
    callAjax(url, {datas: params}, processAjax, reLoadMain, null);
}

//分配营销员
function assignTracker(){
    var value = tracker.getValue();
    if(!value){
        nui.alert("请选择营销员！");
        return false;
    }
    updateField("visitManId", value);
}

function reLoadMain(data, json){
    if(json.errCode == "S"){
        nui.alert("设置成功！");
        dgGrid.reload();
    }
}

function add(){
    editWin("新增模板", {});
}

//修改资料
function editGuestInfo(){
    var row = dgGrid.getSelected();
    if (row) {
        editWin("修改模板", row);
    } else {
        alert("请选中一条记录");
    }
}

function editWin(title, data){
    data.artType = tree1.getData();
    nui.open({
        url: _crmWebRoot + "/com.hsweb.crm.telsales.clientInfo_edit.flow",
        title: title, width: 520, height: 520,
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