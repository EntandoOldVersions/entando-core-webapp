<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<s:set var="targetNS" value="%{'/do/jacms/Content'}" />
<h1><s:text name="jacms.menu.contentAdmin" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>
<div id="main">
<h2><s:text name="title.reload.contentReferences" /></h2>
<s:if test="contentManagerStatus == 1">
<p class="message message_error">
	<s:text name="note.reload.contentReferences.status.working" /> ( <a href="<s:url action="openIndexProspect" namespace="/do/jacms/Content/Admin" />" title="<s:text name="note.reload.contentReferences.refresh" />"><s:text name="label.refresh" /></a> )
</p>
</s:if>
<s:else>

<p class="message message_confirm">
<s:if test="contentManagerStatus == 2">
	<s:text name="note.reload.contentReferences.status.needToReload" />
</s:if>
<s:elseif test="contentManagerStatus == 0">
	<s:text name="note.reload.contentReferences.status.ready" />
</s:elseif>
	( <a href="<s:url action="reloadContentsReference" namespace="/do/jacms/Content/Admin" />"><s:text name="note.reload.contentReferences.start" /></a> )
</p>

</s:else>

<h2><s:text name="title.reload.contentIndexes" /></h2>
<s:if test="lastReloadInfo != null">
<p>
	<s:text name="note.reload.contentIndexes.lastOn.intro" />&#32;<span class="important"><s:date name="lastReloadInfo.date" format="dd/MM/yyyy HH:mm" /></span>,
	<s:if test="lastReloadInfo.result == 0">
		<s:text name="note.reload.contentIndexes.lastOn.ko" />.
	</s:if>
	<s:else>
		<s:text name="note.reload.contentIndexes.lastOn.ok" />.
	</s:else>
</p>
</s:if>

<s:if test="searcherManagerStatus == 1">
<p class="message message_error">	
	<s:text name="note.reload.contentIndexes.status.working" /> ( <a href="<s:url action="openIndexProspect" namespace="/do/jacms/Content/Admin" />" title="<s:text name="note.reload.contentIndexes.refresh" />"><s:text name="label.refresh" /></a> )
</p>
</s:if>
<s:else>

<p class="message message_confirm">
<s:if test="searcherManagerStatus == 2">
	<s:text name="note.reload.contentIndexes.status.needToReload" />
</s:if>
<s:elseif test="searcherManagerStatus == 0">
	<s:text name="note.reload.contentIndexes.status.ready" />
</s:elseif>
	( <a href="<s:url action="reloadContentsIndex" namespace="/do/jacms/Content/Admin" />"><s:text name="note.reload.contentIndexes.start" /></a> )
</p>
</s:else>
</div>
