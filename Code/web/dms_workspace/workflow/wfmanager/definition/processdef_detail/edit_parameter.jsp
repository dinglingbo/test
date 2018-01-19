<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<div id="editTriggerParams" style="background:#FFFFFF;border: 1px solid #0066FF;width: 250px; height: 200px; display:none; position: absolute; top: 100px; left: 150px;">
		        			<table width='250' cellpadding='0' cellspacing='0' border='0'>
								<tr>
									<td><img height='23' width='350' src='<%=request.getContextPath()%>/workflow/wfmanager/definition/js/x11_title.gif'></td>
									<td><a href="#" onclick="obj('editTriggerParams').style.display='none';return false;"><img height='23' width='24' src='<%=request.getContextPath()%>/workflow/wfmanager/definition/js/x11_close.gif' border='0'></a></td>
								</tr>
								<tr>
									<td colspan="2" >
											<fieldset class="paramFieldset">
												<div>
							        				<label for="formalParameter.description"><b:message key="edit_parameter_jsp.paramName"/></label><!-- 参数名称 -->
							        				<input type="text" id="formalParameter.description" name="formalParameter.description">
							        			</div>
							        			<div>
							        				<label for="formalParameter.mode"><b:message key="edit_parameter_jsp.passMode"/></label><!-- 传递方式 -->
							        				<select id="formalParameter.mode" name="formalParameter.mode">
							        					<option value="in"><b:message key="edit_parameter_jsp.in"/></option> <!-- 输入 -->
							        					<option value="out"><b:message key="edit_parameter_jsp.out"/></option><!-- 输出 -->
							        					<option value="in-out"><b:message key="edit_parameter_jsp.inOut"/></option><!-- 输入/输出 -->
							        				</select>
						        				</div>
							        			<div>
							        				<label for="formalParameter.dataType.typeClass"><b:message key="edit_autoact_info_jsp.dataClassification"/></label><!-- 数据分类 -->
							        				<select id="formalParameter.dataType.typeClass" name="formalParameter.dataType.typeClass">
							        					<option value="primitive"><b:message key="edit_parameter_jsp.simple"/></option><!-- 简单 -->
							        					<option value="sdo">SDO</option>
							        					<option value="node"><b:message key="edit_parameter_jsp.node"/></option><!-- 节点 -->
							        					<option value="pojo">POJO</option>
							        				</select>
							        			</div>
							        			<div>
								        				<label for="formalParameter.dataType.typeValue"><b:message key="edit_autoact_info_jsp.dataType"/></label><!-- 数据类型 -->
								        				<input type="text" id="formalParameter.dataType.typeValue" name="formalParameter.dataType.typeValue">
								        		</div>
							        			<div>
							        				<label for="actualParameter.expression.scriptGrammar"><b:message key="edit_autoact_info_jsp.valueType"/></label>&nbsp;&nbsp;<!-- 值类型 -->
							        				<select id="actualParameter.expression.scriptGrammar" name="actualParameter.expression.scriptGrammar">
							        					<option value="variable"><b:message key="edit_autoact_info_jsp.variable"/></option><!-- 变量 -->
							        					<option value="constant"><b:message key="edit_autoact_info_jsp.constant"/></option><!-- 常量 -->
							        				</select>
							        			</div>
							        			<div>
								        				<label for="actualParameter.expression.scriptValue"><b:message key="edit_autoact_info_jsp.value"/></label><!-- 值 -->
								        				<div style="padding-left:36px;display:inline">
								        					<input type="text" id="actualParameter.expression.scriptValue" name="actualParameter.expression.scriptValue">
								        					</div>
								        		</div>
							        			<div style="padding-left:30px">
													<input type="button" name="parameterOK" value="<b:message key="edit_autoact_info_jsp.ok"/>"><!-- 确定 -->
													<button class="button" id="parameterCancel" onClick="javascript:obj('editTriggerParams').style.display='none';"><b:message key="edit_autoact_info_jsp.cancel"/></button><!-- 取消 -->
							        			</div>
						        			</fieldset>
									</td>
								</tr>
							</table>
		        		</div>