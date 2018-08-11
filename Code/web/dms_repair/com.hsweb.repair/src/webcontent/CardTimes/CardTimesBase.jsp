<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): huang
- Date: 2014-08-13 12:27:01
- Description:
  --%>
  <head>
  
    <title>
      计次卡基本信息
    </title>
    <script src="<%=request.getContextPath()%>/repair/js/CardTimes/CardTimesBase.js?v=1.1.1"></script>

  </head>
  <body>
    <fieldset style="border:solid 1px #aaa;position:relative;margin:5px 2px 0px 2px;">
      <legend>
        计次卡基本信息
      </legend>
      <div id="dataform1" style="padding-top:5px;">
        <!-- hidden域 -->
        <input class="nui-hidden" id="id"/>
        <table style="table-layout:fixed;" class="nui-form-table" > 
        	<tr>
	            <td class="form_label" style="width:15%;" >
	              计次卡名称:
	            </td >
	            <td >
	              <input class="nui-textbox" name="cardName" readonly="readonly" style="width:100%;"/>
	            </td>
            </tr>
            <tr>    
	            <td class="form_label" colspan="1" style="width:10%">
	              有效期(月):
	            </td>
	            <td style="width:10%;">
	              <input class="nui-textbox" name="periodValidity" readonly="readonly"/>
				</td>
				
				
				
				
	            <td class="form_label"  colspan="1" style="width:10%">
	             过期日期:
	            </td>
	            <td colspan="1"  >
	              <input format="yyyy-MM-dd" class="mini-datepicker"   name="pastDate" dateFormat="yyyy-MM-dd" readonly="readonly" />
	            </td>
            </tr>
            <tr>
	            <td class="form_label" colspan="1" style="width:10%">
	              销售价格:
	            </td>
	            <td colspan="1" >
	              <input class="nui-textbox" name="sellAmt" readonly="readonly"/>
	            </td>
	            <td class="form_label">
	           总价值:
	            </td>
	            <td colspan="1">
	              <input class="nui-textbox" name="totalAmt" readonly="readonly"/>
	            </td>
            </tr>
         
          <tr>
	            <td class="form_label">
	          计次卡状态:
	            </td>
	            <td colspan="1">
	             <input class="nui-combobox" data ="[{value:'0',text:'草稿',},{value:'1',text:'已提交'},{value:'2',text:'未提交',}]" textField="text" valueField="value" name="status" value="status" readonly="readonly"/>
	            </td>
	            <td class="form_label">
	              是否用完:
	            </td>
	            <td colspan="1">
	              <input class="nui-textbox"  name="isFinish"  readonly="readonly"/>
	            </td> 
          </tr>
           <tr>
	            <td class="form_label">
	             使用说明:
	            </td>
	            <td colspan="2">
	            <input class="nui-TextArea" name="useRemark"   readonly="readonly"  style="width:280px;height:65px;"/>
	
	            </td>
	            </tr>
	            <tr>
	            <td class="form_label">
	           卡说明:
	            </td>
	            <td colspan="1">
	            <input class="nui-TextArea" name="remark" readonly="readonly"  style="width:280px;height:65px;"/>
	            </td>
          </tr>
       
        </table>
      </div>
    </fieldset>
    
    <!-- 从表的修改 -->
	
		 <div class="nui-tabs"  activeIndex="0" style="width: 100%;" >
			<div title="计次卡明细" >	
		  <div class="nui-fit">
					<div  class="nui-datagrid"  id="datagrid1"  onDrawCell="onDrawCell"
						style="width: 100%; " showPager="false"
						sortMode="client" allowCellEdit="true" allowCellSelect="true"
						multiSelect="true" editNextOnEnterKey="true">
						
						<div property="columns">
             
							<div field="prdtName" allowSort="true" align="left"
								headerAlign="center" width="180px">
								项目名称 
							</div>
							
							<div field="prdtType" allowSort="true" align="left"
								headerAlign="center" width="">
								项目类型 
							</div>
							
							<div field="totalTimes" allowSort="true" align="left"
								headerAlign="center" width="">
								总次数 
							</div>
							
							<div field="useTimes" allowSort="true" align="left"
								headerAlign="center" width="">
								已使用次数
							</div>
							
							<div field="balaTimes" allowSort="true" align="left"
								headerAlign="center" width="">
								剩余次数
							</div>
							
							<div field="qty" allowSort="true" align="left"
								headerAlign="center" width="">
								工时/数量 <input class="nui-textbox" name="qty" property="editor" />
							</div>
							
							<div field="oldPrice" allowSort="true" align="left"
								headerAlign="center" width="">
								原价 <input class="nui-textbox" name="oldPrice" property="editor" />
							</div>
							
							<div field="sellPrice" allowSort="true" align="left"
								headerAlign="center" width="">
								销价 <input class="nui-textbox" name="sellPrice" property="editor" />
							</div>
							
							<div field="oldAmt" allowSort="true" align="left"
								headerAlign="center" width="">
								原销售金额 <input class="nui-textbox" name="oldAmt" property="editor" />
							</div>
							
							<div field="sellAmt" allowSort="true" align="left"
								headerAlign="center" width="">
								现销售金额 <input class="nui-textbox" name="sellAmt" property="editor" />
							</div>
						</div>
					</div>
				</div>		 		
			</div>
		</div>
     
    
        </body>
      </html>
