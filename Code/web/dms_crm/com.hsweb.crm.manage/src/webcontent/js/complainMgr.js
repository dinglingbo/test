function addComplain(){
	 nui.open({
         url: "com.hsweb.crm.manage.complainDetail.flow",
         title: "客户投诉登记",
         width: 800, 
         height: 600,
         onload: function () {
             var iframe = this.getIFrameEl();
             iframe.contentWindow.setData(null);
         },
         ondestroy: function (action) {
             
         }
     });
}