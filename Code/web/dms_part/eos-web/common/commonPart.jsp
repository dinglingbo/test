
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.eos.data.datacontext.IMUODataContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<script src="<%=request.getContextPath()%>/common/nui/nui.js"
	type="text/javascript"></script>
<script type="text/javascript">
	
<%IMUODataContext muo = DataContextManager.current()
					.getMUODataContext();
			String currUserName = "";
			String currOrgid = "";
			if (muo != null) {
				IUserObject userobject = muo.getUserObject();
				if (userobject != null) {
					//String ip = userobject.getUserRemoteIP();
					currUserName = userobject.getUserRealName();
					currOrgid = userobject.getUserOrgId();
				}
			}%>
	var currUserName =
<%="'" + currUserName + "'"%>
	;
	var currOrgid =
<%="'" + currOrgid + "'"%>
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

	var getDictItemsUrl = window._rootUrl
			+ "com.hsapi.part.common.svr.getDictItems.biz.ext";
	function getDictItems(dictIdList, callback) {
		var params = {};
		params.dictIdList = dictIdList;
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
	var getProvinceAndCityUrl = window._rootUrl
			+ "com.hsapi.part.common.svr.getProvinceAndCity.biz.ext";
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
	var getStorehouseUrl = window._rootUrl
			+ "com.hsapi.part.baseDataCrud.crud.getStorehouse.biz.ext";
	function getStorehouse(callback) {
		nui.ajax({
			url : getStorehouseUrl,
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
	var getStorehouseUrl = window._rootUrl
			+ "com.hsapi.part.baseDataCrud.crud.getStorehouse.biz.ext";
	function getStorehouse(callback) {
		nui.ajax({
			url : getStorehouseUrl,
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
	var getAllCarBrandUrl = window._rootUrl
			+ "com.hsapi.part.common.svr.getAllCarBrand.biz.ext";
	function getAllCarBrand(callback) {
		nui.ajax({
			url : getAllCarBrandUrl,
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
	var getOrgListUrl = window._rootUrl
			+ "com.hsapi.part.common.svr.getOrgList.biz.ext";
	function getOrgList(callback) {
		nui.ajax({
			url : getOrgListUrl,
			type : "post",
			success : function(data) {
				if (data && data.orgList) {
					callback && callback({
						code : "S",
						orgList : data.orgList
					});
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
	}
	var getAllPartBrandUrl = window._rootUrl
			+ "com.hsapi.part.common.svr.getAllPartBrand.biz.ext";
	function getAllPartBrand(callback) {
		nui.ajax({
			url : getAllPartBrandUrl,
			type : "post",
			success : function(data) {
				if (data && data.quality && data.brand) {
					callback && callback(data);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
	}
	var getPartByIdUrl = window._rootUrl
			+ "com.hsapi.part.baseDataCrud.crud.getPartById.biz.ext";
	function getPartById(id, callback) {
		var params = {};
		params.id = id;
		nui.ajax({
			url : getPartByIdUrl,
			type : "post",
			data : JSON.stringify(params),
			success : function(data) {
				callback && callback(data);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
	}
	var getOrgListUrl = window._rootUrl
			+ "com.hsapi.part.common.svr.getOrgList.biz.ext";
	function getOrgList(callback) {
		nui.ajax({
			url : getOrgListUrl,
			type : "post",
			success : function(data) {
				if (data && data.orgList) {
					callback && callback({
						code : "S",
						orgList : data.orgList
					});
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
	}
	var getRoleMemberUrl = window._rootUrl
			+ "com.hsapi.part.common.svr.getRoleMemberByRoleId.biz.ext";
	function getRoleMember(roleId, callback) {
		var params = {};
		params.roleId = roleId;
		nui.ajax({
			url : getRoleMemberUrl,
			type : "post",
			data : JSON.stringify(params),
			success : function(data) {
				callback && callback(data);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				//  nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
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