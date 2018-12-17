/**
 * Created by Administrator on 2018/4/27.
 */
var baseUrl = apiPath + repairApi + "/";
/*var queryOldMaintain = baseUrl
+"com.hsapi.repair.baseData.crud.queryOldMaintain.biz.ext";*/


$(document).ready(function(v) {


	team();

    /*grid.setUrl(queryOldMaintain);*/
    

});

/*function search(){

	var carNo = nui.get("carNo").getValue();
	var params = {
			carNo:carNo
	}
	var json1 = {
			params:params,
			token:token
	}
	nui.ajax({
		url : queryOldMaintain,
		type : 'POST',
		data : json1,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			grid.setData(text.oldMaintain);
					
		}
	});
}


// 当选择列时
function selectionChanged() {
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
	var row = grid.getSelected();
	var serviceCode = row.serviceCode;
	var params = {};
	params.serviceCode = serviceCode;
	var json1 = {
			params:	params
	};
	nui.ajax({
		url : queryOldItemPart,
		type : 'POST',
		data : json1,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			nui.unmask(document.body);
			grid2.setData(text.oldPart);
			grid3.setData(text.oldItem);
		}
	});
}
*/

function team(){
	var data = [
	            {id:"0",name:"所有"},{id:"1",name:"中级技师"},{id:"2",name:"高级技师"}
	 ];
	var str = "";
	for(var i = 0;i<data.length;i++){
		str = str+"<a  class='show' style='padding: 0px 10px;margin-bottom: 0;border-radius: 4px;line-height: 24px;'>"+data[i].name+"</a>";
	}
	document.getElementById("team").innerHTML=str; 
}
