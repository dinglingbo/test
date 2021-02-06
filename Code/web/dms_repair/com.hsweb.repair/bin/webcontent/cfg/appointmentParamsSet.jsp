<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:05:48
  - Description:
-->
<head>
<title>预约设置</title>
<script src="<%=webPath + contextPath%>/repair/cfg/js/appointmentParamsSet.js?v=1.0.5"></script>
<link href="<%=webPath + contextPath%>/repair/cfg/css/appoint.css" rel="stylesheet"	type="text/css" />
<style type="text/css">
.table-label {
	text-align: right;
}

.title {
   width: 60px;
   text-align: right;
}

.form_label {
   width: 72px;
   text-align: right;
}

.required {
   color: red;
}

.rmenu {
  font-size: 14px;
  /* font-weight: bold; */
  text-align: left;
  margin: 0;
  padding-left: 25px;
  height: 18px;
  color: #fff;
  width: auto;
  margin-left: 20px;
  margin-top: 20px;
  background-size: 50%;
}

.tbtext{
  text-align: right;
  line-height: 40px;
  width: 20%;
}
.tbitext{
  text-align: right;
  line-height: 40px;
}
.spTag{
    float: right;
    margin-right: 20%;
}


</style>
</head>
<body>

<div id="mainTabs" class="nui-tabs" 
     activeIndex="0" 
     style="width:100%; height: 100%;" 
     plain="false" 
     onactivechanged="showInfo"
     ontabload=""
     >
    <div title="预约时间" name="timeTab" url="" >
        <%@include file="/repair/cfg/appointmentContainTimes.jsp" %>
    </div>
    <div title="预约工位" name="stationTab" url="" >
        <%@include file="/repair/cfg/appointmentContainStation.jsp" %>
    </div>  
    <div title="预约通知" name="noticeTab" url="" >
        <%@include file="/repair/cfg/appointmentContainNotice.jsp" %>
    </div>  

</div>

<div id="advancedDeductWin" class="nui-window"
     title="预约优惠设置" style="width:280px;height:150px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedAddForm" class="form">
        <table style="width:100%;" style="border-collapse:separate; border-spacing:0px 10px;margin-top: 20px;" >
            <tr>
                <td class="required" style="text-align: right">预约时间</td>
                <td id="timeIdEdit">09:00</td>
            </tr>
            <tr>
                <td class="required" style="text-align: right">项目折扣</td>
                <td >
                    <input class="nui-spinner" minValue="0" maxValue="100" id="prdtRateEdit"
                        showButton="false" format="0"  changeOnMousewheel="true" >&nbsp;&nbsp;%
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="advancedDeductOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="advancedDeductCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>
</body>
</html>
