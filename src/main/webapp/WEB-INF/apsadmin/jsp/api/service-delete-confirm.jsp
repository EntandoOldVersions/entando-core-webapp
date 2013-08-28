<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1 class="panel panel-default title-page"><span class="panel-body display-block"><s:text name="title.apiServiceManagement" /></span></h1>

<div id="main">
	<h2><s:text name="title.api.apiService.trash" /></h2>
	<s:form action="delete">
		<p class="sr-only"><wpsf:hidden name="serviceKey" /></p>
		
		<p>
			<s:text name="note.api.apiService.trash" />&#32;<em class="important"><s:property value="serviceKey" /></em>?
			<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.remove')}" cssClass="button" />
		</p>
		
		<p><s:text name="note.api.apiService.trash.goBack" />&#32;<a href="<s:url action="list" namespace="/do/Api/Service" />" ><s:text name="menu.apisAdmin.services" /></a></p>		
		
	</s:form>
</div>