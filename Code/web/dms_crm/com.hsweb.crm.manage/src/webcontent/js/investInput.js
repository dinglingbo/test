function onAddClick(){
	nui.open({
		url: "com.hsweb.crm.manage.investDetail.flow",
		title: "业绩新增",
		allowResize:false,
		width: 300, 
		height: 400,
		onload: function () {
			var iframe = this.getIFrameEl();
        	iframe.contentWindow.setData(null);
         },
         ondestroy: function (action) {
             
         }
	});
}

function onEditClick(){
	var data=null;
	nui.open({
		url: "com.hsweb.crm.manage.investDetail.flow",
		title: "业绩修改",
		allowResize:false,
		width: 300, 
		height: 400,
		onload: function () {
			var iframe = this.getIFrameEl();
        	iframe.contentWindow.setData(data);
         },
         ondestroy: function (action) {
             
         }
	});
}