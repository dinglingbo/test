/**
 * Created by steven on 2018/1/31.
 */

baseUrl = apiPath + sysApi + "/";;
var gridUrl = baseUrl + "com.hsapi.system.confi.paramSet.getbusinessSort.biz.ext";
var s=["维修","保养","美容","钣喷漆","轮胎","洗车","精品","零售","其他"];
var grid;
var editWindow;
var total;
$(document).ready(function(v) {
	grid=nui.get("dgGrid");
	grid.setUrl(gridUrl);
	grid.load({
		params:s,
	});
	
	editWindow = nui.get("editWindow");
});




 function editRow(num) {
	 	
	 
		var s=grid.getRowByUID(num);
		var form1=new nui.Form("#editform");
		form1.setData(s);
        editWindow.show();
      
}
 function newRow(){
		var form1=new nui.Form("#editform");
		form1.setData('');
	 	editWindow.show();
 }
 
 function onActionRenderer(e) {
    var grid = e.sender;
    var record = e.record;
    var uid = record._uid;
    var rowIndex = e.rowIndex;
	if(parseInt(rowIndex)==8)
    {var s = '<a class="New_Button" href="javascript:newRow()">New</a>';
    }
	else if(parseInt(rowIndex)>8){
		var s = '<a class="New_Button" href="javascript:newRow()">New</a>'
            + ' <a class="Edit_Button" href="javascript:editRow(\'' + uid + '\')" >Edit</a>'
            + ' <a class="Delete_Button" href="javascript:delRow(\'' + uid + '\')">Delete</a>';	
	}else 
	{var s='';}

    return s;
}
 function onCancel(){
	 var form1=new nui.Form("#editform");
	 form1.setData('');
	 editWindow.hide();
}
 var saveUrl = baseUrl + "com.hsapi.system.confi.paramSet.saveBusinessSort.biz.ext";
 function onOk(){
	 var form1=new nui.Form("#editform");
	 var formData=form1.getData();
	 nui.ajax({
			url:saveUrl,
			type:"post",
			data:{
				params:formData
			},
			success: function (data) {
	               if (data.errCode == "S"){
	            	    nui.alert("保存成功！");
	               	}
					else{
					 	nui.alert("保存失败！");
	               	}
	       
	           },
	           error: function (jqXHR, textStatus, errorThrown) {
	               nui.alert(jqXHR.responseText);
	           }
		
		});
	form1.setData('');
	editWindow.hide();
	grid.load({
			params:s,
	});
 }


 var delUrl = baseUrl + "com.hsapi.system.confi.paramSet.delBusinessSort.biz.ext";
 function delRow(num){
		var s=grid.getRowByUID(num);
	 	nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '删除中...'
	    });
		 nui.ajax({
				url:delUrl,
				type:"post",
				data:{
					params:s
				},
				success: function (data) {
		               if (data.errCode == "S"){
		            	    nui.unmask(document.body);
		            	    nui.alert("删除成功！");
		            		grid.load({
		            			params:s,
		            		});
		               	}
						else{
						    nui.unmask(document.body);
						 	nui.alert("删除失败！");
		               	}
		       
		           },
		           error: function (jqXHR, textStatus, errorThrown) {
		               nui.alert(jqXHR.responseText);
		           }
			
			});
	 
 }