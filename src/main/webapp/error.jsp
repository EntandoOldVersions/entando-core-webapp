<%@ page isErrorPage="true" %>
<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
		Object statusCode = request.getAttribute("javax.servlet.error.status_code");
		Object exceptionType = request.getAttribute("javax.servlet.error.exception_type");
		Object message = request.getAttribute("javax.servlet.error.message");
%>
<wp:contentNegotiation mimeType="text/html" charset="utf-8"/>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Entando - Error</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta charset="utf-8" />
		<link rel="stylesheet" href="<wp:resourceURL />administration/bootstrap/css/bootstrap.min.css" media="screen" />
	</head>
	<body>
		<div class="container">
			<h1>Entando - Error</h1>
			<p><a class="" href="<%=response.encodeURL(request.getContextPath()) %>">Go to Home</a></p>
			<table class="table table-responsive table-striped">
				<tr>
					<th scope="row">Status Code</th>
					<td><code><%= statusCode %></code></td>
				</tr>
				<wp:ifauthorized permission="superuser">
					<tr>
						<th scope="row">Exception Type</th>
						<td><code><%= exceptionType %></code></td>
					</tr>
					<tr>
						<th scope="row">Message</th>
						<td><code><%= message %></code></td>
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
									if( (exception != null) && (exception instanceof ServletException) ) {
											Throwable cause = ((ServletException)exception).getRootCause();
											if( cause != null ) {
												out.print("<pre>");
												cause.printStackTrace(new PrintWriter(out));
												out.print("</pre>");
											}
									}
								%>
						</td>
					</tr>
				</wp:ifauthorized>
			</table>
			<wp:ifauthorized permission="superuser">
				<h2 class="margin-large-top">Header List</h2>
				<table class="table table-responsive table-striped">
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
						 pageContext.setAttribute("name", name);
						 pageContext.setAttribute("value", value);
					%>
							<tr>
							 <td><c:out value="${name}" /></td>
							 <td>
							 	<c:choose>
							 		<c:when test="${name=='Cookie'}">
							 			<pre style="max-width: 100%;"><c:out value="${value}" /></pre>
							 		</c:when>
							 		<c:otherwise>
							 			<code><c:out value="${value}" /></code>
							 		</c:otherwise>
							 	</c:choose>
							 	</td>
							</tr>
					<%
						}
					%>
				</table>
				<h2 class="margin-large-top">Attribute List</h2>
				<%-- "javax.servlet.jsp.jspException" for getting an Exception --%>
				<table class="table table-responsive table-striped">
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
						 <td><code><%=value%></code></td>
						</tr>
					<%
						}
					%>
				</table>
			</wp:ifauthorized>
		</div>
	</body>
</html>