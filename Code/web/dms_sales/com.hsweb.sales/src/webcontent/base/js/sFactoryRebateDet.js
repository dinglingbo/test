var saveUrl = apiPath + saleApi + "/sales.base.saveCssFRebate.biz.ext";
var gUrl = apiPath + saleApi + "/sales.base.searchCsbRebate.biz.ext?params/isDisabled=0&token=" + token;
var leftGridUrl = apiPath + saleApi +"/sales.inventory.queryCheckEnter.biz.ext";
var rightGridUrl = apiPath + saleApi +"/sales.base.searchCssFRebateDet.biz.ext";
var form = null;
var mainData = null;
var searchBeginDate = null;
var searchEndDate = null;
var leftGrid = null;
var rightGrid = null;
var comServiceId = null;
var comSearchGuestId = null;
$(document).ready(function() {
    form = new nui.Form("form1"); 
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    comServiceId = nui.get("serviceId");
    comSearchGuestId = nui.get("searchGuestId");

    
    initMember("operator", function () { });
    nui.get("rebateId").setUrl(gUrl);
    onSearch();

    initDicts({
        "frameColorId": "DDT20130726000003",
        "interialColorId": "10391"
    }, function () { })

    rightGrid.on("drawcell", function (e) { 
        var value = e.value;
        var field = e.field;
        if (field == 'frameColorId') {
            e.cellHtml = setColVal('frameColorId','customid', 'name', e.value);
        } else if (field == 'interialColorId') {
            e.cellHtml = setColVal('interialColorId','customid', 'name', e.value);
        } else if (field == 'rebateAmt' || field == 'remark') {
            e.cellStyle = 'background-color:lightgreen';
        }
    })


    leftGrid.on("rowclick", function (e) {
        // var billFormData = billForm.getData(true); //主表信息
        // if (billFormData.status != 0) {
        //     return;
        // } 
        var leftData = leftGrid.getSelecteds();
        var rightData = rightGrid.getData();
        for (var i = 0, l = leftData.length; i < l; i++) {
            var msg = rightData.find(rightData => rightData.enterId == leftData[i].id);
            if (!msg) {
                var newRow = {
                    enterId: leftData[i].id,
                    carModelId: leftData[i].carModelId,
                    vin: leftData[i].carFrameNo,
                    carModelName: leftData[i].carModelName,
                    frameColorId: leftData[i].frameColorId,
                    interialColorId: leftData[i].interialColorId,
                    orderPrice: leftData[i].unitPrice,
                };
                rightGrid.addRow(newRow, rightData.length);
            };
        }
        rightData = rightGrid.getData();
        for (var i = 0, l = rightData.length; i < l; i++) {
            var row = rightGrid.getRow(i);
            var msg = leftData.find(leftData => leftData.id == rightData[i].enterId);
            if (!msg) {
                rightGrid.commitEdit();
                rightGrid.removeRow(row, false);
            };
        };
    });

    rightGrid.on("cellcommitedit",function(e){
		var field = e.field; 
        var value = e.value; 
        var editor = e.editor;
        if (field == 'rebateAmt') {
            if (editor.isValid() == false) {
                showMsg("请输入有效数字！","W");
                e.cancel = true;
            }
        }

    });

})


function setInitData(row) { 
    mainData = row;
    quickSearch(4);
    form.setData(row);
    nui.get("guestId").setText(row.guestFullName);
    //onSearch();
    rightGrid.load({
        params: {
            orderId: row.id
        }
    });
}


function selectSupplier(elId,e)
{
    var supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title: "供应商资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                isSupplier: 1,
                guestType:'01020201'
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
                if (e == 1) {
                    nui.get("guestFullName").setValue(text);
                }
            }
        }
    });
}



function save() {
    var data = form.getData(true);
    var addList = rightGrid.getChanges("added"); //精品加装
    var upList = rightGrid.getChanges("modified");
    var delList = rightGrid.getChanges("removed");

    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});
    nui.ajax({
        url:saveUrl,
        type:'post',
        data:{
            data: data,
            addArr: addList,
            upArr: upList,
            delArr:delList
        },
        success: function (res) {
            nui.unmask(document.body);
            if(res.errCode == 'S'){
                showMsg('保存成功', 'S');
                nui.get('id').setValue(res.res.id);
                var params = {
                    orderId: nui.get("id").value
                };
                rightGrid.load({params:params});
            }else{
                showMsg('保存失败','E');
            }
            CloseWindow("ok");
        }
    })
}


function onCancel() {
    CloseWindow("cancel");
}

function CloseWindow(action) {
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else
        window.close();
}



function quickSearch(type){
    var params = getSearchParam();
    var querysign = 1;
    var queryname = "本日";
    var querystatusname = "所有";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;
        default:
        	querysign = 2;
        	querystatusname = "所有";
        	params.auditSign=-1;
            break;
    }
    
    searchBeginDate.setValue(params.startDate);
    searchEndDate.setValue(addDate(params.endDate,-1));
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname); 	
    doSearch(params);
}
function onSearch(){
	var params = getSearchParam();
    doSearch(params);
}

function doSearch(params)
{

    leftGrid.load({
        params:params,
        token:token
    },function(){
        leftGrid.mergeColumns(["serviceId"]);
    });
}

function getSearchParam(){
    var params = {};
    params.serviceId = comServiceId.getValue();
    params.carModelName = nui.get("carModelName").getValue();
	// if(typeof comSearchGuestId.getValue() !== 'number'){
    // 	params.guestId=null;
    // 	params.guestName = comSearchGuestId.getValue();
    // }else{
    // 	params.guestId = comSearchGuestId.getValue();
    // }
    params.guestId = nui.get("guestId").getValue();
    params.endDate = addDate(searchEndDate.getValue(), 1);
    if (params.endDate == 'NaN-NaN-NaN')
        params.endDate = '';
    params.startDate = searchBeginDate.getFormValue();
    params.billStatus = 1;
    return params;
}