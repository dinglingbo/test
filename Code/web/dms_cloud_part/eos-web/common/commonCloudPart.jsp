
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<script src="<%=request.getContextPath()%>/common/nui/nui.js"
	type="text/javascript"></script>
<script src="<%= request.getContextPath() %>/common/date.js" type="text/javascript"></script>
<script type="text/javascript">
	<%
		IMUODataContext muo = DataContextManager.current().getMUODataContext();
		String currUserName = "";
		String currOrgid = "";
		if (muo != null) 
		{
			IUserObject userobject = muo.getUserObject();
			if (userobject != null) {
				//String ip = userobject.getUserRemoteIP();
				currUserName = userobject.getUserRealName();
				currOrgid = userobject.getUserOrgId();
			}
		}
	%>
	var currUserName = <%="'"+currUserName+"'"%>;
	var currOrgid = <%="'"+currOrgid+"'"%>;
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
	function onProvinceSelected(cityId) {
		if (provinceEl) {
			cityEl = nui.get(cityId);
			var id = provinceEl.getValue();
			var currCityList = cityList.filter(function(v) {
				return v.provinceId == id;
			});
			cityEl.setData(currCityList);
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
		nui.ajax({
			url : getProvinceAndCityUrl,
			data: {token: token},
			type : "post",
			success : function(data) {
				if (data) {
					callback && callback(data);
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
	var getAllCarBrandUrl = apiPath + cloudPartApi + "/" + "com.hsapi.cloud.part.common.svr.getAllCarBrand.biz.ext";
	function getAllCarBrand(callback) {
		nui.ajax({
			url : getAllCarBrandUrl,
			data : {token: token},
			type : "post",
			success : function(data) {
				if (data && data.carBrands) {
					callback && callback(data);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
	}	
	var getAllPartBrandUrl = apiPath + cloudPartApi + "/"+"com.hsapi.cloud.part.common.svr.getAllPartBrand.biz.ext";
	function getAllPartBrand(callback)
	{
	    nui.ajax({
	        url:getAllPartBrandUrl,
	        data : {token: token},
	        type:"post",
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
</script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

table {
	font-size: 12px;
}
</style>