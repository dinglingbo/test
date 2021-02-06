
    var webBaseUrl = webPath + contextPath + "/";
    var baseUrl = apiPath + repairApi + "/";
    var gridUrl = apiPath + partApi + "/com.hsapi.part.invoice.stockcal.queryOutableEnterGridWithPage.biz.ext";
    var mrecordId = null;//
    var mainRow = null;
    var mainGrid = null;
    $(document).ready(function () {
         mainGrid = nui.get("mainGrid"); 
        mainGrid.setUrl(gridUrl);
        
        mainGrid.on("load",function(e){
            var tdata = mainGrid.getData();
            if(tdata.length < 1){
                showMsg('该配件没有剩余库存!','W');
            }
        });
        
        mainGrid.on("cellcommitedit",function(e){
            var record = e.record;
            var value = e.value;
            var column = e.column;
            var field = e.field;  
            var editor = e.editor;
            var sumData = gridData();
            if(column.field == "outQty"){  
                editor.validate();  
                if (editor.isValid() == false) {
                    showMsg("请输入有效数字！","W");
                    e.cancel = true;
                }

                if(record.stockQty < value){
                    e.cancel = true;
                    showMsg("该配件领料数量不能大于库存数量！","W");
                } 

                if(sumData.sum_stock < sumData.sum_outQty){
                    e.cellHtml = "0";
                    showMsg("总领料数量不能大于库存数量！","W");
                } 
            }
        });
        
    });

    function SetData(par,type,id,mRow){
        //id= 9522; 
        onSearch(par,type);
        mrecordId = id;
        mainRow = mRow;

    } 

    function onSearch(par,type) {  
        if(type == "Id"){
            var params = {
                partId:par
            };
        }
        if(type == "Code"){
            var params = {
                partCode:par
            };
        }
        mainGrid.load({params:params,token:token});

    }


    function onOk(){
        var sum_out = 0;
        var data = mainGrid.getData();
        if(data.length > 0){

            for (var i = 0; i < data.length; i++) {
                if(data[i].outQty){
                    sum_out +=parseFloat(data[i].outQty);
                }
            }

            if(!sum_out){
                showMsg('请先填写领料数量!','W');
                return;
            }
            nui.open({
                url:webBaseUrl + "com.hsweb.RepairBusiness.partSelectMember.flow?token="+token,
                title:"选择领料人",
                height:"300px",
                width:"600px", 
                onload:function(){ 
                    var iframe = this.getIFrameEl();
                    iframe.contentWindow.SetData("ll");
                },
                ondestroy:function(action){
                    if (action == "ok") {  
                        var iframe = this.getIFrameEl();
                        var childdata = iframe.contentWindow.GetFormData();
                    savePartOut(childdata);     //如果点击“确定”
                    window.parent.tt(333);
                    CloseWindow("ok");
                }

            }

        });

        }else{
            showMsg('没有需要出库的配件!','W');
        }
    }


    function  savePartOut(childdata){
        var data = mainGrid.getData();
        if(data){
            var paramsDataArr = [];
            //var paramsData = nui.clone(data); 
            for (var i = 0; i < data.length; i++) { 
                var paramsData = {};
                paramsData.serviceId = '';
                paramsData.id = '';
                paramsData.mainId = mrecordId;
                paramsData.sourceId = data[i].id;
                paramsData.serviceId = mainRow.id;
                paramsData.serviceCode = mainRow.serviceCode;
                paramsData.carNo = mainRow.carNO;
                paramsData.vin = mainRow.carVin;
                paramsData.partId = data[i].partId;
                paramsData.partCode = data[i].partCode;
                paramsData.oemCode = data[i].oemCode;
                paramsData.partName = data[i].partName;
                paramsData.partNameId = data[i].partNameId;
                paramsData.partFullName = data[i].partFullName;
                paramsData.stockQty = data[i].stockQty;
                paramsData.outQty = data[i].outQty;
                paramsData.enterPrice = data[i].enterPrice;
                paramsData.billTypeId = '050206';
                paramsData.storeId = data[i].storeId;
                paramsData.unit = data[i].systemUnitId;
                paramsData.pickMan = childdata.mtAdvisor;
                paramsData.remark = childdata.remark;
                paramsData.pickType = "维修出库-领料";
                paramsData.taxUnitPrice = data[i].taxUnitPrice;
                paramsData.taxAmt = data[i].taxAmt;
                paramsData.noTaxUnitPrice = data[i].noTaxUnitPrice;
                paramsData.noTaxAmt = data[i].noTaxAmt;
                paramsData.trueUnitPrice = data[i].trueUnitPrice;
                paramsData.trueCost = data[i].trueCost;
                paramsData.sellUntiPrice = data[i].sellUntiPrice;
                paramsData.sellAmt = data[i].sellAmt;
                if(!paramsData.partNameId){ 
                    paramsData.partNameId = "0"; 
                }
                paramsDataArr.push(paramsData);
            } 

            //console.log(paramsData);
            //console.log(tdata);
            //return;  
            nui.ajax({
                url:baseUrl + "com.hsapi.repair.repairService.work.repairOut.biz.ext",
                type:"post",
                async: false,
                data:{ 
                    data:paramsDataArr,
                    billTypeId:"050206",
                    serviceId:mainRow.id,
                    token:token   
                },   
                success:function(text){   
                    var errCode = text.errCode;
                    var errMsg = text.errMsg;
                    if(errCode == "S"){

                        showMsg('领料成功!','S'); 
                    }else{ 
                        showMsg(errMsg,'E'); 
                    }
                }  
            }); 
        }else{  
            showMsg('没有需要出库的配件!','W'); 
        } 
    } 




function gridData(){//获取汇总的数据
    var sum_stock = 0;
    var sum_outQty = 0;
    var girdData = mainGrid.getData();
    for (var i = 0; i < mainGrid.length; i++) {
        sum_stock += mainGrid[i].stockQty;
        sum_outQty += mainGrid[i].outQty;
    }

    var reData = {
        sum_stock:sum_stock,
        sum_outQty:sum_outQty
    };
    return reData;
}


/*
    function newCheckBill(tid) {
        var item={};
        item.id = "checkDetail";
        item.text = "查车单";
        item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/checkDetail.jsp?tid="+tid+"&actionType=new";
        item.iconCls = "fa fa-cog";
        window.parent.activeTab(item);
    }
    */

    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
