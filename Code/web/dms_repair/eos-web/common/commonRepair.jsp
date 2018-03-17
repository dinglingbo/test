<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/sysCommon.jsp"%>
<script type="text/javascript">
	
<%IMUODataContext muo = DataContextManager.current()
					.getMUODataContext();
			String currUserName = "";
			String currOrgid = "";
			String currOrgName = "";
			if (muo != null) {
				IUserObject userobject = muo.getUserObject();
				if (userobject != null) {
					//String ip = userobject.getUserRemoteIP();
					currUserName = userobject.getUserRealName();
					currOrgid = userobject.getUserOrgId();
					currOrgName = userobject.getUserOrgName();
				}
			}%>
	var currUserName =
<%="'" + currUserName + "'"%>
	;
	var currOrgid =
<%="'" + currOrgid + "'"%>
	;
	var currOrgName =
<%="'" + currOrgName + "'"%>
	;
	var currentTimeMillis =
<%=System.currentTimeMillis()%>
	;
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
	function doPost(opt) {
		var url = opt.url;
		var data = opt.data;
		var success = opt.success || function() {
		};
		var error = opt.error || function() {
		};
		data.orgid = currOrgid;
		data.userName = currUserName;
		nui.ajax({
			url : url,
			type : "post",
			data : JSON.stringify(data),
			success : success,
			error : error
		});
	}
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
	var getDatadictionariesUrl = window._rootUrl
			+ "com.hsapi.repair.common.common.getDatadictionaries.biz.ext";
	function getDatadictionaries(parentId, callback) {
		var params = {};
		params.parentId = parentId;
		doPost({
			url : getDatadictionariesUrl,
			data : params,
			success : function(data) {
				callback && callback(data);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
				callback && callback({});
			}
		});
	}

	var getDictItemsUrl = window._rootUrl
			+ "com.hsapi.repair.common.common.getDictItems.biz.ext";
	function getDictItems(dictIdList, callback) {
		var params = {};
		params.dictIdList = dictIdList;
		doPost({
			url : getDictItemsUrl,
			data : params,
			success : function(data) {
				callback && callback(data);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
	}
	var getProvinceAndCityUrl = window._rootUrl
			+ "com.hsapi.repair.common.common.getProvinceAndCity.biz.ext";
	function getProvinceAndCity(callback) {
		nui.ajax({
			url : getProvinceAndCityUrl,
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

	var getAllCarBrandUrl = window._rootUrl
			+ "com.hsapi.part.common.svr.getAllCarBrand.biz.ext";
	function getAllCarBrand(callback) {
		doPost({
			url : getAllCarBrandUrl,
			data : {},
			success : function(data) {
				callback && callback(data);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
				callback && callback({});
			}
		});
	}
	var getCarSeriesByBrandIdUrl = window._rootUrl
			+ "com.hsapi.repair.common.common.getCarSeriesByBrandId.biz.ext";
	function getCarSeriesByBrandId(brandId, callback) {
		var params = {};
		params.brandId = brandId;
		doPost({
			url : getCarSeriesByBrandIdUrl,
			data : params,
			success : function(data) {
				callback && callback(data);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
				callback && callback(null);
			}
		});
	}
	var getCarModelByBrandIdUrl = window._rootUrl
			+ "com.hsapi.repair.common.common.getCarModelByBrandId.biz.ext";
	function getCarModelByBrandId(brandId, callback) {
		var params = {};
		params.brandId = brandId;
		doPost({
			url : getCarModelByBrandIdUrl,
			data : params,
			success : function(data) {
				callback && callback(data);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
				callback && callback(null);
			}
		});
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