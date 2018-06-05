<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-05-04 14:17:55
  - Description:
-->
<head>    
    <title>产品管理-弹出窗</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
       <%@include file="/common/sysCommon.jsp"%>
    <style type="text/css">
    html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
    }

    .mini-grid-headerCell, .mini-grid-topRightCell
    {
        font-weight:bold;
    }
    .mini-panel-border {
        border-radius: 0px;
    }
    .tbtext{
        width: 100px;
        text-align: right;
    }
</style>
</head>
<body>

    <div id="form1"  style="width:630px;height:auto;margin-top:15px;margin-left:auto; margin-right:auto;" class="nui-form" >
        <table style="margin-top:15px;left:0;right:0;margin:0 auto;"> 
            <tr> 
                <td class="tbtext">产品名称：</td>
                <td><input class="nui-textbox" style="width: 150px;" name="name"/></td>
                <td class="tbtext">产品类型：</td>
                <td><input class="nui-textbox" style="width: 150px;" name="type"></td>
                <td style="width: 100px;"></td>
                <td><input class="nui-textbox" style="width: 150px;" name="id" visible="false"/></td>
            </tr>
            <tr> 
                <td class="tbtext">产品描述：</td>
                <td colspan="3"><input class="nui-textbox" style="width:100%" name="remark"/></td>

            </tr>
            <tr>
                <td class="tbtext">是否限定周期：</td>
                <td colspan="3"><input   name="isCycle"  id="isCycle" class="nui-combobox" style="width:100%" data="isTrue" idFeild="id" textFeild="text" onvaluechanged="isLimitedCycleChanged"/></td>
            </tr>      
            <tr>
                <td class="tbtext">产品限定周期：</td>
                <td><input name="cycle" class="nui-textbox" id="cycle" style="width: 150px;" enabled="false"/></td>
                <td class="tbtext">周期消费次数：</td>
                <td><input name="consumptionTimes"  id="consumptionTimes" class="nui-textbox" style="width: 150px;"  enabled="false"/></td>
            </tr>
 
            <tr>
                <td class="tbtext">原价：</td>
                <td><input name="salesPrice1" class="nui-textbox" style="width: 150px;"/></td>
                <td class="tbtext">活动价：</td>
                <td><input name="salesPrice2" class="nui-textbox" style="width: 150px;"/></td>

            </tr>

            <tr>
                <td class="tbtext">是否推荐：</td>
                <td><input name="isRecommend" class="nui-combobox" style="width: 150px;" data="isTrue" idFeild="id" textFeild="text"/></td>
                <td class="tbtext">排序号：</td>
                <td><input name=orderNumber class="nui-textbox" style="width: 150px;"/></td>

            </tr>

        </table> 

        <div style="text-align: center; padding: 10px;">
            <a class="nui-button" onclick="onOk()" style="margin-right: 20px;"><i class="fa fa-save"></i>&nbsp;保存</a> 
            <a class="nui-button" onclick="onCancel()"><i class="fa fa-times"></i>&nbsp;取消</a>
        </div>
    </div>
   
    <script type="text/javascript">
        var isTrue = [{id:1,text:"是"},{id:0,text:"否"}];
        var form = new nui.Form("#form1");
        nui.parse();
        var productLimitedCycle = nui.get("cycle");//产品限定周期
        var costNumCycle = nui.get("consumptionTimes");//周期消费次数
        var isLimitedCycle = nui.get("isCycle");//是否限定周期
        function isLimitedCycleChanged(){
            var isLimitedCycle_value = isLimitedCycle.getValue();
            if(isLimitedCycle_value == "0"){
                costNumCycle.setVisible(false);
                costNumCycle.setValue(null);
                costNumCycle.setRequired(false);
                costNumCycle.setIsValid(true);
                productLimitedCycle.setVisible(false);
                productLimitedCycle.setValue(null);
                productLimitedCycle.setRequired(false);
                productLimitedCycle.setIsValid(true);
            }
            else{
                costNumCycle.setVisible(true);
                costNumCycle.enable();
                costNumCycle.setRequired(true);//设置为必填
                productLimitedCycle.setVisible(true);
                productLimitedCycle.setRequired(true);
                productLimitedCycle.enable();
            }
        }


    


        function onOk(e) {
            
            var s=new nui.Form("#form1").getData();
            saveData(s);
        }
        baseUrl = apiPath + sysApi + "/";;
        var savetUrl=baseUrl +"com.primeton.tenant.comProduct.updateProduct.biz.ext";
		function saveData(row){
		
    	nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '保存中...'
	    });
        nui.ajax({
            url: savetUrl,
            type: 'post',
            data: nui.encode({
            	params: row
            }),
            cache: false,
            success: function (data) {
                if (data.errCode == "S"){
                	nui.unmask(document.body);
                	nui.alert("保存成功！");
                	CloseOwnerWindow('ok');
                    }else {
                    nui.unmask(document.body);
                    nui.alert("保存失败！");
                    CloseOwnerWindow('ok');
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                nui.alert(jqXHR.responseText);
            }
		});
    
	}
	
        function onCancel(e) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow('ok');
            else window.close();
        }
        
        function SetInitData(s){
        	new nui.Form("#form1").setData(s);
        }
    </script>
</body>
</html>