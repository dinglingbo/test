define(['text!bi/tpl.html', 'api'], function (tpl, api) {



  var controller = function (name) {
    $('.j_serach').css('height', '70px').removeClass('full').addClass('mini')
    var auth = decodeURIComponent(name.toString())
    var carAttrSubgroup = window.store.carAttrSubgroup
    if (!auth || !store.carInfo || !store.carInfo.vin || !store.carInfo.brand) {
      location.hash = '/'
    }

    var params = {
      vin: store.carInfo.vin,
      brand: store.carInfo.brand,
      auth: auth
    }
   

    var requestNum = 0
    var data = {
      partList: [],
      partImg: '',
      partMap: []
    }
    var imgSize = {
      ratio: 1,
      w: 0,
      h: 0
    }
    var offset = {
      x: 0,
      y: 0
    }

    load()
    
    function render () {
      if (requestNum === 2) {
        requestNum = 0
        appView.html(template.compile(tpl)(data))
        initSize()
        loadImg(function () {
          appView
            .find('.j_part-img')
            .attr({'src': data.partImg, 'width': imgSize.w * imgSize.scale + 'px', height: imgSize.h * imgSize.scale + 'px' })
            .show();
          renderMap()
        })
      }
    }

    appView
    .on('click', 'area', function() {
      var num = $(this).data('num')
      renderMapRect(num)
      $('.part-group').removeClass('active')
      $('.part-group[key="itid_'+ num +'"]').addClass('active')
    })
    .on('click', '.j_part-group', function() {
      var key = $(this).attr('key')
      var num = key.split('_')[1]
      renderMapRect(num)
      $('.part-group').removeClass('active')
      $('.part-group[key="itid_'+ num +'"]').addClass('active')
    })
    .on('click', '.j_back', function() {
      history.back()
    })
    .on('click', '.j_perv', function () {
      var index = 0
      carAttrSubgroup.forEach(function(item, i) {
        if (decodeURIComponent(item.auth) === params.auth) {
          index = i > 0 ? i - 1 : carAttrSubgroup.length - 1
        }
      })
      params.auth = decodeURIComponent(carAttrSubgroup[index].auth)
      load()
    })
    .on('click', '.j_next', function () {
      var index = 0
      carAttrSubgroup.forEach(function(item, i) {
        if (decodeURIComponent(item.auth) === params.auth) {
          index = i > carAttrSubgroup.length - 1 ? i + 1 : 0
        }
      })
      params.auth = decodeURIComponent(carAttrSubgroup[index].auth)
      load()
    })

    // 窗口大小改变
    $(window).resize(function() {
      initSize()
      loadImg(function () {
        appView
          .find('.j_part-img')
          .attr({'src': data.partImg, 'width': imgSize.w * imgSize.scale + 'px', height: imgSize.h * imgSize.scale + 'px' })
          .show();
        renderMap()
      })
      appView.find('.j_part-map-rect').html('')
      $('.part-group').removeClass('active')
    })

    function load () {
      api.fetchCarPartsText({
        params: params
      }).then(function(res) {
        requestNum++
        console.log(res.data.result.data)
        var partList = {}
        res.data.result.data.forEach(function(item) {
          if (partList.hasOwnProperty('itid_' + item.itid)) {
            partList['itid_' + item.itid].push(item)
          } else {
            partList['itid_' + item.itid] = [item]
          }
        })
        console.log(partList)
        window.store.carPartsText = partList
        data.partGroupList = partList
        render()
      })
      
      api.fetchCarPartsImg({
        params: params
      }).then(function(res) {
        requestNum++
        window.store.carPartsImg = res.data.result.data
        data.partImg = store.carPartsImg.imgurl
        data.partMap = store.carPartsImg.mapdata
        render()
      })
    }

    function loadImg (cb) {
      var img = new Image();
      img.onload = function () {
        imgSize.w = img.width;
        imgSize.h = img.height;
        imgSize.scale = appView.find('.j_part-img-container').width() / img.width
        offset.x = 0
        offset.y = ($('.j_part-img-container').height() - imgSize.h * imgSize.scale) / 2
        cb && cb()
    　}
      img.src = data.partImg
    }

    function renderMap () {
      var html = ''
      data.partMap.forEach(function(item, index) {
        console.log()
        var coords = [
          item.maxx * imgSize.scale,
          item.maxy * imgSize.scale,
          item.minx * imgSize.scale,
          item.miny * imgSize.scale
        ]
        html +='<area shape="rect" coords="' + coords.join(',') + '" data-index="'+ index +'" data-num="' + item.num + '" />'
      })
      appView.find('.j_part-img-map').html(html)
    }
    function renderMapRect(num) {
      var html = ''
      data.partMap.forEach(function(item, index) {
        if (item.num == num) {
          console.log(offset)
          var style = [
            'top:' + (item.miny * imgSize.scale - 2 + offset.y) + 'px',
            'left:' + (item.minx * imgSize.scale - 2 + offset.x) + 'px',
            'width:' + ((item.maxx- item.minx ) * imgSize.scale + 4) + 'px',
            'height:' + ((item.maxy- item.miny ) * imgSize.scale + 4) + 'px',
          ]
          html += '<div style="' + style.join(';') + '" class="part-rect"></div>'
        }
      })
      appView.find('.j_part-map-rect').html(html)
    }

    function initSize() {
      var winH = $(window).height()
      var headerH = $('.j_serach').outerHeight()

      $('#container').css('height', winH - headerH + 'px')
      
    }
    function reset() {
      appView.find('.j_part-img').hide()
      appView.find('.j_part-group-container').hide()
    }
  }

  


  controller.onRouteChange = function () {
    appView.off('click')  //解除所有click事件监听
  }

  return controller;
});