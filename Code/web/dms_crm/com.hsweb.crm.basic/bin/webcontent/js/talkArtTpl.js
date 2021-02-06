var queryForm;
var tree1;
var dgGrid;
var currTypeNode;
var currRow;

$(document).ready(function(v){
    queryForm = new nui.Form("#queryForm");
    tree1 = nui.get("tree1");
    dgGrid = nui.get("dgGrid");
    dgGrid.on("beforeload",function(e){
    	e.data.token = token;
    });
    nui.get('query').focus();
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        
        if ((keyCode == 13)) { // Enter
            query();
        }
        
        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }
    initDicts({
        tree1: "DDT20130725000001"//话术类型
    });
    initMember("recorder",function(){ });
    query();
});

/*
 *查询
 **/
function query(e){
    var data = queryForm.getData();
    var params = {};
    params.p = data;
    if(currTypeNode && e != 0){
        params.p.typeId = currTypeNode.customid;
    }
    //param.token = token;
//    dgGrid.load(params,null,function(){
//        //失败;
//        showMsg("数据加载失败！");
//    });
    dgGrid.load({p:params.p,token:token});
}

function onNodeDbClick(e){
    var node = e.node || currTypeNode;
    if(!node){
        return;
    }
    
    currTypeNode = node;
    query();    
}

function getData(){
    if(currRow){
        return currRow;
    }else{
        return {};
    }
}

function setData(data){
    if(data.action=="sel"){
        $(".selgroup").show();
        $(".editgroup").hide();
    }else{
        $(".selgroup").hide();
        $(".editgroup").show();
    }
}

function doSelect(){
    var row = dgGrid.getSelected();
    if (row) {
        currRow = row;
        closeWindow("ok");
    } else {
        showMsg("请选中一条记录","W");
    }
}

function add(){
    editWin("新增话术", {});
}

function edit(){
    var row = dgGrid.getSelected();
    if (row) {
        editWin("修改话术", row);
    } else {
        showMsg("请选中一条记录","W");
    }
}

function editWin(title, data){
    data.artType = tree1.getData();
    mini.open({
        url: webPath + crmDomain + "/com.hsweb.crm.basic.talkArtTpl_edit.flow",
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

function CloseWindow(action){
    if (window.CloseOwnerWindow) 
    	return window.CloseOwnerWindow(action);
    else 
    	window.close();
}