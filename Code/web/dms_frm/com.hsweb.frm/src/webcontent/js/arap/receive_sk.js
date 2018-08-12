var form1;
var dgGrid;
var content;

$(document).ready(function(v) {

	form1 = new nui.Form("#form1");
	content=nui.get('recive');
	var dictDefs = {
		"payment" : "DDT20130703000031"
	};
	initDicts(dictDefs, null);
	dgGrid = nui.get("dgGrid");

});
function query(s) {

	var p = {
		"params" : {
			"guestId" : s.guestId,
			"rOrptemp":s.rpType
		}
	};
	dgGrid.load(p, function() {
		//成功;
		// nui.alert("数据成功！");
	}, function() {
		//失败;
		nui.alert("数据失败！");
	});
	
}

var mentt = [ {
	id : 1,
	text : '保险挂账'
}, {
	id : 2,
	text : '担保挂账'
} ];
function SetData(param) {
	form1.setData(param.data);
	query(param.data);
	
	//nui.alert(param.data.billAmt);
	if(param.data.billAmt==0)
	$("#fiebillAmt").hide();
		/* if (param.action == "edit") {
	          //跨页面传递的数据对象，克隆后才可以安全使用
	          data = nui.clone(data);

	       
	      }*/
}
function onOk() {

	var s = GetData();
	if (s != undefined) {
		nui.ajax({
			url : apiPath + frmApi
					+ "/com.hsapi.frm.setting.updateguarante.biz.ext",
			type : 'post',
			data : nui.encode({
				params : s
			}),
			success : function(data) {
				if (data.errCode == "S") {
					nui.alert("挂账成功！");
					closeWindow("ok");
				} else {
					closeWindow("ok");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				nui.alert(jqXHR.responseText);
			}
		});
	}

}
function GetData() {
	var o = form1.getData();
	return o;
}
function pay(){
	var payment=nui.get('payment').getValue();
	var revive=nui.get('recive').getValue();
    var row = dgGrid.getSelected();
    if (row) {
    	if(revive==""){
    		nui.alert("请输入金额！");
    		return ;
    	}
    	else if(payment==""){
    		nui.alert("请选择收款方式!！");
    		return ;
    	}
    	var rpcode=row.rpCode;
    	var guestid=row.guestId;
    	var fullname=row.guestFullName;
    	var s ={
    		"fullname":fullname,
    		"guestid":guestid,
    		"rpcode":rpcode,
    		"revive":revive,
    		"payment":payment,
    		"rpType":"1",
    		"row":row
    	};
    	nui.ajax({
			url : apiPath + frmApi
					+ "/com.hsapi.frm.arap.saveFisRpBillList.biz.ext",
			type : 'post',
			data : nui.encode({
				"params" : s
				}),
			success : function(data) {
				if (data.errCode == "S") {
					closeWindow("ok");
					nui.alert("收款成功！");
				} else {
					nui.alert("收款失败！");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				nui.alert(jqXHR.responseText);
			}
		});
    } else {
        alert("请选中一条记录");
    }
   
	
}
function setCharCount(){

    var txt = content.getInputText() || "";
    var maxnum = form1.getData().rpAmt;
    
    if(parseFloat(txt) > parseFloat(maxnum)){
    	
    	content.setValue(maxnum);
    	}
}