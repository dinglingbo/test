var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var billForm = null;
var jpGrid = null;
var jpUrl = baseUrl + "sales.search.searchCsbGiftMsg.biz.ext";
var jpDetailGrid = null;
var jpDetailGridUrl = baseUrl + "sales.search.searchSaleGiftApply.biz.ext";
var queryUrl = baseUrl + "com.hsapi.frm.frmService.crud.queryFibInComeExpenses.biz.ext";
var costGrid = null;
var costDetailGrid = null;
var costDetailGrid2 = null;
var costDetailGridUrl = baseUrl + "sales.search.searchSaleCostList.biz.ext";
var form = null;
var is_not = [{ id: 0, text: '未审' }, { id: 1, text: '已审' }];
var insuranceForm = null;
var detailGrid = null;
var searchKeyEl = null;
var searchNameEl = null;
var detailGridUrl = baseUrl + "com.hsapi.repair.repairService.insurance.queryRpsInsuranceDetailList.biz.ext";
var guestInfoUrl = baseUrl + "sales.search.searchGuest.biz.ext";
var settleTypeIdList = [{ id: 1, name: "保司直收" }, { id: 2, name: "门店代收全款" }, { id: 3, name: "代收减返点" }];
var costList = [{ id: 0, name: "免费" }, { id: 1, name: "收费" }];

$(document).ready(function(v) {

    document.getElementById("caCalculation").src = webBaseUrl + "sales/sales/caCalculation.jsp";
    billForm = new nui.Form("#billForm");
    form = new nui.Form("#form1");
    insuranceForm = new nui.Form("#insuranceForm");
    var fields = insuranceForm.getFields();
    for (var i = 0, l = fields.length; i < l; i++) {
        var c = fields[i];
        if (c.setReadOnly) c.setReadOnly(true); //只读
        if (c.setIsValid) c.setIsValid(true); //去除错误提示
    };
    detailGrid = nui.get("detailGrid");
    detailGrid.setReadOnly(true);
    detailGrid.setUrl(detailGridUrl);

    jpGrid = nui.get("jpGrid");
    jpGrid.setUrl(jpUrl);

    jpDetailGrid = nui.get("jpDetailGrid");
    jpDetailGrid.setUrl(jpDetailGridUrl);

    costGrid = nui.get("costGrid");
    costGrid.setUrl(queryUrl);
    var params = { isSale: 1 };
    costGrid.load({ params: params });

    costDetailGrid = nui.get("costDetailGrid");
    costDetailGrid2 = nui.get("costDetailGrid2");
    costDetailGrid.setUrl(costDetailGridUrl);
    costDetailGrid2.setUrl(costDetailGridUrl);

    jpGrid.load();
    jpGrid.on("rowclick", function(e) {
        var billFormData = billForm.getData(true); //主表信息
        if (billFormData.status != 0) {
            return;
        } 
        var jpdata = jpGrid.getSelecteds();
        var jpDetailData = jpDetailGrid.getData();
        for (var i = 0, l = jpdata.length; i < l; i++) {
            var msg = jpDetailData.find(jpDetailData => jpDetailData.giftId == jpdata[i].id);
            if (!msg) {
                var newRow = {
                    giftId: jpdata[i].id,
                    giftName: jpdata[i].name,
                    billType: 2
                };
                jpDetailGrid.addRow(newRow, jpDetailData.length);
            };
        }
        jpDetailData = jpDetailGrid.getData();
        for (var i = 0, l = jpDetailData.length; i < l; i++) {
            var row = jpDetailGrid.getRow(i);
            var msg = jpdata.find(jpdata => jpdata.id == jpDetailData[i].giftId);
            if (!msg) {
                jpDetailGrid.commitEdit();
                jpDetailGrid.removeRow(row, false);
            };
        };
    });

    jpGrid.on("load", function(e) {
        var data = jpDetailGrid.getData();
        var data1 = jpGrid.getData();
        for (var i = 0, l = data.length; i < l; i++) {
            for (var j = 0, k = data1.length; j < k; j++) {
                if (data[i].giftId == data1[j].id) {
                    var row = jpGrid.getRow(j);
                    jpGrid.select(row, false);
                };
            };
        };
    });

    jpDetailGrid.on("drawcell", function(e) {
        var field = e.field;
        if (field == "receType") {
            if (e.value) {
                e.cellHtml = costList.find(costList => costList.id == e.value).name;
            }
        }
    });

    jpDetailGrid.on("load", function(e) {
        var data = jpDetailGrid.getData();
        var data1 = jpGrid.getData();
        for (var i = 0, l = data.length; i < l; i++) {
            for (var j = 0, k = data1.length; j < k; j++) {
                if (data[i].giftId == data1[j].id) {
                    var row = jpGrid.getRow(j);
                    jpGrid.select(row, false);
                };
            };
        };
    });

    jpDetailGrid.on("cellendedit", function(e) {
        var row = e.row,
            field = e.field;
        if (field == "price" || field == "qty") {
            var price = row.price || 0;
            var qty = row.qty || 0;
            var value = (price * qty).toFixed(2);
            var newRow = { amt: value };
            jpDetailGrid.updateRow(row, newRow);
            //编辑完成后调用购车计算表将精品加装金额赋值上去
            var data = jpDetailGrid.getBottomColumns();
            var decrAmt = data.find(data => data.field == "amt").summaryValue;
            document.getElementById("caCalculation").contentWindow.setDecrAmt(decrAmt);
        };
    });

    jpGrid.on("beforedeselect", function(e) {
        var billFormData = billForm.getData(true); //主表信息
        if (billFormData.status != 0) {
            e.cancel = true;
        }
    });

    jpGrid.on("beforeselect", function(e) {
        var billFormData = billForm.getData(true); //主表信息
        if (billFormData.status != 0) {
            e.cancel = true;
        }
    });

    costGrid.on("load", function(e) {
        var data = costGrid.getData();
        var data1 = costDetailGrid.getData();
        var data2 = costDetailGrid2.getData();
        var arr = data1.concat(data2);
        if (arr.length > 0 && data.length > 0) {
            for (var i = 0, l = data.length; i < l; i++) {
                for (var j = 0, k = arr.length; j < k; j++) {
                    if (data[i].id == arr[j].costId) {
                        var row = costGrid.getRow(j);
                        costGrid.select(row, false);
                    };
                };
            };
        };
    });

    costGrid.on("beforedeselect", function(e) {
        var billFormData = billForm.getData(true); //主表信息
        if (billFormData.status != 0) {
            e.cancel = true;
        }
    });

    costGrid.on("beforeselect", function(e) {
        var billFormData = billForm.getData(true); //主表信息
        if (billFormData.status != 0) {
            e.cancel = true;
        }
    });

    costDetailGrid.on("load", function(e) {
        var costData = costGrid.getData();
        var data = costDetailGrid.getData();
        if (costData.length > 0 && data.length > 0) {
            for (var i = 0, l = data.length; i < l; i++) {
                for (var j = 0, k = costData.length; j < k; j++) {
                    if (data[i].costId == costData[j].id) {
                        var row = costGrid.getRow(j);
                        costGrid.select(row, false);
                    };
                };
            };
        };
    });

    costDetailGrid.on("drawcell", function(e) {
        var field = e.field;
        var row = e.row;
        if (field == "action") {
            if (row.auditSign == 0) {
                e.cellHtml = '<a class="optbtn" iconCls="" onclick="checkCost(costDetailGrid,1)"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>';
            } else {
                e.cellHtml = '<a class="optbtn" iconCls="" onclick="checkCost(costDetailGrid,0)"><span class="fa fa-close fa-lg"></span>&nbsp;反审</a>';
            }
        }
    });

    costDetailGrid2.on("drawcell", function(e) {
        var field = e.field;
        var row = e.row;
        if (field == "action") {
            if (row.auditSign == 0) {
                e.cellHtml = '<a class="optbtn" iconCls="" onclick="checkCost(costDetailGrid2,1)"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>';
            } else {
                e.cellHtml = '<a class="optbtn" iconCls="" onclick="checkCost(costDetailGrid2,0)"><span class="fa fa-close fa-lg"></span>&nbsp;反审</a>';
            }
        }
    });

    costDetailGrid2.on("load", function(e) {
        var costData = costGrid.getData();
        var data = costDetailGrid2.getData();
        if (costData.length > 0 && data.length > 0) {
            for (var i = 0, l = data.length; i < l; i++) {
                for (var j = 0, k = costData.length; j < k; j++) {
                    if (data[i].costId == costData[j].id) {
                        var row = costGrid.getRow(j);
                        costGrid.select(row, false);
                    };
                };
            };
        };
    });

    costGrid.on("rowclick", function(e) {
        var billFormData = billForm.getData(true); //主表信息
        if (billFormData.status != 0) {
            return;
        }
        var data = costGrid.getSelecteds();
        var data1 = costDetailGrid.getData();
        var data2 = costDetailGrid2.getData();
        for (var i = 0, l = data.length; i < l; i++) {
            var newRow = {
                costName: data[i].name,
                costId: data[i].id,
                auditSign: 0
            };
            if (data[i].name == "购置税" || data[i].name == "保险费") {
                var msg = data1.find(data1 => data1.costId == data[i].id);
                if (!msg) {
                    newRow.type = 1;
                    costDetailGrid.addRow(newRow, costDetailGrid.length);
                };
            } else {
                var msg = data2.find(data2 => data2.costId == data[i].id);
                if (!msg) {
                    newRow.type = 2;
                    costDetailGrid2.addRow(newRow, costDetailGrid2.length);
                };
            };
        }
        data1 = costDetailGrid.getData();
        for (var i = 0, l = data1.length; i < l; i++) {
            var row = costDetailGrid.getRow(i);
            var msg = data.find(data => data.id == data1[i].costId);
            if (!msg) {
                costDetailGrid.commitEdit();
                costDetailGrid.removeRow(row, false);
            };
        }
        data2 = costDetailGrid2.getData();
        for (var i = 0, l = data2.length; i < l; i++) {
            var row = costDetailGrid2.getRow(i);
            var msg = data.find(data => data.id == data2[i].costId);
            if (!msg) {
                costDetailGrid2.commitEdit();
                costDetailGrid2.removeRow(row, false);
            };
        };
    });
    var dictDefs = { "billTypeId": "DDT20130703000008", "saleType": 10392 };
    initDicts(dictDefs, function() {});

    initMember("saleAdvisorId", function() {
        nui.get("saleAdvisorId").setValue(currEmpId);
        nui.get("saleAdvisorId").setText(currUserName);
        var data = nui.get("saleAdvisorId").getData();
        nui.get("submitCarMen").setData(data);
        nui.get("saleManIds").setData(data);
    });

    searchKeyEl = nui.get("search_key");
    searchNameEl = nui.get("search_name");
    searchKeyEl.setUrl(guestInfoUrl);

    searchKeyEl.on("beforeload", function(e) {
        var data = {};
        var params = {};
        var value = e.data.key;
        value = value.replace(/\s+/g, "");
        params.isDisabled = 0;
        if (value.length < 2) {
            e.cancel = true;
            return;
        } else {
            var reg = /^[0-9]*$/; //纯数字
            if (reg.test(value)) {
                params.mobile = value;

                data.params = params;
                e.data = data;
                return;
            }

            //包含中文
            var reg = /[\u4E00-\u9FA5\uF900-\uFA2D]/;
            if (reg.test(value)) {
                params.fullName = value;

                data.params = params;
                e.data = data;
                return;
            }
        }

    });

    searchKeyEl.on("itemclick", function(e) {
        var item = e.item;
        var fullName = item.fullName || "";
        var mobile = item.mobile || "";
        var msg = fullName + "/" + mobile
        if (fullName && mobile) {
            searchNameEl.setValue(msg);
        }
        if (fullName && !mobile) {
            searchNameEl.setValue(fullName);
        }
        if (mobile && !fullName) {
            searchNameEl.setValue(mobile);
        }
        searchNameEl.setEnabled(false);
        searchNameEl.setVisible(true);
        var sk = document.getElementById("search_key");
        sk.style.display = "none";
        var billFormData = billForm.getData(true); //主表信息
        billFormData.guestId = item.id;
        billForm.setData(billFormData);
    });
});

function checkMsg(e) { //进行保存操作前进行验证
    var billFormData = billForm.getData(true); //主表信息
    var params = document.getElementById("caCalculation").contentWindow.getValue(); //购车信息
    if (params.isValid == false) {
        showMsg("购车信息填写有误，请检查后再保存", "W");
        return;
    }
    var caCalculationData = params.data;
    if (caCalculationData.saleType == "" || caCalculationData.saleType == null) {
        showMsg("请选择购车方式后再保存", "W");
        return;
    }
    if (e == 3 && billFormData.status != 0) {
        showMsg("请返单后再作废！", "W");
        return;
    }
    if (form.isValid() == false) {
        showMsg("交车信息有误，请检查后再保存！", "W");
        return;
    }
    if (e == 6 && billFormData.status != 2) {
        showMsg("当前工单尚未审核！", "W");
        return;
    }
    if (e == 6 && billFormData.isSubmitCar == 1) {
        showMsg("当前工单已交车！", "W");
        return;
    }
    save(e);
}

function submitCar() { //交车
    checkMsg(6);
}

function save(e) { //保存（主表信息+精品加装+购车信息+费用信息）
    var billFormData = billForm.getData(true); //主表信息
    if (e == 1 || e == 0) { //返单 待审  或者  反审  将费用全部状态修改为待审
        var newRow = { auditSign: 0 };
        updateGridMsg(costDetailGrid, newRow);
        updateGridMsg(costDetailGrid2, newRow);
    }
    if (e == 0) {
        if (billFormData.enterId != 0 && billFormData.enterId != "") {
            updateCheckEnter(billFormData.enterId);
        }
        billFormData.enterId = 0;
        billFormData.isSubmitCar = 0;
        billFormData.isSettle = 0;
    }
    var params = document.getElementById("caCalculation").contentWindow.getValue(); //购车信息
    var caCalculationData = params.data;
    var jpDetailGridAdd = jpDetailGrid.getChanges("added"); //精品加装
    var jpDetailGridEdit = jpDetailGrid.getChanges("modified");
    var jpDetailGridDel = jpDetailGrid.getChanges("removed");
    caCalculationData.billType = 2;
    var saleExtend = caCalculationData;
    billFormData.saleAdvisor = nui.get("saleAdvisorId").text;
    billFormData.status = e; //0 草稿 、1提交（待审）、2已审、3作废
    if (e == 6) {
        billFormData.status = 2;
        var formData = form.getData();
        billFormData.submitCarMen = formData.submitCarMen;
        billFormData.submitTrueDate = formData.submitTrueDate;
        billFormData.submitCarKeyQty = formData.submitCarKeyQty;
        billFormData.submitCarRemark = formData.submitCarRemark;
        billFormData.isSubmitCar = 1;
    }
    var addMsg = costDetailGrid.getChanges("added");
    var editMsg = costDetailGrid.getChanges("modified");
    var deleteMsg = costDetailGrid.getChanges("removed");
    var addMs2 = costDetailGrid2.getChanges("added");
    var editMsg2 = costDetailGrid2.getChanges("modified");
    var deleteMsg2 = costDetailGrid2.getChanges("removed");
    var addArr = addMsg.concat(addMs2);
    var editArr = editMsg.concat(editMsg2);
    var deleteArr = deleteMsg.concat(deleteMsg2);
    nui.ajax({
        url: baseUrl + "sales.save.saveSaleMainAll.biz.ext",
        data: {
            billFormData: billFormData,
            caCalculationData: caCalculationData,
            jpDetailGridAdd: jpDetailGridAdd,
            jpDetailGridEdit: jpDetailGridEdit,
            jpDetailGridDel: jpDetailGridDel,
            saleExtend: saleExtend,
            addArr: addArr,
            editArr: editArr,
            deleteArr: deleteArr
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                var serviceId = text.serviceId;
                document.getElementById("caCalculation").contentWindow.SetDataMsg(serviceId);
                searchSalesMain(serviceId);
                jpDetailGrid.load({ billType: 2, serviceId: serviceId });
                costDetailGrid.load({ serviceId: serviceId, type: 1 });
                costDetailGrid2.load({ serviceId: serviceId, type: 2 });
                showMsg(text.errMsg, "S");
            };
        }
    });
}

function setInitData(params) { //初始化
    if (params.typeMsg == 1) {
        nui.get("saveBtn").setVisible(true);
        nui.get("submitBtn").setVisible(true);
        nui.get("invalidBtn").setVisible(true);
        nui.get("submitCarBtn").setVisible(true);
    } else if (params.typeMsg == 2) {
        nui.get("audit").setVisible(true);
        document.getElementById("auditno").style.display = "";
        nui.get("selectBtn").setVisible(true);
    } else if (params.typeMsg == 3) {
        nui.get("case").setVisible(true);
        document.getElementById("caseno").style.display = "";
    }
    if (params.id) {
        searchSalesMain(params.id);
        jpDetailGrid.load({ billType: 2, serviceId: params.id });
        costDetailGrid.load({ serviceId: params.id, type: 1 });
        costDetailGrid2.load({ serviceId: params.id, type: 2 });
    } else {
        var date = new Date();
        nui.get("orderDate").setValue(date);
    }
}

function updateCheckEnter(enterId) { //返单 修改库存表车辆状态
    var data = {
        id: enterId,
        carStatus: 0
    };
    nui.ajax({
        url: baseUrl + "sales.save.updateCheckEnter.biz.ext",
        data: {
            data: data
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                showMsg(text.errMsg, "S");
            } else {
                showMsg(text.errMsg, "W");
            }
        }
    });
}

function checkCost(grid, value) { //费用信息  审核反审
    var row = grid.getSelected();
    var newRow = {
        auditSign: value
    };
    grid.updateRow(row, newRow);
}

/////////////////////////////////////////////////////////////////////////////////数据读取
function searchSalesMain(serviceId) { //查询主表信息
    var params = {
        id: serviceId
    };
    nui.ajax({
        url: baseUrl + "sales.search.searchSalesMain.biz.ext",
        data: {
            params: params
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                var data = text.data[0];
                billForm.setData(data);
                form.setData(data);
                $("#servieIdEl").html(data.serviceCode);

                document.getElementById("caCalculation").contentWindow.SetDataMsg(data.id, data.frameColorId, data.interialColorId); //查询购车计算表，如果购车计算表车身颜色和内饰颜色为空，则将主表信息赋值上去
                if (data.status != 0) {
                    nui.get("saveBtn").disable();
                    nui.get("submitBtn").disable();
                    setReadOnlyMsg();
                    setReadOnlySubmitCar(1);
                    document.getElementById("caCalculation").contentWindow.setReadOnlyMsg();
                    if (data.isSettle == 0) {
                        if (data.status == 1 || data.status == 2) {
                            costDetailGrid.showColumn("action");
                            costDetailGrid2.showColumn("action");
                        } else {
                            costDetailGrid.hideColumn("action");
                            costDetailGrid2.hideColumn("action");
                        }
                    }
                } else {
                    nui.get("saveBtn").enable();
                    setInputModel();
                    setReadOnlySubmitCar(0)
                    document.getElementById("caCalculation").contentWindow.setInputModel();
                }
                if (data.guestId) {
                    insuranceMsg(data.guestId)
                }
                if (data.isSubmitCar == 1) {
                    setReadOnlySubmitCar(1);
                } else {
                    if (data.status == 2 && data.isSettle == 0) { //已审未交车
                        setReadOnlySubmitCar(0);
                    } else {
                        setReadOnlySubmitCar(1);
                    }
                }
                var msg = (data.contactor || "") + "/" + (data.contactorTel || "");
                if (data.contactor && data.contactorTel) {
                    searchNameEl.setValue(msg);
                }
                if (!data.contactor && data.contactorTel) {
                    searchNameEl.setValue(data.contactorTel);
                }
                if (data.contactor && !data.contactorTel) {
                    searchNameEl.setValue(data.contactor);
                }
                searchNameEl.setEnabled(false);
                searchNameEl.setVisible(true);
                var sk = document.getElementById("search_key");
                sk.style.display = "none";
            };
        }
    });
}

function insuranceMsg(guestId) { //获取保险信息
    var params = { guestId: guestId };
    nui.ajax({
        url: baseUrl + "sales.search.searchInsuranceMsg.biz.ext",
        data: {
            params: params
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                var list = text.list[0];
                var data = text.data;
                detailGrid.setData(data);
                insuranceForm.setData(list);
            };
        }
    });
}
/////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////弹窗
function addGuest() { //新增客户资料
    nui.open({
        url: webPath + contextPath + "/sales/customer/addGuest.jsp?token=" + token,
        title: "新增客户资料",
        width: 900,
        height: 460,
        allowDrag: true,
        allowResize: true,
        onload: function() {
            var iframe = this.getIFrameEl();
            // iframe.contentWindow.setViewData(dock, dodelck, docck);
        },
        ondestroy: function(action) {


        }
    });
}

function selectCar() { //点击选车时触发
    var billFormData = billForm.getData(true);
    if (billFormData.isSettle == 1) {
        showMsg("当前订单已结算！", "W");
        return;
    }
    if (billFormData.status != 2) {
        showMsg("当前订单尚未审核！", "W");
        return;
    }
    nui.open({
        url: webPath + contextPath + "/sales/sales/selectCar.jsp?token=" + token,
        title: "选择库存车",
        width: "70%",
        height: "50%",
        onload: function() {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(billFormData.carModelId);
        },
        ondestroy: function(action) {
            if (action == "ok") {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getSelectedValue();
                var billFormData = billForm.getData(true); //主表信息
                var handcartAmt = data.receiveCost || 0; //运输成本
                var carCost = data.unitPrice || 0; //购买成本
                var enterId = data.id;
                billFormData.enterId = enterId;
                billForm.setData(billFormData);
                document.getElementById("caCalculation").contentWindow.setSelectCarValue(handcartAmt, carCost);
                save(2);
            }
        }
    });
}

function registration() { //车辆上牌
    var billFormData = billForm.getData(true); //主表信息
    nui.open({
        url: webPath + contextPath + "/sales/sales/vehicleRegistration.jsp?token=" + token,
        title: "车辆上牌",
        width: "550px",
        height: "490px",
        onload: function() {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(billFormData.id, billFormData.guestId, billFormData.guestFullName);
        },
        ondestroy: function(action) {

        }
    });
}

function caseMsg() { //销售结案审核
    var billFormData = billForm.getData(true); //主表信息
    nui.open({
        url: webPath + contextPath + "/sales/sales/salesReview.jsp?token=" + token,
        title: "销售结案审核",
        width: "880px",
        height: "700px",
        onload: function() {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(billFormData.id);
        },
        ondestroy: function(action) {

        }
    });
}

function salesOnPrint(p) {
    var billFormData = billForm.getData(true); //主表信息
    var url = webPath + contextPath;
    switch (p) {
        case 1:
            url = url + "/sales/sales/print/cashPurchases.jsp";
            break;
        case 2:
            url = url + "/sales/sales/print/printLoanDetail .jsp";
            break;
        case 3:
            url = url + "/sales/sales/print/printJCDetail.jsp";
            break;
        case 4:
            url = url + "/sales/sales/print/printSalesContract.jsp";
            break;
    }
    nui.open({
        url: url,
        title: "打印",
        width: "100%",
        height: "100%",
        onload: function() {
            var iframe = this.getIFrameEl();
            var serviceId = billFormData.id;
            if (p == 1) {
                var params = {
                    serviceId: serviceId,
                    billType: 2
                };
                iframe.contentWindow.SetData(params);
            } else {
                iframe.contentWindow.SetData(serviceId);
            }

        },
        ondestroy: function(action) {

        }
    });
}
/////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////表格控制/数据处理
function updateGridMsg(grid, newRow) { //更新表格数据   传表格对象grid  需要修改的内容newRow  用于无条件全表格更新数据
    var data = grid.getData();
    for (var i = 0, l = data.length; i < l; i++) {
        var row = grid.getRow(i);
        grid.updateRow(row, newRow);
    };
}

function setInputModel() { //恢复表格为输入模式
    var fields = billForm.getFields();
    for (var i = 0, l = fields.length; i < l; i++) {
        var c = fields[i];
        if (c.setReadOnly) c.setReadOnly(false);
    };
    jpGrid.setReadOnly(false);
    jpDetailGrid.setReadOnly(false);
    costGrid.setReadOnly(false);
}

function setReadOnlyMsg() { //设置表格信息为只读
    var fields = billForm.getFields();
    for (var i = 0, l = fields.length; i < l; i++) {
        var c = fields[i];
        if (c.setReadOnly) c.setReadOnly(true); //只读
        if (c.setIsValid) c.setIsValid(true); //去除错误提示
    };
    jpGrid.setReadOnly(true);
    jpDetailGrid.setReadOnly(true);
    costGrid.setReadOnly(true);
}

function setReadOnlySubmitCar(e) { //交车信息  编辑/只读
    if (e == 1) {
        var fields = form.getFields();
        for (var i = 0, l = fields.length; i < l; i++) {
            var c = fields[i];
            if (c.setReadOnly) c.setReadOnly(true); //只读
            if (c.setIsValid) c.setIsValid(true); //去除错误提示
        };
    } else {
        var fields = form.getFields();
        for (var i = 0, l = fields.length; i < l; i++) {
            var c = fields[i];
            if (c.setReadOnly) c.setReadOnly(false);
        };
    }
}

function onIsNotRenderer(e) {
    for (var i = 0, l = is_not.length; i < l; i++) {
        var g = is_not[i];
        if (g.id == e.value) return g.text;
    };
    return "";
}

function onCellCommitEdit(e) {
    var editor = e.editor;
    if (e.field == "qty" || e.field == "price" || e.field == "costAmt") {
        if (editor.isValid() == false) {
            showMsg("请输入数字!", "W");
            e.cancel = true;
        };
    };
}

function OnModelCellBeginEdit(e) {
    var field = e.field;
    var billFormData = billForm.getData(true); //主表信息
    if (field == "costAmt" || field == "remark") {
        if (billFormData.status != 0) {
            e.cancel = true;
        };
    };
};
//////////////////////////////////////////////////////////////////////////////////////////////////////////////