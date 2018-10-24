<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="联系内容" name="tab1" visible="true">    
    <form id="form1" method="post">
        <fieldset style="border:solid 1px #aaa;padding:3px;">
            <legend >基本信息</legend>
            <div style="padding:5px;">
                <div id="basicInfoForm" class="form">
                    <input class="nui-hidden" name="guestId"/>
                    <input class="nui-hidden" name="deputyId"/>
                    <input class="nui-hidden" name="scoutMan"/>
                    <input class="nui-hidden" name="carNo"/>
                    <div class="row">
                        <span class="title title-width3 required">资料有效状态：</span>
                        <input name="status"
                               id="status"
                               required="true"
                               class="nui-combobox width2"
                               textField="text"
                               valueField="value"
                               emptyText="请选择..."
                               data="const_enabled"
                               allowInput="false"
                               valueFromSelect="true"
                               showNullItem="false"
                               nullItemText="请选择..."/>
                               
                        <span class="title title-width3 required">跟踪方式：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        <input name="scoutMode"
                               id="scoutMode"
                               required="true"
                               class="nui-combobox width2"
                               textField="name"
                               valueField="customid"
                               emptyText="请选择..."
                               allowInput="false"
                               valueFromSelect="true"
                               showNullItem="false"
                               nullItemText="请选择..."/>
                    </div>
                    <div class="row">
                        <span class="title title-width3 required">跟踪结果：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        <input name="scoutResult"
                               id="scoutResult"
                               required="true"
                               class="nui-combobox width2"
                               textField="text"
                               valueField="value"
                               emptyText="请选择..."
                               data="const_enabled_communicate"
                               allowInput="false"
                               valueFromSelect="true"
                               showNullItem="false"
                               nullItemText="请选择..."/>
                               
                        <span class="title title-width3 required">跟踪状态：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        <input name="visitStatus"
                               id="visitStatus"
                               required="true"
                               class="nui-combobox width2"
                               textField="name"
                               valueField="customid"
                               emptyText="请选择..."
                               url=""
                               allowInput="false"
                               valueFromSelect="true"
                               showNullItem="false"
                               nullItemText="请选择..."/>
                    </div>
                    <div class="row">
                        <span class="title title-width3 required">下次跟踪日期：</span>
                        <input id="nextScoutDate" 
                            name="nextScoutDate" 
                            required="true"
                            class="nui-datepicker width2" 
                            dateFormat="yyyy-MM-dd HH:mm:ss" 
                            emptyText="请选择日期" alwaysView="true"/>
                        <span class="title title-width3 required">下次保养日期：</span>
                        <input id="careDueDate" 
                            name="careDueDate" 
                            required="true"
                            class="nui-datepicker width2" 
                            dateFormat="yyyy-MM-dd HH:mm:ss" 
                            emptyText="请选择日期" alwaysView="true"/>
                    </div>
                    <div class="row">
                        <span class="title title-width3">商业险到期日：</span>
                        <input id="annualInspectionDate" 
                            name="annualInspectionDate" 
                            class="nui-datepicker width2" 
                            dateFormat="yyyy-MM-dd HH:mm:ss" 
                            emptyText="请选择日期" alwaysView="true"/>
                        <span class="title title-width3">交强险到期日：</span>
                        <input id="insureDueDate" 
                            name="insureDueDate" 
                            class="nui-datepicker width2" 
                            dateFormat="yyyy-MM-dd HH:mm:ss" 
                            emptyText="请选择日期" alwaysView="true"/>
                    </div>
                    <div class="row">
                        <span class="title title-width3 required">跟踪内容：</span>
                        <textarea id="scoutContent" 
                            name="scoutContent" 
                            class="mini-textarea width7" 
                            onValuechanged=""
                            onKeyup=""
                            style="height: 120px;" 
                            emptyText="请输入短信内容"
                            required="true">
                        </textarea>
                    </div>
                </div>
                
            </div>
        </fieldset>
        <div style="text-align:center;padding:10px;display:none;" class="saveGroup">
            <a id="saveScout" class="mini-button" onclick="saveScout" style="width:60px;margin-right:20px;">保存</a>
            <a id="selTalkArt" class="mini-button" onclick="selTalkArt" style="width:70px;margin-right:20px;">选择话术</a>
            <a id="colleTalkArt" class="mini-button" onclick="colleTalkArt" style="width:70px;margin-right:20px;">收藏话术</a>
        </div>
    </form>
    
    <div class="nui-fit">   
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
                <div field="visitDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss" width="50px" align="center">跟踪日期</div>
                <div field="scoutResult" headerAlign="center" width="50px" align="center">跟踪结果</div>
                
                <div field="scoutMode" headerAlign="center" width="50px" align="center">跟踪方式</div>
                <div field="scoutContent" headerAlign="center" width="50px" align="center">跟踪内容</div>
            </div>
        </div>
    </div> 
</div>