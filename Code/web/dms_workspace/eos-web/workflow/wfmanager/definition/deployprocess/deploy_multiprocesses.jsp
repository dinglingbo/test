<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String wfResLib = ResourcesMessageUtil.getI18nResourceMessage("deploy_multiprocesses_jsp.wf_res_lib");
%>
<head>
<title></title>
<script>
	var G_NESTED = "NESTED"
	var contributionName ;
	var contributionNumber=0;
	//定义客户端Cache对象
	var workflowDefArray=new Array();//工作流对象数组
	
	var currEditObj;
	//业务流程对象和相关方法
	function workflowdef(){
		var contributionName;
		var status=false;
		var name;
		var path;
		var option_mode;
		var version;
		var isRelease;
		var description;
		var versionArray;
		var onlycheck;
		//创建对象
		this.build=function (contributionName,name,path){
			this.contributionName=contributionName;
			this.name=name.substring(0,name.length-9);
			this.path=path;
			this.version="";
			this.description=this.getDescription();
			this.isRelease=true;
			this.option_mode="default";
			this.versionArray=new Array();
			this.onlycheck=false;
		};
		//创建描述
		this.getDescription=function (){
			var time=sysDateTime();
			var prefix="--------<b:write property='<%=IUserObject.KEY_IN_CONTEXT+"/userId"%>' scope="session"/>--------";
			return prefix+"\n"+"===="+time+"=====";
		};
		//缓存属性将编辑器复原
		this.showCacheInfo=function (){
			if(this.onlycheck){
				this.showRemoteInfo();
			}
			else {
			
				$("description").value=this.description;
				$("isRelease").checked=this.isRelease;
				//$("version").value=this.version;
				//$("option/mode").value=this.option_mode;
				var mode=document.getElementsByName("option/mode");
				for(var i=0;i<mode.length;i++){
					if(mode[i].value==this.option_mode){
						mode[i].checked=true;
						break;
					}
				}
				//版本复原
				var version=$("version");
				version.options.length=0;
				for(var i=0;i<this.versionArray.length;i++){
					var option=this.versionArray[i];
					version.options.add(option);
				}
				if(this.option_mode=="old-version"){
					$("version").value=this.version;
					$("version").disabled=false ;	
				}
				else {
					$("version").disabled=true;	
				}
			}
		};
		//获得远程属性并且将编辑器复原
		this.showRemoteInfo=function (){
			var url="com.primeton.workflow.manager.def.processdef.getProcessDef.biz";
			var ajax = new HideSubmit(url);
			ajax.addParam("path",this.path);
			ajax.onFailure=function (){};
			ajax.submit();
			var dataset=new Dataset("11");
			dataset.init(ajax.retDom.selectNodes("root/data/wfprocess"));
			if(dataset!=null&&dataset.getLength()>0){
				var version=$("version");
				version.options.length=0;
				var currVersion="";
				var wfdescription;
				for(var i=0;i<dataset.getLength();i++){
					var wf=dataset.get(i);
					var option=new Option();
					option.value=wf.getProperty("versionSign");
					option.text="Version--("+wf.getProperty("versionSign")+")";
					if(wf.getProperty("currentState")=="3"){
						option.text+="*";
						wfdescription=wf.getProperty("versionDesc");
					}
					version.options.add(option);
					this.versionArray.push(option);
				}
				//编辑器赋值
			    $("description").value=(wfdescription==null)?(this.getDescription()):wfdescription;
				$("isRelease").checked=this.isRelease;
				$("version").value=currVersion;
				$("option/mode").checked=this.option_mode;
				//缓存对象赋值
				this.version=currVersion;
				this.description=(wfdescription==null)?(this.getDescription()):wfdescription;
			}
			else {
				this.showCacheInfo();
			}
		};
	}

    //系统时间参数
	function sysDateTime(){
		var year,month,day,hours,minutes,seconds,ap;
		var intYear,intMonth,intDay,intHours,intMinutes,intSeconds;
		var today;
		today=new Date();
		intYear=today.getYear();
		intMonth=today.getMonth()+1;
		intDay=today.getDate();
		intHours=today.getHours();
		intMinutes=today.getMinutes();
		intSeconds=today.getSeconds();
		//获取系统时间的小时数
		if(intHours<12){
			hours=intHours+":";
			ap="<b:message key="deploy_multiprocesses_jsp.am"/>";//上午
		}
		else if(intHours==12){
			hours=intHours+":";
			ap="<b:message key="deploy_multiprocesses_jsp.noon"/>";//中午
		}
		else	{
			intHours=intHours-12;
			hours=intHours+":";
			ap="<b:message key="deploy_multiprocesses_jsp.pm"/>";//下午
		}
		//获取系统时间的分数
		if(intMinutes<10)
		{
		minutes="0"+intMinutes+":";
		}
		else
		minutes=intMinutes+":";
		//获取系统时间的秒数
		if(intSeconds<10)
		seconds="0"+intSeconds+" ";
		else
		seconds=intSeconds+" ";
		var timeString=intYear+"-"+intMonth+"-"+intDay+ap+hours+minutes+seconds;
		return timeString;
	}
	//编辑器修改信息后，对业务流程信息修改
	function modifyProperty(obj,index){
		if(currEditObj!=null){
			switch(index){
				case 5:currEditObj.description=obj.value;break;
				case 4:obj.checked?currEditObj.isRelease=true:currEditObj.isRelease=false;break;
				case 3:currEditObj.version=obj.value;break;
			}
			//将修改后的属性放到缓存对象中
			for(var i=0;i<workflowDefArray.length;i++){
				var temp=workflowDefArray[i];
				if(temp.path==currEditObj.path){
					workflowDefArray.splice(i,1,currEditObj)
					break;
				}
			}
		}
	}
	//选中流程对象
	function registerProcessDef(obj){
		var contributionName=obj.previousSibling.value;
		var packageName=obj.previousSibling.previousSibling.value;
		var name="";
		if(packageName!=""){
			name=name+packageName+"."+obj.nextSibling.innerText;
		}
		else name=obj.nextSibling.innerText;
		var path=obj.name;
		//currEditObj=getCacheObject(contributionName,name,path);
		var checkedStatus=obj.checked?true:false;
					
		var flag=true;
		if(workflowDefArray.length>0){
			for(var i=0;i<workflowDefArray.length;i++){
				var temp=workflowDefArray[i];
				if(temp.path==path){
					temp.status=checkedStatus;
					workflowDefArray.splice(i,1,temp);
					flag=false;
					break;
				}
			}
		}
		//缓存数组中没有该流程，则加入该流程定义信息
		if(flag){
			wf=new workflowdef();
			wf.build(contributionName,name,path);
			wf.status=checkedStatus;
			wf.onlycheck=true;
			workflowDefArray.push(wf);
		}
	}
	//流程发布模式和版本选择
	function disableSelectbox(obj,isDisable) {
	//FIXME:document.getElementById --> $id
			var List = $id('version')
		    if(isDisable == "true") {
		   		List.disabled="true" ;	
		   	}	else {
				var ListLen = List.options.length;
				for(i = ListLen - 1; i >= 0; i--)
				{
					List.options[i].selected = false ;
				}		   		
		   		List.disabled=false ;	
		   	}
		    //发布模式更改
		    if(obj.checked){
			    var models=document.getElementsByName("option/mode");
			    var checkedModel;
			    for(var i=0;i<models.length;i++){
			    	if(models[i].checked){
			    		checkedModel=models[i].value;
			    		break;
			    	}
			    }
		    }
		   	if(currEditObj!=null){
				currEditObj.option_mode=checkedModel;
				//将修改后的属性放到缓存对象中
				for(var i=0;i<workflowDefArray.length;i++){
					var temp=workflowDefArray[i];
					if(temp.path==currEditObj.path){
						workflowDefArray.splice(i,1,currEditObj)
						break;
					}
				}
			}
		   	
		}
		
	//编辑业务流程属性
	function editorWorkflow(currWorkflow){
		enableEditor();
		var contributionName=currWorkflow.previousSibling.previousSibling.value;
		var packageName=currWorkflow.previousSibling.previousSibling.previousSibling.value;
		var name="";
		if(packageName!=""){
			name=name+packageName+"."+currWorkflow.innerText;
		}
		else name=currWorkflow.innerText;
		
		var path=currWorkflow.previousSibling.name;

		currEditObj=getCacheObject(contributionName,name,path);
		
	}
	//编辑器控件去掉 
	function enableEditor(){
		var models=document.getElementsByName("option/mode");
	    var checkedModel;
	    for(var i=0;i<models.length;i++){
	    	models[i].disabled="";
	    }
	    
	    $("isRelease").disabled="";
	    $("description").disabled="";
	    
	}
	
	//取出缓存对象或者创建一个新的业务流程对象
	function getCacheObject(contributionName,currWorkflow,path){
		var wf;
		var flag=true;
		if(workflowDefArray.length>0){
			for(var i=0;i<workflowDefArray.length;i++){
				var temp=workflowDefArray[i];
				if(temp.path==path){
					wf=temp;
					wf.showCacheInfo();
					flag=false;
					break;
				}
			}
		}
		//缓存数组中没有该流程，则加入该流程定义信息
		if(flag){
			wf=new workflowdef();
			wf.build(contributionName,currWorkflow,path);
			wf.showRemoteInfo();
			workflowDefArray.push(wf);
		}
		return  wf;
		
	}
	//确定部署
	function deploy(){
		var count=0;
		for(var i=0;i<workflowDefArray.length;i++){
				var temp=workflowDefArray[i];
				if(temp.status){
					count+=1;
				}
		}
		//confirm("部署"+count+"个流程");
		deploy_process();
	}
	//关闭当前窗口
	function closeWin() {
		window.close();
	}
		
		
		
		
	
	function initParam0 (node) {
		var contrib = '<%=request.getParameter("contrib")%>' ;
		if( contrib != 'null') {
			return "<contributionName>"+contrib+"</contributionName>" ;
		}
	}
	 
	function initParam (node) {
		contributionName = node.getProperty('name');
		return "<contributionName>"+contributionName+"</contributionName>" ;
	}
	 
	function initParam1 (node) {
		return "<contributionName>"+contributionName+"</contributionName><packageName>"+node.getProperty("packageName")+"</packageName>" ;
	}
	   
	function createLink (node){
		node.setText("<input type='hidden' value='"+node.getProperty("packageName")+"' /><input type='hidden' value='"+node.getProperty("contributionName")+"' /><input type='checkbox' name='"+node.getProperty("path")+"' onclick='registerProcessDef(this)'  /><a onclick='editorWorkflow(this)' >"+node.getProperty("name"))+"</a>";
	}
	
	
	//包可选全选 onRefreshFunc="includePackageAll"
	function includePackageAll(node){
		node.setText("<input type='checkbox' value='"+node.getProperty("packageName")+"' />"+contributionName+"/"+node.getProperty("packageName"));
	}
</script>
</head>
<body class="workarea"  style="overflow:hidden; ">
<div style="position:absolute;width:270;  padding:5px;z-index:1; height: 300;overflow-x:auto;overflow-y:auto; ">
<nobr>
<r:rtree
	hasRoot="true" id="tree"><!-- 工作流资源库 -->
	<r:treeRoot display="<%=wfResLib%>"
		action="com.primeton.workflow.manager.def.processdef.getContributions.biz"
		initParamFunc="initParam0" childEntities="contributions" />

	<r:treeNode  action="com.primeton.workflow.manager.def.processdef.listPackages.biz" 
				initParamFunc="initParam" showField="name" nodeType="contributions" childEntities="packages" icon="/workflow/wfmanager/images/contribution.gif"/>
			
			<r:treeNode  showField="packageName" nodeType="packages" childEntities="files"
					      initParamFunc="initParam1" action="com.primeton.workflow.manager.def.processdef.listWFFiles.biz"  icon="/workflow/wfmanager/images/eospackage.gif"/>
		       
		    <r:treeNode  showField="name" nodeType="files" onRefreshFunc="createLink" icon="/workflow/wfmanager/images/processdef.gif"/>
		    
</r:rtree>
</nobr>
</div>
<div style="position:absolute; padding-top:0px; padding-left:5px; width:355px; left: 285px; top: 10px; height: 100px;" >
	
<!--单独提交使用IFrame
    <iframe align="left" name="versionInfo"
	src="<%=request.getContextPath()%>/workflow/wfmanager/definition/processdef_list/deploy_process.jsp"
	width="400" height="350" />
-->	
<!--批量提交使用隐藏层-->
    <table border="0" cellpadding="0" cellspacing="0" width="100%" name="optionEditor" id="optionEditor" style="display:">
		<tr>
			<td>
				<div>
					<fieldset>
						<legend><b:message key="deploy_multiprocesses_jsp.version_info"/></legend><!-- 版本相关信息 -->
						<div>
							<input type="radio" id="option/mode" name="option/mode"  value="default" disabled="true"  onclick="disableSelectbox(this,'true')">
							<label for="deployType_default"><b:message key="deploy_multiprocesses_jsp.submit_default"/></label><!-- 按照默认方式提交 -->
							<div style="padding-left:13px"> 
								<b:message key="deploy_multiprocesses_jsp.note"/>
							</div>
						</div>
						<div>
							<input type="radio" id="option/mode" name="option/mode"  value="old-version" disabled="true" onclick="disableSelectbox(this,'false')">
							<label for="deployType_update"><b:message key='deploy_multiprocesses_jsp.overwrite_exist'/></label><!-- 覆盖已有版本 -->
							<div style="padding-left:63px">
								<select id="version" name="version" size="4" style="width:240px" disabled="true"  onchange="modifyProperty(this,3)"">
								</select>
							</div>
						</div>
						<div>
							<input type="radio" id="option/mode" name="option/mode" value="new-version" disabled="true" onclick="disableSelectbox(this,'true')">
							<label for="deployType_new"><b:message key='deploy_multiprocesses_jsp.create_new'/></label><!-- 创建新版本 -->
						</div>
						<div>
							<div style="display:inline;padding-left:3px">
								<label for="isRelease"><b:message key='deploy_multiprocesses_jsp.release_now'/></label><!-- 立即发布 -->
							</div>
							<input type="checkbox" id="isRelease" name="isRelease"  disabled="true"   onblur="modifyProperty(this,4)">
						</div>
						<div>
							<div style="display:inline;padding-left:3px">
								<label for="description"><b:message key='deploy_multiprocesses_jsp.desc'/></label><!-- 描述 -->
							</div>
							<div style="display:inline;padding-left:29px">
								<textarea id="description" name="option/versionDesc" rows="4"  cols="40" onblur="modifyProperty(this,5)" disabled="true"></textarea>
							</div>
						</div>
					</fieldset>
				</div>
		</td>
		</tr> 
	</table>

</div>
<br/>
<form name="wfSelect" action="com.primeton.workflow.manager.def.deployeeProcessList.flow" method="post">
</form>
<div style="position:absolute; padding-top:0px; padding-left:5px; width:355px; left:300px; top: 350px; height: 100px;"">
					<input type="button" name="btnOk" class="button" value='<b:message key="defcommon.btn_ok"/>' onclick="deploy_process()">
					<input type="button" name="btnCancel" class="button" value='<b:message key="defcommon.btn_cancel"/>' onclick="closeWin()">
				</div>
</body>
<script type="text/javascript">
<!--
  function deploy_process(){
        var count=fillform();
        if(count==0){
        	alert('<b:message key="deploy_multiprocesses_jsp.select"/>');//请选择提交流程
        	return;
        }
        $name("btnOk").disabled= true;
        document.forms["wfSelect"].submit();
        
    }
    
    function fillform(){
        var fm = document.forms["wfSelect"];    
    	var count=0;
        for (var i=0;i<workflowDefArray.length;i++){
            var wd = workflowDefArray[i];
            if (!wd.status) continue;
            
            var prefix = 'deployInfoArr['+i+']/';
            
            add_hidden(fm,prefix+"name",wd.name);
            add_hidden(fm,prefix+"path",wd.path);
            add_hidden(fm,prefix+"version",wd.version);
            add_hidden(fm,prefix+"option_mode",wd.option_mode);
            add_hidden(fm,prefix+"isRelease",wd.isRelease);
            add_hidden(fm,prefix+"description",wd.description);
            add_hidden(fm,prefix+"contribution",wd.contributionName);
            count+=1;
            
        }
        return count;
    }   
    
    function add_hidden(fm,name,value){
            var h = document.createElement('input');
            h.type="hidden";
            h.name=name;
            h.value=value;
            fm.appendChild(h);
    }

//-->
</script>



</html>
