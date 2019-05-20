var webBaseUrl = webPath + contextPath + "/";
var billForm = null;
$(document).ready(function(v) {
    document.getElementById("caCalculation").src = webBaseUrl + "sales/sales/caCalculation.jsp";
    billForm = new nui.Form("#billForm");
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

function save() {
    var billFormData = billForm.getData();
    var caCalculation = document.getElementById("caCalculation").contentWindow.getValue();

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
}