
var saveUrl = apiPath + saleApi + "/sales.base.addCssGiftOutMain.biz.ext";
var mGridUrl = apiPath + saleApi + "/sales.base.searchCssGiftOutMain.biz.ext";
var sellTypeArr = [{ id: 1, text: "库存车" }, { id: 2, text: "销售车" }];
var form = {};
var mainGrid = {};
$().ready(function (H) {
    form = new nui.Form("form1");
    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mGridUrl);
    mainGrid.load();




    mainGrid.on("drawcell", function (e) {
        var value = e.value;
        switch (e.field) {
            case "status":
                    e.cellHtml = (value == 0?'草稿':'已提交');
				break;
            case "sellType":
                    e.cellHtml = (value == 1?'库存车':'销售车');
				break;
            default:
                break;
        }
	});
	
})


function save(params) {
    var data = form.getData(true);
    nui.ajax({
        url: saveUrl,
        type: 'post',
        data: {
            data:data
        },
        success:function (res) {
            if (res.errCode == 'S') {
                showMsg('保存成功', 'S');
            }
        }
    })
}

function onSaleEdit(params) {
        nui.open({
        url: webPath + contextPath + '/sales/base/selectSellCar.jsp',
        title: '选择销售单',
        width: 1000,
        height: 500,
        onload: function () {
          var iframe = this.getIFrameEl();
          //iframe.contentWindow.setData(row);
        },
        ondestroy: function (action) {
            var iframe = this.getIFrameEl();
            if(action == 'ok'){
                var row = iframe.contentWindow.getRow();
                nui.get("saleId").setValue(row.id);
                nui.get("enterId").setValue(row.enterId);
                nui.get("serviceCode").setValue(row.serviceCode);
                nui.get("serviceCode").setText(row.serviceCode);
                nui.get("carModelName").setValue(row.carModelName);
                nui.get("vin").setValue(row.vin);
                nui.get("guestFullName").setValue(row.guestFullName);
                nui.get("guestId").setValue(row.guestId);
            }
        }
      });

}

function onEnterIdEdit(params) {
    nui.open({
    url: webPath + contextPath + '/sales/sales/selectCar.jsp',
    title: '选择库存车',
    width: 1000,
    height: 500,
    onload: function () {
      var iframe = this.getIFrameEl();
      iframe.contentWindow.SetData('',1);
    },
    ondestroy: function (action) {
        var iframe = this.getIFrameEl();
      if(action == 'ok'){
        var row = iframe.contentWindow.getSelectedValue();
        nui.get("enterId").setValue(row.id);
        nui.get("vin").setValue(row.vin);
        nui.get("carModelName").setValue(row.carModelName);
        // nui.get("serviceCode").setValue(row.serviceCode);
        // nui.get("serviceCode").setText(row.serviceCode);
      }
    }
  });

}