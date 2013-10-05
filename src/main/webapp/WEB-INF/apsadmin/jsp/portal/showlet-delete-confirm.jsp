<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1><s:text name="title.widgetManagement" /></h1>
<div id="main">

<h2><s:text name="title.widgetManagement.type.delete" /></h2>

<s:form namespace="/do/Portal/WidgetType" action="delete">
<p class="noscreen">
	<wpsf:hidden name="widgetTypeCode" />
</p>

<p><s:text name="note.deleteType.areYouSure" />&#32;<em class="important"><s:property value="widgetTypeCode" /></em>? <wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.remove')}" cssClass="button" /></p>
</s:form>
</div>
