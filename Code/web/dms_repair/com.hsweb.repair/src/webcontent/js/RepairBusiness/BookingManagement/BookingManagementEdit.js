baseUrl = apiPath + sysApi + "/";;
var queryForm;
var basicInfoForm;
var upGrid;
var downGrid;
var currGuest;
var assignStatus;
var timeStatus;
var rOrp;
var statusStatus;
var carSeriesId;
var prebookCategoryHash;
var advancedSearchWin = null;
var listUrl= baseUrl + "com.hsapi.repair.repairService.booking.queryBookingList.biz.ext";
var prebookCategoryHash=[{text:'用户主动预约',value:'0'},{text:'用户被动预约',value:'1'}];
$(document).ready(function(v){
	nui.get("prebookCategory").setData(prebookCategoryHash);
	carSeriesId=nui.get("carSeriesId");
	initMember("mtAdvisorId",null);
	
	initCarBrand("carBrandId",null);
	//getCarModel("carSeriesId",null);
	
	getBisinessList(function(data) {
		var bisinessList=[];
		bisinessList = data.data;
		nui.get("serviceTypeId").setData(bisinessList);
		
		
	});
	
	
});



/*
 *设置时间菜单
 **/
function setMenu(obj, target, value){
    target.setValue(value);
    target.setText(obj.getText());   
   
}

function setMenu1(obj, target, value){
    target.setValue(value);
    target.setText(obj.getText());   
   
}

function onOk() {

	basicInfoForm = new nui.Form("#basicInfoForm");	
	s=basicInfoForm.getData();
	if (s != undefined) {
		nui.ajax({
			url : baseUrl
					+ "com.hsapi.repair.repairService.booking.updateBooking.biz.ext",
			type : 'post',
			data : nui.encode({
				param : s
			}),
			success : function(data) {
				if (data.errCode == "S") {
					
					window.CloseOwnerWindow("ok");
				} else {
					window.CloseOwnerWindow("ok");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				nui.alert(jqXHR.responseText);
			}
		});
	}

}
function onCancel(){
	
	window.CloseOwnerWindow("ok");
	
}



function search() {
    var param = getSearchParam();
    doSearch(param);
}

function getSearchParam() {
	queryForm = new nui.Form("#queryForm");
    var params = queryForm.getData();
    return params;
}

function doSearch(params) {
	basicInfoForm = new nui.Form("#basicInfoForm");	
	nui.ajax({
           url: listUrl,
           type: 'post',
           data: nui.encode({
        	 params: params
           }),
           success: function (data) {
        	   basicInfoForm.setData(data.data[0]);
           },
           error: function (jqXHR, textStatus, errorThrown) {
               nui.alert(jqXHR.responseText);
           }
       });}

function SetData(params){
	basicInfoForm = new nui.Form("#basicInfoForm");	
	basicInfoForm.setData(params.data);
	
	if(params.data.carBrandId!="") 
	{
	getCarModel("carSeriesId",params.data.carBrandId);
	}
	}
	
function addCarBrand() {
    selectCustomer(function (car) {
        var maintain = {
            guestId: car.guestId,
            contactorId: car.contactorId,
            carId: car.id,
            carNo: car.carNo,
            carVin: car.underpanNo,
            serviceTypeId: "0",
            mtType: "0",
            mtAdvisor: currUserName,
            insureCompCode: car.insureCompCode
        };
        nui.mask({
            html: '保存中..'
        });
        getServiceCode(function (data) {
            var code = data.code;
            if (!code) {
                nui.unmask();
                nui.alert("获取单号失败");
                return;
            }
            maintain.serviceCode = code;
            saveMaintain(maintain, function (data) {
                nui.unmask();
                data = data || {};
                if (data.errCode == "S") {
                    reload();
                }
                else {
                    nui.alert(data.errMsg || "新增失败");
                }
            });
        });
    });
}

function selectCustomer(callback) {
    nui.open({
        url: "com.hsweb.RepairBusiness.Customer.flow",
        title: "客户选择", width: 800, height: 450,
        onload: function () {
        },
        ondestroy: function (action) {
            if ("ok" == action) {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                callback && callback(guest);
            }
        }
    });
}


/*
 * 
 * 获取业务分类列表*/
var bisinessUrl = baseUrl + "com.hsapi.system.confi.paramSet.getbusinessSort.biz.ext";
function getBisinessList(callback){
    nui.ajax({
        url: bisinessUrl,
        type: 'post',
        data: nui.encode({
        }),
        cache: false,
        success: function (data) {
            if (data) {
             callback(data);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            nui.alert(jqXHR.responseText);
        }
	});
	
}

function onChange(e){
    var value = e.selected.empName;
    nui.get("mtAdvisor").setValue(value);
}


function onBrandChange(e){
    
        
        initCarMT('carSeriesId',e.value);
}

