<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-26 10:19:12
  - Description:
-->
<head>
    <title>跟踪历史</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
</head>
<body>
    <input name="scoutMode"id="scoutMode"class="nui-combobox" visible="false" textField="name"valueField="customid"/>
    <input name="scoutResult"id="scoutResult"class="nui-combobox" visible="false" textField="text"
    valueField="value" data="const_enabled_communicate"/>
    <div class="nui-fit" >   
        <div id="dgScoutDetail" class="nui-datagrid"
        allowCellEdit="false" allowCellSelect="true"
        style="width:100%;height:100%;"
        url="<%=webPath + contextPath%>/com.hs.common.unify.intfc.biz.ext"
        dataField="result"
        showColumns="true"
        allowcellwrap="true"
        showPager="true"
        totalField="page.count">
        <div property="columns">
            <div field="visitMan" headerAlign="center" width="50px" align="center">跟踪员</div>
            <div field="visitDate" headerAlign="center" dateFormat="yyyy-MM-dd hh:MM" width="80px" align="center">跟踪日期</div>
            <div field="scoutResult" headerAlign="center" width="50px" align="center">跟踪结果</div>
            <div field="scoutMode" headerAlign="center" width="50px" align="center">跟踪方式</div>
            <div field="scoutContent" headerAlign="center" width="150px" align="center">跟踪内容</div>
        </div>
    </div>
</div> 


<script type="text/javascript">
    nui.parse();
    var dgScoutDetail = nui.get("dgScoutDetail");

    initDicts({
        scoutMode: "DDT20130703000021"//跟踪方式
    });

nui.get("dgScoutDetail").focus();
document.onkeyup=function(event){
var e=event||window.event;
var keyCode=e.keyCode||e.which;//38向上 40向下

if((keyCode==27)) { //ESC
onClose();
}
};

    dgScoutDetail.on("drawcell", function (e) { //表格绘制
        var field = e.field;
        if(field == "scoutResult"){//跟踪结果
            e.cellHtml = setColVal('scoutResult', 'value', 'text', e.value);
        }else if(field == "scoutMode"){//跟踪方式
            e.cellHtml = setColVal('scoutMode', 'customid', 'name', e.value);
        }
    });


    function setData(data) {
        var params = {
            "p":{ 
                "def":{
                    "ds":"DB10_MYSQL_WB_CRM", //数据源 必填
                    "url":"com.hsapi.crm.data.crmTelsales.allTrackDetail",  //命名SQL路径 必填
                    "page":true
                },
                "orgid": currOrgId,
                "guestId": data.guestId
            },
            token:token
        };
        dgScoutDetail.load(params);
    }



function CloseWindow(action) {
if (action == "close") {
} else if (window.CloseOwnerWindow)
return window.CloseOwnerWindow(action);
else
return window.close();
}

function onClose(){
window.CloseOwnerWindow(); 
}
</script>
</body>
</html>