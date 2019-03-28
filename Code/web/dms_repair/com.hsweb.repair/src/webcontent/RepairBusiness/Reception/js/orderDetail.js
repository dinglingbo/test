var rpsPackageGrid = null;
var rpsItemGrid = null;
var billForm = null;
var servieTypeList = [];
var servieTypeHash = {};
var mtAdvisorIdEl = null;
var FItemRow = {};
var advancedMorePartWin = null;
var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";  
var frmUrl = apiPath + frmApi + "/";
var serviceId=null;
var sellForm=null;
var servieIdEl = null;
var plist = [];
var rlist = [];
var amt = 0;//其他收入支出金额
var tcAmt = 0;
var gsAmt = 0;
var allowanceAmt = 0;
var ycAmt = 0;
var prdtTypeHash = {
	    "1":"套餐",
	    "2":"项目",
	    "3":"配件"
	};
$(document).ready(function () {
	rpsPackageGrid = nui.get("rpsPackageGrid");
	rpsItemGrid = nui.get("rpsItemGrid");
	billForm = new nui.Form("#billForm");
	sellForm =new nui.Form('#sellForm');
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	advancedMorePartWin = nui.get("advancedMorePartWin");
	servieIdEl = nui.get("servieIdEl");
	initServiceType("serviceTypeId",function(data) {
	    servieTypeList = nui.get("serviceTypeId").getData();
	    servieTypeList.forEach(function(v) {
	        servieTypeHash[v.id] = v;
	    });
	 });
	
	
	initMember("mtAdvisorId",function(){
        memList = mtAdvisorIdEl.getData();
    });
	mtAdvisorIdEl.on("valueChanged",function(e){
        var text = mtAdvisorIdEl.getText();
        nui.get("mtAdvisor").setValue(text);
    });
	rpsPackageGrid.on("cellendedit",function(e){
		var row = e.row,
		field = e.field;
		if(field == "subtotal"){
			var rate = null;
			if(row.amt){
				rate = 1 - (parseFloat(row.subtotal)/parseFloat(row.amt/100));
			}else{
				rate = 1;
			}
			var newRow = {rate : rate};
			rpsPackageGrid.updateRow(row,newRow);
		}
		if(field == "rate"){
			var subtotal = null;
			if(row.rate){
				subtotal = parseFloat(row.amt) * parseFloat(100-row.rate)/100;
			}else{
				subtotal = 0;
			}
			var newRow = {subtotal : subtotal};
			rpsPackageGrid.updateRow(row,newRow);
		}
	});
	rpsPackageGrid.on("drawcell",function(e){
		var field = e.field,
		value = e.value;
		var record = e.record;
//		if(field == "rate"){
//			if(value){
//				e.cellHtml = value.toFixed(2) + "%";
//			}else{
//				e.cellHtml = 0 + "%";
//			}
//		}
		if(field=="type"){
			 if(e.value == 1){
                 e.cellHtml = "--";
             }else{
                 e.cellHtml = prdtTypeHash[e.value];
             }
		}
	 	if(field == "serviceTypeId") {
         var type = record.type||0;
         if(type>1){
             e.cellHtml = "--";
         }else{
             e.cellHtml = servieTypeHash[e.value].name ||"";
         }
		}
		if(field == "subtotal"){
			if(!value){
				e.cellHtml = 0;
			}
		}
		if(field == "action"){
			e.cellHtml = ' <a class="optbtn" href="javascript:deleteRow(rpsPackageGrid)">删除</a>';
		}
		if(field == "prdtName"){
			   var cardDetailId = record.cardDetailId||0;
	           var s = "";
	           if(cardDetailId>0){
	               s = "<font color='red'>(预存)</font>";
	           }
	           e.cellHtml = e.value + s;
		}
	});
	rpsItemGrid.on("cellendedit",function(e){
		var row = e.row,
		field = e.field;
		if(field == "itemTime" || field == "unitPrice" || field == "rate"){
			var subtotal = parseFloat(row.itemTime) * parseFloat(row.unitPrice) * parseFloat(100-row.rate) * 0.01;
			var newRow = {subtotal : subtotal};
			rpsItemGrid.updateRow(row,newRow);
		}
	});
	rpsItemGrid.on("drawcell",function(e){
		var field = e.field,
		value = e.value,
		row = e.row;
		var record = e.record;
		var uid = record._uid;
		if(field == "serviceTypeId") {
	         var type = record.type||0;
	         if(type>2){
	             e.cellHtml = "--";
	         }else{
	             e.cellHtml = servieTypeHash[e.value].name ||"";
	         }
			}
		if(field == "rate"){
			if(value){
				e.cellHtml = value.toFixed(2) + "%";
			}else{
				e.cellHtml = 0 + "%";
			}
		}
		if(field == "itemTime" || field == "unitPrice"){
			if(!value){
				e.cellHtml = 0;
			}
		}
		if(field == "action"){
			e.cellHtml = ' <a class="optbtn" href="javascript:deleteRow(rpsItemGrid)">删除</a>';
		}
		if(field == "itemName"){
			if(row.pid == 0){
                e.cellHtml = '<a href="javascript:showMorePart(\'' + uid + '\')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;配件</a>' + e.value;	
            }else{
            	e.cellHtml ='<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>' + e.value;
            }
		}
		if(field == "prdtName"){
			   var cardDetailId = record.cardDetailId||0;
	           var s = "";
	           if(cardDetailId>0){
	               s = "<font color='red'>(预存)</font>";
	           }
	           e.cellHtml = e.value + s;
		}
	});
});

function setInitData(params){
	var param = {isMain:0};
	svrInComeExpenses(param,function(data) {
		var list = data.list||{};
		for(var i = 0; i<list.length; i++){
			var obj = list[i];
			if(obj.itemTypeId==1){
				rlist.push(obj);
			}else if(obj.itemTypeId==-1){
				plist.push(obj);
			}
		}
    });
	order(params.id);
	otherPreferential(params.id);
	 var params = {
	            data: {
	                id: params.id
	            }
	        };
	getMaintain(params, function(text){
        var errCode = text.errCode||"";
        var data = text.maintain||{};
        params.sourceServiceId = params.id;
        $("#servieIdEl").html(data.serviceCode);
        billForm.setData(data);   
    var p = {
            data:{
                guestId: data.guestId||0,
                contactorId: data.contactorId||0,
                carId:data.carId || 0,
            }
        };
        getGuestContactorCar(p, function(text){
            var errCode = text.errCode||"";
            var guest = text.guest||{};
            var car = text.car || {};
            var carExtend = text.carExtend || {};
            var contactor = text.contactor||{};
            if(errCode == 'S'){

                var carNo = data.carNo||"";
                var tel = guest.mobile||"";
                var guestName = guest.fullName||"";
                var carVin = data.carVin||"";
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


                data.guestFullName = guest.fullName;
                data.guestMobile = guest.mobile;
                data.contactorName = contactor.name;
                data.sex = contactor.sex;
                data.mobile = contactor.mobile;
                data.carModel = car.carModel;

                fguestId = data.guestId||0;
                fcarId = data.carId||0;

                
                billForm.setData(data);
     

                var p1 = {
                    interType: "package",
                    data:{
                        serviceId: data.id||0
                    }
                }
                var p2 = {
                    interType: "item",
                    data:{
                        serviceId: data.id||0
                    }
                }
                var p3 = {
                    interType: "part",
                    data:{
                        serviceId: data.id||0
                    }
                }
                loadDetail(p1, p2, p3);
            }else{
                showMsg("数据加载失败,请重新打开工单!","W");
            }

        }, function(){});
    });
 }

function loadDetail(p1, p2, p3){
    if(p1 && p1.interType){
        getBillDetail(p1, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsPackageGrid.clearRows();
                rpsPackageGrid.addRows(data);
                rpsPackageGrid.accept();
            }
        }, function(){});
    }
    if(p2 && p2.interType){
        getBillDetail(p2, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsItemGrid.clearRows();
                rpsItemGrid.addRows(data);
                rpsItemGrid.accept();
            }
        }, function(){});
    }
    if(p3 && p3.interType){
        getBillDetail(p3, function(text){
        }, function(){});
    }
}

function onDrawSummaryCellItem(e){
	  var data = sellForm.getData();
	  var rows = e.data;
	  sumItemSubtotal = 0;
	  sumItemPrefAmt = 0;
	  var sumItemAmt = 0;
	  sumPartSubtotal = 0;
	  sumPartPrefAmt = 0;
	  var sumPartAmt = 0;
	  // || e.field == "amt"
	  


	  if(e.field == "subtotal") 
	  {   
		  gsAmt = 0;
		  for (var i = 0; i < rows.length; i++)
		  {
			  if(rows[i].cardDetailId>0){
				  gsAmt=gsAmt+rows[i].subtotal;
			  }
			 if(rows[i].billItemId=="0"){
				 sumItemSubtotal += parseFloat(rows[i].subtotal);
				 sumItemAmt  += parseFloat(rows[i].amt); 
			 }else{
				 sumPartSubtotal += parseFloat(rows[i].subtotal);
				 sumPartAmt  += parseFloat(rows[i].amt); 
			 }
			   
		  }
		  ycAmt = parseFloat(tcAmt)+parseFloat(gsAmt);
		  data.ycAmt = ycAmt;
		  data.otherPreferential = allowanceAmt;
		  if( sumItemSubtotal>0 && sumItemAmt>=0  )
		  {   
			  sumItemPrefAmt = sumItemAmt - sumItemSubtotal;
			  sumItemSubtotal = sumItemSubtotal.toFixed(2);
			  sumItemPrefAmt = sumItemPrefAmt.toFixed(2);
			  data.itemSubtotal = sumItemSubtotal;
			  data.itemPrefAmt = sumItemPrefAmt;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal)+parseFloat(amt);//加上其他支出收入
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);			 
			  data.totalAmt = totalAmt.toFixed(2);
			  var settlementAmt = parseFloat(data.totalAmt)-parseFloat(data.totalPrefAmt)-parseFloat(allowanceAmt)-parseFloat(ycAmt);
			  data.settlementAmt =settlementAmt.toFixed(2);
			  
			  sellForm.setData(data);
		  }else{
			  data.itemSubtotal = 0;
			  data.itemPrefAmt = 0;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal)+parseFloat(amt);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);			  
			  var settlementAmt = parseFloat(data.totalAmt)-parseFloat(data.totalPrefAmt)-parseFloat(allowanceAmt)-parseFloat(ycAmt);
			  data.settlementAmt =settlementAmt.toFixed(2);
			  
			  sellForm.setData(data);
		  }
		  if(sumPartSubtotal>0 && sumPartAmt>=0)
		  {   
			  sumPartPrefAmt = sumPartAmt - sumPartSubtotal;
			  sumPartSubtotal = sumPartSubtotal.toFixed(2);
			  sumPartPrefAmt = sumPartPrefAmt.toFixed(2);
			  data.partSubtotal = sumPartSubtotal;
			  data.partPrefAmt = sumPartPrefAmt;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal)+parseFloat(amt);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  
			  var settlementAmt = parseFloat(data.totalAmt)-parseFloat(data.totalPrefAmt)-parseFloat(allowanceAmt)-parseFloat(ycAmt);
			  data.settlementAmt =settlementAmt.toFixed(2);
			  sellForm.setData(data);
		  }else{
			  data.partSubtotal = 0;
			  data.partPrefAmt = 0;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal)+parseFloat(amt);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  
			  var settlementAmt = parseFloat(data.totalAmt)-parseFloat(data.totalPrefAmt)-parseFloat(allowanceAmt)-parseFloat(ycAmt);
			  data.settlementAmt =settlementAmt.toFixed(2);
			  sellForm.setData(data);
		  }  
	  }  
}


var sumPkgSubtotal = 0;
var sumPkgPrefAmt = 0;
var sumItemSubtotal = 0;
var sumItemPrefAmt = 0;
var sumPartSubtotal = 0;
var sumPartPrefAmt = 0;
function onDrawSummaryCellPack(e){ 	
	  var data = sellForm.getData();
	  var rows = e.data;
	  sumPkgSubtotal = 0;
	  sumPkgPrefAmt = 0;
	  var sumPkgAmt = 0;
	  //|| e.field == "amt"
	  

	  if(e.field == "subtotal") 
	  {   
		  tcAmt = 0;
		  for (var i = 0; i < rows.length; i++)
		  {
			  if(rows[i].cardDetailId>0){
				  tcAmt=tcAmt+rows[i].subtotal;
			  }
			  if(rows[i].billPackageId=="0"){
				  sumPkgSubtotal += parseFloat(rows[i].subtotal);
				  sumPkgAmt  += parseFloat(rows[i].amt);
			  }
		  }
		  ycAmt = parseFloat(tcAmt)+parseFloat(gsAmt);
		  data.ycAmt = ycAmt;
		  data.otherPreferential = allowanceAmt;
		  if(sumPkgAmt>0 && sumPkgSubtotal>=0)
		  {   sumPkgPrefAmt = sumPkgAmt - sumPkgSubtotal;
			  sumPkgSubtotal = sumPkgSubtotal.toFixed(2);
			  sumPkgPrefAmt = sumPkgPrefAmt.toFixed(2);
			  
			  data.packageSubtotal = sumPkgSubtotal;
			  data.packagePrefAmt = sumPkgPrefAmt;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal)+parseFloat(amt);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  
			  var settlementAmt = parseFloat(data.totalAmt)-parseFloat(data.totalPrefAmt)-parseFloat(allowanceAmt)-parseFloat(ycAmt);
			  data.settlementAmt =settlementAmt.toFixed(2);
			  sellForm.setData(data);
		  }else{
			  data.packageSubtotal = 0;
			  data.packagePrefAmt = 0;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal)+parseFloat(amt);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  
			  var settlementAmt = parseFloat(data.totalAmt)-parseFloat(data.totalPrefAmt)-parseFloat(allowanceAmt)-parseFloat(ycAmt);
			  data.settlementAmt =settlementAmt.toFixed(2);
			  sellForm.setData(data);
		  }
	  } 
}
function onPrint(e){
	var main = billForm.getData();
	var openUrl = null;	
	if(main.id){
		var params = {
            source : e,
            serviceId : main.id,
            isSettle : main.isSettle
		};
		if(e==3 || e==4 || e==9 || e==10){
			if(main.status==2){
				doPrint(params);
			}else{
				showMsg("工单未完工，不能打印","W");
				return;
			}
		}else{
			 doPrint(params);
		}
       
	}else{
        showMsg("请先保存工单,再打印!","W");
        return;
    }
}

//查询其他收入支出
function order(serviceId){
	
	var json = {
			serviceId: serviceId,
			dc: 1,
			token: token
	}
	nui.ajax({
		url : baseUrl
		+ "com.hsapi.repair.repairService.svr.getRpsExpense.biz.ext" ,
		type : "post",
		data : json,
		async: false,
		success : function(rs) {
			var str = "";
			var srnum = rs.data;
			if(srnum.length>0){
				for(var i = 0;i<rs.data.length;i++){
					for(var j =0;j<rlist.length;j++){
						if(rs.data[i].typeCode==rlist[j].code){
							rs.data[i].typeCode=rlist[j].name;
						}
					}
					if(rs.data[i].remark==null){
						rs.data[i].remark="无";
					}
					var ss = '<td width="110" height="44" align="right">收入项目</td>'+'<td>'+'<input class="nui-textbox" enabled="false" id ='+i+'stypeCode name ="amount" value='+rs.data[i].typeCode+' style="width: 100px;">'+'</td>   <td width="110" height="44" align="right">收入金额</td>'+'<td>'+'<input class="nui-textbox" enabled="false" value='+rs.data[i].amt+' id ='+i+'sAmt name ="amount"  style="width: 100px;">'+'</td> <td width="110" height="44" align="right">备注</td>'+'<td>'+'<input class="nui-textbox" enabled="false" value='+rs.data[i].remark+' id ='+i+'sremark name ="amount"  style="width: 100px;">'+'</td>';
						ss=ss+'</tr>'+'<tr>';
					str = str+ss;
				}
				str='<tr>'+str+'</tr>';
			}else{
				str='<tr><td align="center" ><spand style="color: #ff7800;">无其它费用收入</spand></td></tr>';
			}
			for(var i = 0;i<srnum.length;i++){
				amt=amt+parseFloat(srnum[i].amt);
			}
			document.getElementById('paytype0').innerHTML = str;
			for(var i = 0;i<rs.data.length;i++){
				//nui.get().enable();
				document.getElementById(i+"stypeCode").disabled =true;
				document.getElementById(i+"sAmt").disabled =true;
				document.getElementById(i+"sremark").disabled =true;
			}


		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
	var json1 = {
			serviceId: serviceId,
			dc: -1,
			token: token
	}
	nui.ajax({
		url : baseUrl
		+ "com.hsapi.repair.repairService.svr.getRpsExpense.biz.ext" ,
		type : "post",
		data : json1,
		async: false,
		success : function(rs) {
			var str = "";
			var srnum = rs.data;
			if(srnum.length>0){
				for(var i = 0;i<rs.data.length;i++){
					for(var j =0;j<plist.length;j++){
						if(rs.data[i].typeCode==plist[j].code){
							rs.data[i].typeCode=plist[j].name;
						}
					}
					if(rs.data[i].remark==null){
						rs.data[i].remark="无";
					}
					var ss = '<td width="110" height="44" align="right">费用项目</td>'+'<td>'+'<input class="nui-textbox" readonly="readonly" id ='+i+'ztypeCode name ="amount" value='+rs.data[i].typeCode+' style="width: 100px;">'+'</td>   <td width="110" height="44" align="right">支出金额</td>'+'<td>'+'<input class="nui-textbox" readonly="readonly" value='+rs.data[i].amt+' id ='+i+'zAmt name ="amount"  style="width: 100px;">'+'</td> <td width="110" height="44" align="right">备注</td>'+'<td>'+'<input class="nui-textbox" enabled="false" value='+rs.data[i].remark+' id ='+i+'zremark name ="amount"  style="width: 100px;">'+'</td>';
						ss=ss+'</tr>'+'<tr>';
					str = str+ss;
				}
				str='<tr>'+str+'</tr>';
			}else{
				str='<tr><td align="center" ><spand style="color: #ff7800;">无其它费用支出</spand></td></tr>';
			}
			
/*			for(var i = 0;i<srnum.length;i++){
				amt=amt+parseFloat(srnum[i].amt);
			}*/
			document.getElementById('paytype1').innerHTML = str;
			for(var i = 0;i<rs.data.length;i++){
				//nui.get().enable();
				document.getElementById(i+"ztypeCode").disabled =true;
				document.getElementById(i+"zAmt").disabled =true;
				document.getElementById(i+"zremark").disabled =true;
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

}

var inComeExpensesUrl = frmUrl + "com.hsapi.frm.frmService.crud.queryFibInComeExpenses.biz.ext";
function svrInComeExpenses(params, callback) {
    //var params = {itemTypeId : 1, isMain: 0};
    nui.ajax({
        url : inComeExpensesUrl,
        data : {
            params: params,
            token: token
        },
        type : "post",
        async: false,
        success : function(data) {
            if (data && data.list) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function otherPreferential(serviceId){
	var json1 = {
			serviceId: serviceId
	}
	nui.ajax({
		url : baseUrl
		+ "com.hsapi.repair.repairService.query.getSettleDetail.biz.ext" ,
		type : "post",
		data : json1,
		async: false,
		success : function(rs) {
			var srnum = rs.data;
			allowanceAmt = srnum.allowanceAmt||0;
			
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});	
}