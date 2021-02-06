<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
    


<div class="nui-fit">
    
        <div class="nui-toolbar" style="padding:0px;border-bottom:1;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;text-align:left;">
                        <input id="stationName" width="150px" emptyText="工位名称" class="nui-textbox" onenter="queryStationName"/>
                        <a class="nui-button" plain="true" onclick="queryStation" id="stationBtn">
                            <span class="fa fa-search fa-lg"></span>&nbsp;查询
                        </a>
                        <span class="separator"></span>
                        <a class="nui-button" plain="true" onclick="addStation" id="addStationBtn">
                            <span class="fa fa-plus fa-lg"></span>&nbsp;新增
                        </a>
                        <!-- <a class="nui-button" plain="true" onclick="delStation" id="addStationBtn">
                            <span class="fa fa-close fa-lg"></span>&nbsp;删除
                        </a> -->
                        <a class="nui-button" plain="true" onclick="saveStation" id="saveStationBtn">
                            <span class="fa fa-save fa-lg"></span>&nbsp;保存
                        </a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div id="stationGrid" class="nui-datagrid" style="width:100%;height:100%;"
                    showPager="true"
                    dataField="stations"
                    totalField="page.count"
                    sortMode="client"
                    allowCellSelect="true"
                    allowCellEdit="true"
                    showModified="false"
                    pageSize="50"
                    sizeList="[50,100,200]"
                    showSummaryRow="true">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div allowSort="true" field="stationName"  summaryType="count" headerAlign="center" header="名称">
                            <input property="editor" class="nui-textbox"/>
                    </div>
                    <div allowSort="true" field="stationQty"  headerAlign="center" header="工位数量">
                            <input property="editor" class="nui-spinner" minValue="0" maxValue="9999999" format="0" showButton="false"/>
                    </div>
                    <div allowSort="true" field="orderIndex"  headerAlign="center" header="排序值">
                            <input property="editor" class="nui-spinner" minValue="0" maxValue="9999999" format="0" showButton="false"/>
                    </div>
                    <div allowSort="true" allowSort="true" field="status"  headerAlign="center" header="状态">
                        <input property="editor" class="nui-combobox" textField="name" data="statusList"
                            valueField="id" />
                    </div>
                </div>
            </div>
        </div>
</div>


