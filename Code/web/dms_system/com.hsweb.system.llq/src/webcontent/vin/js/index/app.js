define(['api'], function(api) {
  'use strict';
  return function () {
    console.log(1234)
    var $serach = $('.j_serach')
    $serach.css('height', $(window).height() + 'px')
    $serach.removeClass('mini').addClass('full')
    $('#container').html()
    $serach
      // 查询车架号
      .on('keyup', '.j_serach-input', function() {
        var $searchInfo = $serach.find('.j_search-info')
        var val = $(this).val()
        api.fetchSearch({vin: val})
          .then(function(res){
            var data = res.data.data
            var html = ''
            data.forEach(function(item) {
              if (item.vin) {
              html += '<li>' + item.brandname + ' - '+ item.vin + '</li>'
              }
            })
            html && $searchInfo.html(html).show()
          })
          .catch(function(err) {
            alert('查询失败')
          })
      })
      // 选择车架号
      .on('click', '.j_search-info li', function() {
        $serach.find('.j_serach-input').val($(this).text().split('-')[1])
        $serach.find('.j_search-info').hide()
      })
      // 搜索车架号
      .on('submit', '.j_serach-form', function(e) {
        e.preventDefault()
        $('.j_search-btn').prop('disabled', true).text('查询中...')
        var vin = $serach.find('.j_serach-input').val()
        api.fetchCarInfo({params: {vin: vin}})
          .then(function(res) {
            window.store.carInfo = res.data.result.data
            if (res.data.result.code == 0) {
//            	alert(res.data.result.msg)
            	throw new Error(res.data.result.msg)
            } else {
            	return api.fetchCarAttrGroup({params: {vin: vin, brand: window.store.carInfo.brand}})
            }
          })
          .then(function(res){
            window.store.carAttrGroup = res.data.result.data
            $('.j_search-btn').prop('disabled', false).text('查询')
            location.hash = 'ac'
          })
          .catch(function(res) {
        	  console.log(res)
            $('.j_search-btn').prop('disabled', false).text('查询')
            alert(res.message)
          })
      })
  }
})