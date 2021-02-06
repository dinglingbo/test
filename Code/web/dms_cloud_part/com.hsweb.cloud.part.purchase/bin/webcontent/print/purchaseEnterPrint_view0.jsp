<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="org.eclipse.jdt.internal.compiler.ast.TryStatement"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="net.sf.jasperreports.engine.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page
      import="java.io.*,
              net.sf.jasperreports.engine.*,
              net.sf.jasperreports.engine.util.*,
              java.util.*,java.sql.*,
              net.sf.jasperreports.engine.export.*"%>
<HTML> 
<%
	//System.out.println("java version: " + System.getProperty("java.version"));
	//String fileAddr = request.getSession().getServletContext().getRealPath("") +"/iReport/采购订单打印.jasper";
	//Object i = request.getParameter("ID");
	//System.out.println(i);
	String fileAddr = request.getSession().getServletContext().getRealPath("") +"/purchase/iReport/purchaseEnterReport.jasper";
	//System.out.println("fileAddr=" + fileAddr);
	File reportFile = new File(fileAddr);//"c:/采购订单打印.jasper"
try {
	if (reportFile.isFile()) {
		Class.forName("com.mysql.jdbc.Driver");
		/*String url = "jdbc:mysql://14.23.35.20:6289/dms_cloud_part?useSSL=false";
		String user = "root";
		String password = "000000";*/
		String url = "jdbc:mysql://10.168.2.110:3306/dms_cloud_part?useSSL=false";
		String user = "root";
		String password = "hsqc@.198";
		Connection conn = DriverManager.getConnection(url, user,
				password);

		Map<String, Object> rptParameters = new HashMap<String, Object>();
		rptParameters.put("ID", Integer.parseInt(request.getParameter("ID")));

	    byte[] bytes=JasperRunManager.runReportToPdf(reportFile.getPath(), rptParameters, conn);
		
		response.setContentType("application/pdf");  
		response.setContentLength(bytes.length);  
		ServletOutputStream outStream = response.getOutputStream();  
		outStream.write(bytes,0,bytes.length);  
		
		outStream.flush();  
		outStream.close();  
		out.clear();  
		out = pageContext.pushBody();
		
		
		//System.out.println("SUCCESS");
	} else {
		System.out.println("not file");
	}
	} catch (Exception e) {
		System.out.println(e.getMessage());
		e.printStackTrace();
	}
	
	//response.sendRedirect("iReport/pchsOrder.html");
%>


<script language= "javascript/text">
	alert(1);
</script>
</HTML>
