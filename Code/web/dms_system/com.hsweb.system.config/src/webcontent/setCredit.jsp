<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
  <title>积分设置</title>
  <script src="<%=webPath + contextPath%>/config/js/comParamsSet1.js?v=1.0.7"></script>
  <style type="text/css">

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
	}
	.tbtext2 {
    line-height:0px;
}
	.tbtext3 {
    line-height:80px;
}

</style>

</head>
<body>

    <div id="basicInfoForm" class="form" contenteditable="false" >
        <table class="table" id="table1"> 
            <!-- <tr>
                <td class="tbtext">综合服务单流程控制：</td>
                <td class="tbCtrl" >
                    <div id="repairBillControlFlag" name="repairBillControlFlag" 
                         class="nui-radiobuttonlist" value="" repeatItems="2" 
                         repeatDirection="" repeatLayout="table" 
                         textField="text" valueField="id" ></div>
                </td>      
            </tr> -->
           <tr>
                <td class="tbtext">消费奖励：</td>
                <td class="tbCtrl" >
                    <input id="repairSettorderPrintShowT" name="repairSettorderPrintShowT" class="nui-textbox" >
                </td>
            </tr>
            <tr>
            	<td></td>
            	<td class="tbtext2" >消费几元奖励1积分，为0不奖励(可设小数)</td>
            </tr>
            <tr>
                <td class="tbtext">预约奖励：</td>
                <td class="tbCtrl" >
                    <input id="repairSettorderPrintShowT" name="repairSettorderPrintShowT" class="nui-textbox" >
                </td>
            </tr>
            <tr>
            	<td></td>
            	<td class="tbtext2" >预约并成功消费1次的奖励积分，为0不奖励</td>
            </tr>
            <tr>
                <td class="tbtext">消费评论奖励：</td>
                <td class="tbCtrl" >
                    <input id="repairSettorderPrintShowT" name="repairSettorderPrintShowT" class="nui-textbox" >
                </td>
            </tr>
            <tr>
            	<td></td>
            	<td class="tbtext2" >成功消费1次后并评论的积分奖励，评价内容超过10个字才会有奖励，系统自动奖励，为0不奖励</td>
            </tr>
             <tr>
                <td class="tbtext">首次绑定奖励：</td>
                <td class="tbCtrl" >
                    <input id="repairSettorderPrintShowT" name="repairSettorderPrintShowT" class="nui-textbox" >
                </td>
            </tr>
            <tr>
            	<td></td>
            	<td class="tbtext2" >首次绑定奖励，系统自动奖励，为0不奖励</td>
            </tr>
            <tr>
                <td class="tbtext">每日分享奖励：</td>
                <td class="tbCtrl" >
                    <input id="repairSettorderPrintShowT" name="repairSettorderPrintShowT" class="nui-textbox" >
                </td>
            </tr>
            <tr>
            	<td></td>
            	<td class="tbtext2" >分享手机端任一页面，每天只奖励一次</td>
            </tr>
           <tr>
                <td class="tbtext">项目、配件默认积分比：</td>
                <td class="tbCtrl" >
                    <input id="repairSettorderPrintShowT" name="repairSettorderPrintShowT" class="nui-textbox" >
                </td>
            </tr>
            <tr>
            	<td></td>
            	<td class="tbtext2" >例：默认0，新增项目、配件时应用</td>
            </tr>
           <tr>
                <td class="tbtext">积分重命名：</td>
                <td class="tbCtrl" >
                    <input id="repairSettorderPrintShowT" name="repairSettorderPrintShowT" class="nui-textbox" >
                </td>
            </tr>
            <tr>
            	<td></td>
            	<td class="tbtext2" >将积分再换个名字，比如X币，只对车主手机端有效</td>
            </tr>
            
            <tr>
                <td class="tbtext">微信支付积分增长比：</td>
                <td class="tbCtrl" >
                    <input id="repairSettorderPrintShowT" name="repairSettorderPrintShowT" class="nui-textbox" >
                </td>
            </tr>
            <tr>
            	<td></td>
            	<td class="tbtext2" >例：若使用微信支付，则结算积分奖励按此比例增加</td>
            </tr>
           
           <tr>
                <td class="tbtext">无等级客户享受积分奖励：</td>
                <td class="tbCtrl" >
                     <input id="repairSettorderPrintShowT" name="repairSettorderPrintShowT" class="nui-textbox" >
                </td>
            </tr>
            <tr>
            	<td></td>
            	<td class="tbtext2" >开启后，未设置客户等级的客户结算时默认有奖励积分</td>
            </tr>
            <tr>
            
                <td class="tbtext3"></td>
                <td class="tbCtrl" >
                   </br>
                    <a class="nui-button" onclick="save()"   plain="false" >保存</a>
                </td>
            </tr>
        </table>
    </div>

<script type="text/javascript">
   nui.parse();

</script>
</body>
</html>