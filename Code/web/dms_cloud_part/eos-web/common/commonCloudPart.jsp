
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<link href="<%=webPath + contextPath %>/common/nui/res/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<script src="<%=webPath + contextPath %>/common/date.js" type="text/javascript"></script>
<script type="text/javascript">
	<%
		IMUODataContext muo = DataContextManager.current().getMUODataContext();
		String currUserName = "";
		String currUserId="";
		String currOrgid = "";
		if (muo != null) 
		{
			IUserObject userobject = muo.getUserObject();
			if (userobject != null) {
				//String ip = userobject.getUserRemoteIP();
				currUserName = userobject.getUserName();
				currUserId = userobject.getUserId();
				currOrgid = userobject.getUserOrgId();
			}
		}
	%>
	var currUserName = <%="'"+currUserName+"'"%>;
	var currOrgid = <%="'"+currOrgid+"'"%>;
	var currentTimeMillis =<%=System.currentTimeMillis()%>
	var cloudPartApiUrl = apiPath + cloudPartApi + "/";
	var cloudPartWebUrl = apiPath + contextPath + "/";
</script>
<script type="text/javascript">
	function getRoot() {
		var hostname = location.hostname;
		var pathname = location.pathname;
		var contextPath = pathname.split("/")[1];
		var port = location.port;
		var protocol = location.protocol;
		return protocol + "//" + hostname + ":" + port + "/" + contextPath
				+ "/";
	}

	window._rootUrl = getRoot();
	//console.log(window._rootUrl);

	var provinceHash = {};
	var provinceList = [];
	var cityHash = {};
	var cityList = [];
	var provinceEl = null;
	var cityEl = null;
	var addrEl=null;
	function onProvinceSelected(cityId) {
		if (provinceEl) {
			cityEl = nui.get(cityId);
			addrEl=nui.get('addr');
			var id = provinceEl.getValue();
			var code = provinceHash[id].code;
			var currCityList = cityList.filter(function(v) {
				return v.parentid == code;
			});
			cityEl.setData(currCityList);
			addrEl.setValue(provinceEl.getText());
		}
	}
	
	function onCitySelected(cityId){
		if(provinceEl && cityEl){
			cityEl = nui.get(cityId);
			addrEl=nui.get('addr');
			addrEl.setValue('');
			var text=cityEl.getText();
			if(text){
				addrEl.setValue(provinceEl.getText()+text);
			}	
		}
	}
	var getDictItemsUrl = apiPath + cloudPartApi + "/" + "com.hsapi.cloud.part.common.svr.getDictItems.biz.ext";//window._rootUrl		
	function getDictItems(dictIdList, callback) {
		var params = {};
		params.dictIdList = dictIdList;
		params.token = token;
		nui.ajax({
			url : getDictItemsUrl,
			type : "post",
			data : JSON.stringify(params),
			success : function(data) {
				if (data && data.dataItems) {
					callback && callback({
						code : "S",
						dataItems : data.dataItems
					});
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
	}
	var getProvinceAndCityUrl = apiPath + cloudPartApi + "/" + "com.hsapi.cloud.part.common.svr.getProvinceAndCity.biz.ext";
	function getProvinceAndCity(callback) {
		if (!provinceHash) {
			provinceHash = {};
		}
		if (!cityHash) {
			cityHash = {};
		}
		if (window.top._provinceList && window.top._cityList) {
			provinceList = window.top._provinceList;
			cityList = window.top._cityList;
			provinceList.forEach(function(v) {
				provinceHash[v.code] = v;
			});
			cityList.forEach(function(v) {
				cityHash[v.code] = v;
			});
			if (provinceEl) {
				provinceEl.setData(provinceList);
			}
			callback && callback({
				province : provinceList,
				city : cityList
			});
			console.log("getProvinceAndCity from client");
			return;
		}
		nui.ajax({
			url : getProvinceAndCityUrl,
			data: {token: token},
			type : "post",
			success : function(data) {
				if (data && data.province) {
					window.top._provinceList = data.province;
					provinceList = window.top._provinceList;
					window.top._cityList = data.city;
					provinceList.forEach(function(v) {
						provinceHash[v.id] = v;
					});
					if (provinceEl) {
						provinceEl.setData(provinceList);
					}
					cityList = window.top._cityList;
					cityList.forEach(function(v) {
						cityHash[v.code] = v;
					});
					callback && callback(data);
				//	console.log("getProvinceAndCity from server");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
	}
	var getStorehouseUrl = apiPath + cloudPartApi + "/" + "com.hsapi.cloud.part.baseDataCrud.crud.getStorehouse.biz.ext";
	function getStorehouse(callback) {
		nui.ajax({
			url : getStorehouseUrl,
			data : {token: token},
			type : "post",
			success : function(data) {
				if (data && data.storehouse) {
					callback && callback(data);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
	}
	var getAllCarBrandUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.queryCarBrand.biz.ext";
	function getAllCarBrand(callback) {
		nui.ajax({
			url : getAllCarBrandUrl,
			data : {token: token},
			type : "post",
			success : function(data) {
				if (data && data.data) {
					callback && callback(data);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
	}	
	var getAllPartBrandUrl = apiPath + sysApi + "/"+"com.hsapi.system.dict.dictMgr.queryPartBrand.biz.ext";
	function getAllPartBrand(callback)
	{
	    nui.ajax({
	        url:getAllPartBrandUrl,
	        data : {token: token},
	        type:"post",
	        async:false,
	        success:function(data)
	        {
	            if(data && data.quality && data.brand)
	            {
	                callback && callback(data);
	            }
	        },
	        error:function(jqXHR, textStatus, errorThrown){
	            //  nui.alert(jqXHR.responseText);
	            console.log(jqXHR.responseText);
	        }
	    });
	}
	var getAllPartTypeUrl = apiPath + sysApi + "/"+"com.hsapi.system.dict.dictMgr.queryPartType.biz.ext";
	function getAllPartType(callback)
	{
	    nui.ajax({
	        url:getAllPartTypeUrl,
	        data : {token: token},
	        type:"post",
	        async:false,
	        success:function(data)
	        {
	            if(data && data.partTypes)
	            {
	                callback && callback(data);
	            }
	        },
	        error:function(jqXHR, textStatus, errorThrown){
	            //  nui.alert(jqXHR.responseText);
	            console.log(jqXHR.responseText);
	        }
	    });
	}
	
	var getPartByIdUrl = apiPath + cloudPartApi+ "/"
	+ "com.hsapi.cloud.part.baseDataCrud.crud.getPartById.biz.ext";
	function getPartById(id, callback) {
		var params = {};
		params.id = id;
		nui.ajax({
			async: false,
			url : getPartByIdUrl,
			data : {
				id: id
			},
			success : function(data) {
				callback && callback(data);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
	}
	function addDate(date, days) {
        if (days == undefined || days == '') {
            days = 1;
        }
        var date = new Date(date);
        date.setDate(date.getDate() + days);
        var month = date.getMonth() + 1;
        var day = date.getDate();
    	return date.getFullYear() + '-' + getFormatDate(month) + '-' + getFormatDate(day);
    }

    // 日期月份/天的显示，如果是1位数，则在前面加上'0'
    function getFormatDate(arg) {
        if (arg == undefined || arg == '') {
            return '';
        }

        var re = arg + '';
        if (re.length < 2) {
            re = '0' + re;
        }

        return re;
    }
    
    function Trim(str,is_global){
	   var result;
	   result = str.replace(/(^\s+)|(\s+$)/g,"");
	   if(is_global.toLowerCase()=="g") {
	   		result = result.replace(/\s/g,"");
	   }
	   return result;
	}

	function numToMoneyField(inputString) {
	    regExpInfo = /(\d{1,3})(?=(\d{3})+(?:$|\.))/g;
	    var ret = inputString.toString().replace(regExpInfo, "$1,");
	    return ret;
	}
	
	//获取两个日期之间的年月数组
	function getYearMonthList(startDate, endDate){
		var yearMonthList = [];
		var diffMonths = getMonths(startDate, endDate);
		var startYear = (new Date(startDate)).getFullYear();
		var startMonth = (new Date(startDate)).getMonth() + 1;
		var yearMonthObj = {year: startYear, month: startMonth};
		var tempMonth = startMonth;
		if (tempMonth < 10) {
			tempMonth = "0" + tempMonth;
		}
		yearMonthObj.yearMonth = startYear.toString() + tempMonth.toString();
		yearMonthList.push(yearMonthObj);
		
		var endMonth = (new Date(endDate)).getDate();
		if(endMonth == 1) {
			diffMonths-=1;
		}
		if(diffMonths > 1){
			for(var i=0; i<diffMonths-1; i++){
				var tempObj = {};
				if(startMonth == 12){
					startYear+=1;
					startMonth = 1;
				}else{
					startMonth+=1;
				}

				tempMonth = startMonth;
				tempObj.year = startYear;
				if (tempMonth < 10) {
					tempMonth = "0" + tempMonth;
				}
				tempObj.month = startMonth;
				tempObj.yearMonth = startYear.toString() + tempMonth.toString();
				yearMonthList.push(tempObj);
			}
		}

		return yearMonthList;
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

	function Cleanup() {
		window.clearInterval(idTmr);
		CollectGarbage();
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

			document.getElementById(tagName).href = uri + base64(format(template, ctx));
			document.getElementById(tagName).download = name;
			document.getElementById(tagName).click();
		}
	})()

	//判断输入的信息是编码(全数字，数字+字母，数字+字母+符号)，名称(包含中文)，拼音(全字母)，目前不考虑全字母可能为编码的情况
	function judgeConditionType(value){
		//1代表编码，2代表名称，3代表拼音，-1输入信息有误
		if(!value) return -1;
		value = value.replace(/\s+/g, "");
		var reg = /^[0-9]*$/;//纯数字
		if(reg.test(value)){
			return 1;
		}

		var numReg = /[0-9]/;
		var zmReg = /[a-z]/i;
		if(numReg.test(value) && zmReg.test(value)){
			return 1;
		}

		var reg = new RegExp("[\\u4E00-\\u9FFF]+","g"); 
		if(reg.test(value)){
			return 2
		}

		return 3;
	}
	
	var dictField = ["enterTypeId","settType","settTypeId","billTypeId","managerDuty","guestType","supplierType"];
dictField.push("backReasonId");
var insureField = ["insureCompCode","insuranceSaliComany","insuranceBizComany"];
	function onDrawCell(e) {
		var hash = _initDmsHash || {};
		var field = e.field;
		var value = e.value;
		if (field == "carBrandId") {// 车辆品牌
			var carBrand = hash.carBrand || {};
			carBrand[value] && (e.cellHtml = carBrand[value].nameCn);
		} else if (dictField.indexOf(field) > -1) {
			var dict = hash.dict || {};
			dict[value] && (e.cellHtml = dict[value].name);
		}
		else if(field == "orgid")
		{
			var comp = hash.comp || {};
			comp[value] && (e.cellHtml = comp[value].orgname);
		}
		else if (insureField.indexOf(field) > -1)
		{
			var insureComp = hash.insureComp || {};
			insureComp[value] && (e.cellHtml = insureComp[value].fullName);
		}
	}
    function isUTF8(bytes) {
	    var i = 0;
	    while (i < bytes.length) {
	        if ((// ASCII
	            bytes[i] == 0x09 ||
	            bytes[i] == 0x0A ||
	            bytes[i] == 0x0D ||
	            (0x20 <= bytes[i] && bytes[i] <= 0x7E)
	        )
	        ) {
	            i += 1;
	            continue;
	        }
	        if ((// non-overlong 2-byte
	            (0xC2 <= bytes[i] && bytes[i] <= 0xDF) &&
	            (0x80 <= bytes[i + 1] && bytes[i + 1] <= 0xBF)
	        )
	        ) {
	            i += 2;
	            continue;
	        }
	        if ((// excluding overlongs
	            bytes[i] == 0xE0 &&
	            (0xA0 <= bytes[i + 1] && bytes[i + 1] <= 0xBF) &&
	            (0x80 <= bytes[i + 2] && bytes[i + 2] <= 0xBF)
	        ) ||
	            (// straight 3-byte
	                ((0xE1 <= bytes[i] && bytes[i] <= 0xEC) ||
	                    bytes[i] == 0xEE ||
	                    bytes[i] == 0xEF) &&
	                (0x80 <= bytes[i + 1] && bytes[i + 1] <= 0xBF) &&
	                (0x80 <= bytes[i + 2] && bytes[i + 2] <= 0xBF)
	            ) ||
	            (// excluding surrogates
	                bytes[i] == 0xED &&
	                (0x80 <= bytes[i + 1] && bytes[i + 1] <= 0x9F) &&
	                (0x80 <= bytes[i + 2] && bytes[i + 2] <= 0xBF)
	            )
	        ) {
	            i += 3;
	            continue;
	        }
	        if ((// planes 1-3
	            bytes[i] == 0xF0 &&
	            (0x90 <= bytes[i + 1] && bytes[i + 1] <= 0xBF) &&
	            (0x80 <= bytes[i + 2] && bytes[i + 2] <= 0xBF) &&
	            (0x80 <= bytes[i + 3] && bytes[i + 3] <= 0xBF)
	        ) ||
	            (// planes 4-15
	                (0xF1 <= bytes[i] && bytes[i] <= 0xF3) &&
	                (0x80 <= bytes[i + 1] && bytes[i + 1] <= 0xBF) &&
	                (0x80 <= bytes[i + 2] && bytes[i + 2] <= 0xBF) &&
	                (0x80 <= bytes[i + 3] && bytes[i + 3] <= 0xBF)
	            ) ||
	            (// plane 16
	                bytes[i] == 0xF4 &&
	                (0x80 <= bytes[i + 1] && bytes[i + 1] <= 0x8F) &&
	                (0x80 <= bytes[i + 2] && bytes[i + 2] <= 0xBF) &&
	                (0x80 <= bytes[i + 3] && bytes[i + 3] <= 0xBF)
	            )
	        ) {
	            i += 4;
	            continue;
	        }
	        return false;
	    }
	    return true;
	}


</script>
<style type="text/css">


table {
	font-size: 12px;
}
</style>