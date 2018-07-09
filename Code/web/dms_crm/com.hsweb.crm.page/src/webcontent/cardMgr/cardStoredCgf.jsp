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
  <title>储值卡</title>
  <script src="<%=webPath + repairDomain%>/repair/js/RepairBusiness/Reception/ReceptionMain.js?v=1.1.8"></script>
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
    width: 50px;
}

</style>

</head>
<body>
    <div id="form1">
        <fieldset style="width: 620px; border: solid 1px #aaa; margin-top: 8px;margin-left: 14px;  position: relative;">
            <legend>基本资料</legend>
            <div id="editForm1" style="padding: 5px;">
                <input class="nui-hidden" name="id">
                <table style="width: 100%;">
                    <tbody>
                        <tr>
                            <td class="col" style="width: 90px; text-align: right;">会员卡名称</td>
                            <td>
                                <input class="nui-textbox" style="width: 150px;">
                            </td>
                            <td class="col" style="width: 90px; text-align: right;">实际售价</td>
                            <td>
                                <input style="width: 150px;" class="nui-textbox">
                            </td>
                        </tr>
                        <tr>
                            <td class="col" style="width: 90px; text-align: right;">有效期</td>
                            <td>
                                <input style="width: 150px;" class="nui-textbox">月</td>
                                <td class="col" style="width: 90px; text-align: right;">赠送金额</td>
                                <td>
                                    <input  style="width: 150px;" class="nui-textbox">
                                </td>
                            </tr>
                            <tr>
                                <td class="col" style="width: 90px; text-align: right;">状态</td>
                                <td>
                                    <label>
                                        <input name="Fruit" type="radio" value="">有效</label>
                                        <label>
                                            <input name="Fruit" type="radio" value="">停用</label>
                                        </td>
                                        <td class="col" style="width: 90px; text-align: right;">限制车辆</td>
                                        <td>
                                            <input style="width: 150px;" class="nui-combobox">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </fieldset>
                    <fieldset style="width: 620px; border: solid 1px #aaa; margin-top: 8px;margin-left: 14px;  position: relative;">
                        <legend>工时信息</legend>
                        <div id="editForm1" style="padding: 5px;">
                            <table style="width: 100%;">
                                <tbody>
                                    <tr>
                                        <td class="col" style="width: 90px; text-align: right;">工时折扣</td>
                                        <td>
                                            <input id="" style="width: 150px;" class="nui-textbox">
                                        </td>
                                        <td class="col" style="width: 90px; text-align: right;">配件折扣</td>
                                        <td>
                                            <input style="width: 150px;" class="nui-textbox">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </fieldset>
                    <div style="margin-top:15px;" align="center"> <a class="nui-button" style="margin-right:15px;" iconcls="icon-save" onclick="saveData()">保存</a>
                     <a class="nui-button" iconcls="icon-close" onclick="close()">取消</a>
                 </div>
             </div>
             <script type="text/javascript">
                 nui.parse();

 //700px   550px
</script>
</body>
</html>