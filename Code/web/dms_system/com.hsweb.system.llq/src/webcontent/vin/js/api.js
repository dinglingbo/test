define(['axios'], function(axios) {
  'use strict';
  var root = webPath + sysDomain;//'http://127.0.0.1:8080/default'
  var api = {
    search: {
      url: root + '/com.hsweb.system.llq.vin.vin.searchHistory.biz.ext',
    },
    carInfo: {
      url: root + '/llq/vin/com.hsweb.system.llq.call.doCall.biz.ext',
      originUrl: 'https://llq.007vin.com/ppyvin/searchvins'
    },
    carAttrGroup: {
      url: root + '/llq/vin/com.hsweb.system.llq.call.doCall.biz.ext',
      originUrl: 'https://llq.007vin.com/ppyvin/group'
    },
    carAttrSubgroup: {
      url: root + '/llq/vin/com.hsweb.system.llq.call.doCall.biz.ext',
      originUrl: 'https://llq.007vin.com/ppyvin/subgroup'
    },
    carPartsText: {
      url: root + '/llq/vin/com.hsweb.system.llq.call.doCall.biz.ext',
      originUrl: 'https://llq.007vin.com/ppyvin/parts'
    },
    carPartsImg: {
      url: root + '/llq/vin/com.hsweb.system.llq.call.doCall.biz.ext',
      originUrl: 'https://llq.007vin.com/ppycars/subimgs'
    } 
  }

  function getQueryString(name) {
    try {
      var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)","i");
      var r = window.location.search.substr(1).match(reg);
      if (r!=null) return unescape(r[2]); return null;
    } catch (e) {
      alert ('请传递token')
    }
  }

  var request = function (url, params) {
    params.token = token;//getQueryString('token')
    api[url].originUrl && (params.url = api[url].originUrl)
    return axios.post(api[url].url, params)
  }
  return {
    fetchSearch: function (params) { return request('search', params) },
    fetchCarInfo: function (params) { return request('carInfo', params) },
    fetchCarAttrGroup: function (params) { return request('carAttrGroup', params) },
    fetchCarAttrSubgroup: function (params) { return request('carAttrSubgroup', params) },
    fetchCarPartsText: function (params) { return request('carPartsText', params) },
    fetchCarPartsImg: function (params) { return request('carPartsImg', params) },
  }
})

