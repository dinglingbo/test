//http://14.23.35.20:6288/dms/com.hsweb.system.llq.call.doCall.biz.ext

var url = apiPath + sysApi + "/com.hsapi.system.llq.call.maintenanceCallV.biz.ext";
//com.hsapi.system.llq.call.doCallV2(原)
//var llq_pre_url = "https://llqapitm.007vin.com";//http://124.172.221.179:81  https://llqapitm.007vin.com
var llq_pre_url = "";//"http://124.172.221.179:81";
function loadData(url, params, callBack){
	callAjax(url, params, processRs);
    nui.ajax({
		url: url,
		type: "post",
		cache: false,
        data: params,
		contentType: 'text/json',
		success: function (json) {
            if(json.result.code == '1'){
                //nui.alert("获取数据成功！");
                callBack(json.result.data);
            }
            else{
                nui.alert("获取数据失败！");
            }
		},
		error: function () {
			nui.alert("获取数据遇到错误！");
		}
	});
}

/*
* 执行Ajax
*/

function callAjax(url, params, processAjax, callBack){
    //url = url.replace("llq.","llqapitm.");
    params.token = token;//"214e2f71-4237-4601-9a1a-538bf982b995";
	nui.ajax({
		async: false,
		url: url,
		type: "post",
        data: params,
		contentType: 'text/json',
		success: function (json) {
            processAjax(json, callBack);
		},
		error: function () {
			nui.alert("获取数据遇到错误！");
		}
	});
}

/*
* 处理Ajax结果
*/
function processAjax(rs, callBack){
    if(rs.errCode != 'E' && rs.result.code == '1'){
        //nui.alert("获取数据成功！");
        callBack(rs.result.data, rs.result);
    }else if(rs.errCode != 'E' && rs.result.code == '0'){//零件接口成功返回0
        //nui.alert("获取数据成功！");
        callBack(rs.result.data, rs.result);
    }else if(rs.errCode != 'E' && rs.result.code == '6'){//针对输入零件号判断品牌的接口,如果
        var data = rs.result.data;
        if(data && data.length > 0){
            callBack(rs.result.data, rs.result);
        }else{
            nui.alert("获取数据失败！\n\r[" + (rs.errMsg || rs.result.msg) + "]");
        }
    }else if(rs.errCode != 'E' && rs.result.code == '4007'){
        selectBrand(rs.result.brand_list, rs.result);//brandQuery
    }else if(rs.errCode != 'E' && rs.result.code == '4005'){
        //alert("该类型正在调试中，后续开放！[4005]");
        selectConfig(rs.result.brand_list, rs.result);
    }else if(rs.errCode != 'E' && rs.result.code == '4003'){
        selectBrand4003(rs.result.data, rs.result);
    }else{
        nui.alert("获取数据失败！\n\r[" + (rs.errMsg || rs.result.msg) + "]");
    }
}

/*
*处理键值对串
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

/*
*零件图片处理
*/
var imgSize = {
    ratio: 1,
    w: 0,
    h: 0
}
var offset = {
    x: 0,
    y: 0
}
var partData = {}

function setPartImg(data, rs){
    partData = data;
    $('.j_part-img').attr({'src': "", 'width': '0px', height: '0px'}).show();
    
    loading();
    var img = new Image();
    img.onload = function () {
        imgSize.w = img.width;
        imgSize.h = img.height;
        if (($('.j_part-img-container').width() / img.width) * 10000 > ($('.j_part-img-container').height() / img.height) * 10000) {
            imgSize.scale = $('.j_part-img-container').width() / img.width;
        } else {
            imgSize.scale = $('.j_part-img-container').height() / img.height;
        }
        
        offset.x = 0;
        offset.y = ($('.j_part-img-container').height() - imgSize.h * imgSize.scale) / 2;

        $('.j_part-img').attr({'src': data.imgurl, 'width': imgSize.w * imgSize.scale + 'px', height: imgSize.h * imgSize.scale + 'px'}).show();


        var html = '';
	    data.mapdata.forEach(function(item, index) {
	        item = checkMapItem(item);
            var coords = [
	          item.maxx * imgSize.scale,
	          item.maxy * imgSize.scale,
	          item.minx * imgSize.scale,
	          item.miny * imgSize.scale
	        ];
	        html +='<area shape="rect" coords="' + coords.join(',') + '" data-index="'+ index +'" data-num="' + item.num + '" />';
	    });
	    $('.j_part-img-map').html(html);
    }

    img.src = data.imgurl;
    //$('.part-img-container').show();
    
}

function loading() {
    nui.mask({
        el: document.getElementById("vin_part_img"),
        cls: 'mini-mask-loading',
        html: '加载中...'
    });
    setTimeout(function () {
        nui.unmask(document.getElementById("vin_part_img"));
    }, 1000);
}


$('.j_part-img-container area').live('click', function() {
    var num = $(this).data('num');
    renderMapRect(num);

    clearSelectedCls();
    gridParts.clearSelect(false);
    addRowCls(num);
    //$('.part-group').removeClass('active')
    //$('.part-group[key="itid_'+ num +'"]').addClass('active')
});

//清除选中行的样式
function clearSelectedCls(){
    var rows = gridParts.findRows(function(row) {
        if (row){
            gridParts.removeRowCls(row, "select-row");
            return true;
        }  
    });
}

//添加行样式
function addRowCls(num){
    var rows = gridParts.findRows(function(row) {
        if (row.num && row.num == num){
            gridParts.addRowCls(row, "select-row");
            return true;
        }  
    });

    if(rows && rows.length > 0) {
        //定位滚动条到行
        gridParts.scrollIntoView(rows[0]);
    }
}

function renderMapRect(num) {
  var html = ''
  partData.mapdata.forEach(function(item, index) {
    item = checkMapItem(item);
    if (item.num == num) {
      var style = [
        'top:' + (item.miny * imgSize.scale) + 'px',
        'left:' + (item.minx * imgSize.scale - 2 + offset.x) + 'px',
        'width:' + ((item.maxx- item.minx ) * imgSize.scale + 0) + 'px',
        'height:' + ((item.maxy- item.miny ) * imgSize.scale + 0) + 'px',
      ]
      html += '<div style="' + style.join(';') + '" class="part-rect"></div>'
    }
  })
  $('.j_part-map-rect').html(html);
}

function renderMapRectDash(num) {
  var html = ''
  partData.mapdata.forEach(function(item, index) {
    item = checkMapItem(item);
    if (item.num == num) {
      var style = [
        'top:' + (item.miny * imgSize.scale) + 'px',
        'left:' + (item.minx * imgSize.scale - 2 + offset.x) + 'px',
        'width:' + ((item.maxx- item.minx ) * imgSize.scale + 0) + 'px',
        'height:' + ((item.maxy- item.miny ) * imgSize.scale + 0) + 'px',
      ]
      html += '<div style="' + style.join(';') + '" class="part-rect_dash"></div>'
    }
  })
  $('.j_part-map-rect').html(html);
}

function checkMapItem(item){
    if(item instanceof Array){
        item.num = item[4];
        item.minx = item[0];
        item.miny = item[1];
        item.maxx = item[2];
        item.maxy = item[3];
    }
    return item;
}