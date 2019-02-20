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
<fieldset id="fd1" style="width:100%;">
    <legend><span>锁挡：</span></legend>
    <div class="fieldset-body">
        <table class="form-table" style="width:100%">
            <tr>
            	<td>
                    <label class="label1"><input type="radio" name="radio1" value="1"/>只有一个挡在工作</label>
                </td>
                <td>
                    <label class="label1"><input type="radio" name="radio1" value="2"/>亮故障灯</label>
                </td>
                <td>
                    <label class="label1"><input type="radio" name="radio1" value="3"/>跑步起来</label>
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
                    <label class="label2"><input type="radio" name="radio2" value="1"/>行车异响</label>
                </td>
                <td>
                    <label class="label2"><input type="radio" name="radio2" value="2"/>挂挡异响</label>
                </td>
                <td>
                    <label class="label2"><input type="radio" name="radio2" value="3"/>停车异响</label>
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
                    <label class="label3"><input type="radio" name="radio3" value="1"/>1换2</label>
                </td>
                <td>
                    <label class="label3"><input type="radio" name="radio3" value="2"/>2换3</label>
                </td>
                <td>
                    <label class="label3"><input type="radio" name="radio3" value="3"/>3换4</label>
                </td>
                <td>
                    <label class="label3"><input type="radio" name="radio3" value="4"/>4换5</label>
                </td>
                <td>
                    <label class="label3"><input type="radio" name="radio3" value="5"/>5换6</label>
                </td>
                <td>
                    <label class="label3"><input type="radio" name="radio3" value="6"/>6换7</label>
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
                    <label class="label4"><input type="radio" name="radio4" value="1"/>换挡冲击</label>
                </td>
                <td>
                    <label class="label4"><input type="radio" name="radio4" value="2"/>挂挡冲击</label>
                </td>
                <td>
                    <label class="label4"><input type="radio" name="radio4" value="3"/>降档冲击</label>
                </td>
                <td>
                    <label class="label4"><input type="radio" name="radio4" value="4"/>停车冲击</label>
                </td>
            </tr>
        </table>
    </div>
</fieldset>
<fieldset id="fd5" style="width:100%;">
    <legend><span>漏油位置：</span></legend>
   <!--  <input class="nui-textarea"  style="width:100%" onvaluechanged="changeOilMsg"/> -->
  <div class="wordCount" id="wordCount" style="width:100%;">
	<textarea style="resize:none;border-style:none;background:#f8f8f8" oninput="OnInput(event)" id="oilMsgChange" name="oilMsgChange"></textarea>
</div>
</fieldset>
<fieldset id="fd6" style="width:100%;">
    <div  class="nui-checkbox" type="" onvaluechanged="change" id="change" name="change">挂挡不能行走</div>
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
     $(function()
		{	
			var radio1 = [{id:1,text:"锁挡只有一个在工作;"},{id:2,text:"锁挡亮故障灯;"},{id:3,text:"锁挡跑不起来;"}];
			var radio2 =  [{id:1,text:"波箱行车异响;"},{id:2,text:"波箱挂挡异响;"},{id:3,text:"波箱停车异响;"}];
			var radio3 =  [{id:1,text:"波箱打滑1换2;"},{id:2,text:"波箱打滑2换3;"},{id:3,text:"波箱打滑3换4;"},{id:4,text:"波箱打滑4换5;"},{id:5,text:"波箱打滑5换6;"},{id:6,text:"波箱打滑6换7;"}];
			var radio4 =  [{id:1,text:"波箱换挡冲击;"},{id:2,text:"波箱挂挡冲击;"},{id:3,text:"波箱降档冲击;"},{id:4,text:"波箱停车冲击;"}];
			$('.label1').click(function(e){
				/* var text=$(this).text();
				alert(text); */
				for(var i = 0,l = radio1.length ; i < l ;i++){
					if( $('input[name="radio1"]:checked').val() - 1 == i){
						document.getElementById("span1").innerHTML = radio1[i].text;
						break;
					}
				}
			});
			
			$('.label2').click(function(e){
				for(var i = 0,l = radio2.length ; i < l ;i++){
					if( $('input[name="radio2"]:checked').val() - 1 == i){
						document.getElementById("span2").innerHTML = radio2[i].text;
						break;
					}
				}
			});
			
			$('.label3').click(function(e){
				for(var i = 0,l = radio3.length ; i < l ;i++){
					if( $('input[name="radio3"]:checked').val() - 1 == i){
						document.getElementById("span3").innerHTML = radio3[i].text;
						break;
					}
				}
			});
			
			$('.label4').click(function(e){
				for(var i = 0,l = radio4.length ; i < l ;i++){
					if( $('input[name="radio4"]:checked').val() - 1 == i){
						document.getElementById("span4").innerHTML = radio4[i].text;
						break;
					}
				}
			});
		}); 
		
		function OnInput(event){
			document.getElementById("span5").innerHTML =$("#oilMsgChange").val()+";";
		}
		
		function change(e){
			var checked = this.getChecked();
			if(checked){
				document.getElementById("span6").innerHTML = "挂挡不能行走;";
			}else{
				document.getElementById("span6").innerHTML = "";
			}
		}
		
		function MemSelectOk(){//确定
		    var value1 = $('input:radio[name="radio1"]:checked').val();
		    var value2 = $('input:radio[name="radio2"]:checked').val();
		    var value3 = $('input:radio[name="radio3"]:checked').val();
		    var value4 = $('input:radio[name="radio4"]:checked').val();
		    var value5 = document.getElementById("oilMsgChange").value;
		    var value6 = nui.get("change").checked?1:0;
		    var value7 = $("#span1")[0].innerHTML + $("#span2")[0].innerHTML + $("#span3")[0].innerHTML + 
		    					$("#span4")[0].innerHTML + $("#span5")[0].innerHTML + $("#span6")[0].innerHTML;
			//保存
		}
		
		function setValueMsg(data){
			var arr = ["radio1","radio2","radio3","radio4"];
		}
		
		function selectRedio(radio,value){//设置选中radio
			
		}
    </script>
</body>
</html>