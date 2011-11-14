<%@ page isErrorPage="true" %>
<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%
    Object statusCode = request.getAttribute("javax.servlet.error.status_code"); 
    Object exceptionType = request.getAttribute("javax.servlet.error.exception_type"); 
    Object message = request.getAttribute("javax.servlet.error.message"); 
%>
<wp:contentNegotiation mimeType="application/xhtml+xml" charset="utf-8"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it">
<head>
	<title>Entando - Error</title>
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/css/administration.css" />
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/css/layout.css" />
	<!--[if lte IE 6]>
		<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/css/layout_ie6.css" />
	<![endif]-->
</head>
<body>

<h1>Entando - Error</h1>
<p><a href="<%=response.encodeURL(request.getContextPath()) %>">Home</a></p>
<div class="message message_error">
<table border="1" width="100%" summary="Stack Trace">
<tr>
	<th scope="row">Status Code</th> 
	<td><%= statusCode %></td>
</tr>
<tr>
	<th scope="row">Exception Type</th> 
	<td><%= exceptionType %></td>
</tr>
<tr>
	<th scope="row">Message</th> 
	<td><%= message %></td>
</tr>
<tr>
	<th scope="row">Exception</th> 
	<td>
	    <%
		if( exception != null )
		{
		    out.print("<pre>");
		    exception.printStackTrace(new PrintWriter(out));
		    out.print("</pre>");
		}    
	    %>
	</td>
</tr>
<tr>
	<th scope="row">Root Cause</th> 
	<td>
	    <%
		if( (exception != null) && (exception instanceof ServletException) )
		{
		    Throwable cause = ((ServletException)exception).getRootCause();
		    if( cause != null )
		    {
			out.print("<pre>");
			cause.printStackTrace(new PrintWriter(out));
			out.print("</pre>");
		    }
		}            
	    %>
	</td>
</tr>
</table>
</div>

<h2>Header List</h2>
<div class="message message_error">
<table border="1" width="100%">
<tr>
 <th>Name</th>
 <th>Value</th>
</tr>
<%
String name  = "";
String value = "";

java.util.Enumeration headers = request.getHeaderNames();
while(headers.hasMoreElements())
{
 name  = (String) headers.nextElement();
 value = request.getHeader(name);
%>
<tr>
 <td><%=name%></td>
 <td><%=value%></td>
</tr>
<%
}
%>
</table>
</div>

<h2>Attribute List</h2>
<!-- "javax.servlet.jsp.jspException" for getting an Exception -->
<div class="message message_error">
<table border="1" width="100%">
<tr>
 <th>Name</th>
 <th>Value</th>
</tr>
<%
java.util.Enumeration attributes = request.getAttributeNames();
while(attributes.hasMoreElements())
{
 name  = (String) attributes.nextElement();

 if (request.getAttribute(name) == null)
 {
  value = "null";
 }
 else
 {
  value = request.getAttribute(name).toString();
 }
%>
<tr>
 <td><%=name%></td>
 <td><%=value%></td>
</tr>
<%
}
%>
</table>
</div>

</body>
</html>