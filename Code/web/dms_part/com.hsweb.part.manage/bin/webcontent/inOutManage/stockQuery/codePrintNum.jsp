<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/commonPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-12-20 12:27:39
  - Description:
-->
<head>
<title>二维码打印</title>
    
</head>
<body>
<div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">
        <a class="nui-button" iconCls="" plain="true" onclick="print()"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
        <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
    </div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" 
              showPager="true"  dataField="list"   url="" sortMode="client"  allowCellEdit="true" allowCellSelect="true"
             pageSize="500" sizeList="[500,1000,2000]" showSummaryRow="true" allowResize="true" multiSelect="true" >
            <div property="columns">   
                <div type="indexcolumn"  headeralign="center" width="30">序号</div>
                <div field="code" name="code" width="80"  headeralign="center" summaryType="count" allowsort="true" >配件编码</div>
                <div field="name" name="name"   width="60"  headeralign="center"  allowsort="true" >配件名称</div>         
                <div field="store" name="store" width="60"  headeralign="center"  allowsort="true" >仓库</div>              
                <div field="storeShelf" name="storeShelf" width="60"  headeralign="center" allowsort="true" >仓位</div>
                <div field="codeNum" name="codeNum" width="60"  headeralign="center" allowsort="true" >二维码数量
                	<input  property="editor" class="nui-textbox" dataType="int"/>
                </div>
            </div>
        </div>
    </div>
	<script type="text/javascript">
		
		function setData(codeList){
			var mainGrid = nui.get("mainGrid");
			mainGrid.setData(codeList);
		}
		function print(){
			var mainGrid = nui.get("mainGrid");
			var codeList = mainGrid.getData();
			var yz = /^[1-9]\d*$/;
			for(var i =0;i<codeList.length;i++){
				if (!yz.test(codeList[i].codeNum)){
					showMsg(codeList[i].name + "的二维码数量必须为正整数!", "W");
					return;
				}				
			}
			var createQRCodeByListUrl = webPath + sysDomain + "/com.hs.common.uitls.createQRCodeByList.biz.ext";
		    nui.ajax({
		        url: createQRCodeByListUrl,
		        type:"post",
		        async: false,
		        data:{
		        	codeList:codeList,
		        	"width": 150,
		        	"height" : 150,
		        	token:token
		        },
		        cache: false,
		        success: function (data) {
		        	var codeList = data.codeList;
		            if(data.errCode == "S"){
		                nui.open({
		                    url:  webPath + contextPath + "/com.hsweb.print.codePrint.flow",
		                    title:"打印配件二维码",
		                    height:"100%",
		                    width:"100%",
		                    onload:function(){
		                        var iframe = this.getIFrameEl();
		                        iframe.contentWindow.setData(codeList);
		                    },
		                    ondestroy:function(action){
		                    	 onCancel();
		                    }
		
		                });
		            }else{
		                showMsg("生成二维码失败!","E");
		            }
		        }
		    });
		}	
		//关闭窗口
		function CloseWindow(action) {
		    if (window.CloseOwnerWindow)
		        return window.CloseOwnerWindow(action);
		    else window.close();
		}
		//取消
		function onCancel() {
		    CloseWindow("cancel");
		}
    </script>
</body>
</html>