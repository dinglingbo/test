define(['text!ac/tpl.html', 'text!ac/media.html', 'api'], function (tpl, subGroupTpl, api) {
  


  var controller = function (name) {
    console.log(123,)
    try {
      var data = {
        group: store.carAttrGroup,
        carInfo: store.carInfo.mains.split(/\n/)[0]
      }
      $('.j_serach').css('height', '70px').removeClass('full').addClass('mini')
      appView.html(template.compile(tpl)(data))
    } catch (e) {
      location.hash = '/'
    }
    appView
      // 点击主组
      .on('click', '.j_attr-group-item', function(){
        var auth = $(this).data('auth')
        api.fetchCarAttrSubgroup({
          params: {
            auth: decodeURIComponent(auth),
            brand: store.carInfo.brand,
            is_filter: 1,
            vin: store.carInfo.vin
          }
        })
        .then(function(res) {
          window.store.carAttrSubgroup = res.data.result.data
          var data = {
            subGroup: window.store.carAttrSubgroup
          }
          appView.find('.j_subgroup-container').html(template.compile(subGroupTpl)(data))
        })
      })
      // 点击分组
      .on('click', '.j_attr－subgroup-item', function() {
        var auth = $(this).data('auth')
        location.hash = '/bi/' + auth

      })
  };

  

 
  
  controller.onRouteChange = function () {
    console.log('change');      //可以做一些销毁工作，例如取消事件绑定
    appView.off('click');   //解除所有click事件监听
  };

  return  controller
});