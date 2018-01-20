<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/bps/web/control/html/common.jsp"%>
<html>
<head>
<title></title>
</head>
<body>
    <!-- @REVIEW style样式需要抽取到css中[guwei] -->
	<table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
	  <tr>
	    <th height="23" class="nui-form-label" scope="col" style="vertical-align:middle;padding-top:3px;text-align:left;">
	    	<div class="nui-toolbar" style="border-bottom:0;padding:2px;">
		        <table style="width:100%;">
		            <tr>
		                <td style="white-space:nowrap;">
		                	<input id="key1" style="width:100%;" class="nui-textbox search" emptyText="" onenter="searchTree"/>   
		            	</td>
		            </tr>
		        </table>           
		    </div>
	    </th>
	    <th scope="col" class="nui-form-label" style="vertical-align:middle; padding-top:3px; text-align:left; ">
	    	<div class="nui-toolbar" style="border-bottom:0;padding:2px;">
		        <table style="width:100%;">
		            <tr>
		                <td style="white-space:nowrap;">
		                	<input id="key2" style="width:100%;" class="nui-textbox search" emptyText="" onenter="searchDataGrid"/>   
		            	</td>
		            </tr>
		        </table>           
		    </div>
	    </th>
	  </tr>
	  <tr>
	    <td height="261" valign="top"  style="border:1px solid #CCCCCC;" bgcolor="#FFFFFF"> 
			<div id="fromDiv"  class="nui-fit" style="height:261;width:100%;overflow:auto;">
				<!-- @REVIEW 双击不要选中图片和文字[guwei] -->
				<ul id="selectTree" class="nui-tree" style="height:100%;width:100%;" resultAsTree="false" showTreeIcon="true" 
					dataField="childNodes" textField="text" idField="id" parentField="pid" imgField="icon" 
					onbeforeload="onBeforeTreeLoad" onpreload="onPreTreeLoad"
					onnodeclick="onDisplayLeafInfo" onnodedblclick="addItemFromTree">
				</ul>
			</div>
	     </td>
	    <td valign="top" height="261" >
	    	<div class="nui-fit">
				<div id="datagrid" class="nui-datagrid" idField="id" style="height:100%;width:100%;" 
				     allowResize="false" allowAlternating="true" allowRowSelect="true" 
				     showHeader="false" allowSortColumn="false" showPager="false" showModified="false" showColumns="false" 
				     onrowdblclick="addItemFromDatagrid">
				     <div property="columns">
					    <div field="text" width="100%" headerAlign="center" renderer="onDataGridRender"></div> 
					  </div>
				</div>
			</div>
	  	</td>
	  </tr>
	
	  <tr>
	    <td align="center" colspan="2"  valign="baseline">
	    	<input id="selectedList" class="nui-textboxlist" style="width:100%;height:30px;" allowInput="false" 
	       		onvaluechanged="onChangeTextboxlist"/>
		</td>
	  </tr>
	</table>
	<div class="bottomBtnDiv">
		<a class="nui-button redBtn" onclick="removeAllItems"><%=I18nUtil.getMessage(request, "bps.control.common.clear")%></a>
		<a class="nui-button redBtn" onclick="confirm"><%=I18nUtil.getMessage(request, "bps.control.common.confirm")%></a>
		<a class="nui-button redBtn" onclick="cancel"><%=I18nUtil.getMessage(request, "bps.control.common.cancel")%></a>
	</div>
	<script type="text/javascript">
    	nui.parse();
		
		var maxCount = 1;
		var otherParamObj = {};
		var dataGridDataOld = null;
		
		var selectTreeObj = nui.get("selectTree");
        var dataGridObj = nui.get("datagrid");
		var selectedList = nui.get("selectedList");
		var childSelected = {};

		function initData(data) {
			maxCount = data.maxCount;
			otherParamObj = data.otherParamObj;
			selectTreeObj.setUrl(otherParamObj.loadUrl);
			selectTreeObj.load();
			//默然显示第一级菜单
			selectTreeObj.loadNode(selectTreeObj.getChildNodes(selectTreeObj.getRootNode())[0]);
			if (data.ids == null || data.ids.length == 0) {
				return;
			}
			var idsArray = data.ids.split(",");
			var textsArray = data.texts.split(",");
			for (var i = 0; i < idsArray.length; i++) {
				addItem(idsArray[i], textsArray[i]);
			}
		}

		function onDataGridRender(e){
			return "<div style='background:url(" + e.record.icon + ") no-repeat;padding-left:20px;'>"+e.value+"</div>";
		}
		
		function searchTree(e) {
            var key = nui.get("key1").getValue();
            if (key == "") {
            	selectTreeObj.clearFilter();
            } else {
                key = key.toLowerCase();                
                selectTreeObj.filter(function (node) {
                    var text = node.text ? node.text.toLowerCase() : "";
                    if (text.indexOf(key) != -1) {
                    	expandNode(node);
                    	selectTreeObj.selectNode(node);
                        return true;
                    }
                });
            }
        }
        
        function expandNode(node) {
        	var parent = selectTreeObj.getParentNode(node);
        	if (parent) {
        		expandNode(parent);
	        	if (!selectTreeObj.isExpandedNode(parent)) {
	                selectTreeObj.expandNode(parent);
	            }
        	}
        }
		
		function searchDataGrid(e) {
            var key = nui.get("key2").getValue();
            if (key == "") {
            	dataGridObj.setData(dataGridDataOld);
            } else {
                key = key.toLowerCase();    
                var dataGridDataTmp = [];
                for(var i = 0; i < dataGridDataOld.length; i++) {
					if(dataGridDataOld[i].text.toLowerCase().indexOf(key) != -1){
						dataGridDataTmp.push(dataGridDataOld[i]);
					}
				}
                dataGridObj.setData(dataGridDataTmp); 
            }
        }
		
		function onBeforeTreeLoad(e) {
	        var tree = e.sender;    //树控件
	        var node = e.node;      //当前节点
	        var params = e.params;  //参数对象	     
	        params.node = node;
	    	otherParamObj.commitParamObj.isLoadLeaf = false;
	        params.otherParamObj = otherParamObj.commitParamObj;
	    }

	    function onPreTreeLoad(e) {
		    if (e.exception) {
			    if(tfcToast && tfcToast.take){
			    	tfcToast.take('<%=I18nUtil.getMessage(request, "bps.control.common.loadFail")%>');
			    	return;
				}
		    	window.top.nui.alert('<%=I18nUtil.getMessage(request, "bps.control.common.loadFail")%>');
			}
		}

	    function onDisplayLeafInfo(e) {
	    	otherParamObj.commitParamObj.isLoadLeaf = true;
	    	nui.ajax({
	            url: otherParamObj.loadUrl,
	            type: 'POST',
	            data: {node: e.node, otherParamObj : otherParamObj.commitParamObj},
	            cache: false,
	            success: function (res) {
	            	if(res.exception) {
	            		if(tfcToast && tfcToast.take){
	    			    	tfcToast.take('<%=I18nUtil.getMessage(request, "bps.control.common.loadFail")%>');
	    			    	return;
	    				}
	        			window.top.nui.alert('<%=I18nUtil.getMessage(request, "bps.control.common.loadFail")%>');
	        		} else {
		            	dataGridDataOld = res.childNodes;
						var length=dataGridDataOld.length;
		            	for(var i=0;i<length;i++){
		            		var data=dataGridDataOld[i];
		            		var id=data.id;
		            		var beginIndex=id.indexOf("|");
		            		var endIndex=id.indexOf("$");
		            		id=id.substring(beginIndex+1,endIndex);
		            		var text=data.text;
							text=text.replace("("+id+")","");
							dataGridDataOld[i].text=text;
		            	}
						dataGridObj.setData(dataGridDataOld);
		        	}
	            },
	            error: function () {
	            	if(tfcToast && tfcToast.take){
				    	tfcToast.take('<%=I18nUtil.getMessage(request, "bps.control.common.loadFail")%>');
				    	return;
					}
	            	window.top.nui.alert('<%=I18nUtil.getMessage(request, "bps.control.common.loadFail")%>');
	            }
	        });
	    }

	    function addItemFromTree(event) {
			if (event.node._pid != "-1") {
				addItem(event.node.id, event.node.text, event.node.pid);
			}
		}

	    function addItemFromDatagrid(event) {
			addItem(event.row.id, event.row.text, event.row.pid);
		}
		
		//增加选项
		function addItem(value, text, pvalue) {
			if (value.length == 0) {
				return;
			}
			var values = selectedList.getValue();
			var texts = selectedList.getText();
			if (maxCount == 1) {
				values = ""
				texts = "";
			}
			if (values.indexOf(value) != -1 
					|| (otherParamObj.selectableType.length > 0 && otherParamObj.selectableType.indexOf(value.split("|")[0]) == -1)
					|| (otherParamObj.isNotAllowParentChild && (values.indexOf(pvalue) != -1 || (childSelected[value] && childSelected[value].length > 0))) ) {
				return;
			}
			var valueArray = values.split(",");
			//REVIEW 条件判断错误 {wuyh}					
			if (maxCount != 1 && maxCount != -1 && valueArray.length >= maxCount) {
				if(tfcToast && tfcToast.take){
			    	tfcToast.take('<%=I18nUtil.getMessage(request, "bps.control.common.exceedMaxCount")%>' + maxCount);
			    	return;
				}
				window.top.nui.alert('<%=I18nUtil.getMessage(request, "bps.control.common.exceedMaxCount")%>' + maxCount);
				return;
			}
			if(values.length > 0) {
				values = values + "," + value;
				texts = texts + "," + text;
			} else {
				values = value;
				texts = text;
			}
			valueArray = values.split(",");
			var textArray = texts.split(",");
			sortArray(valueArray, textArray);

			if (otherParamObj.isNotAllowParentChild) {
				childSelected[pvalue] += "," + value;
			}
			selectedList.setValue(valueArray.join(","));
			selectedList.setText(textArray.join(","));

			renderTextboxlist();
		}

		function sortArray(valueArray, textArray) {
			for(var i = 0; i < valueArray.length; i++) {
				valueArray[i] = valueArray[i] + "," + textArray[i];
			}

			valueArray.sort();
			for(var i = 0; i < valueArray.length; i++) {
				var temp = valueArray[i].split(",");
				valueArray[i] = temp[0];
				textArray[i] = temp[1];
			}
		}

		function renderTextboxlist() {
			var valueArray = selectedList.getValue().split(",");
			//颜色渲染
			var childs = $("ul").children(".mini-textboxlist-item");
			for(var i = 0; i < valueArray.length; i++) {
				var type = valueArray[i].split("|")[0];
				var bgString = 'none repeat scroll 0 0 ' + otherParamObj.colorMap[type];
				$(childs[i]).css({'background': bgString});
			}
		}	

		function onChangeTextboxlist() {
			if (otherParamObj.isNotAllowParentChild) {
				var value = selectedList.getValue();
				for(var prop in childSelected) {
					var childs = childSelected[prop].split(",");
					childSelected[prop] = "";
					for (var i = 0; i < childs.length; i++) {
						if (value.indexOf(childs[i]) != -1) {
							childSelected[prop] += "," + childs[i];
						}
					}
				}
			}
			
			renderTextboxlist();
		}	
		
		//删除所有选项
		function removeAllItems() {	
			selectedList.setValue("");
			selectedList.setText("");
			childSelected = {};
		}

		function returnData() {
			return {
					  ids : selectedList.getValue(), 
					  texts : selectedList.getText()
				   };
		}
		
		function confirm() {	
			closeWindow("ok");
		}
		
		function cancel() {
			closeWindow("cancle");
		}

		function closeWindow(action) {   
            if (window.CloseOwnerWindow) {
                return window.CloseOwnerWindow(action);
            } else {
            	window.close();  
            }          
        }
    </script>
</body>
</html>
