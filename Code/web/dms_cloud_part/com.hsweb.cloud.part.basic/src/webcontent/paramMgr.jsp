<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-02-20 16:36:58
  - Description:
-->
<head>
<title>参数设置</title>
    <script src="<%=webPath + contextPath%>/basic/js/paramMgr.js?v=1.0.12"></script>
    
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

</style>
    
</head>
<body>
	<div id="basicInfoForm" class="form" contenteditable="false" >
        <table class="table" id="table1">
        	<tr>
                <td class="tbCtrl" >
                    <a class="nui-button" onclick="save()"   plain="false" >保存</a>
                </td>
            </tr> 
        	<tr>
                <td class="tbtext">销售单、销售出库配件选择tab切换成批次选择：</td>
                <td class="tbCtrl" >
                    <div id="swithBatchFlag" name="swithBatchFlag" 
                        class="nui-radiobuttonlist" value="" repeatItems="2" 
                        repeatDirection="" repeatLayout="table" 
                        textField="text" valueField="id" ></div>
                </td>      
            </tr> 
            <tr>
                <td class="tbtext">打印抬头显示：</td>
                <td class="tbCtrl" >
                    <input id="repairSettorderPrintShow" name="repairSettorderPrintShow" class="nui-textbox" >
                </td>
            </tr>
            <tr>
                <td class="tbtext">销售单、销售出库单打印内容：</td>
                <td class="tbCtrl" >
                    <input id="cloudSellOrderPrintContent" name="cloudSellOrderPrintContent" class="nui-textarea"   style="height:100px;width:300px">
                </td>
            </tr>    
              
        </table>
    </div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>