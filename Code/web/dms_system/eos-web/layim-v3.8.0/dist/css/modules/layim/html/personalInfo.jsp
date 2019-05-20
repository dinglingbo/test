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

<form class="layui-form" >
  
  <div class="layui-form-item" style="margin-top: 20px;">
    <div class="layui-inline">
    <label class="layui-form-label">昵称</label>
     <input type="text" name="nickname" id="nickname" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input" style="width: 250px;">
    </div>
  
     <div class="layui-inline">
    <label class="layui-form-label">个人编号</label>
     <input type="text" name="title"   lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input" style="width: 250px;">
    </div>
 </div>
 
 <div class="layui-form-item" style="margin-top: 20px;">
    <div class="layui-inline">
    <label class="layui-form-label">出生日期</label>
    <input type="text" class="layui-input" id="test1" style="width: 250px;" name="birthday">
    </div>
  
    <div class="layui-inline">
    <label class="layui-form-label">性别</label>
    <div class="layui-input-block" style="width: 250px;">
      <input type="radio" name="sex" value="1" title="男">
      <input type="radio" name="sex" value="0" title="女" checked>
    </div>
    </div> 
 </div>
 
  <div class="layui-form-item" style="margin-top: 20px;">
    <div class="layui-inline">
     <label class="layui-form-label">职位</label>
     <input type="text" name="title"   lay-verify="required" placeholder="请输入职位" autocomplete="off" class="layui-input" style="width: 250px;">
   </div>
  
    <div class="layui-inline">
     <label class="layui-form-label">邮箱</label>
     <input type="text" name="email"  lay-verify="required" placeholder="请输入邮箱" autocomplete="off" class="layui-input" style="width: 250px;">
   </div>
 </div>
 
 <div class="layui-form-item">
        <label class="layui-form-label">选择地区</label>
        <div class="layui-input-inline">
            <select name="province" lay-filter="province">
                <option value="">请选择省</option>
            </select>
        </div>
        <div class="layui-input-inline" style="display: none;">
            <select name="city" lay-filter="city">
                <option value="">请选择市</option>
            </select>
        </div>
        <div class="layui-input-inline" style="display: none;">
            <select name="area" lay-filter="area">
                <option value="">请选择县/区</option>
            </select>
        </div>
    </div>
  <div class="layui-form-item">
        <label class="layui-form-label">详细地址</label>
        <div class="layui-input-block" style="">
            <input type="text" name="address"   lay-verify="required" placeholder="" autocomplete="off" class="layui-input" style="width: 550px;">
        </div>
    </div>
 
 <div class="layui-form-item layui-form-text"  >
    <label class="layui-form-label">个性签名</label>
    <div class="layui-input-block" style="width:550px;">
      <textarea placeholder="请输入内容" class="layui-textarea" name="signature"></textarea>
    </div>
  </div>
  
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">个人说明</label>
    <div class="layui-input-block" style="margin-top: 20px;width: 550px;">
      <textarea placeholder="请输入内容" class="layui-textarea" name="remark"></textarea>
    </div>
  </div>
 
   <div class="layui-form-item">
    <div class="layui-input-block">
      <button class="layui-btn" lay-submit lay-filter="formDemo" onclic="save">保存</button>
      <!-- <button type="reset" class="layui-btn layui-btn-primary">重置</button> -->
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
layui.use('form', function(){
  /* var form = layui.form;
  form.render();
  loadProvince(); */
  
    $ = layui.jquery;
    form = layui.form;
    $form = $('form');
    loadProvince();
  
  //监听提交
   form.on('submit(formDemo)', function(data){
    //layer.msg(JSON.stringify(data.field));
     //调用接口
     var temp = data.field;
     //查询
     var params = temp;
      params.id=dataSys.id,
      params.updateuser = dataSys.name;
	  json = nui.encode({
	          params:params,
			  token:dataSys.token
		});
     $.ajax({
        type:'post',
        dataType:'json',
        contentType:'application/json',
        cache : false,
        data: json,
        url:baseUrl + "com.hs.common.env.upateUserInfo.biz.ext",
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
        	
        }
    });
    return false;
  });  
});

function save(obj){
    data = obj.data;
    layer.msg(JSON.stringify(data.field));
    return false;
}

layui.use('laydate', function(){
  var laydate = layui.laydate;
  
  //执行一个laydate实例
  laydate.render({
    elem: '#test1' //指定元素
  });
});

/* var provinces = {};
var city = {};
var areaData = [];
$(document).ready(function(){

   

}); */
//http://127.0.0.1:8080/default/com.hs.common.region.getRegin.biz.ext
function setData(params){
   dataSys = params;
   
   /*  $.post(params.apiPath + params.sysApi + "/"+"com.hsapi.system.dict.dictMgr.getProvinces.biz.ext?token="+params.token,{},function(text){
		   provinces = text.data; 
		   if(provinces.length>0){
	        //循环省份，找市
	         for(var p = 0;p<provinces.length;p++){
	          $.post(params.apiPath + params.sysApi + "/"+"com.hsapi.system.dict.dictMgr.getProvinces.biz.ext?token="+params.token,{},function(text){
		             provinces = text.data; 
		             if(provinces.length>0){
	                //循环省份，找市
	         for(var p = 0;p<provinces.length;p++){
	         
	        }
	  }
	  });
	        }
	  }
	  }); */
	  
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
          function loadProvince() {
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
        function loadArea(areas) {
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



</script>
</body>
</html>