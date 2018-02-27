		var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
		var basicInfoForm = null;
		
		$(document).ready(function(){
			basicInfoForm = new nui.Form("#basicInfoForm");
		});
		function setData(data){
			if(!basicInfoForm){
				basicInfoForm = new nui.Form("#basicInfoForm");
			}
			data = data||{};
			var comguest = data.comguest;
			basicInfoForm.setData(comguest);
		};
		//必填
		var requiredField = {
			    code:"保险公司代码",
			    fullName:"保险公司名称"
		};
		var saveUrl = baseUrl + "com.hsapi.repair.baseData.insurance.saveInsurance.biz.ext";
		function onOk()
		{
		    var data = basicInfoForm.getData();
		    console.log(data);
		    for(var key in requiredField)
		    {
		        if(!data[key] || data[key].trim().length==0)
		        {
		            nui.alert(requiredField[key]+"不能为空");
		            return;
		        }
		    }
		    nui.mask({
		        html:'保存中...'
		    });
		    nui.ajax({
		        url:saveUrl,
		        type:"post",
		        data:JSON.stringify({
		            comguest:data
		        }),
		        success:function(data)
		        {
		            nui.unmask();
		            data = data||{};
		            if(data.errCode == "S")
		            {
		                nui.alert("保存成功");
		                CloseWindow("ok");
		            }
		            else{
		                nui.alert(data.errMsg||"保存失败");
		            }
		        },
		        error:function(jqXHR, textStatus, errorThrown){
		            //  nui.alert(jqXHR.responseText);
		            console.log(jqXHR.responseText);
		        }
		    });
		}
		
		function CloseWindow(action) {
		    //if (action == "close" && form.isChanged()) {
		    //    if (confirm("数据被修改了，是否先保存？")) {
		    //        return false;
		    //    }
		    //}
		    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
		    else window.close();
		}
		function onCancel() {
		    CloseWindow("cancel");
		}
		
		