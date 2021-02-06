<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<style type="text/css">
.widthall{
    width: 100%;
}
</style>
 <div class="nui-toolbar" style="padding:0px;">
    <table style="width:80%;">
        <tr>
            <td style="width:80%;">
               <a id="saveScout" plain="true" class="mini-button" onclick="saveScout" ><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
               <a id="selTalkArt" plain="true" class="mini-button" onclick="selTalkArt"><span class="fa fa-check fa-lg"></span>&nbsp;选择话术</a>
               <a id="colleTalkArt" plain="true" class="mini-button" onclick="colleTalkArt"><span class="fa fa-star fa-lg"></span>&nbsp;收藏话术</a>
           </td>
       </tr>
   </table>
</div>
<form id="form1" method="post">
    <fieldset style="border:solid 1px #aaa;padding:3px;">
        <legend >基本信息</legend>
        <div style="padding:5px;">
            <div id="basicInfoForm" class="form">
                <input class="nui-hidden" name="guestId"/>
                <input class="nui-hidden" name="deputyId"/>
                <input class="nui-hidden" name="scoutMan"/>
                <input class="nui-hidden" name="carNo"/>
                <table style="width: 100%;">
                    <tr>
                        <td style="width:90px;"><span class="title title-width3 required">资料有效状态：</span></td>
                        <td>
                            <input name="status"
                            id="status"
                            required="true"
                            class="nui-combobox widthall"
                            textField="text"
                            valueField="value"
                            emptyText="请选择..."
                            data="const_enabled"
                            allowInput="false"
                            valueFromSelect="true"
                            showNullItem="false"
                            nullItemText="请选择..."/>
                        </td>
                        <td style="width:90px;"><span class="title title-width3 required">跟踪方式：</span></td>
                        <td>
                            <input name="scoutMode"
                            id="scoutMode"
                            required="true"
                            class="nui-combobox widthall"
                            textField="name"
                            valueField="customid"
                            emptyText="请选择..."
                            allowInput="false"
                            valueFromSelect="true"
                            showNullItem="false"
                            nullItemText="请选择..."/>
                        </td>
                    </tr>
                    <tr>
                        <td><span class="title title-width3 required">跟踪结果：</span></td>
                        <td>
                            <input name="scoutResult"
                            id="scoutResult"
                            required="true"
                            class="nui-combobox widthall"
                            textField="text"
                            valueField="value"
                            emptyText="请选择..."
                            data="const_enabled_communicate"
                            allowInput="false"
                            valueFromSelect="true"
                            showNullItem="false"
                            nullItemText="请选择..."/>
                        </td>
                        <td><span class="title title-width3 required">跟踪状态：</span></td>
                        <td>
                            <input name="visitStatus"
                            id="visitStatus"
                            required="true"
                            class="nui-combobox widthall"
                            textField="name"
                            valueField="customid"
                            emptyText="请选择..."
                            data="visStatus"
                            url=""
                            allowInput="false"
                            valueFromSelect="true"
                            showNullItem="false"
                            nullItemText="请选择..."/>
                        </td>
                    </tr>
                    <tr>
                        <td><span class="title title-width3 required">下次跟踪时间：</span></td>
                        <td>
                            <input id="nextScoutDate"
                            name="nextScoutDate"
                            required="true"
                            class="nui-datepicker widthall"
                            format="yyyy-MM-dd hh:MM:ss"
                            emptyText="请选择日期" alwaysView="true"/>
                        </td>
                        <td><span class="title title-width3 required">下次保养日期：</span></td>
                        <td>
                            <input id="careDueDate"
                            name="careDueDate"
                            required="true"
                            class="nui-datepicker widthall"
                            dateFormat="yyyy-MM-dd hh:MM"
                            emptyText="请选择日期" alwaysView="true"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span class="title title-width3">商业险到期日：</span></td>
                        <td>
                            <input id="annualInspectionDate"
                            name="annualInspectionDate"
                            class="nui-datepicker widthall"
                            dateFormat="yyyy-MM-dd hh:MM"
                            emptyText="请选择日期" alwaysView="true"/>
                        </td>
                        <td><span class="title title-width3">交强险到期日：</span></td>
                        <td>
                            <input id="insureDueDate"
                            name="insureDueDate"
                            class="nui-datepicker widthall"
                            dateFormat="yyyy-MM-dd hh:MM"
                            emptyText="请选择日期" alwaysView="true"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span class="title title-width3 required">跟踪内容：</span></td>
                        <td colspan="3">
                            <textarea id="scoutContent"
                            name="scoutContent"
                            class="mini-textarea widthall"
                            onValuechanged=""
                            onKeyup=""
                            style="height: 120px;width: 100%"
                            emptyText="请输入跟踪内容"
                            required="true">
                        </textarea> 
                    </td>
                </tr>

            </table>
                </div>

            </div>
        </fieldset>
        <!--         <div style="text-align:center;padding:10px;display:none;" class="saveGroup"> -->
            <!--             <a id="saveScout" class="mini-button" onclick="saveScout" style="width:60px;margin-right:20px;">保存</a> -->
            <!--             <a id="selTalkArt" class="mini-button" onclick="selTalkArt" style="width:70px;margin-right:20px;">选择话术</a> -->
            <!--             <a id="colleTalkArt" class="mini-button" onclick="colleTalkArt" style="width:70px;margin-right:20px;">收藏话术</a> -->
            <!--         </div> -->
        </form>

        <div style="display:none;">
            <div id="dgScoutDetail" class="nui-datagrid"
            allowCellEdit="false" allowCellSelect="true"
            style="width:100%;height:100%;"
            url="<%=webPath + contextPath%>/com.hs.common.unify.intfc.biz.ext"
            dataField="result"
            showColumns="true"
            allowcellwrap="true"
            showPager="true"
            totalField="page.count">
            <div property="columns">
                <div field="visitMan" headerAlign="center" width="50px" align="center">跟踪员</div>
                <div field="visitDate" headerAlign="center" dateFormat="yyyy-MM-dd hh:MM" width="80px" align="center">跟踪日期</div>
                <div field="scoutResult" headerAlign="center" width="50px" align="center">跟踪结果</div>
                <div field="scoutMode" headerAlign="center" width="50px" align="center">跟踪方式</div>
                <div field="scoutContent" headerAlign="center" width="300px" align="center">跟踪内容</div>
            </div>
        </div>
    </div>
