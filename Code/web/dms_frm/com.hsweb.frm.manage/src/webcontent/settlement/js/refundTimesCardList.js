/**
 * Created by Administrator on 2018/4/27.
 */
var baseUrl = apiPath + repairApi + "/";
var queryCardUrl = baseUrl
+"com.hsapi.repair.baseData.cardTimes.queryCardTimesList.biz.ext";
var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";
var grid = null;
var servieTypeList = [];
var searchKeyEl = null;
var searchNameEl = null;
var guestId = 0;
 var guestName ="";
$(document).ready(function(v) {
	grid = nui.get("datagrid1");
	grid.setUrl(queryCardUrl);
	searchKeyEl = nui.get("search_key");
	searchNameEl = nui.get("search_name");
    searchKeyEl.setUrl(guestInfoUrl);
    
    searchKeyEl.on("beforeload",function(e){
        var data = {};
        var params = {};
        var value = e.data.key;
        value = value.replace(/\s+/g, "");
        if(value.length<3){
            e.cancel = true;
            return;
        }else{
            var reg = /^[0-9]*$/;//纯数字
            if(reg.test(value)){
                params.nums = value;

                data.params = params;
                e.data =data;
                return;
            }

            //包含字母
            var reg = /[a-z]/i;
            if(reg.test(value)){
                params.letters = value;

                data.params = params;
                e.data =data;
                return;
            }

            //包含中文
            var reg = /[\u4E00-\u9FA5\uF900-\uFA2D]/;
            if(reg.test(value)){
                params.chis = value;

                data.params = params;
                e.data =data;
                return;
            }
        }
        
    });
    
    
    searchKeyEl.on("itemclick",function(e){
    	var item = e.item;
        if (item) { 
        	setGuest(item);
        }
    });
    searchKeyEl.focus();
});



function setGuest(item){
	var carNo = item.carNo||"";
    var tel = item.guestMobile||"";
     guestName = item.guestFullName||"";
    var carVin = item.vin||"";
     guestId = item.guestId||"";
    var sk = document.getElementById("search_key");
    sk.style.display = "none";
    searchNameEl.setVisible(true);
    
    if(tel){
        tel = "/"+tel;
    }
    if(guestName){
        guestName = "/"+guestName;
    }
    if(carVin){
        carVin = "/"+carVin;
    }
    var t = carNo + tel + guestName + carVin;
    searchNameEl.setValue(t);
    
    grid.load({
    	guestId: guestId,
    	token : token
    });
    //searchNameEl.setEnabled(false);

}









//计次卡退款
function refund(){
		var row = grid.getSelected();
		if(row){
			
		}else{
			showMsg("请选一张储值卡!","W");
			return;
		}
		nui.open({
	        url: webPath + contextPath +"/com.hsweb.frm.manage.refundPay.flow?token="+token,
	         width: "100%", height: "100%", 
	        onload: function () {
	            var iframe = this.getIFrameEl();
	            var data = {
	            		card:row,
	            		payAmt:row.sellAmt,
	            		typeCard:1
	            }
	            iframe.contentWindow.setData(data);
	        },
			ondestroy : function(action) {// 弹出页面关闭前
				if (action == "saveSuccess") {
					showMsg("退款成功!", "S");
					var query = queryForm.getData();
					grid.load({
				    	query:query,
				    	token : token
				    });

				}
			}
	    });
	}



function refundRecord(){

    nui.open({
        targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.frm.manage.refundRecord.flow?token="+token,
        title: "退款记录", width: 850, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
            		guestId : guestId
            };
            iframe.contentWindow.setData(params);

        },
        ondestroy: function (action)
        {

        }
    });
}


function add(){

	grid.setData({});
    searchNameEl.setVisible(false);
    searchNameEl.setEnabled(false);
    searchNameEl.setValue("");
    var sk = document.getElementById("search_key");
    sk.style.display = "";
    searchKeyEl.focus();
    searchKeyEl.setValue("");//点增加给输入框个值，防止触发不了onchanged方法，不能放入客户



}