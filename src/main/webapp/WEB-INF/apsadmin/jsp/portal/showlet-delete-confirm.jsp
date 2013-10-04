<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1><s:text name="title.showletManagement" /></h1>
<div id="main">

<h2><s:text name="title.showletManagement.type.delete" /></h2>

<s:form namespace="/do/Portal/ShowletType" action="delete">
<p class="sr-only">
	<wpsf:hidden name="showletTypeCode" />
</p>

<p><s:text name="note.deleteType.areYouSure" />&#32;<em class="important"><s:property value="showletTypeCode" /></em>? <wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.remove')}" cssClass="button" /></p>
</s:form>
</div>
