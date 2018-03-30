var queryForm;
var dgGrid;
var currTypeNode;
$(document).ready(function(v){
    queryForm = new nui.Form("#queryForm");
    dgGrid = nui.get("dgGrid");
    dgGrid.on("beforeload",function(e){
    	e.data.token = token;
    });
    query();
});


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

function onNodeClick(e){
    var node = e.node || currTypeNode;
    if(!node){
        return;
    }
    
    currTypeNode = node;    
    
}