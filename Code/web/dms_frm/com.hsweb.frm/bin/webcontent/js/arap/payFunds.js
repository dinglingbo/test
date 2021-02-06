var queryForm;
var dgGrid;
var currGuest;
var billStatusList = [{text:'挂账',value:'0'},{text:'待审核',value:'1'}];
var assignStatus;
var timeStatus;
var rOrp;
$(document).ready(function(v){
	assignStatus = nui.get("assignStatus");
	timeStatus=nui.get("timeStatus");
	queryForm = new nui.Form("#queryForm");
    rOrp = nui.get("rOrp");
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
        }else if(field == "billStatus"){//主营业务
            e.cellHtml = setColVal(billStatusList, 'value', 'text', e.value);
     
    }});
    
    init();
    query();


});

function init(){
   
	
}


function fk(){
	var s=dgGrid.getSelected ();
	if(s!=undefined){
		
		 nui.open({
//             url: "receiveFunds_sk.jsp",
             url:"http://127.0.0.1:8080/default/frm/receiveFunds_sk.jsp",
             title: "付款", width: 1150, height: 600,
             onload: function () {
                 var iframe = this.getIFrameEl();
                 var param = { action: "fk", data: s };
                 iframe.contentWindow.SetData(param);
             },
             ondestroy: function (action) {
                 //var iframe = this.getIFrameEl();

            	 dgGrid.reload();

             }
         });
	}
	else{
		  nui.alert("请选中一条数据！！");
	}
}
/*
 *状态改变
 **/
function statuschange(){
	var s=dgGrid.getSelected ();
	if(s!=undefined){
	if(s.billStatus==0){
		$(shbutton).hide();
		$(skbutton).show();
	
	}else{
		$(shbutton).show();
		$(skbutton).hide();
		
	}}
}
/*
 *查询
 **/
function query(){
    var data = queryForm.getData();
    var assigntemp=assignStatus.getValue();
    var timetemp=timeStatus.getValue();
    var rOrptemp=rOrp.getValue();
    data.assignStatus=assigntemp;
    data.timetemp=timetemp;
    data.rOrptemp=rOrptemp;
    var params = {
    		"params":data
    };
    
    dgGrid.load(params,function(){
        //成功;
       // nui.alert("数据成功！");
    },function(){
        //失败;
        nui.alert("数据失败！");
    });
}

/*function add(){
    editWin("收支项目设置", {});
}*/
/*
 *查询
 **/
function sh(){
	var s=dgGrid.getSelected ();
	if(s!=undefined){
		
        nui.ajax({
            url: apiPath + frmApi + "/com.hsapi.frm.setting.updateInit.biz.ext",
            type: 'post',
            data: nui.encode({
            	params: {"id":s.id}
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                	nui.alert("审核成功！");
                	dgGrid.reload();
                    }else {
                    nui.alert("审核失败！");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                nui.alert(jqXHR.responseText);
            }
		});
       
	}
	else{
		  nui.alert("请选中一条数据！！");
	}
}

function edit(){
    var row = dgGrid.getSelected();
    if (row) {
        editWin("收支项目设置", row);
    } else {
        alert("请选中一条记录");
    }
}

function editWin(title, data){
    data.itemType = nui.get("itemTypeId").getData();
    nui.open({
        url: webPath + frmDomain + "/com.hsweb.frm.setting.incomeExpenItem_edit.flow",
        title: title, width: 380, height: 260,
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

function clearQueryForm(){
    queryForm.setData({});
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
 *设置时间菜单
 **/
function setMenu2(obj, target, value){
    target.setValue(value);
    target.setText(obj.getText());   
    query();    
}
