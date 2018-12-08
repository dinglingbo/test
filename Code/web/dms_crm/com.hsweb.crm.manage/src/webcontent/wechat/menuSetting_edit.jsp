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

    width: 90px;
    text-align: right;
  }
  .tbinput{
    width: 100%
  }
 
</style>
</head>
<body>


    <div class="nui-fit">
      <div  id="t1">  

        <div  id="t2"  style="float:left;width: 40%; height: 100%;">       
     

                            <div style="background-image: url('<%=request.getContextPath()%>/manage/css/pic/mobile.png');width: 344px;height: 623px;position: relative;">
                                <div style="position: absolute;bottom: 170px;left: 46px; width: 82px;" zcdrel="maincd1">
                    
                                <div style="position: absolute;bottom: -52px;left: 0px;">
                                    <table style="border: none;" cellpadding="0" cellspacing="0">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <div style="height: 45px;width: 85px;line-height: 45px;text-align: center;" id="maincd1" reldata="{&quot;typ&quot;:&quot;res_ejcd&quot;,&quot;data&quot;:&quot;&quot;,&quot;tit&quot;:&quot;主菜单一&quot;,&quot;subdata&quot;:null}" class="maincd">主菜单一</div>
                                                </td>
                                                <td>
                                                    <div style="height: 45px;width: 87px;line-height: 45px;text-align: center;" id="maincd2" reldata="{&quot;typ&quot;:&quot;res_ejcd&quot;,&quot;data&quot;:&quot;&quot;,&quot;tit&quot;:&quot;主菜单二&quot;,&quot;subdata&quot;:null}" class="maincd">主菜单二</div>
                                                </td>
                                                <td>
                                                    <div style="height: 45px;width: 85px;line-height: 45px;text-align: center;" id="maincd3" reldata="{&quot;typ&quot;:&quot;res_ejcd&quot;,&quot;data&quot;:&quot;&quot;,&quot;tit&quot;:&quot;主菜单三&quot;,&quot;subdata&quot;:null}" class="maincd">主菜单三</div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

 </div>


    </div>
    <div  id="t3"  style="float:left;width: 50%; height: 550px;">       

      <div class="nui-fit">
  <div id="tabs1" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" plain="true">
    <div title="全局菜单" >
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

         <!--  <tr>
           <td class="tbtext"><label>文字内容：</label></td>
           <td ><input class="nui-textarea tbinput" name="" 
             value="分享成消费股东,养车不花钱轻松开豪车"></td>
         </tr> -->

         <!--  <tr >
           <td class="tbtext"><label>上传文件：</label></td>
           <td ><a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-upload fa-lg"></span>&nbsp;上传</a></td>
         </tr> -->
          <tr >
             <td class="tbtext"><label>名称：</label></td>
            <td ><input class="nui-textbox tbinput" name="" ></td>
          </tr>
          <tr >
             <td class="tbtext"><label>显示名称：</label></td>
            <td ><input class="nui-textbox tbinput" name="" ></td>
          </tr>          <tr >
             <td class="tbtext"><label>点击菜单：</label></td>
            <td ><input class="nui-combobox tbinput" name="" ></td>
          </tr>          <tr >
             <td class="tbtext"><label>按钮顶端：</label></td>
            <td ><input class="nui-textbox tbinput" name="" ></td>
          </tr>
           <tr >
             <td class="tbtext"><label>按钮中上：</label></td>
            <td ><input class="nui-textbox tbinput" name="" ></td>
          </tr>
           <tr >
             <td class="tbtext"><label>按钮中部：</label></td>
            <td ><input class="nui-textbox tbinput" name="" ></td>
          </tr>
           <tr >
             <td class="tbtext"><label>按钮中下：</label></td>
            <td ><input class="nui-textbox tbinput" name="" ></td>
          </tr>
                    <tr >
             <td class="tbtext"><label>按钮底端：</label></td>
            <td ><input class="nui-textbox tbinput" name="" ></td>
          </tr>

        </table>


      </div>




          <div title="用户个性菜单" >
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

         <!--  <tr>
           <td class="tbtext"><label>文字内容：</label></td>
           <td ><input class="nui-textarea tbinput" name="" 
             value="分享成消费股东,养车不花钱轻松开豪车"></td>
         </tr> -->

         <!--  <tr >
           <td class="tbtext"><label>上传文件：</label></td>
           <td ><a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-upload fa-lg"></span>&nbsp;上传</a></td>
         </tr> -->
                  <tr >
             <td class="tbtext"><label>用户分组：</label></td>
            <td ><input class="nui-combobox tbinput" name="" ></td>
          </tr>
          <tr >
             <td class="tbtext"><label>名称：</label></td>
            <td ><input class="nui-textbox tbinput" name="" ></td>
          </tr>
          <tr >
             <td class="tbtext"><label>显示名称：</label></td>
            <td ><input class="nui-textbox tbinput" name="" ></td>
          </tr>          <tr >
             <td class="tbtext"><label>点击菜单：</label></td>
            <td ><input class="nui-combobox tbinput" name="" ></td>
          </tr>          <tr >
             <td class="tbtext"><label>按钮顶端：</label></td>
            <td ><input class="nui-textbox tbinput" name="" ></td>
          </tr>
           <tr >
             <td class="tbtext"><label>按钮中上：</label></td>
            <td ><input class="nui-textbox tbinput" name="" ></td>
          </tr>
           <tr >
             <td class="tbtext"><label>按钮中部：</label></td>
            <td ><input class="nui-textbox tbinput" name="" ></td>
          </tr>
           <tr >
             <td class="tbtext"><label>按钮中下：</label></td>
            <td ><input class="nui-textbox tbinput" name="" ></td>
          </tr>
                    <tr >
             <td class="tbtext"><label>按钮底端：</label></td>
            <td ><input class="nui-textbox tbinput" name="" ></td>
          </tr>

        </table>


      </div>
      </div>

      </div>
    </div>

    <div style="clear: both"></div>
    <!-- 注释：清除float产生浮动 -->
    
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