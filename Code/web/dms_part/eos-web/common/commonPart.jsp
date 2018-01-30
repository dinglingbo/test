<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:01:46
  - Description:
-->
<head>
<title>common</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=request.getContextPath()%>/common/nui/nui.js"
	type="text/javascript"></script>
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
</style>
</head>
<body>
	<script type="text/javascript">
		nui.parse();
	</script>
</body>
</html>