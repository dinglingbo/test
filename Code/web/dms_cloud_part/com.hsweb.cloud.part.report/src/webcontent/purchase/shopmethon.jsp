<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>


 <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                <a class="nui-button" iconCls="" plain="true" onclick="quSearch(0)" id="type0">本日</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quSearch(1)" id="type1">昨日</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="qukSearch(2)" id="type2">本周</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quSearch(3)" id="type3">上周</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quSearch(4)" id="type4">本月</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quSearch(5)" id="type5">上月</a>
                <span class="separator"></span>
               
                <span class="separator"></span>
                <label style="font-family:Verdana;">公司名称：</label>
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择公司"
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <span class="separator"></span>
                <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
            </td>
        </tr>
    </table>
</div>
