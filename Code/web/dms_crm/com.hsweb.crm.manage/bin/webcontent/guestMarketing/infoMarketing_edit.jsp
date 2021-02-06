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
    font-size:14px;
    width: 72px;

    /* text-align: right;
*/  }
.tbinput{
    width: 100%
}


.btn {
    display: inline-block;
    margin-bottom: 0px;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    touch-action: manipulation;
    cursor: pointer;
    user-select: none;
    background-image: none;
    padding: 6px 12px;
    border-width: 1px;
    border-style: solid;
    border-color: transparent;
    border-image: initial;
    border-radius: 4px;
}

.btn-primary {
    background-color: rgb(26, 179, 148);
    color: rgb(255, 255, 255);
    border-color: rgb(26, 179, 148);
}

.control-label {
    padding-top: 7px;
    margin-bottom: 0px;
    text-align: right;
}
.tags{
    display: inline-block;
    background: #1ab394;
    color: #fff;
    margin: 2px 0;
    border-radius: 3px;
    cursor: pointer;
}


.smsExplain{
    position: absolute;
    left: 0px;
    top: 3px;
    width: 255px;
    padding: 5px;
    font-size: 10px;
    background-color: white;
}

</style>
</head>
<body>


  <div class="nui-fit">
    <div  id="t1">  

      <div  id="t2"  style="float:left;width: 40%; height: 100%;">       


        <div style="background-image: url('<%=request.getContextPath()%>/manage/css/pic/mobile.png');width: 344px;height: 615px;position: relative;">
          <div style="position: absolute;bottom: 170px;left: 46px; width: 82px;" zcdrel="maincd1">

            <div style="position: absolute;bottom: -2px;left: 0px;">
              <div contenteditable="true" id="Smscontent" style="width:255px;height: 309px;resize:none"></div>

              <!-- <textarea id="Smscontent" name="" style="width:255px;height: 309px;resize:none"></textarea> -->
          </div>
          <div class="smsExplain">单条短信限制<strong style="color:red;">60</strong>个字符，如超过60字符时则按 短信字数/60 计算短信条数</div>
          <div style="position: absolute;bottom: 0px;left: 0px;width:255px;height: 50px;">
          </div>

      </div>

  </div>


</div>
<div  id="t3"  style="float:left;width: 60%; height: 570px;">       

    <div class="nui-fit">

     <div class="nui-toolbar" style="padding:0px;">
      <table style="width:80%;">
        <tr>
          <td style="width:80%;">
            <a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
            <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
        </td>
    </tr>
</table>
</div>
<table style="width:100%;height:; margin-top:20px; ">

  <tr >
   <td class="tbtext"><label>短信名称：</label></td>

   <td ><input class="nui-textbox tbinput" name="" ></td>
</tr>
<tr >
   <td class="tbtext"><label>短信类型：</label></td>

   <td ><input class="nui-combobox " name="" style="width:50%"></td>
</tr>
          <!-- <tr >
             <td colspan="2"><label>常用字段：</label></td>
         </tr>           -->
         <tr >
             <td colspan="2">
              <label class="tbtext">常用字段：</label>
              <div class="form-group" style="height:;    margin-bottom: 0px;display: inline-table;border-radius: 25px;">
                <div class="form-group" style="margin: 10px;">
                  <label class="control-label" style="text-align: center;">车主类:</label>
                  <h4>
                    <span class="btn btn-primary tagText" data-text="[车主]">车主</span>
                    <span class="btn btn-primary tagText" data-text="[姓名]">姓名</span>
                    <span class="btn btn-primary tagText" data-text="[生日]">生日</span>
                    <span class="btn btn-primary tagText" data-text="[车牌号]">车牌号</span>
                    <span class="btn btn-primary tagText" data-text="[保险到期]">保险到期</span>
                    <span class="btn btn-primary tagText" data-text="[年审到期]">年审到期</span>
                    <span class="btn btn-primary tagText" data-text="[驾驶证到期]">驾驶证到期</span>
                </h4>
            </div>

            <div class="form-group" style="margin: 10px;">
              <label class="control-label" style="text-align: center;">本公司:</label>
              <h4>
                <span class="btn btn-primary tagText" data-text="[电话]">电话</span>
                <span class="btn btn-primary tagText" data-text="[手机]">手机</span>
                <span class="btn btn-primary tagText" data-text="[地址]">地址</span>
            </h4>
        </div>
    </div>



</td>
</tr>          


</table>


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
    //startDateEl.setValue(params.startDate);
    //endDateEl.setValue(addDate(params.endDate,-1));
    //var menunamedate = nui.get("menunamedate");
    //menunamedate.setText(queryname);
    //doSearch(params);
}


(function ($) {
    $.fn.extend({
      insertAtCaret: function (myValue) {
        var $t = $(this)[0];
        if (document.selection) {
          this.focus();
          sel = document.selection.createRange();
          sel.text = myValue;
      }else if ($t.selectionStart || $t.selectionStart == '0') {
          var startPos = $t.selectionStart;
          var endPos = $t.selectionEnd;
          var scrollTop = $t.scrollTop;
                    //$t.html($t.value.substring(0, startPos) + myValue + $t.value.substring(endPos, $t.value.length));
                    $t.value = $t.value.substring(0, startPos) + myValue + $t.value.substring(endPos, $t.value.length);
                    this.focus();
                    $t.selectionStart = startPos + myValue.length;
                    $t.selectionEnd = startPos + myValue.length;
                    $t.scrollTop = scrollTop;
                } else {
                    // this.value += myValue;
                    $(this).append(myValue);
                    this.focus();
                }
            }
        })
})(jQuery);




$(".tagText").click(function () {

    $("#Smscontent").focus();
    var txt=$(this).attr('data-text');
                //console.log(txt)
                var l=$("#Smscontent").text().replace(' ','').length;
                var value='<span class="tags" contenteditable="false">'+txt+'</span>&nbsp;';
                //var value = txt;
                $("#Smscontent").insertAtCaret(value);

                /*if ((l+txt.length)<=50) {
                    var value='<span class="tags" contenteditable="false">'+txt+'</span>&nbsp;';
                    $("#Smscontent").insertAtCaret(value);
                    // $("strong").text(50-(l+txt.length));
                }*/



            });

$(document).on('click','#Smscontent .tags', function(event) {
    event.preventDefault();
    $(this).remove();
});



</script>
</body>
</html>