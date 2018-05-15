var timeStatus;
var queryForm;
var dgGrid1;
var dgGrid2;
$(document).ready(function(v){
	timeStatus=nui.get("timeStatus");
	queryForm = new nui.Form("#queryForm");
    dgGrid1 = nui.get("dgGrid1");
    dgGrid2 = nui.get("dgGrid2");
});

function init(){
   
	
}
/*
 *状态改变
 **/
function statuschange(){

}

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
	    dgGrid.load(params,function(){
	        //成功;
	       // nui.alert("数据成功！");
	    },function(){
	        //失败;
	        nui.alert("数据失败！");
	    });
	}
	else{
		  nui.alert("请选中一条数据！！");
	}
}
function db(){
	var s=dgGrid.getSelected ();
	if(s!=undefined){
		
		 nui.open({
             url: "receriveFunds_gz.jsp",
             title: "编辑员工", width: 600, height: 400,
             onload: function () {
                 var iframe = this.getIFrameEl();
                 var param = { action: "edit", data: s };
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
function sk(){
	var s=dgGrid.getSelected ();
	if(s!=undefined){
		
		 nui.open({
             url: "receiveFunds_sk.jsp",
             title: "编辑员工", width: 1150, height: 600,
             onload: function () {
                 var iframe = this.getIFrameEl();
                 var param = { action: "sk", data: s };
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
 *查询
 **/
function query(){
    var data = queryForm.getData();
    var timetemp=timeStatus.getValue();
    data.timetemp=timetemp;
    var params = {
    		"params":data
    };
    
    dgGrid1.load(params,function(){
        //成功;
       // nui.alert("数据成功！");
    },function(){
        //失败;
        nui.alert("数据失败！");
    });
    dgGrid2.load(params,function(){
        //成功;
       // nui.alert("数据成功！");
    },function(){
        //失败;
        nui.alert("数据失败！");
    });
}

/*
 *设置时间菜单
 **/
function setMenu2(obj, target, value){
    target.setValue(value);
    target.setText(obj.getText());   
    query();    
}
