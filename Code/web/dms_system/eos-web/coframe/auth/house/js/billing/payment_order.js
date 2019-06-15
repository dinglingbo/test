var carno = null,
	serviceno = null,
	projectPicre = 0;
	
$(function () {
	isLogin();
	
	serviceno = getUrlParam("serviceno");

	writeCustomerInfo(serviceno);
	
	detailPjPlantoutList();

	$("#cancelWords").click(function () {
		location = '/billing/order.html';
	});
	$("#submitWords").click(submitWords);
});

//填写客户信息
function writeCustomerInfo(serviceno) {
	sendRequest({
		token: true,
		action: 'clerk/receive/getMaintain',
		data: {serviceno: serviceno},
		lock: true,
		onSuccess: function(obj) {
			if (obj.status == 'success') {
				var data = obj.data.clientcarsDTO,
					itemquotelist = obj.data.itemlist || [],
					pqlist = obj.data.pqlist || [],
					packagequotelist = obj.data.packagelist || [],
					onlineorderlist = obj.data.onlineorderlist || [];
					
					for (var p=0;p<pqlist.length;p++) {
						itemquotelist.push(pqlist[p])
					}
					
					for (var y=0;y<onlineorderlist.length;y++) {
						var onlPartlist =  onlineorderlist[y].pkgpartlist

						for (var k=0;k<onlPartlist.length;k++) {
							if (onlPartlist[k]) {
								packagequotelist.push(onlPartlist[k])
							}
							
						}
					}
					
					$("#carNo").val(data.carno);

					$("#clientcode").val(data.clientcode);
					$("#clientname").val(data.clientname);
					$("#mobile").val(data.mobile);
					
					$("#vin").val(data.vin);
					$("#carModelName").val(CAR_BRAND[data.carplate]+ data.carmodel)
						.data("carplate", data.carplate)
						.data("carmodel", data.carmodel)
						.data("carline", data.carline);
					
					$("#distance").val(data.distance);

					$("#insurercode").val(data.insurername);
					
					$("#maturedate").val(data.maturedate ? new Date(data.maturedate).formatFullDate() : null);
					$("#firstenrol").val(data.firstenrol ? new Date(data.firstenrol).formatFullDate() : null);
					
					$("#packageList").html($('#quote-list-tmpl').tmpl(itemquotelist)).append($('#package-show-tmpl').tmpl(onlineorderlist));
					$("#packageListTotal").text(obj.data.banlansum);
					projectPicre = obj.data.banlansum;
			}
		}
	});

}
//详情里的维修已出库厂品
function detailPjPlantoutList() {
	sendRequest({
		token: true,
        action: 'carbeauty/getPjPlantoutList',
        data: {serviceno: serviceno,
	        pageSize: 200,
			retnsign: 0,
			pdownsort: 'C002'},
        lock: true,
        onSuccess: function(obj) {
			if (obj.status == 'success') {
				var data = obj.page.items || [];
				if (data.length> 0) {
					$(".suppliesList").show();
					$("#liliaoBox").show();
					$("#suppliesList").html($('#supplies-list-tmpl').tmpl(data));
				}

			} else {
				Dialog.popup(obj.message);
			}
        }
    });	
}


//提交结算
function submitWords() {
	//取值
	var agiosum =  Number($("#agiosum").val().trim()).toFixed(2)
	var settlement = {
		serviceno: serviceno,
		agiosum: agiosum,
		remark: $("#remark").val().trim(),
		project: projectPicre,
		banlansum: accMin(projectPicre, agiosum)
	},
	$content = $('#open-banlansum-tmpl').tmpl(settlement);

	
	if (settlement.agiosum > projectPicre) {
		Dialog.popup('折让金额不能大于项目金额！');
		$("#agiosum").focus();
		return false;
	}
	
	var openBanlansum = new Dialog({
		closeable: false,
		width: '450',
		title: '结算',
		content: $content,
		operate: [{
			text: '确定',
			onClick: function() {
				settlement.fsort = $content.find("input[name='sex']:checked").val();
				
				if (!settlement.fsort) {
					Dialog.popup('请选择支付方式！');
					$content.find("input[name='sex']").focus();
					return false;
				}
				
				sendRequest({
					token: true,		
					action: 'carbeauty/saveSettlement',
					data: settlement,
					lock: true,
					onSuccess: function(obj) {
						if (obj.status == 'success') {
							Dialog.popup('支付成功！', location = '/billing/order.html');
						} else {
							Dialog.popup(obj.message);
						}
					}
				});	
				
			}
		}, {
			text: '取消',
			attr: {'class': 'btn btn_red'}, 
			onClick: function() {
				openBanlansum.close();
			}
		}]
	}).show();
	
	
}
