<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>

<p><s:text name="note.workingOn" />: <em><s:if test="!#myNameIsJack"><a href="<s:url action="backToEntryContent" />" title="<s:text name="note.content.backToEdit" />" ></s:if><s:property value="content.descr" /><s:if test="!#myNameIsJack"></a></s:if></em> (<s:property value="content.typeDescr" />) <abbr title="<s:text name="name.version" />">v</abbr><s:property value="content.version" />&#32;<s:text name="note.lastEditor" />&#32;<wp:ifauthorized permission="superuser"><a href="<s:url action="edit" namespace="/do/User"><s:param name="username" value="content.lastEditor"/></s:url>" title="<s:text name="label.edit" />: <s:property value="content.lastEditor" />"></wp:ifauthorized><s:property value="content.lastEditor" /><wp:ifauthorized permission="superuser"></a></wp:ifauthorized>
<s:if test="content.onLine">
<br /><s:text name="note.lastApprovedIntro" />&#32;<a href="<s:url action="inspect" namespace="/do/jacms/Content" ><s:param name="contentId" value="content.id" /><s:param name="currentPublicVersion" value="'true'" /></s:url>"><s:text name="note.lastApproved" /></a>
</s:if><span class="noscreen">.</span></p>
