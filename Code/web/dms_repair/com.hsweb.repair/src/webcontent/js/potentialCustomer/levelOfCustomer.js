/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = apiPath + sysApi + "/";;
//var gridUrl = baseUrl + "com.hsapi.system.confi.paramSet.getbusinessSort.biz.ext";
var gridUrl = apiPath + repairApi + "/com.hsapi.repair.common.common.getBusinessType.biz.ext"
//var s=["维修","保养","美容","钣喷漆","轮胎","洗车","精品","零售","其他"];
var statusList = [{id:0,name:"启用"},{id:1,name:"禁用"}];
var statusHash = {0:"启用",1:"禁用"};
var dgGrid;
$(document).ready(function(v) {
	dgGrid=nui.get("dgGrid");
	dgGrid.setUrl(gridUrl);
	dgGrid.load({token:token});
	
	dgGrid.on("drawcell",function(e){
        switch (e.field) {
            case "isDisabled":
                if (statusHash[e.value]) {
                    e.cellHtml = statusHash[e.value] || "";
                } else {
                    e.cellHtml = "";
                }
				break;
			case "operateBtn":
				e.cellHtml = '<span class="fa fa-plus" onClick="javascript:addR()" title="添加行">&nbsp;&nbsp;</span>';
							 //' <span class="fa fa-close" onClick="javascript:deleteR()" title="删除行"></span>';
                break;
            default:
                break;
        }
	});
	
	dgGrid.on("cellbeginedit",function(e){
		var field=e.field; 
		var row = e.row;
        if(row.orgid == 0){
			e.cancel = true;
		}
	});
});
function addShareUrl(){
    var newRow = {isDisabled:0};
    dgGrid.addRow(newRow);
}
var saveShareUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.crud.saveBusinessType.biz.ext";
function saveShare(){
    var addList = dgGrid.getChanges("added");
	var updateList = dgGrid.getChanges("modified");
	var deleteList = dgGrid.getChanges("removed");

    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveShareUrl,
		type : "post",
		data : JSON.stringify({
			addList : addList,
			updateList : updateList,
			deleteList : deleteList,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
                parent.showMsg("保存成功!","S");
			} else {
				parent.showMsg(data.errMsg || "保存失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

}
function doSearch()
{
    dgGrid.load({token:token});
}

//  function editRow(num) {
	 	
	 
// 		var s=grid.getRowByUID(num);
// 		var form1=new nui.Form("#editform");
// 		form1.setData(s);
//         editWindow.show();
      
// }
//  function newRow(){
// 		var form1=new nui.Form("#editform");
// 		form1.setData('');
// 	 	editWindow.show();
//  }
 
//  function onActionRenderer(e) {
//     var grid = e.sender;
//     var record = e.record;
//     var uid = record._uid;
//     var rowIndex = e.rowIndex;
// 	if(parseInt(rowIndex)==8)
//     {var s = '<a class="New_Button" href="javascript:newRow()">New</a>';
//     }
// 	else if(parseInt(rowIndex)>8){
// 		var s = '<a class="New_Button" href="javascript:newRow()">New</a>'
//             + ' <a class="Edit_Button" href="javascript:editRow(\'' + uid + '\')" >Edit</a>'
//             + ' <a class="Delete_Button" href="javascript:delRow(\'' + uid + '\')">Delete</a>';	
// 	}else 
// 	{var s='';}

//     return s;
// }
 
//  function onCancel(){
// 	 var form1=new nui.Form("#editform");
// 	 form1.setData('');
// 	 editWindow.hide();
// }
//  var saveUrl = baseUrl + "com.hsapi.system.confi.paramSet.saveBusinessSort.biz.ext";
//  function onOk(){
// 	 var form1=new nui.Form("#editform");
// 	 var formData=form1.getData();
// 	 nui.ajax({
// 			url:saveUrl,
// 			type:"post",
// 			data:{
// 				params:formData
// 			},
// 			success: function (data) {
// 	               if (data.errCode == "S"){
// 	            	    nui.alert("保存成功！");
// 	            		grid.load({
// 	            			params:s,
// 	            			});
// 	               	}
// 					else{
// 					 	nui.alert("保存失败！");
// 	               	}
	       
// 	           },
// 	           error: function (jqXHR, textStatus, errorThrown) {
// 	               nui.alert(jqXHR.responseText);
// 	           }
		
// 		});
// 	form1.setData('');
// 	editWindow.hide();

//  }


//  var delUrl = baseUrl + "com.hsapi.system.confi.paramSet.delBusinessSort.biz.ext";
//  function delRow(num){
// 		var s=grid.getRowByUID(num);
// 	 	nui.mask({
// 	        el : document.body,
// 	        cls : 'mini-mask-loading',
// 	        html : '删除中...'
// 	    });
// 		 nui.ajax({
// 				url:delUrl,
// 				type:"post",
// 				data:{
// 					params:s
// 				},
// 				success: function (data) {
// 		               if (data.errCode == "S"){
// 		            	    nui.unmask(document.body);
// 		            	    nui.alert("删除成功！");
// 		            		grid.load({
// 		            			params:s,
// 		            		});
// 		               	}
// 						else{
// 						    nui.unmask(document.body);
// 						 	nui.alert("删除失败！");
// 		               	}
		       
// 		           },
// 		           error: function (jqXHR, textStatus, errorThrown) {
// 		               nui.alert(jqXHR.responseText);
// 		           }
			
// 			});
	 
//  }