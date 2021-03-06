<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        table td {
            font-size: 12px;
            width: 200px;
            height: 30px;
            text-align: center;
            background-color: #4f891e;
            color: #ffffff;
        }
    </style>
</head>
<body>
<a download="table导出Excel" id="excelOut" href="#">table导出Excel</a>
<table cellspacing="0" cellpadding="0" border="1" id="tableToExcel">
    <thead>
    <tr>
        <td style="font-size: 18px">公司一</td>
        <td>公司二一</td>
        <td>公司三</td>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>A公司</td>
        <td>B公司</td>
        <td>C公司</td>
    </tr>
    <tr>
        <td>A公司</td>
        <td>B公司</td>
        <td>C公司</td>
    </tr>
    <tr>
        <td>A公司</td>
        <td>B公司</td>
        <td>C公司</td>
    </tr>
    <tr>
        <td colspan="3">共计</td>
    </tr>
    </tbody>
</table>
<script>
    window.onload = function () {
        tableToExcel('tableToExcel', '下载模板')
    };
    //base64转码
    var base64 = function (s) {
        return window.btoa(unescape(encodeURIComponent(s)));
    };
    //替换table数据和worksheet名字
    var format = function (s, c) {
        return s.replace(/{(\w+)}/g,
            function (m, p) {
                return c[p];
            });
    }
    function tableToExcel(tableid, sheetName) {
        var uri = 'data:application/vnd.ms-excel;base64,';
        var template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel"' +
            'xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>'
            + '<x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets>'
            + '</x:ExcelWorkbook></xml><![endif]-->' +
            ' <style type="text/css">' +
            'table td {' +
            'border: 1px solid #000000;' +
            'width: 200px;' +
            'height: 30px;' +
            ' text-align: center;' +
            'background-color: #4f891e;' +
            'color: #ffffff;' +
            ' }' +
            '</style>' +
            '</head><body ><table class="excelTable">{table}</table></body></html>';
        if (!tableid.nodeType) tableid = document.getElementById(tableid);
        var ctx = {worksheet: sheetName || 'Worksheet', table: tableid.innerHTML};
        document.getElementById("excelOut").href = uri + base64(format(template, ctx));
    }

</script>
</body>
</html>

完整代码