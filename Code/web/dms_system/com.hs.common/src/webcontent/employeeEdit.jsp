<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
-->
<head>
    <title>添加员工</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/common/nui/nui.js" type="text/javascript"></script>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style type="text/css"> 
    body {
       margin: 0;
       padding: 0;
       border: 0;
       width: 100%;
       height: 100%;
       overflow: hidden;
   }


   table
   {
      font-weight:bold;
      left:0;right:0;margin: 0 auto;
  }


  table tr
  {
      height:40px;
  }
  table tr td span
  {
      width:10px;
      display: inline-block;
  }

  .tabwidth{
    width:600px;
}
.tbtext{
    float: right; 
    line-height: 40px;
}
.mini-textbox{
    height: 28px;
}
.mini-textbox-border{
    height: 25px;
} 
.mini-textbox-input{/* 输入框的里面的高度 */
    height: 24px;
}

.checkboxwidth{
    width: 65px;
    margin-left:20px;
}
</style> 
</head>
<body>
    <div class="nui-fit"> 
        <div style="width:90%;height:99%;left:0;right:0;margin: 0 auto;">
           <table >

            <tr>
                <td class="tbtext">员工姓名<span style="color:red">*</span></td>
                <td style="width:400px;"><input class="mini-textbox" style="width: 400px;"/></td>
                <td> 
                    <label><input name="Fruit" type="radio" value="" />男</label>
                    <label><input name="Fruit" type="radio" value="" />女</label></td>
                    <td></td>
                </tr>

                <tr>
                    <td class="tbtext">手机号码<span style="color:red">*</span></td>
                    <td colspan="2"><input class="mini-textbox tabwidth"/></td>

                </tr>

                <tr>
                    <td class="tbtext">服务技师<span style="color:red">*</span></td>

                    <td>
                        <label><input name="Fruit" type="radio" value="" />是</label>
                        <label><input name="Fruit" type="radio" value="" />否</label></td>
                        <td></td>
                    </tr>

                    <tr>
                        <td class="tbtext">出生日期<span></span></td>
                        <td colspan="2"><input class="mini-textbox tabwidth"/></td>

                    </tr>
                    <tr>
                        <td class="tbtext">入职日期<span></span></td>
                        <td colspan="2"><input class="mini-textbox tabwidth"/></td>

                    </tr>
                    <tr>
                        <td class="tbtext">身份证号<span></span></td>
                        <td colspan="2"><input class="mini-textbox tabwidth"/></td>

                    </tr>
                    <tr>
                        <td class="tbtext">家庭住址<span></span></td>
                        <td colspan="2"><input class="mini-textbox tabwidth"/></td>

                    </tr>
                    <tr>
                        <td class="tbtext">电子邮件<span></span></td>
                        <td colspan="2"><input class="mini-textbox tabwidth"/></td>

                    </tr>
                    <tr>
                        <td class="tbtext">微信号<span></span></td>
                        <td colspan="2"><input class="mini-textbox tabwidth"/></td>

                    </tr>
                    <tr>
                        <td class="tbtext">基本工资<span></span></td>
                        <td colspan="2"><input class="mini-textbox tabwidth"/></td>

                    </tr>
                    <tr>
                        <td class="tbtext">紧急联系人<span></span></td>
                        <td colspan="2"><input class="mini-textbox tabwidth"/></td>

                    </tr>
                    <tr>
                        <td class="tbtext">紧急联系人电话<span></span></td>
                        <td colspan="2"><input class="mini-textbox tabwidth"/></td>

                    </tr>
                    <tr>
                        <td class="tbtext">基本工资关系<span></span></td>
                        <td colspan="2"><input class="mini-textbox tabwidth"/></td>

                    </tr>
                    <tr>
                        <td class="tbtext">积分抵扣上限金额<span></span></td>
                        <td colspan="2"><input class="mini-textbox tabwidth"/></td>
                        <td><div class="nui-checkbox checkboxwidth"  readOnly="false" text="无限制"></div></td>
                    </tr>
                    <tr>
                        <td class="tbtext">优惠最低折扣（按应收）<span></span></td>
                        <td >工时费<input class="mini-textbox" style="margin-left:10px;"/><div class="nui-checkbox checkboxwidth"  readOnly="false" text="无限制"></div></td>
                        <td style="float: right;line-height: 40px;">材料费<input class="mini-textbox" style="margin-left:10px;"/></td>
                        <td><div class="nui-checkbox checkboxwidth"  readOnly="false" text="无限制"></div></td>
                    </tr> 
                    <tr>
                        <td class="tbtext">结清优惠上限金额<span></span></td>
                        <td colspan="2"><input class="mini-textbox tabwidth"/></td>
                        <td><div class="nui-checkbox checkboxwidth"  readOnly="false" text="无限制"></div></td>
                    </tr>
                    <tr>
                        <td class="tbtext">收银优惠上限金额<span></span></td>
                        <td colspan="2"><input class="mini-textbox tabwidth"/></td>
                        <td><div class="nui-checkbox checkboxwidth"  readOnly="false" text="无限制"></div></td>
                    </tr>
                    
                </table>
                <div style="text-align: center;margin-top: 10px;margin-bottom: 20px;">
                    <a class="nui-button " style="margin-right:10px;" iconcls="" plain="false" onclick=""><i class="fa fa-plus"></i>&nbsp;新建并继续</a>
                    <a class="nui-button " style="margin-right:10px;" iconcls="" plain="false" onclick=""><i class="fa fa-save"></i>&nbsp;保存退出</a>
                    <a class="nui-button " style="margin-right:10px;" iconcls="" plain="false" onclick=""><i class="fa fa-sign-out"></i>&nbsp;退出</a>

                </div>
            </div>
        </div> 
        <script type="text/javascript">
          nui.parse();

      </script>
  </body>
  </html>