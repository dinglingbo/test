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
    initDicts({
        tree1: "DDT20130725000001"//话术类型
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
        alert("请选中一条记录");
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
        alert("请选中一条记录");
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