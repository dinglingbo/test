<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<HTML>
<HEAD>
<TITLE><b:message key="current_tran_info_jsp.his_tran_proc_info"/></TITLE>
<script language="JavaScript">	
	var refreshTime = 400;
		
	var interval;
	function refreshWin(){
		var url="com.primeton.workflow.manager.tranhistory.TranHistory.queryTranHistoryInfo.biz";
		var ajax = new HideSubmit(url);
		ajax.addParam("path",this.path);
		ajax.addParam("clientID","default");
		ajax.onFailure=function (){};
		ajax.submit();
		var dataset=new Dataset("result");
		dataset.init(ajax.retDom.selectNodes("root/data/result"));
		if(dataset.getLength()>0){
				var result=dataset.get(0);
				var currentNumber=result.getProperty("currentNumber");
				var totalNumber=result.getProperty("totalNumber");
				var beginTime=result.getProperty("beginTime");
				$id("currentNumber").innerHTML=currentNumber;
				showHistoryProcess(currentNumber,totalNumber,beginTime);
				var status=result.getProperty("status");
				if(status=="SUCCESS"){
					//工作流历史数据转移成功！
					$id("message").innerHTML='<b:message key="current_tran_info_jsp.tran_seccess"/>';
					window.clearInterval(interval);
				}
		}
	}	
	
	
	function counttime(){
		interval=window.setInterval("refreshWin()",refreshTime);
	}	
	
	function showHistoryProcess(currentNumber,totalNumber,beginTime){
			var cn = currentNumber;
			var ctn = totalNumber;
			var cbt = beginTime;
			
			var pos = 100*cn/ctn;
			var progress = new CProgress("progress", 0, 100, pos);
			progress.Create();
			
			
			var percentId = $id("percent");
			percentId.innerHTML = pos.toString().split(".")[0]+"%";
			//$("progress").innerHTML=$("progress").innerHTML+pos.toString().split(".")[0]+"%";
			var ctime = new Date();
			cbt=cbt.split(" ")[1];
			var cbtime = (new String(cbt)).split(":");
			
			var temphour = ctime.getHours() - cbtime[0];
			var tempmin = ctime.getMinutes() - cbtime[1];
			var tempsec = ctime.getSeconds() - cbtime[2];
			var temptime = temphour*3600 + tempmin*60 + tempsec;
		
			var ltime = temptime/cn*(ctn-cn);
			temphour = (ltime/3600).toString().split(".")[0];
			tempmin = (ltime/60 - temphour*60).toString().split(".")[0];
			tempsec = (ltime - temphour*3600 - tempmin*60).toString().split(".")[0];
			
			var lefttimeId = $id("lefttime");
			if( temphour>=0 && tempmin>=0 && tempsec>=0 ){
				if( temphour < 10 )
					temphour="0"+temphour;
				if( tempmin < 10 )
					tempmin="0"+tempmin;
				if( tempsec < 10 )
					tempsec="0"+tempsec;
				lefttimeId.innerHTML = temphour+":"+tempmin+":"+tempsec;
			}
			//正在估计
			else lefttimeId.innerHTML = '<b:message key="current_tran_info_jsp.assess"/>';
	}
	
	
	
	function CProgress(progressIdStr, min, max, pos)
{
    this.progressIdStr = progressIdStr;
    this.progressId = $id(this.progressIdStr);
    this.barIdStr = progressIdStr + "_bar";
    this.barId = null;
    
    this.min = (min>=0)?min:0;
    this.max = (max>=min)?max:min;
    this.pos = (pos>=min && pos<=max)?pos:min;
    
    this.progressWidth = 320;
    this.progressHeight = 10;
    this.progressBorderClr = "#CCCCCC";
    this.progressBarClr = "#3292A8";
    
    this.Create = CProgress_Create;
    this.SetPos = CProgress_SetPos;
}


//创建进度条控件
function CProgress_Create()
{

	
    if (document.all)
    {
        this.progressId.style.width = (this.progressWidth+2) + "px"; //IE 的边框属于宽度的一部分
        this.progressId.style.height = (this.progressHeight+2) + "px";
    }
    else
    {
        this.progressId.style.width = this.progressWidth + "px";
        this.progressId.style.height = this.progressHeight + "px";
    }
    
    this.progressId.style.fontSize = "0px";
    this.progressId.style.border = "1px solid " + this.progressBorderClr;
    this.progressId.innerHTML = "<div id=\"" + this.barIdStr + "\" style=\"width:0px;float:left;height:80%;background-color:" + this.progressBarClr + ";\"></div>";
    this.barId = $id(this.barIdStr);
    this.SetPos(this.pos);
}

//设置进度条的当前指示位置
function CProgress_SetPos(pos)
{
    pos = (pos<=this.max)?pos:this.max;
    pos = (pos>=this.min)?pos:this.min;
    this.pos = pos;
    this.barId.style.width = (this.progressWidth*this.pos)/this.max + "px";
}
	
</script>

</HEAD>
<body onload="counttime()">
<form method="post" name="tranhistoryForm"><input
	type="hidden" name="_eosFlowAction"> <input type="hidden"
	name="type">
<table border="0" cellpadding="0" cellspacing="0" class="workarea"
	width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><b:message key="last_tran_info_jsp.his_data_tran"/></td>
	</tr>
	<tr>
		<td width="100%" valign="top">
		<table cellpadding="0" width="100%" cellspacing="0" border="0">
			<tr>
				<td>
				<table border="0" class="EOS_panel_body" width="100%">
					<tr>
						<td width="100%">
						<table width="100%" height="20%" border="0" cellpadding="0"
							cellspacing="0" align="center" class="form_table">
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row"
									width="15%"><b:message key="current_tran_info_jsp.status"/></td>
								<td height="26" nowrap="nowrap">
								<div id="message"><b:write property="result/message" /></div>
								</td>
							</tr>
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row"
									width="15%"><b:message key="current_tran_info_jsp.progress"/></td>
								<td height="26" nowrap="true">
								<div id="progress" style="display: inline;width: 320px;">
								</div>
								<div id="percent" style="display: inline;padding-left: 10px;"></div>
								</td>
							</tr>

							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row"
									width="15%"><b:message key="current_tran_info_jsp.remain_time"/></td>
								<td height="26" nowrap="nowrap">
								<div id="lefttime">
								</td>
							</tr>
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row"
									width="15%"><b:message key="current_tran_info_jsp.start_time"/></td>
								<td height="26" nowrap="nowrap"><b:write
									property="result/beginTime" /></td>
							</tr>
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row"
									width="15%"><b:message key="current_tran_info_jsp.success_tran_num"/></td>
								<td height="26" nowrap="nowrap">
								<div id="currentNumber"><b:write property="result/currentNumber" /></div>
								</td>
							</tr>
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row"
									width="15%"><b:message key="current_tran_info_jsp.total_tran_num"/></td>
								<td height="26" nowrap="nowrap"><b:write
									property="result/totalNumber" /></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>


<script language="JavaScript">
	
</script>
</HTML>
