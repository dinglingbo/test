<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="联系内容" name="tab1" visible="true">    
    <form id="form1" method="post">
        <fieldset style="border:solid 1px #aaa;padding:3px;">
            <legend >基本信息</legend>
            <div style="padding:5px;">
                <div id="basicInfoForm" class="form">
                    <input class="nui-hidden" name="id"/>
                    <div class="row">
                        <span class="title title-width2 required">资料是否有效：</span>
                        <input name="typeId"
                               id="typeId"
                               required="true"
                               class="nui-combobox width2"
                               textField="NAME"
                               valueField="CUSTOMID"
                               emptyText="请选择..."
                               url=""
                               allowInput="false"
                               valueFromSelect="true"
                               showNullItem="false"
                               nullItemText="请选择..."/>
                               
                        <span class="title title-width2 required">联系方式：</span>
                        <input name="typeId"
                               id="typeId"
                               required="true"
                               class="nui-combobox width2"
                               textField="NAME"
                               valueField="CUSTOMID"
                               emptyText="请选择..."
                               url=""
                               allowInput="false"
                               valueFromSelect="true"
                               showNullItem="false"
                               nullItemText="请选择..."/>
                    </div>
                    <div class="row">
                        <span class="title title-width2 required">联系结果：</span>
                        <input name="typeId"
                               id="typeId"
                               required="true"
                               class="nui-combobox width2"
                               textField="NAME"
                               valueField="CUSTOMID"
                               emptyText="请选择..."
                               url=""
                               allowInput="false"
                               valueFromSelect="true"
                               showNullItem="false"
                               nullItemText="请选择..."/>
                               
                        <span class="title title-width2 required">联系状态：</span>
                        <input name="typeId"
                               id="typeId"
                               required="true"
                               class="nui-combobox width2"
                               textField="NAME"
                               valueField="CUSTOMID"
                               emptyText="请选择..."
                               url=""
                               allowInput="false"
                               valueFromSelect="true"
                               showNullItem="false"
                               nullItemText="请选择..."/>
                    </div>
                    <div class="row">
                        <span class="title title-width2">保养到期日期：</span>
                        <input id="recordDate" 
                            name="recordDate" 
                            class="nui-datepicker width2" 
                            dateFormat="yyyy-MM-dd HH:mm:ss" 
                            emptyText="请选择日期" alwaysView="true"/>
                        <span class="title title-width2">预计购买日期：</span>
                        <input id="recordDate" 
                            name="recordDate" 
                            class="nui-datepicker width2" 
                            dateFormat="yyyy-MM-dd HH:mm:ss" 
                            emptyText="请选择日期" alwaysView="true"/>
                    </div>
                    <div class="row">
                        <span class="title title-width2">下次联系日期：</span>
                        <input id="recordDate" 
                            name="recordDate" 
                            class="nui-datepicker width2" 
                            dateFormat="yyyy-MM-dd HH:mm:ss" 
                            emptyText="请选择日期" alwaysView="true"/>
                    </div>
                    <div class="row">
                        <span class="title title-width2 required">联系内容：</span>
                        <textarea id="content" 
                            name="content" 
                            class="mini-textarea width7" 
                            onValuechanged="setCharCount()"
                            onKeyup="content.doValueChanged()"
                            style="height: 160px;" 
                            emptyText="请输入短信内容"
                            required="true">
                        </textarea>
                    </div>
                </div>
            </div>
        </fieldset>
        <div style="text-align:center;padding:10px;">
            <a id="save" class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
            <a id="save" class="mini-button" onclick="onOk" style="width:70px;margin-right:20px;">选择话术</a>
            <a id="save" class="mini-button" onclick="onOk" style="width:70px;margin-right:20px;">收藏话术</a>
        </div>
    </form>
    
    <div class="nui-fit">   
        <div id="dg2" class="nui-datagrid"
             allowCellEdit="true" allowCellSelect="true"
             style="width:100%;height:100%;"
             showColumns="true"
             showPager="true" >                
            <div property="columns">                                              
                <div field="pid" headerAlign="center" width="50px" align="center">联系人</div>
                <div field="label" headerAlign="center" width="50px" align="center">联系日期</div>
                <div field="label" headerAlign="center" width="50px" align="center">联系方式</div>
                <div field="label" headerAlign="center" width="50px" align="center">联系结果</div>
                <div field="label" headerAlign="center" width="50px" align="center">联系内容</div>
                
                <div field="label" headerAlign="center" width="50px" align="center">联系结果</div>
                <div field="label" headerAlign="center" width="50px" align="center">联系内容</div>
            </div>
        </div>
    </div> 
</div>