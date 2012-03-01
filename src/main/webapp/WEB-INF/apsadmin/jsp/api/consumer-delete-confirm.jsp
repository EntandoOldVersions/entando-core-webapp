<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<s:set var="targetNS" value="%{'/do/Api/Consumer'}" />
<h1><s:text name="title.apiConsumerManagement" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>
<div id="main">
	<h2><s:text name="title.apiConsumerManagement.trash" /></h2>
	<s:form action="delete">
		<p>
			<wpsf:hidden name="consumerKey" />
                        <s:set var="consumerVar" value="%{getConsumer(consumerKey)}" />
                        <s:text name="note.api.consumer.trash" />&#32;<em class="important"><s:property value="#consumerVar.description" /> (<s:property value="consumerKey" />)</em> **AND ITS TOKENS**?
			<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.remove')}" cssClass="button" />
		</p>

		<p><s:text name="note.api.consumer.trash.goBack" />&#32;<a href="<s:url action="list" namespace="/do/Api/Consumer" />" ><s:text name="menu.apisAdmin.consumers" /></a></p>

	</s:form>
</div>