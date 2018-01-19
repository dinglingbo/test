<%@page pageEncoding="UTF-8"%>

<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="com.primeton.bps.workspace.frame.multitenancy.DownloadHelper"%>
<html>
<head>
<title><b:message key="download_file_jsp.download"/></title>
</head>
<body>
<%
	OutputStream output = null;
    FileInputStream fis = null;
    
    String serverTypeJ2ee = "";
	try {
		serverTypeJ2ee = com.eos.system.ServerContext.getInstance().getAppServerType();
	} catch (Exception ignore) {		
	}
    
    if (serverTypeJ2ee.equalsIgnoreCase("weblogic")) {		
	    response.reset();
	}

	try{
		String dirName = request.getParameter("dirName");
		String fileName = request.getParameter("fileName");
		
		response.setContentType("application/octet-stream");
		response.setHeader("Content-disposition","attchment;filename="+DownloadHelper.TOKEN_FILE);
		
		String path = config.getServletContext().getRealPath("");
		String filePath = path + File.separator + dirName +File.separator+ fileName;
		
		File f = new File(filePath);
		fis = new FileInputStream(filePath);
		
		response.setContentLength((int)f.length());
		output = response.getOutputStream();
		
		byte[] buff = new byte[1024];
		int bytesRead;
		
		while((bytesRead = fis.read(buff))>0){
			output.write(buff,0,bytesRead);
		}
		output.flush();
	
	} catch(Exception e){
		
		e.printStackTrace();
		
	} finally{
		
		if(fis != null) fis.close();
		if(output != null) output.close();
		output = null;
		
		if (!serverTypeJ2ee.equalsIgnoreCase("weblogic")) {
			out.clear();
			out = pageContext.pushBody();
		}
	}
	

 %>

</body>
</html>