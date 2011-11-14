<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<s:set var="targetNS" value="%{'/do/jacms/ContentModel'}" />
<h1><s:text name="title.generalSettings.contentModels" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>
<div id="main">

<h2><s:text name="title.generalSettings.contentModels.remove" /></h2>

<s:form>
	<p class="noscreen">	
		<wpsf:hidden name="modelId"/>
	</p>
<p><s:text name="note.deleteContentModel.areYouSure" />&#32;<em class="important"><span class="monospace"><s:property value="modelId" /></span> &ndash; <s:property value="description" /> (<s:property value="%{getSmallContentType(getContentModel(modelId).contentType).descr}" />)</em>? <wpsf:submit useTabindexAutoIncrement="true" action="delete" value="%{getText('label.remove')}" cssClass="button" /></p>
</s:form>
</div>