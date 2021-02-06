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
    
    
                                        <td class="title required">
                                            <label>选择年份：</label>
                                        </td>
                                        <td width="120">
                                            <input name="orderDate"
                                                   id="orderDate"
                                                   width="120px"
                                                   showTime="true"
                                                   class="nui-datepicker" enabled="true" format="yyyy"/></td>

                                        
 <div id="datagrid2" class="nui-datagrid" style="width:100%;height:1200px;"
      url="com.hsapi.demo.Controller.testque.biz.ext"
      allowResize="true"
      sizeList="[20,30,50,100]"     pageSize="20"      dataField="pp"
      showHeader="true"    
      showpage="true"        
      onmouseup="return datagrid1_onmouseup()"
      allowCellEdit="true"          allowCellSelect="true" multiSelect="true" 
      editNextOnEnterKey="true"     editNextRowCell="true">
      
    <div property="columns"  >
    <div header="1月">、
      <div property="columns"  >
           <div type="indexcolumn" ></div>
           <div type="checkcolumn"></div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库金额 </div> 
          
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货金额 </div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库数量</div> 
         
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库金额 </div> 
                
       
    </div>
</div>

<div header="2月">
      <div property="columns"  >
           <div type="indexcolumn" ></div>
           <div type="checkcolumn"></div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库金额 </div> 
          
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货金额 </div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库数量</div> 
         
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库金额 </div> 
                
       
    </div>
</div>
<div header="3月">
      <div property="columns"  >
           <div type="indexcolumn" ></div>
           <div type="checkcolumn"></div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库金额 </div> 
          
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货金额 </div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库数量</div> 
         
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库金额 </div> 
                
       
    </div>
</div>
<div header="4月">
      <div property="columns"  >
           <div type="indexcolumn" ></div>
           <div type="checkcolumn"></div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库金额 </div> 
          
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货金额 </div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库数量</div> 
         
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库金额 </div> 
                
       
    </div>
</div>
<div header="5月">
      <div property="columns"  >
           <div type="indexcolumn" ></div>
           <div type="checkcolumn"></div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库金额 </div> 
          
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货金额 </div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库数量</div> 
         
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库金额 </div> 
                
       
    </div>
</div>
<div header="6月">
      <div property="columns"  >
           <div type="indexcolumn" ></div>
           <div type="checkcolumn"></div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库金额 </div> 
          
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货金额 </div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库数量</div> 
         
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库金额 </div> 
                
       
    </div>
</div>
<div header="7月">
      <div property="columns"  >
           <div type="indexcolumn" ></div>
           <div type="checkcolumn"></div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库金额 </div> 
          
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货金额 </div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库数量</div> 
         
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库金额 </div> 
                
       
    </div>
</div>
<div header="8月">
      <div property="columns"  >
           <div type="indexcolumn" ></div>
           <div type="checkcolumn"></div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库金额 </div> 
          
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货金额 </div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库数量</div> 
         
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库金额 </div> 
                
       
    </div>
</div>
<div header="9月">
      <div property="columns"  >
           <div type="indexcolumn" ></div>
           <div type="checkcolumn"></div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库金额 </div> 
          
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货金额 </div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库数量</div> 
         
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库金额 </div> 
                
       
    </div>
</div>
<div header="10月">
      <div property="columns"  >
           <div type="indexcolumn" ></div>
           <div type="checkcolumn"></div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库金额 </div> 
          
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货金额 </div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库数量</div> 
         
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库金额 </div> 
                
       
    </div>
</div>
<div header="11月">
      <div property="columns"  >
           <div type="indexcolumn" ></div>
           <div type="checkcolumn"></div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库金额 </div> 
          
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货金额 </div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库数量</div> 
         
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库金额 </div> 
                
       
    </div>
</div>
<div header="12月">
      <div property="columns"  >
           <div type="indexcolumn" ></div>
           <div type="checkcolumn"></div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">入库金额 </div> 
          
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货数量</div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">退货金额 </div> 
        
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库数量</div> 
         
           <div field="menulabel" width="120px" headerAlign="center" allowSort="true">实际入库金额 </div> 
                
       
    </div>
</div>
            </div>      
                  </div>

                               
                                         