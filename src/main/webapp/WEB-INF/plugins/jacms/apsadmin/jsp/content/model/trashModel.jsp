<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" namespace="/do/jacms/ContentModel" />">
		<s:text name="title.generalSettings.contentModels" /></a>
		&#32;/&#32;
		<s:text name="title.generalSettings.contentModels.remove" />
	</span>
</h1>

<div id="main">

<s:form>
	<p class="sr-only">	
		<wpsf:hidden name="modelId"/>
	</p>
<p><s:text name="note.deleteContentModel.areYouSure" />&#32;<em class="important"><span class="monospace"><s:property value="modelId" /></span> &ndash; <s:property value="description" /> (<s:property value="%{getSmallContentType(getContentModel(modelId).contentType).descr}" />)</em>? <wpsf:submit useTabindexAutoIncrement="true" action="delete" value="%{getText('label.remove')}" cssClass="button" /></p>
</s:form>
</div>