var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + saleApi + "/";
var billForm = null;
var jpGrid = null;
var jpUrl = baseUrl + "sales.search.searchCsbGiftMsg.biz.ext";
var jpDetailGrid = null;
var jpDetailGridUrl = baseUrl + "sales.search.searchSaleGiftApply.biz.ext";
var queryUrl = baseUrl + "com.hsapi.frm.frmService.crud.queryFibInComeExpenses.biz.ext";
var costGrid = null;
var costDetailGrid = null;
var costDetailGrid2 = null;
$(document).ready(function(v) {
    document.getElementById("caCalculation").src = webBaseUrl + "sales/sales/caCalculation.jsp";
    billForm = new nui.Form("#billForm");
    jpGrid = nui.get("jpGrid");
    jpGrid.setUrl(jpUrl);

    jpDetailGrid = nui.get("jpDetailGrid");
    jpDetailGrid.setUrl(jpDetailGridUrl);

    costGrid = nui.get("costGrid");
    costGrid.setUrl(queryUrl);
    costGrid.load();

    costDetailGrid = nui.get("costDetailGrid");
    costDetailGrid2 = nui.get("costDetailGrid2");

    jpGrid.load();
    jpGrid.on("rowclick", function(e) {
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
            }
        }
        jpDetailData = jpDetailGrid.getData();
        for (var i = 0, l = jpDetailData.length; i < l; i++) {
            var row = jpDetailGrid.getRow(i);
            var msg = jpdata.find(jpdata => jpdata.id == jpDetailData[i].giftId);
            if (!msg) {
                jpDetailGrid.commitEdit();
                jpDetailGrid.removeRow(row, false);
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
                }
            }
        }
    });

    costGrid.on("load", function(e) {
        var data = costGrid.getData();
        for (var i = data.length - 1, l = -1; i > l; i--) {
            var row = costGrid.getRow(i);
            if (!row.parentId) {
                costGrid.commitEdit();
                costGrid.removeRow(row, false);
            }
        }
    });
    jpGrid.on("rowclick", function(e) {
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
            }
        }
        jpDetailData = jpDetailGrid.getData();
        for (var i = 0, l = jpDetailData.length; i < l; i++) {
            var row = jpDetailGrid.getRow(i);
            var msg = jpdata.find(jpdata => jpdata.id == jpDetailData[i].giftId);
            if (!msg) {
                jpDetailGrid.commitEdit();
                jpDetailGrid.removeRow(row, false);
            }
        }
    });

    costGrid.on("rowclick", function(e) {
        var data = costGrid.getSelecteds();
        var data1 = costDetailGrid.getData();
        var data2 = costDetailGrid2.getData();
        for (var i = 0, l = data.length; i < l; i++) {
            var newRow = {
                costName: data[i].name,
                costId: data[i].id
            };
            if (data[i].itemTypeId == -1) {
                var msg = data1.find(data1 => data1.costId == data[i].id);
                if (!msg) {
                    costDetailGrid.addRow(newRow, costDetailGrid.length);
                }
            } else if (data[i].itemTypeId == 1) {
                var msg = data2.find(data2 => data2.costId == data[i].id);
                if (!msg) {
                    costDetailGrid2.addRow(newRow, costDetailGrid2.length);
                }
            }
        }
        data1 = costDetailGrid.getData();
        for (var i = 0, l = data1.length; i < l; i++) {
            var row = costDetailGrid.getRow(i);
            var msg = data.find(data => data.id == data1[i].costId);
            if (!msg) {
                costDetailGrid.commitEdit();
                costDetailGrid.removeRow(row, false);
            }
        }
        data2 = costDetailGrid2.getData();
        for (var i = 0, l = data2.length; i < l; i++) {
            var row = costDetailGrid2.getRow(i);
            var msg = data.find(data => data.id == data2[i].costId);
            if (!msg) {
                costDetailGrid2.commitEdit();
                costDetailGrid2.removeRow(row, false);
            }
        }
    });

    var dictDefs = { "billTypeId": "DDT20130703000008" };
    initDicts(dictDefs, function() {});

    initMember("saleAdvisorId", function() {
        nui.get("saleAdvisorId").setValue(currEmpId);
        nui.get("saleAdvisorId").setText(currUserName);
    });

});

function registration() {
    nui.open({
        url: webPath + contextPath + "/sales/sales/vehicleRegistration.jsp?token=" + token,
        title: "车辆上牌",
        width: "880px",
        height: "290px",
        onload: function() {
            var iframe = this.getIFrameEl();
        },
        ondestroy: function(action) {

        }
    });
}

function save(e) { //保存（主表信息+精品加装+购车信息+费用信息）
    var billFormData = billForm.getData(true); //主表信息
    var caCalculationData = document.getElementById("caCalculation").contentWindow.getValue(); //购车信息
    var jpDetailGridAdd = jpDetailGrid.getChanges("added"); //精品加装
    var jpDetailGridEdit = jpDetailGrid.getChanges("modified");
    var jpDetailGridDel = jpDetailGrid.getChanges("removed");
    caCalculationData.billType = 2;
    caCalculationData.saleType = 1;
    var saleExtend = caCalculationData;
    billFormData.saleAdvisor = nui.get("saleAdvisorId").text;
    if (e) { //0 草稿 、1提交（待审）、2已审、3作废
        billFormData.status = e;
    }
    nui.ajax({
        url: baseUrl + "sales.save.saveSaleMain.biz.ext",
        data: {
            billFormData: billFormData,
            caCalculationData: caCalculationData,
            jpDetailGridAdd: jpDetailGridAdd,
            jpDetailGridEdit: jpDetailGridEdit,
            jpDetailGridDel: jpDetailGridDel,
            saleExtend: saleExtend
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                var serviceId = text.serviceId;
                document.getElementById("caCalculation").contentWindow.SetDataMsg(serviceId);
                searchSalesMain(serviceId);
                jpDetailGrid.load({ billType: 2, serviceId: serviceId });
            }
        }
    });
}

function caseMsg() {
    nui.open({
        url: webPath + contextPath + "/sales/sales/salesReview.jsp?token=" + token,
        title: "销售结案审核",
        width: "880px",
        height: "700px",
        onload: function() {
            var iframe = this.getIFrameEl();
        },
        ondestroy: function(action) {

        }
    });
}

function setInitData(params) {
    if (params.typeMsg == 1) {
        nui.get("saveBtn").setVisible(true);
        nui.get("submitBtn").setVisible(true);
        nui.get("invalidBtn").setVisible(true);
        nui.get("selectBtn").setVisible(true);
        document.getElementById("unfinishBtn").style.display = "";
    } else if (params.typeMsg == 2) {
        nui.get("audit").setVisible(true);
        document.getElementById("auditno").style.display = "";
    } else if (params.typeMsg == 3) {
        nui.get("case").setVisible(true);
        document.getElementById("caseno").style.display = "";
    }
    if (params.id) {
        document.getElementById("caCalculation").contentWindow.SetDataMsg(params.id);
        searchSalesMain(params.id);
        jpDetailGrid.load({ billType: 2, serviceId: params.id });
    }
}


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
                var data = text.data;
                billForm.setData(data[0]);
                document.getElementById("serviceCode").innerHTML = data[0].serviceCode;
            }
        }
    });
}