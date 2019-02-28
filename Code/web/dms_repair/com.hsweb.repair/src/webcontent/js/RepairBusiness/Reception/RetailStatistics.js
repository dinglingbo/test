var baseUrl = apiPath + repairApi + "/";

var gridUrl=baseUrl+"com.hsapi.repair.repairService.report.queryRetailStatistics.biz.ext";
	
var partBrandList = [];
var brandHash = {};
var guestTypeHash = {};
var partTypeList = [];
var typeHash = {};
var partBrandIdEl = null;
var partCodeEl = null;
var partNameEl = null;
var advanceGuestIdEl = null;
var beginDateEl = null;
var endDateEl = null;
var clientGrid = null;
var partGrid = null;
var partBrandGrid = null;
var partTypeGrid = null;
var mainTabs = null;
var orgidsEl = null;
 
$(document).ready(function(v) {
	clientGrid = nui.get("clientGrid");
	clientGrid.setUrl(gridUrl);

    partGrid = nui.get("partGrid");
    partGrid.setUrl(gridUrl);

    partBrandGrid = nui.get("partBrandGrid");
    partBrandGrid.setUrl(gridUrl);

    partTypeGrid = nui.get("partTypeGrid");
    partTypeGrid.setUrl(gridUrl);

    mainTabs = nui.get("mainTabs");
    
    //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
	
	partBrandIdEl = nui.get("partBrandId");
    partCodeEl = nui.get("partCode");
    partNameEl = nui.get("partName");
    advanceGuestIdEl = nui.get("advanceGuestId");
	beginDateEl = nui.get("sRecordDate");
	endDateEl = nui.get("eRecordDate");

	beginDateEl.setValue(getMonthStartDate());
	endDateEl.setValue(addDate(getMonthEndDate(), 1));

	document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		
		if ((keyCode == 13)) { // Enter
			onSearch();
		}


	}
	getAllPartBrand(function(data) {
		partBrandList = data.brand;
		partBrandIdEl.setData(partBrandList);
		partBrandList.forEach(function(v) {
			brandHash[v.id] = v;
		});
	});
	
	
   var dictDefs ={"guestType":GUEST_TYPE};
    initDicts(dictDefs, function(){
        var data = nui.get("guestType").getData();
        data.forEach(function(v) {
            guestTypeHash[v.customid] = v;
        });
    });
    
    mainTabs.on("activechanged",function(e){
    	onSearch();
	});
    getAllPartType(function(data) {
        partTypeList = data.partTypes;
        partTypeList.forEach(function(v) {
            typeHash[v.id] = v;
        });
    });

  
 
});
function getSearchParam() {
	var params = {};
	params.isSettle=1;
    params.partBrandId = partBrandIdEl.getValue();
    params.partNameAndPY = partNameEl.getValue();
    params.partCode = partCodeEl.getValue();
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }
    if(typeof advanceGuestIdEl.getValue() !== 'number'){
    	params.guestId=null;
    	params.guestName = advanceGuestIdEl.getValue();
    }else{
    	params.guestId = advanceGuestIdEl.getValue();
    }
	return params;
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.sRecordDate = getMonthStartDate();
            params.eRecordDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 1:
            params.sRecordDate = getLastMonthStartDate();
            params.eRecordDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;
        case 2:
            params.sRecordDate = getQuarterStartDate();
            params.eRecordDate = addDate(getQuarterEndDate(), 1);
            queryname = "本季";
            break;
        case 3:
            params.sRecordDate = getLastQuarterStart();
            params.eRecordDate = addDate(getLastQuarterEnd(), 1);
            queryname = "上季";
            break;
        case 4:
            params.sRecordDate = getYearStartDate();
            params.eRecordDate = getYearEndDate();
            queryname = "本年";
            break;
        case 5:
            params.sRecordDate = getPrevYearStartDate();
            params.eRecordDate = getPrevYearEndDate();
            queryname = "上年";
            break;
        default:
            break;
    }
    beginDateEl.setValue(params.sRecordDate);
    endDateEl.setValue(addDate(params.eRecordDate,-1));
    currType = type;
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}
function onSearch(){
	var params = getSearchParam();
    params.sRecordDate = beginDateEl.getFormValue();
    params.eRecordDate = addDate(endDateEl.getValue(),1);
    
    doSearch(params);
}
function doSearch(params)
{
    var tab = mainTabs.getActiveTab();
    if(tab.name == "clientGridTab"){
    	params.groupType="a.guest_id";
        clientGrid.load({
            params:params,
            token:token
        }); 
    }else if(tab.name == "partGridTab"){
    	params.groupType="b.part_id";
        partGrid.load({
            params:params,
            token:token 
        });  
    }else if(tab.name == "partBrandGridTab"){
    	params.groupType="d.part_brand_id";
        partBrandGrid.load({
            params:params,
            token:token
        });  
    }else if(tab.name == "partTypeGridTab"){
    	params.groupType="d.car_type_id_f";
        partTypeGrid.load({
            params:params,
            token:token
        });  
    }
	

}
function onDrawCell(e) {
    var row = e.row;
	switch (e.field) {
    	case "partBrandId":
    		  if(brandHash[e.value])
              {
//                  e.cellHtml = brandHash[e.value].name||"";
              	if(brandHash[e.value].imageUrl){
              		
              		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
              	}else{
              		e.cellHtml = brandHash[e.value].name||"";
              	}
              }
              else{
                  e.cellHtml = "";
              }
    		break;
        case "carTypeIdF":
            if (typeHash[e.value]) {
                e.cellHtml = typeHash[e.value].name || "";
            } else {
                e.cellHtml = "";
            }
            break;
        case "guestType":
            if (guestTypeHash[e.value]) {
                e.cellHtml = guestTypeHash[e.value].name || "";
            } else {
                e.cellHtml = "";
            }
            break;
    	default:
    		break;
	}
}

var supplier = null;
function selectSupplier(elId) {
    supplier = null;
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title : "客户资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
            	
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();

                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);

            }
        }
    });
}