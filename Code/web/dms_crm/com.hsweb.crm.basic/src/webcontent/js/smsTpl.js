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
    initMember("recorder",function(){ });
    nui.get("content").focus();
    document.onkeyup=function(event){
        var e=event||window.event;
    var keyCode=e.keyCode||e.which;//38向上 40向下

    if((keyCode==27)) { //ESC
        onClose();
    }
   };
   dgGrid.on("rowdblclick",function(){
	   save();
   });
});

/*
 *查询
 **/
 function query(){
    var data = queryForm.getData();
    var params = {};
    params.p = data;
    if(currTypeNode){
        params.p.typeId = currTypeNode.customid;
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
        title: title, width: 500, height: 340,
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
        if (tmp.customid == e.value) return tmp.name;
    }
    return "";
}

function setData(params){
    $("#span1").show();
    dgGrid.showColumn("check");
}


function getData(){
    var row = dgGrid.getSelected();
    if(row.length<1){
        showMsg('请选择一条短信','W');
        return;
    }
    return row;

}

function save(){
    var row = dgGrid.getData();
    if(row.length<1){
        showMsg('请选择一条短信','W');
        return;
    }else{
    	CloseWindow("ok");
    }
    
}

function CloseWindow(action) {
    if (action == "close") {
    } else if (window.CloseOwnerWindow)
    return window.CloseOwnerWindow(action);
    else
        return window.close();
}

function onClose(){
    window.CloseOwnerWindow();  
}