/**
 * Created by Administrator on 2018/4/27.
 */
var baseUrl = apiPath + repairApi + "/";
var queryCardUrl = baseUrl
+"com.hsapi.repair.baseData.query.queryCardByGuestId.biz.ext";
var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";

var servieTypeList = [];
var searchKeyEl = null;
var searchNameEl = null;
var guestId = 0;
var tableNum = 0;
var printGuest ={};//打印用
var typeList = {};
 var flag=1;
 var checkF = 0;
 var card = [];
 var printcard = {};//打印用
$(document).ready(function(v) {

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
    addType();
});



function setGuest(item){
	
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });
	printGuest = item;
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
	var json = {
			guestId: guestId,
			page : {"currentPage":1,"length":100},
			token:token
		};

	nui.ajax({
		url : queryCardUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if (returnJson.errCode == 'S') {
				card = returnJson.data;
				nui.unmask(document.body);
				
				var cardList =[];
				for(var i = 0;i<returnJson.data.length;i++){
					var tureRefundAmt =0;
					if(returnJson.data[i].balaAmt>returnJson.data[i].giveAmt){
						 tureRefundAmt = (parseFloat(returnJson.data[i].balaAmt)-parseFloat(returnJson.data[i].giveAmt)).toFixed(2);
					} else{
						 tureRefundAmt = 0;
					}
					cardList[i] = {
							value:	returnJson.data[i].id,
							text :returnJson.data[i].cardName+"--剩余金额:"+returnJson.data[i].balaAmt+"--可退金额:"+tureRefundAmt
					};
				}
				nui.get("cardName").setData(cardList);
	
			} else {
				nui.unmask(document.body);
				parent.parent.showMsg(returnJson.errMsg||"获取数据失败","W");

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

    searchNameEl.setVisible(false);
    searchNameEl.setEnabled(false);
    searchNameEl.setValue("");
    var sk = document.getElementById("search_key");
    sk.style.display = "";
    searchKeyEl.focus();
    searchKeyEl.setValue("");//点增加给输入框个值，防止触发不了onchanged方法，不能放入客户



}


function addType(){
	nui.ajax({
		url : apiPath + frmApi + "/com.hsapi.frm.frmService.crud.queryFiSettleAccount.biz.ext?token="+ token,
		type : "post",
		data : "",
		success : function(data) {
			for(var i = tableNum;i<=tableNum;i++){
				$("#optaccount"+i).empty();
				var optaccount = document.getElementById('optaccount'+i);
				$("<option value=''>—请选择结算账户—</option>").appendTo("#optaccount"+i);
				for (var j = 0; j < data.settleAccount.length; j++) {
					if(data.settleAccount[j].isDefault==1 && flag==1){
						$("<option selected = 'selected' value="+data.settleAccount[j].id+">"+data.settleAccount[j].name+"</option>").appendTo("#optaccount"+i);
						checkF = 1;
						flag = 0;
					}else{
						$("<option  value="+data.settleAccount[j].id+">"+data.settleAccount[j].name+"</option>").appendTo("#optaccount"+i);
					}
				}
			}
			if(checkF){
				checkField("optaccount0");
			}
			
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}


function addF(){
	tableNum++;
	var str = '<div class="skbox2" id="div'+tableNum+'" name="'+tableNum+'"><table name="'+tableNum+'" width="98%" border="0" align="center" cellpadding="0" cellspacing="0"><tbody><tr><td width="50%" height="&quot;44&quot;"><select name="optaccount'+tableNum+'" id="optaccount'+tableNum+'" onchange="checkField(this.id)"  style="width: 94%; height: 33px; font-weight: bold; font-size: 15px; color: #578ccd;border:0;"></select></td><td><a class="depj" id="'+tableNum+'" data-balloon="删除收款方式" href="javascript:void(0);" onclick="remove(this.id)" style="margin-left: 15px;"></a></td></tr></tbody></table><table name="ppaytype'+tableNum+'" id="ppaytype'+tableNum+'" width="96%" border="0" cellpadding="0" cellspacing="0"><tbody></tbody></table></div>';
	var dataform = document.getElementById("dataform");
	//dataform.innerHTML = dataform.innerHTML+str;
	 $("#csdiv").before(str);
	addType();
}

function checkField(id){
	 var str = "";
	 var s1=id.split("optaccount");
	 //$("#ppaytype"+s1[1]).empty();
	 var myselect=document.getElementById("optaccount"+s1[1]);
	 var index=myselect.selectedIndex;
	 var c  =myselect.options[index].value;
  var json = {
  		accountId:c,
  		token:token
  };
	nui.ajax({
		url : apiPath + frmApi + "/com.hsapi.frm.setting.queryAccountSettleType.biz.ext",
		type : "post",
		data : json,
		success : function(data) {
			for(var i = 0;i<data.list.length;i++){
				var ss = '<td width="110" height="44" align="right">'+data.list[i].customName+'</td>'+'<td>'+'<input class="nui-textbox" id ='+s1[1]+data.list[i].customId+' name ="amount" onvaluechanged="onChanged" style="width: 100px;">'+'</td>';
				if(((i+1)%3)==0){
					ss=ss+'</tr>'+'<tr>';
				}
				str = str+ss;
			}
			str='<tr>'+str+'</tr>';
			document.getElementById('ppaytype'+s1[1]).innerHTML = str;
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});

}

	
	
function  scount(){
	type = null;
	var count = 0;
	for(var j =0;j<tableNum+1;j++){
		for(var i =0;i<10;i++){
			if(document.getElementById(j+"02010"+i)==null||document.getElementById(j+"02010"+i).value==""){
				
			}else{
				var dk = parseFloat(document.getElementById(j+"02010"+i).value);
				count= count+dk;
				type=type+","+j+"02010"+i+"p"+dk;
			}
		}
	}
	if(type==null||type==""){
		
	}else{
		typeList = type.split(",");
	}

	return count;
}


function pay(){
	var accountTypeList =[];
	var accountDetail = {};
	var amt = scount();
	for(var i = 0;i<tableNum+1;i++){
		var  Sel=document.getElementById("optaccount"+i);
		if(Sel!=null){
			var index=Sel.selectedIndex ;
			var selectValue =  Sel.options[index].value;
			var seletText = Sel.options[index].text;
		}
		for(var j =1;j<typeList.length;j++){
			var dtype = typeList[j].split("p");
			var typeF = dtype[0].substring(0,1);
			if(typeF==i){
				var deductible1 = dtype[1];
				var TypeCode = dtype[0].substring(1,dtype[0].length);
				var list={balaTypeCode:TypeCode,charOffAmt:deductible1,settAccountId:selectValue,settAccountName:seletText};
				accountTypeList.push(list);
			}
		}
	}


	 json = {
				accountTypeList : accountTypeList,
				serviceId:nui.get("cardName").getSelected().value,
				remark:nui.get("txtreceiptcomment").getValue(),
				payAmt:amt,
				type:2
			};
	 //确定退款哪张卡，打印用
	 for(var i = 0 ;i<card.length;i++){
		 if(json.serviceId==card[i].id){
			 printcard = card[i];
			 printcard.payAmt = amt;
		 }
	 }
	    nui.confirm("是否确定退款？", "友情提示",function(action){
		       if(action == "ok"){
				    nui.mask({
				        el : document.body,
					    cls : 'mini-mask-loading',
					    html : '处理中...'
				    });
		    		nui.ajax({
		    			url : baseUrl+ "com.hsapi.repair.repairService.settlement.refundSettle.biz.ext",
		    			type : "post",
		    			data : json,
				        cache : false,
				        contentType : 'text/json',
		    			success : function(data) {
		    				nui.unmask(document.body);
		    				if(data.errCode=="S"){  					
		    					parent.parent.showMsg("退款成功!","W");
		    					print();
		    				}else{
		    					parent.parent.showMsg(data.errMsg||"退款失败!","E");
		    				}

		    			},
		    			error : function(jqXHR, textStatus, errorThrown) {
		    				// nui.alert(jqXHR.responseText);
		    				console.log(jqXHR.responseText);
		    			}
		    		});	
		     }else {
					return;
			 }
		});
}

//打印函数
function print(){
	var sourceUrl = "";
	var printName = currRepairSettorderPrintShow||currOrgName;
	var p = {
		comp : printName,
		partApiUrl:apiPath + partApi + "/",
		baseUrl: apiPath + repairApi + "/",
		sysUrl: apiPath + sysApi + "/",
		webUrl:webPath + contextPath + "/",
        bankName: currBankName,
        bankAccountNumber: currBankAccountNumber,
        currCompAddress: currCompAddress,
        currCompTel: currCompTel,
        currSlogan1: currSlogan1,
        currSlogan2: currSlogan2,
        currUserName : currUserName,
        currCompLogoPath: currCompLogoPath,
		token : token
	};
	params = {
			printGuest:printGuest,
		guestData:printcard,
		p:p
	};

		sourceUrl = webPath + contextPath + "/com.hsweb.repair.DataBase.printCardStoredRefund.flow?token="+token;
		p.name="储值卡退款";
	nui.open({
        url: sourceUrl,
        title: p.name + "打印",
		width: "100%",
		height: "100%",
        onload: function () {
            var iframe = this.getIFrameEl();
           iframe.contentWindow.SetData(params);
        },
        ondestroy: function (action){
        }
    });
}