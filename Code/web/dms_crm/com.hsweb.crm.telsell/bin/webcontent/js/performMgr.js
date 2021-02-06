var queryForm;
var tree1;
var dgGrid;
var currTypeNode;

$(document).ready(function(v){
    queryForm = new nui.Form("#queryForm");
    tree1 = nui.get("tree1");
    dgGrid = nui.get("dgGrid");
    dgGrid.on("beforeload",function(e){
    	e.data.token = token;
    });
    query();
});

/*
 *查询
 **/
function query(){
    var data = queryForm.getData();
    var params = {};
    params.p = data;
    if(currTypeNode){
        params.p.typeId = currTypeNode.CUSTOMID;
    }
    //param.token = token;
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

function setTypeName(e){
    var typeData = tree1.getData();
    var tmp;
    for (var i = 0; i < typeData.length; i++) {
        tmp = typeData[i];
        if (tmp.CUSTOMID == e.value) return tmp.NAME;
    }
    return "";
}