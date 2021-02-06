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
		.tdWidth{width:10%}
</style>
<body>
<input class="nui-hidden" name="id" id="id"/>
<input class="nui-hidden" name="serviceId" id="serviceId"/>
<br/>
<fieldset id="fd1" style="width:99%;">
    <legend><span></span></legend>
    <div  class="nui-checkbox" type="" id="lockGearStatus" name="lockGearStatus">变速箱亮故障灯锁档</div>
</fieldset>
<fieldset id="fd2" style="width:99%;">
    <legend><span>变速箱打滑：</span></legend>
    <div class="fieldset-body">
        <table class="form-table" style="width:100%">
            <tr>
            	<td class="tdWidth">
                    <label class="label2"><input type="radio" name="skiddingStatus" value="1"/>一档升二档</label>
                </td>
                <td class="tdWidth">
                    <label class="label2"><input type="radio" name="skiddingStatus" value="2"/>二档升三档</label>
                </td>
                <td class="tdWidth">
                    <label class="label2"><input type="radio" name="skiddingStatus" value="3"/>三档升四档</label>
                </td>
                <td class="tdWidth">
                    <label class="label2"><input type="radio" name="skiddingStatus" value="4"/>四档升五档</label>
                </td>
                <td class="tdWidth">
                    <label class="label2"><input type="radio" name="skiddingStatus" value="5"/>五档升六档</label>
                </td>
                <td class="tdWidth">
                    <label class="label2"><input type="radio" name="skiddingStatus" value="6"/>六档升七档</label>
                </td>
                 <td class="tdWidth">
                    <label class="label2"><input type="radio" name="skiddingStatus" value="7"/>七档升八档</label>
                </td>
            </tr>
        </table>
    </div>
</fieldset>
<fieldset id="fd3" style="width:99%;">
    <legend><span>变速箱挂档冲击：</span></legend>
    <div class="fieldset-body">
        <table class="form-table" style="width:100%">
            <tr>
            	<td class="tdWidth">
                    <label class="label3"><input type="radio" name="attackStatus" value="1"/>从P-D冲击</label>
                </td>
                <td class="tdWidth">
                    <label class="label3"><input type="radio" name="attackStatus" value="2"/>从P-R冲击</label>
                </td>
                <td class="tdWidth">
                    <label class="label3"><input type="radio" name="attackStatus" value="3"/>从D-R冲击</label>
                </td>
                <td class="tdWidth">
                    <label class="label3"><input type="radio" name="attackStatus" value="4"/>从R-D冲击</label>
                </td>
                <td class="tdWidth">
                    <label class="label3"><input type="radio" name="attackStatus" value="5"/>从N-D冲击</label>
                </td>
                <td class="tdWidth">
                    <label class="label3"><input type="radio" name="attackStatus" value="6"/>从N-R冲击</label>
                </td>
                <td class="tdWidth"></td>
            </tr>
        </table>
    </div>
</fieldset>
<fieldset id="fd4" style="width:99%;">
    <legend><span>变速箱升档冲击：</span></legend>
    <div class="fieldset-body">
        <table class="form-table" style="width:100%">
            <tr>
            	<td class="tdWidth">
                    <label class="label4"><input type="radio" name="shiftUpStatus" value="1"/>一档升二档</label>
                </td>
                <td class="tdWidth">
                    <label class="label4"><input type="radio" name="shiftUpStatus" value="2"/>二档升三档</label>
                </td>
                <td class="tdWidth">
                    <label class="label4"><input type="radio" name="shiftUpStatus" value="3"/>三档升四档</label>
                </td>
                <td class="tdWidth">
                    <label class="label4"><input type="radio" name="shiftUpStatus" value="4"/>四档升五档</label>
                </td>
                <td class="tdWidth">
                    <label class="label4"><input type="radio" name="shiftUpStatus" value="5"/>五档升六档</label>
                </td>
                <td class="tdWidth">
                    <label class="label4"><input type="radio" name="shiftUpStatus" value="6"/>六档升七档</label>
                </td>
                 <td class="tdWidth">
                    <label class="label4"><input type="radio" name="shiftUpStatus" value="7"/>七档升八档</label>
                </td>
            </tr>
        </table>
    </div>
</fieldset>
<fieldset id="fd5" style="width:99%;">
    <div  class="nui-checkbox" type="" id="gearMoveStatus" name="gearMoveStatus">变速箱D/R不走车</div>
    <div  class="nui-checkbox" type="" id="startShakingStatus" name="startShakingStatus"  style="margin-left:50px;">变速箱起步或40-60码时抖动</div>
</fieldset>
<fieldset id="fd6" style="width:99%;">
    <legend><span>变速箱漏油：</span></legend>
    <div class="fieldset-body">
        <table class="form-table" style="width:100%">
            <tr>
            	<td class="tdWidth">
                    <label class="label5"><input type="radio" name="holeOilStatus" value="1"/>前油封漏油</label>
                </td>
                <td class="tdWidth">
                    <label class="label5"><input type="radio" name="holeOilStatus" value="2"/>后油封漏油</label>
                </td>
                <td class="tdWidth">
                    <label class="label5"><input type="radio" name="holeOilStatus" value="3"/>油底壳漏油</label>
                </td>
                <td class="tdWidth">
                    <label class="label5"><input type="radio" name="holeOilStatus" value="4"/>前壳与中壳之间漏</label>
                </td>
                <td class="tdWidth">
                    <label class="label5"><input type="radio" name="holeOilStatus" value="5"/>尾盖漏油</label>
                </td>
                <td class="tdWidth"></td>
                <td class="tdWidth"></td>
            </tr>
        </table>
    </div>
</fieldset>
<fieldset id="fd7" style="width:99%;">
    <legend><span>变速箱异响：</span></legend>
    <div class="fieldset-body">
        <table class="form-table" style="width:100%">
            <tr>
            	<td class="tdWidth">
                    <label class="label6"><input type="radio" name="abnormalSoundStatus" value="1"/>油泵摩损</label>
                </td>
                <td class="tdWidth">
                    <label class="label6"><input type="radio" name="abnormalSoundStatus" value="2"/>变扭器变型</label>
                </td>
                <td class="tdWidth">
                    <label class="label6"><input type="radio" name="abnormalSoundStatus" value="3"/>油格堵塞</label>
                </td>
                <td class="tdWidth">
                    <label class="label6"><input type="radio" name="abnormalSoundStatus" value="4"/>行星齿轮摩损</label>
                </td>
                <td class="tdWidth">
                    <label class="label6"><input type="radio" name="abnormalSoundStatus" value="5"/>轴承摩损</label>
                </td>
                <td class="tdWidth">
                    <label class="label6"><input type="radio" name="abnormalSoundStatus" value="6"/>差速器异响</label>
                </td>
                <td class="tdWidth"></td>
            </tr>
        </table>
    </div>
</fieldset>
<fieldset id="fd8" style="width:99%;">
    <legend><span>分动箱异响：</span></legend>
    <div class="fieldset-body">
        <table class="form-table" style="width:100%">
            <tr>
            	<td class="tdWidth">
                    <label class="label7"><input type="radio" name="transferCaseSoundStatus" value="1"/>轴承摩损</label>
                </td>
                <td class="tdWidth">
                    <label class="label7"><input type="radio" name="transferCaseSoundStatus" value="2"/>链条拉长变形</label>
                </td>
                <td class="tdWidth"></td><td class="tdWidth"></td><td class="tdWidth"></td><td class="tdWidth"></td><td class="tdWidth"></td>
            </tr>
        </table>
    </div>
</fieldset>
<fieldset id="fd9" style="width:99%;">
    <legend><span>分动箱抖动：</span></legend>
    <div  class="nui-checkbox" type="" id="transferCaseJitterStatus" name="transferCaseJitterStatus">摩擦片打滑</div>
</fieldset>
<fieldset id="fd7" style="width:99%;">
    <legend><span>故障描述：</span></legend>
	    <div style="width:100%;height:100px" >
	    	<input class="nui-textarea" style="width:100%;height:100px" id="faultDesc" name="faultDesc"/>
	    </div>
</fieldset>
<div align="right" style="margin-top:20px; ">
        <a class="nui-button  mini-button-info" style="" iconCls="" plain="false" onclick="MemSelectOk()" id="">
            确定
        </a>

        <a class="nui-button  mini-button-info" style="" iconCls="" plain="false" onclick="close()" id="">
            取消
        </a>
    </div>
	<script type="text/javascript">
    	nui.parse();
    	var baseUrl = apiPath + repairApi + "/";
		
		function getFailt(){
			var faultDesc = nui.get("faultDesc").value || "";
			return faultDesc; 
		}
		
		function MemSelectOk(){//确定 
		    var lockGearStatus = nui.get("lockGearStatus").checked?1:0;
		    var skiddingStatus = $('input:radio[name="skiddingStatus"]:checked').val();
		    var attackStatus = $('input:radio[name="attackStatus"]:checked').val();
		    var shiftUpStatus = $('input:radio[name="shiftUpStatus"]:checked').val();
		    var gearMoveStatus =  nui.get("gearMoveStatus").checked?1:0;
		    var startShakingStatus =  nui.get("startShakingStatus").checked?1:0;
		    var holeOilStatus = $('input:radio[name="holeOilStatus"]:checked').val();
		    var abnormalSoundStatus = $('input:radio[name="abnormalSoundStatus"]:checked').val();
		    var transferCaseJitterStatus = nui.get("transferCaseJitterStatus").checked?1:0;
		    var transferCaseSoundStatus = $('input:radio[name="transferCaseSoundStatus"]:checked').val();
		    var faultDesc = nui.get("faultDesc").value;
		    var fault = {
		    	id : nui.get("id").value,
		    	lockGearStatus : lockGearStatus,
		    	skiddingStatus : skiddingStatus,
		    	attackStatus : attackStatus,
		    	shiftUpStatus : shiftUpStatus,
		    	gearMoveStatus : gearMoveStatus,
		    	startShakingStatus : startShakingStatus,
		    	holeOilStatus : holeOilStatus,
		    	abnormalSoundStatus : abnormalSoundStatus,
		    	transferCaseJitterStatus : transferCaseJitterStatus,
		    	faultDesc : faultDesc,
		    	transferCaseSoundStatus : transferCaseSoundStatus,
		    	serviceId : nui.get("serviceId").value
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
                    		window.CloseOwnerWindow('ok');
                    	}
                    }
            });
		}
		
		function SetData(data){
			var ndata = nui.clone(data); 
			nui.get("serviceId").setValue(ndata);
			if(ndata){
				selectRedio(ndata);
			}
		}
		
		function selectRedio(serviceId){//设置选中radio
			nui.ajax({
                    url: baseUrl+"com.hsapi.repair.repairService.crud.searchBXMsg.biz.ext",
                    type: "post",
                    cache: false,
                    async: false,
                    data: {
                       serviceId : serviceId
                    },
                    success: function(text) {
                    	if(text.errCode == "S"){
                    		var msg = text.msg;
                    		if(msg.length){
                    			msg = msg[0];
                    			nui.get("id").setValue(msg.id);
							    var lockGearStatus = msg.lockGearStatus || 0;
							    var skiddingStatus = msg.skiddingStatus || 0;
							    var attackStatus = msg.attackStatus || 0;
							    var shiftUpStatus = msg.shiftUpStatus || 0;
							    var gearMoveStatus =  msg.gearMoveStatus || 0;
							    var startShakingStatus =  msg.startShakingStatus || 0;
							    var holeOilStatus = msg.holeOilStatus || 0;
							    var abnormalSoundStatus = msg.abnormalSoundStatus || 0;
							    var transferCaseJitterStatus = msg.transferCaseJitterStatus || 0;
							    var transferCaseSoundStatus = msg.transferCaseSoundStatus || 0;
							    var faultDesc = msg.faultDesc || "";
			  	  				$("input[name=skiddingStatus][value='"+skiddingStatus+ "']").attr("checked",'checked');
			  	  				$("input[name=attackStatus][value='"+attackStatus+ "']").attr("checked",'checked');
			  	  				$("input[name=shiftUpStatus][value='"+shiftUpStatus+ "']").attr("checked",'checked');
			  	  				$("input[name=holeOilStatus][value='"+holeOilStatus+ "']").attr("checked",'checked');
			  	  				$("input[name=abnormalSoundStatus][value='"+abnormalSoundStatus+ "']").attr("checked",'checked');
			  	  				$("input[name=transferCaseSoundStatus][value='"+transferCaseSoundStatus+ "']").attr("checked",'checked');
			  	  				if(lockGearStatus){
			  	  					var lockGearStatus = nui.get("lockGearStatus");
			  	  					lockGearStatus.setChecked(!lockGearStatus.getChecked());
			  	  				}
			  	  				if(gearMoveStatus){
			  	  					var gearMoveStatus = nui.get("gearMoveStatus");
			  	  					gearMoveStatus.setChecked(!gearMoveStatus.getChecked());
			  	  				}
			  	  				if(startShakingStatus){
			  	  					var startShakingStatus = nui.get("startShakingStatus");
			  	  					startShakingStatus.setChecked(!startShakingStatus.getChecked());
			  	  				}
			  	  				if(transferCaseJitterStatus){
			  	  					var transferCaseJitterStatus = nui.get("transferCaseJitterStatus");
			  	  					transferCaseJitterStatus.setChecked(!transferCaseJitterStatus.getChecked());
			  	  				}
			  	  				nui.get("faultDesc").setValue(faultDesc);
                    		}
                    	}
                    }
            });
		}
		
		function close(){
			window.CloseOwnerWindow('');
		}
    </script>
</body>
</html>