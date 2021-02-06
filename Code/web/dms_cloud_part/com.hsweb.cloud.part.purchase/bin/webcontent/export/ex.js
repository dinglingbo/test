$(document).ready(function(v) {
    setInitData();

    method5('tableExcel',"采购订单",'tableExportA');
});
function setInitData(){
    var tds = '<td  colspan="1" align="center">[id]</td>' +
        "<td  colspan='3' align='center'>[name]</td>" +
        "<td  colspan='3' align='left'>[targerContent]</td>";
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < 10; i++) {
        var tr = $("<tr></tr>");
        tr.append(tds);
        tableExportContent.append(tr);
    }
}
