<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>

<html>

<head>
    <title>系统参数</title>
    <script src="<%=webPath + contextPath%>/config/js/sellCarParamMgr.js?v=1.0.3"></script>
</head>

<body>
    <div class="nui-fit">
        <div id="mainTabs" class="nui-tabs" name="mainTabs" activeIndex="0" style="width:100%; height:100%;"
            plain="false" tabPosition="left">
            <div title="购车用途" id="buyCarUser" name="buyCarUser" url=""></div>
            <div title="信息来源" id="infoSourceTab" name="infoSourceTab" url=""></div>
            <div title="意向级别" id="purposeTypeTab" name="purposeTypeTab" url=""></div>
            <div title="来访方式" id="visitorsTab" name="visitorsTab" url=""></div>
            <div title="关注重点" id="focusTab" name="focusTab" url=""></div>
            <div title="车身颜色" id="" name="carOutcolor" url=""></div>
            <div title="内饰颜色" id="" name="carIncolor" url=""></div>
            <div title="车型级别" id="" name="carLevel" url=""></div>
            <div title="车型国别" id="" name="carCountry" url=""></div>
            <div title="车型结构" id="" name="structure" url=""></div>
            <div title="能源" id="" name="useType" url=""></div>
            <div title="座位数" id="" name="sittingNum" url=""></div>
            <div title="排量" id="" name="displacement" url=""></div> 
            <div title="进气形式" id="" name="intakeType" url=""></div>
            <div title="驱动方式" id="" name="driveType" url=""></div>
            <div title="变速箱形式" id="" name="changeSpeed" url=""></div>
            <div title="生产方式" id="" name="proType" url=""></div>
        </div>
    </div>
</body>

</html>