nui.parse();
		var form = new nui.Form("#dataform1");
		form.setChanged(false);
		
    	function saveData(){
				var urlStr;
                var pageType = nui.getbyName("pageType").getValue();
                if(pageType=="add"){
                    urlStr = "com.hsapi.repair.insurance.InsuranceAdd.biz.ext";
                }
                if(pageType=="edit"){
                    urlStr = "com.hsapi.repair.insurance.InsuranceEdit.biz.ext";
                }
                form.validate();
                if(form.isValid()==false) return;
				var data = form.getData(false,true);
                var json = nui.encode(data);

                $.ajax({
                    url:urlStr,
                    type:'POST',
                    data:json,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                            CloseWindow("saveSuccess");
                        }else{
                            nui.alert("保存失败", "系统提示", function(action){
                                if(action == "ok" || action == "close"){
                                    
                                }
                                });
                            }
                        }
                        });
                    }

                    //页面间传输json数据
                    function setData(data){
                        var infos = nui.clone(data);
						nui.getbyName("pageType").setValue(infos.pageType);

                        if (infos.pageType == "edit") {
                            var json = infos.record;
							var form = new nui.Form("#dataform1");
                            form.setData(json);
                            form.setChanged(false);
                        }
                    }

                    //关闭窗口
                    function CloseWindow(action) {
                        if (action == "close" && form.isChanged()) {
                            if (confirm("数据被修改了，是否先保存？")) {
                                saveData();
                            }
                        }
                        if (window.CloseOwnerWindow)
                        return window.CloseOwnerWindow(action);
                        else window.close();
                    }

                    //确定保存或更新
                    function onOk() {
                        saveData();
                    }

                    //取消
                    function onCancel() {
                        CloseWindow("close");
                    }