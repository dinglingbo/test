<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-03 16:59:41
  - Description:
-->
<head>
  <title>分销设置</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
  <%@include file="/common/commonRepair.jsp"%>

  <style type="text/css">
  html, body{
    margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
  }
  .tbtext {

    width: 70px;
    text-align: right;
  }
  .tbinput{
    width: 100%
  }
  .pic{
    background-image: url("<%=request.getContextPath()%>/manage/css/pic/phone.png");
    background-repeat: no-repeat;
    height: 550px;
  }
  .bg1{
    position: absolute;
    left: 175px;
    top: 65px;
    width: 278px;
    max-width: 282px;
    min-width: 278px;
    height: 420px;
    letter-spacing: 3px;
    padding-top: 5px;
    line-height: 25px;
    caret-color: red;
    overflow-y: auto;
  }
</style>
</head>
<body>
 <div id="tabs1" class="mini-tabs" activeIndex="1" style="width:100%;height:100%;" plain="true">
  <div title="分销设置" >

    <div class="nui-fit">

      <table style="width:50%; float: left">

        <tr>
          <td class="tbtext"><label>温馨提示：</label></td>
          <td colspan="3"><input class="nui-textarea tbinput" name="" style="width:100%;height:100px;"></td>
        </tr>

        <tr>
          <td class="tbtext"><label>新手必读：</label></td>
          <td colspan="3"><input class="nui-textarea tbinput" name="" style="width:100%;height:100px;"></td>
        </tr>
        <tr>
          <td class="tbtext"><label>返利机制：</label></td>
          <td><input class="nui-combobox tbinput" name="" style=""></td>

        </tr>
        <tr>
          <td class="tbtext"><label>一级：</label></td>
          <td><input class="nui-combobox tbinput" name="" style=""></td>

        </tr>
        <tr>
          <td class="tbtext"><label>二级：</label></td>
          <td><input class="nui-combobox tbinput" name="" style=""></td>

        </tr>

        <tr>
          <td class="tbtext"><label>三级：</label></td>
          <td><input class="nui-combobox tbinput" name="" style=""></td>

        </tr>
        <tr>
          <td class="tbtext"><label>审核：</label></td>
          <td>
            <div id="" name="" class="mini-checkbox" readOnly="false" text="分销商自动审核"></div>
          </td>
        </tr>
      </table>


    </div>



  </div>

  <div title="名片二维码" >

    <div class="nui-fit">
      <div  id="t1">  

        <div  id="t2"  style="float:left;width: 40%; height: 100%;">       
          <div class="pic"> 


            <div contenteditable="flase" class="bg1" style="position:absolute;left:160px;top:65px;width:278px;max-width:282px;;min-width:278px;height:420px;letter-spacing:3px;padding-top:5px;line-height:25px;caret-color:red;overflow-y:auto;" id="">
              <img id="code" width="100%"; height="98%" src="/Uploads/images/Show/20180910/5b96371201951.jpg" >

            </div>
            <div contenteditable="flase" class="" style="position:absolute;left: 248px;
            top: 145px;width:100px;max-width:100px;;min-width:100px;height:100px;letter-spacing:3px;padding-top:5px;line-height:25px;caret-color:red;overflow-y:auto; id=">
            <img width="100%"; height="100%" src="<%=request.getContextPath()%>/manage/css/pic/XMAPP.png" >
          </div>
          <div id="content" contenteditable="false" class="" style="position:absolute;left: 195px;
          top: 300px;width:235px;max-width:235px;;min-width:100px;height:100px;letter-spacing:3px;padding-top:5px;;caret-color:red;overflow-y:auto;color:black;white-space:normal;
          word-break:break-all;
          word-wrap:break-word;color:#999999">分享成消费股东,养车不花钱轻松开豪车
        </div>


      </div>

    </div>
    <div  id="t3"  style="float:left;width: 50%; height: 550px;">       

      <div class="nui-fit">

        <table style="width:100%;height:; margin-top:50px; ">

          <tr>
            <td class="tbtext"><label>文字内容：</label></td>
            <td ><input class="nui-textarea tbinput" name="" style="width:100%;height:100px;"
              value="分享成消费股东,养车不花钱轻松开豪车"></td>
          </tr>

          <tr style="height:50px;">
            <td class="tbtext"><label>上传文件：</label></td>
            <td ><a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-upload fa-lg"></span>&nbsp;上传</a></td>
          </tr>
          <tr style="height:50px;">
            <td colspan="2"><label >说明：</label><label style="color:red">图片尺寸为：背景图片，限制大小等于 640(宽) * 1136(高) 单位（像素px），支持类型 jpg、png</label></td>
          </tr>
        </table>
      </div>
    </div>

    <div style="clear: both"></div>
    <!-- 注释：清除float产生浮动 -->
    
  </div>
</div>



</div>
</div>
<script type="text/javascript">
  nui.parse();

  var startDateEl =nui.get('startDate');
  var endDateEl = nui.get('endDate');
  var currType = 2;
  quickSearch(1);
  function quickSearch(type){
    //var params = getSearchParams();
    var params = {};
    var queryname = "本日";
    switch (type)
    {
      case 0:
      params.today = 1;
      params.startDate = getNowStartDate();
      params.endDate = addDate(getNowEndDate(), 1);
      queryname = "本日";
      break;
      case 1:
      params.yesterday = 1;
      params.startDate = getPrevStartDate();
      params.endDate = addDate(getPrevEndDate(), 1);
      queryname = "昨日";
      break;
      case 2:
      params.thisWeek = 1;
      params.startDate = getWeekStartDate();
      params.endDate = addDate(getWeekEndDate(), 1);
      queryname = "本周";
      break;
      case 3:
      params.lastWeek = 1;
      params.startDate = getLastWeekStartDate();
      params.endDate = addDate(getLastWeekEndDate(), 1);
      queryname = "上周";
      break;
      case 4:
      params.thisMonth = 1;
      params.startDate = getMonthStartDate();
      params.endDate = addDate(getMonthEndDate(), 1);
      queryname = "本月";
      break;
      case 5:
      params.lastMonth = 1;
      params.startDate = getLastMonthStartDate();
      params.endDate = addDate(getLastMonthEndDate(), 1);
      queryname = "上月";
      break;

      case 10:
      params.thisYear = 1;
      params.startDate = getYearStartDate();
      params.endDate = getYearEndDate();
      queryname="本年";
      break;
      case 11:
      params.lastYear = 1;
      params.startDate = getPrevYearStartDate();
      params.endDate = getPrevYearEndDate();
      queryname="上年";
      break;
      default:
      break;
    }
    currType = type;
    startDateEl.setValue(params.startDate);
    endDateEl.setValue(addDate(params.endDate,-1));
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    //doSearch(params);
  }

</script>
</body>
</html>