/**
 * Created by Administrator on 2018/4/25.
 */

var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var discountEl = null;
var othetExpenseEl = null;
$(document).ready(function ()
{
    nui.get("insuranceBizRate").on("valuechanged",calculateAmt);
    nui.get("insuranceSaliRate").on("valuechanged",calculateAmt);
    discountEl = nui.get("discount");
    discountEl.on("focus",function(){
        discountEl.setInputStyle("text-align:left");
        discountEl.setFormat("");
    });
    discountEl.on("blur",function(){
        discountEl.setInputStyle("text-align:right");
        discountEl.setFormat("￥0.00");
    });
    othetExpenseEl = nui.get("othetExpense");
    othetExpenseEl.on("focus",function(){
        othetExpenseEl.setInputStyle("text-align:left");
        othetExpenseEl.setFormat("");
    });
    othetExpenseEl.on("blur",function(){
        othetExpenseEl.setInputStyle("text-align:right");
        othetExpenseEl.setFormat("￥0.00");
    });
    var showMsg = nui.get("showMsg");
    showMsg.setValue("保费＝交强险金额+商业险金额+车船税金额\n佣金＝商业险*商业险佣金率 + 交强险*交强险佣金率\n返利：手工录入\n其它费用：赠送项目成本\n保费毛利=应收佣金 - 返利 - 其它费用");
});
function calculateAmt()
{
    var main = basicInfoForm.getData();
    main.insuranceSaliRate = main.insuranceSaliRate||0;
    main.insuranceBizRate = main.insuranceBizRate||0;
    main.commissionAmt = (main.insuranceSaliRate * main.insuranceSaliAmt + main.insuranceBizRate * main.insuranceBizAmt) / 100;
    main.discount = main.discount||0;
    main.othetExpense = main.othetExpense||0;
    main.grossProfit = main.commissionAmt - main.discount - main.othetExpense;
    main.commissionAmt = main.commissionAmt.toFixed(2);
    main.grossProfit = main.grossProfit.toFixed(2);
    basicInfoForm.setData(main);
}
function setData(data)
{
    data = data||{};
    basicInfoForm = new nui.Form("#basicInfoForm");
    var main = data.main||{};
    getMaintainById(main.id);
}
function getMaintainById(id)
{
    nui.mask({
        html:'数据加载中..'
    });
    var url = baseUrl+"com.hsapi.repair.repairService.insurance.getRpsInsuranceMainById.biz.ext";
    doPost({
        url : url,
        data : {
            params:{
                id:id
            }
        },
        success : function(data)
        {
            nui.unmask();
            data = data||{};
            var main = data.main;
            basicInfoForm.setData(main);
            if(main.status == 1)
            {
            	$("#onSave").hide();
            
/*                nui.alert("该单据已提交，不能重复提交","提示",function(){
                    CloseWindow("ok");
                });*/
            	CloseWindow("ok");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            nui.unmask();
            console.log(jqXHR.responseText);
            nui.alert("网络出错，获取数据失败")
        }
    });
}

function onSave()
{
    calculateAmt();
    var main = basicInfoForm.getData();
    nui.mask({
        html:'保存中..'
    });
    var url = baseUrl+"com.hsapi.repair.repairService.insurance.saveInsurance.biz.ext";
    doPost({
        url : url,
        data : {
            main:main,
            isPresettle:1
        },
        success : function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
            	$("#onSave").hide();
                nui.alert("保存成功");
            }
            else{
                nui.alert(data.errMsg||"保存失败");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            nui.unmask();
            console.log(jqXHR.responseText);
            nui.alert("网络出错，保存失败");
        }
    });
}
/*function onOk()
{
    var main = basicInfoForm.getData();
    if(main.status != 1){
    	showMsg("请先保存结算单！","W");
    	return;
    }
    var params = {
        rpType:1,
        guestId:main.guestId,
        guestFullName:main.guestFullName,
        serviceId:main.id,
        serviceCode:main.serviceCode,
        serviceTypeId:"02020112",
        rpAmt:main.insuranceAmt,
        rpAccountId:0,
        billAmt:0,
        remark:"",
        isPrimaryBusiness:1,
        rpAmtYes:0,
        rpAmtNo:main.insuranceAmt
    };
    spRpAccountPost(params,function(){
        var url = baseUrl+"com.hsapi.repair.repairService.insurance.afterInsuranceSubmit.biz.ext";
        doPost({
            url:url,
            data:{
                id:main.id
            },
            success:function(data)
            {
                nui.unmask();
                data = data||{};
                if(data.errCode == "S")
                {
                    nui.alert("提交成功","提示",function(){
                        CloseWindow("ok");
                    });
                }
                else{
                    console.log(data.errMsg);
                    nui.alert("提交失败");
                }
            },
            error:function(jqXHR, textStatus, errorThrown){
                console.log(jqXHR.responseText);
                nui.unmask();
                nui.alert("网络出错");
            }
        });
    });
}*/
function spRpAccountPost(params,callback)
{
    var url = window._rootFrmUrl+"com.hsapi.frm.arap.createArapService.biz.ext";
    doPost({
        url:url,
        data:{
            data:params
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                callback && callback();
            }
            else{
                console.log(data.errMsg);
                nui.alert("提交失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}

function onCancel() {
    CloseWindow("cancel");
}


function pay(){
	var data = basicInfoForm.getData();
	var json = {
			allowanceAmt:0,
			cardPayAmt:0,
			serviceId:data.id,
			payType:"20000",
			payAmt:0
	};
    nui.confirm("结算金额:"+"0"+"元,确定结算吗?", "友情提示",function(action){
	       if(action == "ok"){
			    nui.mask({
			        el : document.body,
				    cls : 'mini-mask-loading',
				    html : '处理中...'
			    });
	    		nui.ajax({
	    			url : baseUrl
	    			+ "com.hsapi.repair.repairService.settlement.ReceiveSettleInsurance.biz.ext" ,
	    			type : "post",
	    			data : json, 
			        cache : false,
			        contentType : 'text/json',
	    			success : function(data) {
	    				nui.unmask(document.body);
	    				if(data.errCode=="S"){
	    					nui.alert(data.errMsg,"提示");
	    				}else{
	    					nui.alert(data.errMsg,"提示");
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