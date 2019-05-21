var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + saleApi + "/";
var billForm = null;
var jpGrid = null;
var jpUrl = baseUrl + "sales.search.searchCsbGiftMsg.biz.ext";
var jpDetailGrid = null;
$(document).ready(function(v) {
    document.getElementById("caCalculation").src = webBaseUrl + "sales/sales/caCalculation.jsp";
    billForm = new nui.Form("#billForm");
    jpGrid = nui.get("jpGrid");
    jpGrid.setUrl(jpUrl);
    jpDetailGrid = nui.get("jpDetailGrid");

    jpGrid.on("rowclick", function(e) {
        var jpdata = jpGrid.getSelecteds();
        var jpDetailData = jpDetailGrid.getData();
        for (var i = 0, l = jpdata.length; i < l; i++) {
            var msg = jpDetailData.find(jpDetailData => jpDetailData.giftId == jpdata[i].id);
            if (!msg) {
                var newRow = {
                    giftId: jpdata[i].id,
                    giftName: jpdata[i].name
                };
                jpDetailGrid.addRow(newRow, jpDetailData.length);
            }
        }
        jpDetailData = jpDetailGrid.getData();
        if (jpDetailData.length != jpdata.length) {
            for (var i = 0, l = jpDetailData.length; i < l; i++) {
                var row = jpDetailGrid.getRow(i);
                var msg = jpdata.find(jpdata => jpdata.id == jpDetailData[i].giftId);
                if (!msg) {
                    jpDetailGrid.commitEdit();
                    jpDetailGrid.removeRow(row, false);
                }
            }
        }
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

function save() { //保存（主表信息+精品加装+购车信息+费用信息）
    var billFormData = billForm.getData(); //主表信息
    var caCalculation = document.getElementById("caCalculation").contentWindow.getValue(); //购车信息
    var jpDetailGridAdd = jpDetailGrid.getChanges("added");
    var jpDetailGridEdit = jpDetailGrid.getChanges("modified");
    var jpDetailGridDel = jpDetailGrid.getChanges("removed");
    nui.ajax({
        url: "com.hs.annual_project.saveAll.disable.biz.ext",
        data: {
            billFormData: billFormData,
            caCalculation: caCalculation,
            jpDetailGridAdd: jpDetailGridAdd,
            jpDetailGridEdit: jpDetailGridEdit,
            jpDetailGridDel: jpDetailGridDel
        },
        cache: false,
        async: false,
        success: function(text) {

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
        nui.get("jsBtn").setVisible(true);
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
    }
    jpGrid.load();
}