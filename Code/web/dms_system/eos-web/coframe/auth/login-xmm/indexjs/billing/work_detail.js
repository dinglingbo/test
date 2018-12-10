var $ownPartList,
	$packageList,
	$itemList,
	$pqlist,
	listParam,
	clientParam;
$(function () {
	isLogin();
	
	listParam = {
		serviceno: getUrlParam("serviceno"),
		tenorsn: getUrlParam("tenorsn")
	}
	console.log(listParam)
	getMaintain();
	if (listParam.tenorsn == 4 || listParam.tenorsn == 5 || listParam.tenorsn == 6) {
		detailPjPlantoutList();
	}

	if (listParam.tenorsn == 1) {
		getQuoteList();
	}
	
});

//获取工单详情
function getMaintain() {
	sendRequest({
		token: true,
		action: 'clerk/receive/getMaintain',
		data: listParam,
		lock: true,
		onSuccess: function(obj) {
			if (obj.status == 'success') {

				var data = obj.data || [],
					itemquotelist = obj.data.itemlist || [],
					packagequotelist = obj.data.partlist || [],
					onlineorderlist = obj.data.onlineorderlist || [],
					pqlist = obj.data.pqlist || [];
				
				var clientcarsDTO = data.clientcarsDTO;

				$("#clientname").val(clientcarsDTO.clientname);
				$("#carno").val(clientcarsDTO.carno);
				$("#mobile").val(clientcarsDTO.mobile);
				
				$("#vin").val(clientcarsDTO.vin);
				$("#carModelName").val(CAR_BRAND[clientcarsDTO.carplate] + ' ' + clientcarsDTO.carmodel);
				$("#distance").val(clientcarsDTO.distance);
				
				$("#insurername").val(clientcarsDTO.insurername);
				
				$("#maturedate").val(clientcarsDTO.maturedate ? new Date(clientcarsDTO.maturedate).formatFullDate() : null);
				$("#firstenrol").val(clientcarsDTO.firstenrol ? new Date(clientcarsDTO.firstenrol).formatFullDate() : null);
				
				if (listParam.tenorsn !== 1) {
					
					$("#packageList").html($('#quote-list-tmpl').tmpl(itemquotelist)).append($('#package-show-tmpl').tmpl(onlineorderlist));
					$("#packageListTotal").text(data.banlansum);
					
					$("#pqlist").html($('#quote-list-tmpl').tmpl(pqlist));
					
				}
				
				if (packagequotelist.length > 0) {
					$(".suppliesList").show();
					$("#suppliesList").html($('#quote-supplies-list-tmpl').tmpl(packagequotelist));
				}

				if (listParam.tenorsn == 6) {
					$('#showWordsPrice').html('<span>（工单金额：'+ accAdd(data.agiosum, data.banlansum) +' 元　 折让金额：'+ data.agiosum +' 元）</span>结算金额：<b class="fa_red">'+ data.banlansum +'</b> 元');
				} else {
					$('#showWordsPrice').html('项目金额：<b class="fa_red">'+ data.banlansum +'</b> 元');
				}
				
			} else {
				$("body").text("暂无数据！");
			}
			
		}
	});
}

//报价单已选项目
function getQuoteList() {
	sendRequest({
		token: true,
        action: 'clerk/receive/getQuoteList',
        data: {serviceno: listParam.serviceno},
        lock: true,
        onSuccess: function(obj) {
			if (obj.status == 'success') {
				var data = obj.data,
					itemquotelist = data.itemquotelist || [],
					packagequotelist = data.packagequotelist || [],
					onlineorderquotelist = obj.data.onlineorderquotelist || [];
					
				for (var q=0;q<onlineorderquotelist.length;q++) {
					var onlItemlist = onlineorderquotelist[q].pkgitemquotelist
					for (var j=0;j<onlItemlist.length;j++) {
						if (onlItemlist[j]) {
							itemquotelist.push(onlItemlist[j])
						}
						
					}
				}
				
				$("#packageList").html($('#quote-list-tmpl').tmpl(itemquotelist));
				$("#packageListTotal").text(data.quoteprice);
				console.log('已选报价项目列表接口')
			} else {
				Dialog.popup(obj.message);
			}
        }
    });	
}

//详情里的维修已出库厂品
function detailPjPlantoutList() {
	sendRequest({
		token: true,
        action: 'carbeauty/getPjPlantoutList',
        data: {serviceno: listParam.serviceno,
	        pageSize: 200,
			retnsign: 0,
			pdownsort: 'C002'},
        lock: true,
        onSuccess: function(obj) {
			if (obj.status == 'success') {
				var data = obj.page.items || [];
				if (data.length> 0) {
					$(".suppliesList").show();
					$("#suppliesList").html($('#supplies-list-tmpl').tmpl(data));
				}
			} else {
				Dialog.popup(obj.message);
			}
        }
    });	
}
