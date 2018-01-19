<%@page pageEncoding="UTF-8"%>
<%@ page import=" com.eos.system.utility.StringUtil" %>
<%
	String contextPath=request.getContextPath();
 %>
<html>
<!-- 
  - Author(s): xiongsh
  - Date: 2013-10-16 10:32:19
  - Description:
-->
<head>
<title>swfupload-demo</title><script type="text/javascript" src="<%=contextPath %>/common/nui/nui.js"></script>
<script type="text/javascript" src="<%=contextPath %>/common/components/swffileupload/swfupload/swffileupload.js"></script>


<style rel="stylesheet" type="text/css">
	fieldset{
		font-size:12px;
	}
	
	table{
		width:100%;
		border-collapse: collapse;
	}
	
	td{border:solid 1px #ccc;padding:5px; vertical-align: top;}
	th{border:solid 1px #ccc;background-color:#efefef;padding:2px;}
	
	#table_ps{font-size:12px;}
	
	#table_ps th{text-align:left;}
	
	input[type="button"]{
		font-weight:12;
		font-family:'微软雅黑';
		margin:5px;
	}
</style>

</head>
<body>
<table style="width:100%;table-layout:fixed;">
	<tr>
		<th style="width:300px;">配置</th>
		<th>示例</th>
		<th style="width:200px;">API</th>
	</tr>
	<tr>
		<td>
			<table id="table_ps">
				<tr>
					<th>renderTo</th>
					<td><input type="text" name="renderTo"/></td>
				</tr>
			</table>
		</td>
		<td>
			<form id="form1">
			<div id="upload_div"></div>
				<input type="text" name="username"/>
			</form>
		</td>
		<td>
			<input type="button" value="重新生成" onclick="initSF()"/>
			<br/>
			<input type="button" value="getValue()" onclick="getValue()"/>
			<br/>
			<input type="button" value="setValue()" onclick="setValue()"/>
			<br/>
			<input type="button" value="startUpload()" onclick="startUpload()"/>
			<br/>
			<input type="button" value="addPostParam()" onclick="addPostParam()"/>
			<br/>
			<input type="button" value="setPostParams()" onclick="setPostParams()"/>
			<br/>
			<input type="button" value="submitForm()" onclick="submitForm()"/>
			<br/>
			<input type="button" value="setDisable()" onclick="setDisable()"/>
			<br/>
			<input type="button" value="setEnable()" onclick="setEnable()"/>
			<br/>
			<input type="button" value="getNames()" onclick="getNames()"/>
		</td>
	</tr>
</table>
<script type="text/javascript">
	var config={};
	(function(){
		var ps=SWFFileUpload.prototype;
		var html=[];
		for(var p in ps){
			var psv=ps[p];
			var psvt=typeof(psv);
			
			if((psvt=='string'||psvt=='number'||psvt=='boolean')&&p.indexOf('__')!==0){
				config[p]=psv;
				
				html.push('<tr><th>'+p+'：</th><td><input valtype="'+psvt+'" name="'+p+'" value="'+psv+'"/></td></tr>');
			}
		}
		
		$('#table_ps').html(html.join(''));
	})();

	function getConfigData(){
		var data={};
		$('#table_ps input').each(function(){
			var valtype=$(this).attr('valtype');
			var v=this.value;
			switch(valtype){
				case 'number':
					v=this.value;
					break;
				case 'boolean':
					if(this.value==='true'){
						v=true;
					}else{
						v=false;
					}
					break;
				default:
					break;
			}
			data[this.name]=v;
		});
		
		return data;
	}
	function setConfigData(data){
		$('#table_ps input').each(function(){
			if(data[this.name]!==undefined){
				this.value=data[this.name];
			}
		});
	}
	
	function getElValue(el){
		
	}

	function initSF(){
		if(sf){
			sf.destroy();
		}
		var data=getConfigData();
		sf=new SWFFileUpload(data);
	}
	var sf;
	
	var value='<%=StringUtil.htmlFilter(request.getParameter("files")) %>'
	if(value=='null'){
		value='';
	}
	window.onload=function(){
		setConfigData({
			renderTo:'#upload_div',
			value:value,
			cancelBtnText:'取消上传',
			maxFileCount:3,
			minFileCount:1,
			width:'',
			height:'',
			//fileRenderType:'image',
			hasCancel:false,
			hiddenType:'nui'
		});
		
		initSF();
	}
	
	function getValue(){
		alert(sf.getValue());
	}
	
	function setValue(){
		sf.setValue('4028dd8141d8a6480141d98f05ba000f,4028dd8141d8a6480141d98f06660010');
	}
	
	function startUpload(succ){
		sf.startUpload(function(){
			alert('所有文件上传成功！');
			alert(sf.getFileNames());
			if(succ){
				$('#form1').submit();
			}
		},function(){
			alert('文件上传失败！');
		});
	}
	
	function submitForm(){
		startUpload(function(){
			$('#form1').submit();
		});
	}
	
	function addPostParam(){
		sf.addPostParam('testparam','hello,test');	
	}
	
	function setPostParams(){
		sf.setPostParams({
			a:1,
			b:2
		});
	}
	
	function setDisable(){
		sf.setDisable();
	}
	
	function setEnable(){
		sf.setEnable();
	}
	
	
	function getNames(){
		alert(sf.getFileNames());
	}
</script>	
</body>

</html>