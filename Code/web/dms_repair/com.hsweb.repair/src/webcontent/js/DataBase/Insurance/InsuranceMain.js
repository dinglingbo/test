nui.parse();
    	
    	
    	var grid = nui.get("datagrid1");
    	var formData = new nui.Form("#form1").getData(false, false);
    	grid.load(formData);
    	
    	function add(){
    		nui.open({
    			url:"InsuranceDetail.jsp",
    			title:"新增保险公司",width:450,height:300,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"add"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    		
    	}
    	
    	function edit(){
    	    var row = grid.getSelected();
    	    if(row) {
    	        nui.open({
    	            url:"InsuranceDetail.jsp",
    	            title:"修改保险公司",
    	            width:450,
    	            height:300,
    	            onload:function(){
    	                var iframe = this.getIFrameEl();
    	                var data = {pageType:"edit",record:{comguest:row}};
    	                //直接从页面获取，不用去后台获取
    	                iframe.contentWindow.setData(data);
    	            },
    	            ondestroy:function(action){
    	                if(action == "saveSuccess"){
    	                    grid.reload();
    	                }
    	            }
    	        });
    	    }else {
    	        nui.alert("请选中一条数据", "系统提示");
    	    }
    	}
    	
    	//重新刷新页面
    	function refresh(){
    		var form = new nui.Form("#form1");
    		var json = form.getData(false, false);
    		grid.load(json);
    		nui.get("update").enable();
    	}
    	//查询
    	function search(){
    		var form = new nui.Form("#form1");
    		var json = form.getData(false, false)
    		grid.load(json);
    	}
    	//重置查询条件
    	function reset(){
    		var form = new nui.Form("#form1");
    		grid.reset();
    	}
    	//enter键触发
    	function onKeyEnter(e){
    		search();
    	}
    	//选择列（判定，大于一编辑禁用）
    	function selectionChanged(){
    	    var rows = grid.getSelecteds();
    	    if(rows.length>1){
    	        nui.get("update").disable();
    	    }else{
    	        nui.get("update").enable();
    	    }
    	}
    	function onIsDisabled(e) {
        if (e.value == 1) return "禁用";
        if (e.value == 0) return "启用";
    }
    	
    	//禁用
    	function forbidden(){
    	    
    	    
    	    
    	}