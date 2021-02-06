<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-03 20:04:02
  - Description:
-->
<head>
<title>其他收支报表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
</head>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
</style>
<body>
<div class="nui-fit">
    <div>
        <input class="nui-combobox" style="width:5%" data="data">&nbsp;&nbsp;
        <span>日期</span>
        <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" /> 至
        <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" />
    </div>
    <div align="center">
        <a class="nui-button" iconcls="" id="" name="" onclick="">其它费用收入</a>
        <a class="nui-button" iconcls="" id="" name="" onclick="">其它费用支出</a>
    </div>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" headeralign="center" align="center">摘<br>要</div>
                <div field="" id="" name="" headeralign="center" align="center">日期</div>
                <div header="其它费用支出" headeralign="center">
                    <div property="columns">
                        <div field="" id="" name="" headeralign="center" align="center">招待费</div>
                        <div field="" id="" name="" headeralign="center" align="center">快递费</div>
                        <div field="" id="" name="" headeralign="center" align="center">会务培训费</div>
                        <div field="" id="" name="" headeralign="center" align="center">宿舍维修</div>
                        <div field="" id="" name="" headeralign="center" align="center">悬赏</div>
                        <div field="" id="" name="" headeralign="center" align="center">返佣</div>
                        <div field="" id="" name="" headeralign="center" align="center">垃圾处理费</div>
                        <div field="" id="" name="" headeralign="center" align="center">工伤意外</div>
                        <div field="" id="" name="" headeralign="center" align="center">维修费</div>
                        <div field="" id="" name="" headeralign="center" align="center">路桥费</div>
                        <div field="" id="" name="" headeralign="center" align="center">设备费</div>
                        <div field="" id="" name="" headeralign="center" align="center">差旅费</div>
                        <div field="" id="" name="" headeralign="center" align="center">包装费</div>
                        <div field="" id="" name="" headeralign="center" align="center">其它费用支出</div>
                        <div field="" id="" name="" headeralign="center" align="center">员工福利</div>
                        <div field="" id="" name="" headeralign="center" align="center">人员工资</div>
                        <div field="" id="" name="" headeralign="center" align="center">办公用品</div>
                        <div field="" id="" name="" headeralign="center" align="center">烟茶费</div>
                        <div field="" id="" name="" headeralign="center" align="center">车辆费</div>
                        <div field="" id="" name="" headeralign="center" align="center">食堂费</div>
                        <div field="" id="" name="" headeralign="center" align="center">伙食费</div>
                        <div field="" id="" name="" headeralign="center" align="center">电话费</div>
                        <div field="" id="" name="" headeralign="center" align="center">业务费</div>
                        <div field="" id="" name="" headeralign="center" align="center">外加工</div>
                        <div field="" id="" name="" headeralign="center" align="center">手续费</div>
                        <div field="" id="" name="" headeralign="center" align="center">税费</div>
                        <div field="" id="" name="" headeralign="center" align="center">电费</div>
                        <div field="" id="" name="" headeralign="center" align="center">辅材</div>
                        <div field="" id="" name="" headeralign="center" align="center">水费</div>
                        <div field="" id="" name="" headeralign="center" align="center">房租</div>
                        <div field="" id="" name="" headeralign="center" align="center">运费</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "本月" }, { id: "2", text: "本季度）" }, { id: "3", text: "本年" }];
    	nui.parse();
    </script>
</body>
</html>