		var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
		var dataGridUrl = baseUrl+"com.hsapi.repair.baseData.insurance.InsuranceQuery.biz.ext";
		var dataGrid = null;
		
		$(document).ready(function(v){
			dataGrid = nui.get("datagrid1");
			dataGrid.setUrl(dataGridUrl);
			loadDataGridData({});
		});
		
		function loadDataGridData(params){
			dataGrid.setData([]);
			dataGrid.load(params,function(){
				var row = dataGrid.getSelected();
				if(row){
					if(row.isDisabled){
						 nui.get("disable").hide();
			             nui.get("enable").show();
					}
					else{
			             nui.get("disable").show();
			             nui.get("enable").hide();
			        }
					loadDataGridData(row.code);
				}
			});
		}
		function onSearch(type)
		{
		    var params = {};
		    if(type == 1||type == 0)
		    {
		        params.isDisabled = type;
		    }
		    loadDataGridData(params);
		}
		
		function addOrEdit(comguest){
    		nui.open({
    			targetWindow: window,
    			url:"InsuranceDetail.jsp",
    			title:"保险公司",width:450,height:300,
    			onload:function(){
    				if(comguest){
    					var iframe = this.getIFrameEl();
    					iframe.contentWindow.setData({
    						comguest:comguest
    					});
    				}
    			},
    			 ondestroy:function(action){
    		    	if(action == "ok"){
    		    		dataGrid.reload();
    		    	}
    		}	
    		});
    		
    	}
		
		function add(){
			addOrEdit();
		}
		function edit(){
			var row = dataGrid.getSelected();
			if(row){
				addOrEdit(row);
			}
		}
		function onDrawCell(e)
		{
		    switch (e.field)
		    {
		        case "isDisabled":
		            e.cellHtml = e.value==1?"禁用":"启用";
		            break;
		        default:
		            break;
		    }
		}
		function disableComeguest(){
		    var row = dataGrid.getSelected();
		    if(row)
		    {
		        nui.confirm("确定要禁用所选保险公司？","提示",function(action)
		        {
		            if(action == "ok")
		            {
		                updateIsDisabled({
		                    id:row.code,
		                    isDisabled:1
		                },function(data)
		                {
		                    data = data||{};
		                    if(data.errCode == "S")
		                    {
		                        row.isDisabled = 1;
		                        dataGrid.updateRow(row,row);
		                        nui.get("disabled").hide();
		                        nui.get("enabled").show();
		                        nui.alert("禁用成功");
		                    }
		                    else{
		                        nui.alert(data.errMsg||"禁用失败");
		                    }
		                });
		            }
		        }.bind(row));
		    }
		}
    	//修改保存启用禁用
		var updateIsDisabledUrl = baseUrl+"com.hsapi.repair.baseData.insurance.saveInsurance.biz.ext";
		function updateIsDisabled(comguest,callback)
		{
		    console.log(comguest);
		    nui.mask({
		        html:'保存中...'
		    });
		    nui.ajax({
		        url:updateIsDisabledUrl,
		        type:"post",
		        data:JSON.stringify({
		        	comguest:comguest
		        }),
		        success:function(data)
		        {
		            nui.unmask();
		            callback && callback(data);
		        },
		        error:function(jqXHR, textStatus, errorThrown){
		            //  nui.alert(jqXHR.responseText);
		            console.log(jqXHR.responseText);
		        }
		    });
		}