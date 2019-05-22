<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-10 17:37:06
  - Description:
-->
<head>
<title>编辑资料</title>
   <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link href="<%=request.getContextPath()%>/layim-v3.8.0/dist/css/layui.css?v=1.0.11" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/layim-v3.8.0/dist/layui.js?v=1.0.0"></script>
    <script src="<%=request.getContextPath()%>/layim-v3.8.0/dist/css/modules/layim/html/area.js?v=1.0.0"></script>
    <style type="text/css">
    	.yuan{width:80px;height:80px;border-radius:80px}
    		.layui-textarea{
    		height: 60px;
    	 min-height: 60px; 
    	}
    </style> 
</head>
<body>
<div >

<form class="layui-form" action="">
  
  <div class="layui-form-item" style="margin-top: 20px;" >
    <div class="layui-inline">
    <label class="layui-form-label" >昵称</label>
     <input type="text" name="nickname" id="nickname" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input" style="width: 200px;">
    </div>
 </div>
 
 <div class="layui-form-item" style="margin-top: 20px;">
    <div class="layui-inline">
    <label class="layui-form-label" >出生日期</label>
    <input type="text" class="layui-input" id="test1" style="width: 200px;" name="birthday">
    </div>
  
    <div class="layui-inline">
    <label class="layui-form-label" >性别</label>
    <div class="layui-input-block" id="sex" style="width: 200px;">
      <input type="radio" name="sex" id="sex1" value="1" title="男">
      <input type="radio" name="sex" value="0"  id="sex0" title="女" checked>
    </div>
    </div> 
 </div>
 
  <div class="layui-form-item" style="margin-top: 20px;">
    <!-- <div class="layui-inline">
     <label class="layui-form-label" >职位</label>
     <input type="text" name="title" id=""   placeholder="请输入职位" autocomplete="off" class="layui-input" style="width: 200px;">
   </div> -->
    <div class="layui-inline">
      <label class="layui-form-label">手机号</label>
     <input type="text" name="phone"  id="phone"  placeholder="请输入手机号" autocomplete="off" class="layui-input" style="width: 200px;">
    </div>
    
    <div class="layui-inline">
     <label class="layui-form-label" >邮箱</label>
     <input type="text" name="email" id="email" placeholder="请输入邮箱" autocomplete="off" class="layui-input" style="width: 200px;">
   </div>
 </div>
    <div class="layui-form-item">
    <label class="layui-form-label" >选择地区</label>
    <div class="layui-input-inline">
        <select name="province" lay-filter="province">
            <option value="">请选择省</option>
        </select>
    </div>
    <div class="layui-input-inline">
        <select name="city" lay-filter="city" id="city">
            <option value="">请选择市</option>
        </select>
    </div>
    <div class="layui-input-inline">
        <select name="area" lay-filter="area" id="area">
            <option value="">请选择县/区</option>
        </select>
    </div>
</div>
  <div class="layui-form-item">
        <label class="layui-form-label" >详细地址</label>
        <div class="layui-input-block" style="">
            <input type="text" name="address"  id="address"  placeholder="" autocomplete="off" class="layui-input" style="width: 480px;">
        </div>
    </div>
 
 <div class="layui-form-item layui-form-text"  >
    <label class="layui-form-label" >个性签名</label>
    <div class="layui-input-block" style="width:480px;">
      <textarea placeholder="请输入内容" class="layui-textarea" name="signature" id="signature"></textarea>
    </div>
  </div>
  
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label" >个人说明</label>
    <div class="layui-input-block" style="margin-top: 20px;width: 480px;">
      <textarea placeholder="请输入内容" class="layui-textarea" name="remark" id="remark"></textarea>
    </div>
  </div>
 
   <div class="layui-form-item">
    <div class="layui-input-block" >
      <button class="layui-btn" lay-submit lay-filter="formDemo" >保存</button>
      <!-- <button type="reset" class="layui-btn layui-btn-primary">重置</button> -->
      <!-- <button class="layui-btn"  lay-filter="find" style="width: 80px;" >确定</button> -->
    </div>
  </div>
    
  
  
</form>
</div>     
<script type="text/javascript">
//Demo
/* var $form;
var form;
var $; */
var dataSys = {};
var areaData = Area;
var $form;
var form;
var $;
layui.use(['form', 'upload'], function(){
    $ = layui.jquery;
    form = layui.form;
    $form = $('form');
   // loadProvince();
   var form2 = layui.form; //获取form模块
    
    var paramsy ={};
    var province = 0;
    var city = 0;
    var area = 0;
   paramsy.id = dataSys.id;
   $.ajax({
        type:'post',
        dataType:'json',
        contentType:'application/json',
        cache : false,
        data: JSON.stringify({
		        	params:paramsy,
		        	token:dataSys.token,
		        	edit:"query"
		      }),
        url:dataSys.baseUrl + "com.hs.common.env.upateUserInfo.biz.ext",
        async:false, 
        success:function(data){
        	if(data.errCode==0){
        	  var user = data.data;
        	  //给表单赋值
        	 // $('#birthday').val(user.birthday);
        	  $('#remark').val(user.remark);
        	  $('#address').val(user.address);
        	  $('#nickname').val(user.nickname);
        	  $('#signature').val(user.signature);
        	  $('#email').val(user.email);
        	  $("#sex0").attr("checked", user.sex == 0 ? true : false);
              $("#sex1").attr("checked", user.sex == 1 ? true : false);
        	  $('#phone').val(user.phone);
        	  province = user.province;
        	  city = user.city;
        	  area = user.area;
        	  //执行一个laydate实例
			  laydate.render({
			    elem: '#test1',//指定元素
			    type: 'datetime',
			    value:user.birthday
			  });
        	}else{
        	   showMsg("查询失败","E");
        	}
        	pca.init('select[name=province]', 'select[name=city]', 'select[name=area]', province,city,area);
        	form.render();
        }
    });
    
    
    //监听提交
   form2.on('submit(formDemo)', function(data){
    //layer.msg(JSON.stringify(data.field));
     //调用接口
    var temp = data.field;
     //查询
    var params = temp;
    params.id=dataSys.id,
    params.updateuser = dataSys.id;
	/* var city  = $('#city').val();
	params.city = city;
	var area = $("#area").val();
	params.area = area; */
     $.ajax({
        type:'post',
        dataType:'json',
        contentType:'application/json',
        cache : false,
        data: JSON.stringify({
		        	params:params,
		        	token:dataSys.token
		      }),
        url:dataSys.baseUrl + "com.hs.common.env.upateUserInfo.biz.ext",
        async:false, 
        success:function(data){
        	if(data.errCode=="S"){
        	    var index = parent.layer.getFrameIndex(window.name);  
                parent.layer.close(index);//关闭当前页  
               // window.parent.location.replace(location.href)//刷新父级页面  
               // window.parent.location.reload(); 
        	}else{
        	   showMsg("保存失败","E");
        	}
        	return false;
        }
    });
    
  });  
  
});
var laydate = null;
layui.use('laydate', function(){
  laydate = layui.laydate;
  
  //执行一个laydate实例
  laydate.render({
    elem: '#test1' //指定元素
  });
}); 

//http://127.0.0.1:8080/default/com.hs.common.region.getRegin.biz.ext
function setDataSys(params){
   dataSys = params;  
}
   /*  var areaData = Area;
    var $form;
    var form;
    var $;
    layui.use(['jquery', 'form'], function() {
        $ = layui.jquery;
        form = layui.form();
        $form = $('form');
        loadProvince();
    }); */
     //加载省数据
  /* function loadProvince() {
    var proHtml = '';
    for (var i = 0; i < areaData.length; i++) {
        proHtml += '<option value="' + areaData[i].provinceCode + '_' + areaData[i].mallCityList.length + '_' + i + '">' + areaData[i].provinceName + '</option>';
    }
    //初始化省数据
    $form.find('select[name=province]').append(proHtml);
    form.render();
    form.on('select(province)', function(data) {
        $form.find('select[name=area]').html('<option value="">请选择县/区</option>').parent().hide();
        var value = data.value;
        var d = value.split('_');
        var code = d[0];
        var count = d[1];
        var index = d[2];
        if (count > 0) {
            loadCity(areaData[index].mallCityList);
        } else {
            $form.find('select[name=city]').parent().hide();
        }
    });
}
 //加载市数据
function loadCity(citys) {
    var cityHtml = '';
    for (var i = 0; i < citys.length; i++) {
        cityHtml += '<option value="' + citys[i].cityCode + '_' + citys[i].mallAreaList.length + '_' + i + '">' + citys[i].cityName + '</option>';
    }
    $form.find('select[name=city]').html(cityHtml).parent().show();
    form.render();
    form.on('select(city)', function(data) {
        var value = data.value;
        var d = value.split('_');
        var code = d[0];
        var count = d[1];
        var index = d[2];
        if (count > 0) {
            loadArea(citys[index].mallAreaList);
        } else {
            $form.find('select[name=area]').parent().hide();
        }
    });
}
 //加载县/区数据
function load
(areas) {
	var areaHtml = '';
	for (var i = 0; i < areas.length; i++) {
	    areaHtml += '<option value="' + areas[i].areaCode + '">' + areas[i].areaName + '</option>';
	}
	$form.find('select[name=area]').html(areaHtml).parent().show();
	form.render();
	form.on('select(area)', function(data) {
	    //console.log(data);
	});
}
 */

	var citys = Area;
	var pca = {};

	pca.city = {};
	pca.area = {};
	
	pca.init = function(province, city, area, initprovince, initcity, initarea){//jQuery选择器, 省-市-区
		//省份选择器
		if(!province || !$(province).length) return; 
		//清空省份选择器内容
		$(province).html('');
		//开始赋值
		$(province).append('<option selected></option>');
		//遍历赋值
		for(var i in citys){
			$(province).append('<option value= '+citys[i].provinceCode+'>'+citys[i].provinceName+'</option>');
			pca.city[citys[i].provinceCode] = citys[i].mallCityList;
		}
		//渲染页面
		form.render();
		//检测省份是否设置
		if(initprovince) {
			$(province).find('option[value="'+initprovince+'"]').attr('selected', true);	
		}

		//城市选择器
		if(!city || !$(city).length) return;
		//渲染空数据
		pca.formRender(city);
		//监听事件
		form.on('select(province)', function(data){
			pca.cityRender(city,data.value);
		}); 

		if(initcity) {
			pca.cityRender(city,initprovince);
			$(city).find('option[value="'+initcity+'"]').attr('selected', true);
		}

		//区县选择器
		if(!area || !$(area).length) return;
		//渲染空数据
		pca.formRender(area);
		//监听事件
		form.on('select(city)', function(data){
		  	pca.areaRender(area,data.value);
		}); 
		if(initarea) {
			pca.areaRender(area,initcity);
			$(area).find('option[value="'+initarea+'"]').attr('selected', true);
		}
	}
	
	pca.formRender = function(obj){
		$(obj).html('');
		$(obj).append('<option></option>');
		form.render();
	}

	pca.cityRender = function(obj,data){
		var city_select = pca.city[data];
		$(obj).html('');
		$(obj).append('<option></option>');
		if(city_select){
			for(var i in city_select){
				$(obj).append('<option value= '+city_select[i].cityCode+'>'+city_select[i].cityName+'</option>');
				pca.area[city_select[i].cityCode] = city_select[i].mallAreaList;
			}
		}
		form.render();
	}

	pca.areaRender = function(obj,data){
		var area_select = pca.area[data];
		$(obj).html('');
		$(obj).append('<option></option>');
		if(area_select){
			for(var i in area_select){
				$(obj).append('<option value= '+area_select[i].areaCode+'>'+area_select[i].areaName+'</option>');
			}
		}
		form.render();
	}

	/* 
	window.pca = pca;
	return pca; */

</script>
</body>
</html>