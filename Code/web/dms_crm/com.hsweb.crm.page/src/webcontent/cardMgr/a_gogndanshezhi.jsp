<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
  <title>计次卡</title>
  <script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/ReceptionMain.js?v=1.1.8"></script>
  <style type="text/css">

  .title {
    width: 60px;
    text-align: right;
}

.form_label {
   width: 72px;
   text-align: right;
}

.required {
   color: red;
}

.rmenu {
  font-size: 14px;
  /* font-weight: bold; */
  text-align: left;
  margin: 0;
  padding-left: 25px;
  height: 18px;
  color: #fff;
  width: auto;
  margin-left: 20px;
  margin-top: 20px;
  background-size: 50%;
}

.tbtext{
  text-align: right;
  line-height: 40px;
}
.tbCtrl{

}

</style>

</head>
<body>

  <table class="table" id="table1"> 
    <tr>
        <td class="tbtext">综合服务单流程控制：</td>
        <td class="tbCtrl" >
            <label><input name="Fruit" type="radio" value="" />开启</label>
            <label><input name="Fruit" type="radio" value="" />关闭</label>
        </td>      
    </tr>
    <tr>
        <td class="tbtext">综合服务单必填项：</td>
        <td class="tbCtrl" >
            <div class="nui-checkbox" text="车辆里程"></div>
            <div class="nui-checkbox" text="VIN" ></div>
            <div class="nui-checkbox" text="车辆品牌" ></div>
            <div class="nui-checkbox" text="车系" ></div>
            <div class="nui-checkbox" text="品牌车型" ></div>
        </td>
    </tr>

    <tr>
        <td class="tbtext">完工、结算配件必须出库：</td>
        <td class="tbCtrl" >
            <label><input name="Fruit" type="radio" value="" />开启</label>
            <label><input name="Fruit" type="radio" value="" />关闭</label>
        </td>      
    </tr>
        <tr>
        <td class="tbtext">小票、结算单显示结算二维码<br>或微信公众号二维码：</td>
        <td class="tbCtrl" >
            <label><input name="Fruit" type="radio" value="" />开启</label>
            <label><input name="Fruit" type="radio" value="" />关闭</label>
        </td>      
    </tr>
        <tr>
        <td class="tbtext">微信车主端服务详细直接结算：</td>
        <td class="tbCtrl" >
            <label><input name="Fruit" type="radio" value="" />开启</label>
            <label><input name="Fruit" type="radio" value="" />关闭</label>
        </td>      
    </tr>
        <tr>
        <td class="tbtext">车型可自由填写：</td>
        <td class="tbCtrl" >
            <label><input name="Fruit" type="radio" value="" />开启</label>
            <label><input name="Fruit" type="radio" value="" />关闭</label>
        </td>      
    </tr>
        <tr>
        <td class="tbtext">是否隐藏手机号：</td>
        <td class="tbCtrl" >
            <label><input name="Fruit" type="radio" value="" />开启</label>
            <label><input name="Fruit" type="radio" value="" />关闭</label>
        </td>      
    </tr>
        <tr>
        <td class="tbtext">哪些类别工时开单不能改价：</td>
        <td class="tbCtrl" >
            <div class="nui-checkbox" text="保养"></div>
            <div class="nui-checkbox" text="钣金" ></div>
            <div class="nui-checkbox" text="喷漆" ></div>
            <div class="nui-checkbox" text="美容" ></div>
            <div class="nui-checkbox" text="洗车" ></div><br>
            <div class="nui-checkbox" text="机修" ></div>
            <div class="nui-checkbox" text="精品" ></div>
            <div class="nui-checkbox" text="改装" ></div>
            <div class="nui-checkbox" text="轮胎" ></div>
            <div class="nui-checkbox" text="其他" ></div>
        </td>
    </tr>
        <tr>
        <td class="tbtext">税率比例：</td>
        <td class="tbCtrl" >
            <input class="nui-textbox" >
        </td>
    </tr>
        <tr>
        <td class="tbtext">工单服务性质对健康档案不开放：</td>
        <td class="tbCtrl" >
            <div class="nui-checkbox" text="正常服务"></div>
            <div class="nui-checkbox" text="保险" ></div>
            <div class="nui-checkbox" text="返工" ></div>
            <div class="nui-checkbox" text="索赔" ></div>
            <div class="nui-checkbox" text="免单" ></div>
        </td>
    </tr>
        <tr>
        <td class="tbtext">工单服务性质对车主微信端不开放：</td>
        <td class="tbCtrl" >
            <div class="nui-checkbox" text="正常服务"></div>
            <div class="nui-checkbox" text="保险" ></div>
            <div class="nui-checkbox" text="返工" ></div>
            <div class="nui-checkbox" text="索赔" ></div>
            <div class="nui-checkbox" text="免单" ></div>
        </td>
    </tr>
        </tr>
        <tr>
        <td class="tbtext"></td>
        <td class="tbCtrl" ><a class="nui-button" onclick=""   plain="false" >保存</a></td>
    </tr>
</table>

<script type="text/javascript">
   nui.parse();

 //700px   550px
</script>
</body>
</html>