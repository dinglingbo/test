<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-23 11:08:45
  - Description:
-->
<head>
    <title>datumMgr_noImportList</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
        <script src="<%=webPath + contextPath%>/common/nui/xlsx.core.min.js?v=2.0.0"></script>
</head>
<body>

    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
               <a class="nui-button" id="cancel" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
           </td>
       </tr>
   </table>
</div>

<div class="nui-fit">
    <div title="" class="nui-panel" showHeader="false" showFooter="false" style="width:100%;height:100%;border: 0;">
        <div id="dgGrid" class="nui-datagrid" style="width:100%;height:100%;" showPager="true" totalField="page.count" pageSize="50" sizeList=[20,50,100] selectOnLoad="true" ondrawcell="" onrowdblclick="" dataField="data" sortMode="client" idField="id" multiSelect="true" allowCellWrap = true showSummaryRow="true">
            <div property="columns">
                <div type="checkcolumn" width="25"></div>
                <div type="indexcolumn" width="30" summaryType="count">
                    序号
                </div>
                <div headerAlign="center">
                    <strong>
                        车辆信息
                    </strong>
                    <div property="columns">
                        <div field="id" visible=false>
                            ID
                        </div>
                        <div field="orgid" width="120" headerAlign="center" allowSort=false>
                            所在分店
                        </div>
                        <div field="carNo" width="90" headerAlign="center" allowSort=false>
                            车牌号
                        </div>
                        <div field="carBrandId" width="100" headerAlign="center" allowSort=false>
                            品牌
                        </div>
                        <div field="carModel" width="250" headerAlign="center" allowSort=false>
                            品牌车型
                        </div>
                        <div field="vin" width="160" headerAlign="center" allowSort=false>
                            车架号(VIN)
                        </div>
                        <div field="engineNo" width="160" headerAlign="center" allowSort=false>
                            发动机号
                        </div>
                        <div field="color" width="160" headerAlign="center" allowSort=false>
                            颜色
                        </div>
                        <div field="firstRegDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort=false>
                            初登日期
                        </div>
                        <div field="annualInspectionDate" width="100" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort=false>
                            保险到期
                        </div>
                        <div field="recorder" width="80" headerAlign="center" allowSort=false>
                            建档人
                        </div>
                        <div field="recordDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort=false>
                            建档日期
                        </div>
                    </div>
                </div>
                <div headerAlign="center">
                    <strong>
                        客户信息
                    </strong>
                    <div property="columns">
                        <div field="guestId" visible=false>
                            客户ID
                        </div>
                        <div field="guestName" width="80" headerAlign="center" summaryType="" allowSort=false>
                            客户名称
                        </div>
                        <div field="mobile" width="100" headerAlign="center" summaryType="" allowSort=false>
                            联系电话
                        </div>
                        <div field="contacts" width="80" headerAlign="center" summaryType="" allowSort=false>
                            联系人
                        </div>
                        <div field="tel" width="80" headerAlign="center" summaryType="" allowSort=false>
                            电话
                        </div>
                        <div field="sex" width="80" headerAlign="center" summaryType="" allowSort=false>
                            性别
                        </div>
                        <div field="address" width="150" headerAlign="center" summaryType="" allowSort=false>
                            地址
                        </div>
                    </div>
                </div>
                <div headerAlign="center">
                    <strong>
                        联系状态
                    </strong>
                    <div property="columns">
                        <div field="visitManId" id="visitManId" name="visitManId" width="60" headerAlign="center" summaryType="" allowSort=false>
                            营销员
                        </div>
                        <div field="visitStatus" width="100" headerAlign="center" summaryType="" allowSort=false>
                            跟踪状态
                        </div>
                        <div field="priorScoutDate" width="150" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort=false>
                            上次联系时间
                        </div>
                        <div field="nextScoutDate" width="150" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort=false>
                            下次联系时间
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
 nui.parse();
 var dgGrid = nui.get("dgGrid");

 function setData(list){
    dgGrid.setData(list);
}


nui.get("cancel").focus();
document.onkeyup=function(event){
var e=event||window.event;
var keyCode=e.keyCode||e.which;//38向上 40向下

if((keyCode==27)) { //ESC
onCancel();
}
};


function onCancel() {
    CloseWindow("cancel");
}

function CloseWindow(action){
    if (window.CloseOwnerWindow) 
        return window.CloseOwnerWindow(action);
    else 
        window.close();
}

</script>
</body>
</html>