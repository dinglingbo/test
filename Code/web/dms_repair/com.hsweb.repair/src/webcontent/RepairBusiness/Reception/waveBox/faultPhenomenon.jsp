<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-02-15 17:30:56
  - Description:
-->
<head>
<title>故障现象</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<style type="text/css">

        .wordCount{ position:relative;width: 600px; }

        .wordCount textarea{ width: 100%; height: 100px;}

        .wordCount .wordwrap{ position:absolute; right: 6px; bottom: 6px;}

        .wordCount .word{ color: red; padding: 0 4px;;}

</style>
<body>
<input class="nui-hidden" name="id" id="id"/>
<fieldset id="fd1" style="width:100%;">
    <legend><span>锁挡：</span></legend>
    <div class="fieldset-body">
        <table class="form-table" style="width:100%">
            <tr>
            	<td>
                    <label class="label1"><input type="radio" name="lockGearStatus" value="1"/>只有一个挡在工作</label>
                </td>
                <td>
                    <label class="label1"><input type="radio" name="lockGearStatus" value="2"/>亮故障灯</label>
                </td>
                <td>
                    <label class="label1"><input type="radio" name="lockGearStatus" value="3"/>跑步起来</label>
                </td>
            </tr>
        </table>
    </div>
</fieldset>
<fieldset id="fd2" style="width:100%;">
    <legend><span>波箱异响：</span></legend>
    <div class="fieldset-body">
        <table class="form-table" style="width:100%">
            <tr>
            	<td>
                    <label class="label2"><input type="radio" name="abnormalSoundStatus" value="1"/>行车异响</label>
                </td>
                <td>
                    <label class="label2"><input type="radio" name="abnormalSoundStatus" value="2"/>挂挡异响</label>
                </td>
                <td>
                    <label class="label2"><input type="radio" name="abnormalSoundStatus" value="3"/>停车异响</label>
                </td>
            </tr>
        </table>
    </div>
</fieldset>
<fieldset id="fd3" style="width:100%;">
    <legend><span>波箱打滑：</span></legend>
    <div class="fieldset-body">
        <table class="form-table" style="width:100%">
            <tr>
            	<td>
                    <label class="label3"><input type="radio" name="skiddingStatus" value="1"/>1换2</label>
                </td>
                <td>
                    <label class="label3"><input type="radio" name="skiddingStatus" value="2"/>2换3</label>
                </td>
                <td>
                    <label class="label3"><input type="radio" name="skiddingStatus" value="3"/>3换4</label>
                </td>
                <td>
                    <label class="label3"><input type="radio" name="skiddingStatus" value="4"/>4换5</label>
                </td>
                <td>
                    <label class="label3"><input type="radio" name="skiddingStatus" value="5"/>5换6</label>
                </td>
                <td>
                    <label class="label3"><input type="radio" name="skiddingStatus" value="6"/>6换7</label>
                </td>
            </tr>
        </table>
    </div>
</fieldset>
<fieldset id="fd4" style="width:100%;">
    <legend><span>波箱冲击：</span></legend>
    <div class="fieldset-body">
        <table class="form-table" style="width:100%">
            <tr>
            	<td>
                    <label class="label4"><input type="radio" name="attackStatus" value="1"/>换挡冲击</label>
                </td>
                <td>
                    <label class="label4"><input type="radio" name="attackStatus" value="2"/>挂挡冲击</label>
                </td>
                <td>
                    <label class="label4"><input type="radio" name="attackStatus" value="3"/>降档冲击</label>
                </td>
                <td>
                    <label class="label4"><input type="radio" name="attackStatus" value="4"/>停车冲击</label>
                </td>
            </tr>
        </table>
    </div>
</fieldset>
<fieldset id="fd5" style="width:100%;">
    <legend><span>漏油位置：</span></legend>
   <!--  <input class="nui-textarea"  style="width:100%" onvaluechanged="changeOilMsg"/> -->
  <div class="wordCount" id="wordCount" style="width:100%;">
	<textarea style="resize:none;border-style:none;background:#f8f8f8" oninput="OnInput(event)" id="holeOilDesc" name="holeOilDesc"></textarea>
</div>
</fieldset>
<fieldset id="fd6" style="width:100%;">
    <div  class="nui-checkbox" type="" onvaluechanged="gearMoveStatus" id="gearMoveStatus" name="gearMoveStatus">挂挡不能行走</div>
</fieldset>
<fieldset id="fd7" style="width:100%;">
    <legend><span>故障描述：</span></legend>
	    <div style="width:100%;height:100px" >
	    	<span id="span1"></span>
	    	<span id="span2"></span>
	    	<span id="span3"></span>
	    	<span id="span4"></span>
	    	<span id="span5"></span>
	    	<span id="span6"></span>
	    </div>
</fieldset>
<div align="right" style="margin-top:20px; ">
        <a class="nui-button  mini-button-info" style="" iconCls="" plain="false" onclick="MemSelectOk" id="">
            确定
        </a>

        <a class="nui-button  mini-button-info" style="" iconCls="" plain="false" onclick="MemSelectCancel(1)" id="">
            取消
        </a>
    </div>
	<script type="text/javascript">
    	nui.parse();
    	var baseUrl = apiPath + repairApi + "/";
     $(function()
		{	
			var lockGearStatus = [{id:1,text:"锁挡只有一个在工作;"},{id:2,text:"锁挡亮故障灯;"},{id:3,text:"锁挡跑不起来;"}];
			var abnormalSoundStatus =  [{id:1,text:"波箱行车异响;"},{id:2,text:"波箱挂挡异响;"},{id:3,text:"波箱停车异响;"}];
			var skiddingStatus =  [{id:1,text:"波箱打滑1换2;"},{id:2,text:"波箱打滑2换3;"},{id:3,text:"波箱打滑3换4;"},{id:4,text:"波箱打滑4换5;"},{id:5,text:"波箱打滑5换6;"},{id:6,text:"波箱打滑6换7;"}];
			var attackStatus =  [{id:1,text:"波箱换挡冲击;"},{id:2,text:"波箱挂挡冲击;"},{id:3,text:"波箱降档冲击;"},{id:4,text:"波箱停车冲击;"}];
			$('.label1').click(function(e){
				/* var text=$(this).text();
				alert(text); */
				for(var i = 0,l = lockGearStatus.length ; i < l ;i++){
					if( $('input[name="lockGearStatus"]:checked').val() - 1 == i){
						document.getElementById("span1").innerHTML = lockGearStatus[i].text;
						break;
					}
				}
			});
			
			$('.label2').click(function(e){
				for(var i = 0,l = abnormalSoundStatus.length ; i < l ;i++){
					if( $('input[name="abnormalSoundStatus"]:checked').val() - 1 == i){
						document.getElementById("span2").innerHTML = abnormalSoundStatus[i].text;
						break;
					}
				}
			});
			
			$('.label3').click(function(e){
				for(var i = 0,l = skiddingStatus.length ; i < l ;i++){
					if( $('input[name="skiddingStatus"]:checked').val() - 1 == i){
						document.getElementById("span3").innerHTML = skiddingStatus[i].text;
						break;
					}
				}
			});
			
			$('.label4').click(function(e){
				for(var i = 0,l = attackStatus.length ; i < l ;i++){
					if( $('input[name="attackStatus"]:checked').val() - 1 == i){
						document.getElementById("span4").innerHTML = attackStatus[i].text;
						break;
					}
				}
			});
		}); 
		
		function OnInput(event){
			document.getElementById("span5").innerHTML =$("#holeOilDesc").val()+";";
		}
		
		function gearMoveStatus(e){
			var checked = this.getChecked();
			if(checked){
				document.getElementById("span6").innerHTML = "挂挡不能行走;";
			}else{
				document.getElementById("span6").innerHTML = "";
			}
		}
		
		function MemSelectOk(){//确定
		    var lockGearStatus = $('input:radio[name="lockGearStatus"]:checked').val();
		    var abnormalSoundStatus = $('input:radio[name="abnormalSoundStatus"]:checked').val();
		    var skiddingStatus = $('input:radio[name="skiddingStatus"]:checked').val();
		    var attackStatus = $('input:radio[name="attackStatus"]:checked').val();
		    var holeOilDesc = document.getElementById("holeOilDesc").value;
		    var gearMoveStatus = nui.get("gearMoveStatus").checked?0:1;
		    var faultDesc = $("#span1")[0].innerHTML + $("#span2")[0].innerHTML + $("#span3")[0].innerHTML + 
		    					$("#span4")[0].innerHTML + $("#span5")[0].innerHTML + $("#span6")[0].innerHTML;
		    var fault = {
		    	id : nui.get("id").value,
		    	lockGearStatus : lockGearStatus,
		    	abnormalSoundStatus : abnormalSoundStatus,
		    	skiddingStatus : skiddingStatus,
		    	attackStatus : attackStatus,
		    	holeOilDesc : holeOilDesc,
		    	gearMoveStatus : gearMoveStatus,
		    	faultDesc : faultDesc
		    };
			//保存
			nui.ajax({
                    url: baseUrl+"com.hsapi.repair.repairService.crud.saveBXFaultRecord.biz.ext",
                    type: "post",
                    cache: false,
                    async: false,
                    data: {
                       fault : fault
                    },
                    success: function(text) {
                    	if(text.errCode == "S"){
                    		var fault = text.fault;
                    		nui.get("id").setValue(fault.id);
                    	}
                    }
            });
		}
		
		function setValueMsg(data){
		
		}
		
		function selectRedio(radio,value){//设置选中radio
			
		}
    </script>
</body>
</html>