var queryForm; //查询表单
var dgGrid; //列表

var tracker;
var tree1;
var tree2;
var currType1Node;//品牌
var currType2Node;//营销员

var menuAssignStatus;

$(document).ready(function(v){
    queryForm = new nui.Form("#queryForm");
    menuAssignStatus = nui.get("assignStatus");
    tracker = nui.get("tracker");
    
    tree1 = nui.get("tree1");
    tree2 = nui.get("tree2");
    dgGrid = nui.get("dgGrid");
    dgGrid.on("beforeload",function(e){
    	e.data.token = token;
    });
    
    tracker.setData(tree2.getData());//设置营销员下拉数据
    query();
});

/*
 *查询
 **/
function query(){
    var data = getQueryValue();
    var params = {};
    params.p = data;

    //param.token = token;
    dgGrid.load(params,null,function(){
        //失败;
        nui.alert("数据加载失败！");
    });
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
    
    var d = menuAssignStatus.getValue();

    if (d == 0) {//未分配
        params.assignStatus = null;
        currType2Node = null;
    } else if (d == 1) {//已分配
        params.assignStatus = 1;
        currType2Node = null;
    }  else if (d == 2) {//今日待跟踪
        params.assignStatus = null;
    }
    
    if(currType1Node){//品牌
        params.carBrandId = currType1Node.CUSTOMID;
    }
    
    if(currType2Node){//营销员
        params.visitManId = currType2Node.CUSTOMID;
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

function setTypeName(e){
    var typeData = tree1.getData();
    var tmp;
    for (var i = 0; i < typeData.length; i++) {
        tmp = typeData[i];
        if (tmp.CUSTOMID == e.value) return tmp.NAME;
    }
    return "";
}