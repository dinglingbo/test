<html>
<head><title></title>
<script>
	var opener ;
	//global argument
	var objArgument ;
	function createIframe () {
		 var page = window.dialogArguments[0] ;
		 opener = window.dialogArguments[1] ;
		 if(window.dialogArguments[2]) {
		 	objArgument = window.dialogArguments[2] ;
		 }
		 if (page != null) {
				var ifr=document.createElement("iframe");
				ifr.name="editWin";
				ifr.id="editWin";
				ifr.frameborder="0";
				ifr.scrolling="no";
				ifr.width="100%";
				ifr.height="100%";
				ifr.marginWidth="0";
				ifr.src=page;
				document.body.appendChild(ifr);
		 }
	}
</script>	
</head>
<body bgcolor="#CDCDCD">
	<script>
		createIframe();
	</script>
</body>
</html>