
/*
* 命名SQL通用查询(可行转置列)
*/
function callNSQL(params, processAjax, callBack, obj){
	var url = "com.hs.common.unify.intfc.biz.ext";
	callAjax(url, params, processAjax, callBack, obj);
}

/*
* 执行Ajax
*/
function callAjax(url, params, processAjax, callBack, obj){
	if(obj){
        nui.mask({
            el: obj,
            cls: 'mini-mask-loading',
            html: '加载中...'
        });
    }
    
    if(params){
        params.token = token;
    }
    
    nui.ajax({
		url: url,
		type: "post",
        data:  nui.encode(params),
		contentType: 'text/json',
		success: function (json) {
            if(obj){
                nui.unmask(obj);
            }
            
            if(processAjax){
                processAjax(json, callBack);                
            }else if(callBack){
                callBack(json.result || json.data || json.rs, json);
            }
		},
		error: function () {
			showMsg("获取数据遇到错误！", "E");
            if(obj){
                nui.unmask(obj);
            }
		}
	});
}

/*
* 处理Ajax结果
*/
function processAjax(json, callBack){
    if(json.errCode != 'E'){//&& json.result.code == '1' 第三方接口定义代码
        //nui.alert("获取数据成功！");
        if(callBack){
            callBack(json.result || json.data || json.rs, json);
        }
    }
    else{
        //nui.alert("获取数据失败！\n\r[" + (json.errMsg) + "]");// || json.result.msg第三方接口定义消息
        if((json.errMsg || "操作失败！").indexOf("登录超时") > -1 ){
            backToLogin();
        }else{
            showMsg(json.errMsg || "操作失败！", "E");
        }
    }
}

function showSuccess(data, json){
    if(json.errCode == 'S'){
        showMsg(json.errMsg || "操作成功！");        
    }
}

/*
*处理键值对串为Array
*/
function processKeyValue(list){
    var dataList=[];
    var tmpList;
    var tmp={};
    for(var i=0; i<list.length; i++){
        tmpList = list[i].split(":");
        tmp.field1 = tmpList[0] || "";
        tmp.field2 = tmpList[1] || "";
        dataList[i] = nui.clone(tmp);
    }
    return dataList;
}

Number.prototype.toFixed = function( digits ){//处理部分浏览器不兼容返回结果不一致
    if(!digits){
    	digits = 0;
    }
    return (parseInt(this * Math.pow(10, digits) + 0.5)/Math.pow(10, digits)).toString();
}

//字数统计
function charCount(objId){
    var obj = nui.get("objId");
    var txt = obj.getInputText() || "";
    //target.setValue(txt.length);
    return txt.length;
}

//表单验证
function formValidate(tform){
    tform.validate();
    if (!tform.isValid()){
        showMsg(tform.getErrors().length + "个必填项未填写，请检查所有页填写信息！", "W")
        return false;
    }
    return true;    
}

//取消
function onCancel(){
    closeWindow("cancel"); //ok
}

//关闭
function closeWindow(action) {
    var a = true;
    if (action == "cancel") {
        a = window.confirm("是否关闭本页面？", "友情提示!");
    }
    
    if (a == true) {
        if (window.CloseOwnerWindow)
            return window.CloseOwnerWindow(action);
        else
            window.close();
    }
    return false;
}

//设置dataGrid的Column字典值(值，中文)
function setColVal(dataFrom, value, name, eValue){//数据源（控件），值，中文，实际值
    var dataList;
    if(typeof dataFrom=="string"){
        dataList = nui.get(dataFrom).getData();
    }else{
        dataList = dataFrom;
    }
    
    for (var i = 0; i < dataList.length; i++) {
        if (dataList[i][value] == eValue) return dataList[i][name];
    }
    return eValue;
}

//手机号验证
function checkMobile(str) {
    var reg = /^1\d{10}$/
    if (reg.test(str)) {
        return true;
    } else {
        showMsg("请输入正确的手机号码！", "W");
        return false;
    }
}

//车型选择
function selectCarModel(callBack) {
	nui.open({
		// targetWindow: window,,
		url : "com.hsweb.repair.common.carModelSelect.flow",
		title : "选择车型",
		width : 900,
		height : 600,
		allowDrag : true,
		allowResize : false,
		onload : function() {
		},
		ondestroy : function(action) {
			if (action == "ok") {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				if (data && data.carModel) {
					var carModel = data.carModel || {};
                    callBack && callBack(carModel);
					/*if (elId && nui.get(elId)) {
						nui.get(elId).setValue(carModel.id);
						nui.get(elId).setText(carModel.carModel);
					}
					if (carBrandId && nui.get(carBrandId)) {
						nui.get(carBrandId).setValue(carModel.carBrandId);
						if (nui.get(carBrandId).doValueChanged) {
							nui.get(carBrandId).doValueChanged();
						}
					}
					if (carModelId && nui.get(carModelId)) {
						nui.get(carModelId).setValue(carModel.id);
					}*/
				}
			}
		}
	});
}

//车牌验证  免验证权限
function isVehicleNumber(vehicleNumber) {
	vehicleNumber = CtoH(vehicleNumber)//全角转半角
	vehicleNumber = vehicleNumber.toUpperCase();//小写转大写
	var data = {};
    var result = false;
	if(currIsCanfreeCarnovin==1){
		data.result = true;
		data.vehicleNumber = vehicleNumber;
		return data; //有自由输入权限
	}
      //var express = /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
    	var express = /(^[\u4E00-\u9FA5]{1}[A-Z_0-9]{1}[A-Z_0-9]{4}[A-Z_0-9_挂学警港澳领]{1}$)|(^WJ[A-Z_0-9_\u4e00-\u9fa5]{1}[A-Z_0-9]{5}$)|(^WJ[A-Z_0-9]{2}[A-Z_0-9_\u4e00-\u9fa5]{1}[A-Z_0-9]{4}$)|(^[A-Z]{2}[0-9]{5}$)|(^[\u4E00-\u9FA5]{1}[A-Z]{1}[A-Z_0-9]{5}[A-Z_0-9_警领]{1}$)/;
      result = express.test(vehicleNumber);
      data.result=result;
      data.vehicleNumber = vehicleNumber;
    return data;
}

//车牌验证不受免验证权限控制
function isVehicleNumberNoJurisdiction(vehicleNumber) {
	vehicleNumber = CtoH(vehicleNumber)//全角转半角
	vehicleNumber = vehicleNumber.toUpperCase();//小写转大写
	var data = {};
    var result = false;
      //var express = /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
    	var express = /(^[\u4E00-\u9FA5]{1}[A-Z_0-9]{1}[A-Z_0-9]{4}[A-Z_0-9_挂学警港澳领]{1}$)|(^WJ[A-Z_0-9_\u4e00-\u9fa5]{1}[A-Z_0-9]{5}$)|(^WJ[A-Z_0-9]{2}[A-Z_0-9_\u4e00-\u9fa5]{1}[A-Z_0-9]{4}$)|(^[A-Z]{2}[0-9]{5}$)|(^[\u4E00-\u9FA5]{1}[A-Z]{1}[A-Z_0-9]{5}[A-Z_0-9_警领]{1}$)/;
      result = express.test(vehicleNumber);
      data.result=result;
      data.vehicleNumber = vehicleNumber;
    return data;
}

function validation(vin){
	vin = CtoH(vin)//全角转半角
	vin = vin.toUpperCase();//小写转大写
	var data = {};
	if(currIsCanfreeCarnovin==1){
		data.isNo= true;
		data.vin = vin
		return data; //有自由输入权限
	}
	if (vin.length > 0 && vin.length == 12){
		data.isNo= true;
		data.vin = vin
		return data; //12位车架号不验证规则；
	} 
    if (vin.length > 0 && vin.length != 17){
		data.isNo= false;
		data.vin = vin
		return data; 
    } 
    var vinVal = vin.toUpperCase();
    var charToNum = {'A':1,'B':2,'C':3,'D':4,'E':5,'F':6,'G':7,'H':8,'J':1,'K':2,'L':3,'M':4,'N':5,'P':7,'R':9,'S':2,'T':3,'U':4,'V':5,'W':6,'X':7,'Y':8,'Z':9};
    var obj = 0;
    var arr = new Array();
    for (var i = 0 ; i < vinVal.length; i++) {
      var temp = vinVal.charAt(i);

      if(charToNum[temp]) {
        arr[i] = charToNum[temp];
      }else{
        arr[i] = Number(temp);
      }
      if(i==8){
        arr[i] = vinVal.charAt(i);
      }
    }

    var a1 = 8;
    for (var i = 0; i < 7; i++) {
      obj += Number(arr[i]) * a1;
      a1--;
    }

    obj += Number(arr[7])*10;

    var a2 = 9;
    for (var i = 9; i < 17; i++) {
      obj += Number(arr[i]) * a2;
      a2--;
    }

    var result = Number(obj)%11;
    if(parseInt(result) === 10){
      result = 'X';
    }

    if(result == arr[8]){
		data.isNo= true;
		data.vin = vin
		return data; 
    }else{
		data.isNo= false;
		data.vin = vin
		return data; 
    } 
}

//JS把全角转为半角的函数  
function CtoH(str)  
{  
    var result="";  
    for (var i = 0; i < str.length; i++){  
        if (str.charCodeAt(i)==12288){  
            result+= String.fromCharCode(str.charCodeAt(i)-12256);  
            continue;  
        }  
        if (str.charCodeAt(i)>65280 && str.charCodeAt(i)<65375){  
            result+= String.fromCharCode(str.charCodeAt(i)-65248);  
        }else{  
            result+= String.fromCharCode(str.charCodeAt(i));  
        }  
    }  
    return result;  
}   

//发送消息
function sendNoticeMsg(socket,params){ 
	var message = new proto.Model(); 
	var content = new proto.MessageBody();
    message.setMsgtype(params.type);
    message.setCmd(params.cmd);
    message.setGroupid(params.group);
    message.setToken(params.sender);  
    message.setSender(params.sender);
    message.setReceiver(params.receiver);
    content.setContent(params.msg);
    content.setType(0);
    message.setContent(content.serializeBinary())
    socket.send(message.serializeBinary()); 
};
//导入时间限制
function importTimeLimit(){
	//免限制权限账户
	if(currLoginName=="sysadmin"||currLoginName=="sysqxy"||currLoginName=="sysqpy"||currLoginName=="SYSADMIN"||currLoginName=="SYSQXY"||currLoginName=="SYSQPY"){
		return true;
	}else{
		var d2=new Date();
		var fullYear = d2.getFullYear();
		var month = d2.getMonth()+1;
		var date = d2.getDate();
		
		var limitMinData = fullYear+"-"+month+"-"+date+" 19:00:00";
		var limitMaxData = fullYear+"-"+month+"-"+(date+1)+" 07:00:00";
		var mixMinDate = fullYear+"-"+month+"-"+date+" 23:59:59";
		var mixMaxDate = fullYear+"-"+month+"-"+date+" 00:00:00";
		limitMinData = limitMinData.replace("-","/");//替换字符，变成标准格式  
		limitMaxData = limitMaxData.replace("-","/");//替换字符，变成标准格式   
		mixMinDate = mixMinDate.replace("-","/");
		mixMaxDate = mixMaxDate.replace("-","/");
		var d1 = new Date(Date.parse(limitMinData)); 
		var d3 = new Date(Date.parse(limitMaxData)); 
		var d4 = new Date(Date.parse(mixMinDate)); 
		var d5 = new Date(Date.parse(mixMaxDate)); 
		if((d2>d1&&d2<d4)||(d2<d3&&d2>d5)){
			return true;
		}else{
			return false;
		}
	}

}
function method5(tableid, name, tagName) {
	if (getExplorer() == 'ie') {
		var curTbl = document.getElementById(tableid);
		var oXL = new ActiveXObject("Excel.Application");
		var oWB = oXL.Workbooks.Add();
		var xlsheet = oWB.Worksheets(1);
		var sel = document.body.createTextRange();
		sel.moveToElementText(curTbl);
		sel.select();
		sel.execCommand("Copy");
		xlsheet.Paste();
		oXL.Visible = true;

		try {
			var fname = oXL.Application.GetSaveAsFilename("Excel.xls", "Excel Spreadsheets (*.xls), *.xls");
		} catch (e) {
			print("Nested catch caught " + e);
		} finally {
			oWB.SaveAs(fname);
			oWB.Close(savechanges = false);
			oXL.Quit();
			oXL = null;
			idTmr = window.setInterval("Cleanup();", 1);
		}

	} else {
		tableToExcel(tableid,name,tagName);

	}
}

//用于数据导出成EXCEL
var idTmr;
function getExplorer() {
	var explorer = window.navigator.userAgent;
	//ie  
	if (explorer.indexOf("MSIE") >= 0) {
		return 'ie';
	}
	//firefox  
	else if (explorer.indexOf("Firefox") >= 0) {
		return 'Firefox';
	}
	//Chrome  
	else if (explorer.indexOf("Chrome") >= 0) {
		return 'Chrome';
	}
	//Opera  
	else if (explorer.indexOf("Opera") >= 0) {
		return 'Opera';
	}
	//Safari  
	else if (explorer.indexOf("Safari") >= 0) {
		return 'Safari';
	}
}

var tableToExcel = (function() {
	var uri = 'data:application/vnd.ms-excel;base64,',
		template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel"' +
        'xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>'
        + '<x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets>'
        + '</x:ExcelWorkbook></xml><![endif]-->' +
        '<head><meta charset="UTF-8"></head><body><table>{table}</table></body></html>',
		base64 = function(s) {
			return window.btoa(unescape(encodeURIComponent(s)))
		},
		format = function(s, c) {
			return s.replace(/{(\w+)}/g,
				function(m, p) {
					return c[p];
				});
		};
	return function(table, name, tagName) {
		if (!table.nodeType) table = document.getElementById(table);
		var ctx = {
			worksheet: name || 'Worksheet',
			table: table.innerHTML
		};
		//window.location.href = uri + base64(format(template, ctx));
		document.getElementById(tagName).hreflang = 'zh'; 
		document.getElementById(tagName).charset = 'utf8'; 
		
        let blob = new Blob([format(template, ctx)]);
        document.getElementById(tagName).href = URL.createObjectURL(blob);//解决由于数据量太大导致chrome导出出现网络错误（由于url长度限制）
		//document.getElementById(tagName).href = uri + base64(format(template, ctx));
		document.getElementById(tagName).download = name+'.xls';
		document.getElementById(tagName).target = '_blank'; 
		document.getElementById(tagName).tableBorder = 1
		document.getElementById(tagName).click();
	}
})()

//多级导出
function setInitExportData( detail,columns,tableName){
	var tds = "";
	for(var i = 0;i<columns.length;i++){
		var columnsList = columns[i].columns||[];
		if(columnsList.length>0){			
			for(var j = 0;j<columnsList.length;j++){
				if(columnsList[j].field=="orgid"){
					
				}else{
					if(columnsList[j].visible) {
						var str = columnsList[j].field;
						tds+='<td colspan="1" align="center">['+str+']</td>';	
					}
				}
	
			}
		}
	}   
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
    	var temp = tds;//y循环完重新赋值
        var row = detail[i];
            var tr = $("<tr></tr>");
            		for(var k = 0; k < columns.length; k++) {
            			var columnsList = columns[k].columns||[];
            			if(columnsList.length>0){			
            				for(var j = 0;j<columnsList.length;j++){	
            					if(columnsList[j].visible) {
	            					var str = columnsList[j].field;
	            					//如果是日期
	            					if(columnsList[j].dateFormat){
	            						temp = temp.replace("["+str+"]", nui.formatDate(detail[i][str]?detail[i][str]:"",'yyyy-MM-dd HH:mm'));
	            					}else{
	            						if(detail[i][str]!=0){   							
	            							temp = temp.replace("["+str+"]", detail[i][str]?detail[i][str]:"");
	            						}else{
	            							temp = temp.replace("["+str+"]", detail[i][str]);
	            						}
	            					}	
	            				}

            				}
            			}
            		} 
            		tr.append(temp);
            tableExportContent.append(tr);
    }

    method5('tableExcel',tableName,'tableExportA');
}

//dataGrid多级列集合对象
function exportMultistage(columns){
	var html="";
	html+='	<table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0"> ';
	html+='		<tr> ';
	for(var i = 0;i<columns.length;i++){
		if(columns[i].header!="序号" && columns[i].type!="expandcolumn" && columns[i].type!="checkcolumn" && columns[i].visible == true){			
			//var str = columns[i].header;
			//html+='<th colspan="'+columns[i].columns.length+'" align="center">'+str+'</th>';
			var childColumns = columns[i].columns||[];
			var headerShow = false;
			var headerColspan = 0;
			for(var j=0; j<childColumns.length; j++) {
				var visible = childColumns[j].visible;
				if(headerShow == false && visible == true) {
					headerShow = true;
				}
				if(visible) {
					headerColspan++;
				}
			}
			if(headerShow) {
				var str = columns[i].header;
				html+='<th colspan="'+headerColspan+'" align="center">'+str+'</th>';
			}
		}
	}
	html+='		</tr> ';
	html+='		<tr> ';
	for(var i = 0;i<columns.length;i++){
		var columnsList = columns[i].columns||[];
		if(columnsList.length>0){			
			for(var j = 0;j<columnsList.length;j++){
				var str = columnsList[j].header||"";
				if(str=="所属公司"){
					
				}else{				
					if(columnsList[j].visible) {
						str = str.replace('<div class="icon-filter headerfilter-trigger"></div>',"");		
						html+='			<td colspan="1" align="center">'+str+'</td>';
					}
				}
			}
		}
	}
	html+='		</tr> ';
	html+='	<tbody id="tableExportContent"> ';	
	html+='	</tbody> ';	
	html+='	</table> ';	
	html+='	<a href="" id="tableExportA"></a> ';	
	document.getElementById("exportDiv").innerHTML=html;
}


function setInitExportDataNoMultistage( detail,columns,tableName){
	var tds = "";
	for(var i = 0;i<columns.length;i++){
		if(columns[i].field&&columns[i].field != "orgid"&&columns[i].visible==true){
			var str = columns[i].field;
			tds+='<td colspan="1" align="center">['+str+']</td>';
		}
		
	}   
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
    	var temp = tds;//y循环完重新赋值
        var row = detail[i];
            var tr = $("<tr></tr>");
            		for(var k = 0; k < columns.length; k++) {		
            			if(columns[k].visible) {
	    					var str = columns[k].field;
	    					//如果是日期
	    					if(columns[k].dateFormat){
	    						temp = temp.replace("["+str+"]", nui.formatDate(detail[i][str]?detail[i][str]:"",'yyyy-MM-dd HH:mm'));
	    					}else{
	    						if(detail[i][str]!=0){   							
	    							temp = temp.replace("["+str+"]", detail[i][str]?detail[i][str]:"");
	    						}else{
	    							temp = temp.replace("["+str+"]", 0);
	    						}
	    					}	
	            		}

            		} 
            		tr.append(temp);
            tableExportContent.append(tr);      
    }

    method5('tableExcel',tableName,'tableExportA');
}

//dataGrid单级列集合对象
function exportNoMultistage(columns){
	var html="";
	html+='	<table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0"> ';
	html+='		<tr> ';
	for(var i = 0;i<columns.length;i++){	
		if(columns[i].field&&columns[i].header!="所属公司" && columns[i].visible == true){
			var str = columns[i].header||"";
			str = str.replace('<div class="icon-filter headerfilter-trigger"></div>',"");		
			html+='			<td colspan="1" align="center">'+str+'</td>';
		}
	}
	html+='		</tr> ';
	html+='	<tbody id="tableExportContent"> ';	
	html+='	</tbody> ';	
	html+='	</table> ';	
	html+='	<a href="" id="tableExportA"></a> ';	
	document.getElementById("exportDiv").innerHTML=html;
}