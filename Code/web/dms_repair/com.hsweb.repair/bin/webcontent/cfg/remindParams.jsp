<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:12:35
  - Description:
-->
<head>
<title>提醒设置</title>
<script src="<%=webPath + contextPath%>/repair/cfg/js/remindParams.js?v=1.0.3"></script>
<style type="text/css">
.title {
	text-align: right;
	display: inline-block;
}

.title-width1 {
	width: 75px;
}

.title-width2 {
	width: 90px;
}
.left{
    text-align: left;
}
.right{
    text-align: right;
}  
.fwidtha{
    width: 60px;
}
.fwidthb{
    width: 60px;
}
.htr{
    height: 20px;
}
/* .mainwidth{
    width: 700px;
} */
.tmargin{
    margin-top: 10px;
    margin-left: 70px;
    margin-bottom: 10px;
    font-size: 14px;
    border-spacing: 0px 10px;
}

.vpanel{
    border:0px solid #d9dee9;
    margin:0px 0px 0px 0px;
    height:248px;
    float:left;
}
.vpanel_heading{
    border-bottom:1px solid #d9dee9;
    width:100%;
    height:28px;
    line-height:28px;
}
.vpanel_heading span{
    margin:0 0 0 20px;
    font-size:8px;
    font-weight:normal;
}
.vpanel_bodyww{
    padding : 10 10 10 10px !important

}

.required {
    color: red;
}

.tbtext{
    text-align: right;
    width: 200px;
}

</style>
</head>
<body>


        <div>
            <div id="editForm" class="form">
                    <input id="orgid" name="orgid" width="100%" class="nui-hidden" >
                    <input class="nui-hidden" name="id"/>
                    <table class="tmargin" width="100%">
                        <tr class="htr">
                            <td class="tbtext ">距离车辆下次保养日期</td>
                            <td >
                                <input name="param1" class="nui-spinner" width="50px" format="0" 
                                    id="param1" maxValue="999999" showButton="false"/>天提醒
                            </td>
                        </tr>
                        <!--<tr class="htr">
                            <td class="tbtext ">车辆保养周期</td>
                            <td >
                                <input name="param2" class="nui-spinner" width="50px" format="0" 
                                    id="param2" maxValue="999999" showButton="false"/>天提醒
                            </td>
                        </tr>-->
                        <tr class="htr">
                            <td class="tbtext ">距离车辆商业险到期日期</td>
                            <td >
                                <input name="param3" class="nui-spinner" width="50px" format="0" 
                                    id="param3" maxValue="999999" showButton="false"/>天提醒
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext ">距离车辆交强险到期日期</td>
                            <td >
                                <input name="param11" class="nui-spinner" width="50px" format="0" 
                                    id="param11" maxValue="999999" showButton="false"/>天提醒
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext ">距离驾照年审日期</td>
                            <td >
                                <input name="param4" class="nui-spinner" width="50px" format="0" 
                                    id="param4" maxValue="999999" showButton="false"/>天提醒
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext ">距离车辆年检日期</td>
                            <td >
                                <input name="param5" class="nui-spinner" width="50px" format="0" 
                                    id="param5" maxValue="999999" showButton="false"/>天提醒
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext ">距离卡到期日期</td>
                            <td >
                                <input name="param6" class="nui-spinner" width="50px" format="0" 
                                    id="param6" maxValue="999999" showButton="false"/>天提醒
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext ">距离客户生日日期</td>
                            <td >
                                <input name="param7" class="nui-spinner" width="50px" format="0" 
                                    id="param7" maxValue="999999" showButton="false"/>天提醒
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext ">距离员工生日日期</td>
                            <td >
                                <input name="param8" class="nui-spinner" width="50px" format="0" 
                                    id="param8" maxValue="999999" showButton="false"/>天提醒
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext ">当客户连续</td>
                            <td >
                                <input name="param9" class="nui-spinner" width="50px" format="0" 
                                    id="param9" maxValue="999999" showButton="false"/>天未到店服务则视为流失客户
                            </td>
                        </tr>
                        <tr class="htr">
                            <td class="tbtext ">距离采购订单到货时间</td>
                            <td >
                                <input name="param10" class="nui-spinner" width="50px" format="0" 
                                    id="param10" maxValue="999999" showButton="false"/>小时提醒
                            </td>
                        </tr>
                        <tr>
                            <td class="tbtext">
                                    <a class="nui-button" onclick="onOk"   plain="false" >保存</a>
                            </td>
                        </tr>
                    </table>
    
              </div>
        </div>
        
 
</body>
</html>
