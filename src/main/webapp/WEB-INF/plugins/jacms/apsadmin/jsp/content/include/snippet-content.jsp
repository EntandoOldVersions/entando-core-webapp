<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>

<%--
<p><s:text name="note.workingOn" />: <em><s:if test="!#myNameIsJack"><a href="<s:url action="backToEntryContent" ><s:param name="contentOnSessionMarker" value="contentOnSessionMarker" /></s:url>" title="<s:text name="note.content.backToEdit" />" ></s:if><s:property value="content.descr" /><s:if test="!#myNameIsJack"></a></s:if></em> (<s:property value="content.typeDescr" />) <abbr title="<s:text name="name.version" />">v</abbr><s:property value="content.version" />&#32;<s:text name="note.lastEditor" />&#32;<wp:ifauthorized permission="superuser"><a href="<s:url action="edit" namespace="/do/User"><s:param name="username" value="content.lastEditor"/></s:url>" title="<s:text name="label.edit" />: <s:property value="content.lastEditor" />"></wp:ifauthorized><s:property value="content.lastEditor" /><wp:ifauthorized permission="superuser"></a></wp:ifauthorized>
<s:if test="content.onLine">
<br /><s:text name="note.lastApprovedIntro" />&#32;<a href="<s:url action="inspect" namespace="/do/jacms/Content" ><s:param name="contentId" value="content.id" /><s:param name="currentPublicVersion" value="'true'" /></s:url>"><s:text name="note.lastApproved" /></a>
</s:if><span class="noscreen">.</span></p>
--%>

<div class="alert alert-info">

<p>
	<s:text name="note.workingOn" />: <s:if test="!#myNameIsJack"><a href="<s:url action="backToEntryContent" ><s:param name="contentOnSessionMarker" value="contentOnSessionMarker" /></s:url>" title="<s:text name="note.content.backToEdit" />" ></s:if><s:property value="content.descrDisablingTemporarily" /><s:if test="!#myNameIsJack"></a></s:if>
	<a href="#" class="alert-link"><span class="icon icon-edit"></span>&#32;Provide a description</a>, or I will use the title as a default. (<s:property value="content.typeDescr" />) <abbr title="<s:text name="name.version" />">v</abbr><s:property value="content.version" />&#32;<s:text name="note.lastEditor" />&#32;<wp:ifauthorized permission="superuser"><a href="<s:url action="edit" namespace="/do/User"><s:param name="username" value="content.lastEditor"/></s:url>" title="<s:text name="label.edit" />: <s:property value="content.lastEditor" />"></wp:ifauthorized><s:property value="content.lastEditor" /> you<%-- TODO content.lastEditor should be == current user if this is a new content --%><wp:ifauthorized permission="superuser"></a></wp:ifauthorized>
	<s:if test="content.onLine">
	<br /><s:text name="note.lastApprovedIntro" />&#32;<a href="<s:url action="inspect" namespace="/do/jacms/Content" ><s:param name="contentId" value="content.id" /><s:param name="currentPublicVersion" value="'true'" /></s:url>"><s:text name="note.lastApproved" /></a>
	</s:if>.
</p>

<%--
<p>
	<s:text name="label.ownerGroup" />:&#32;<s:property value="content.mainGroup" />
</p>
--%>

	<div class="control-group has-warning">
		<label class="control-label" for="contentMainGroup"><s:text name="label.ownerGroup" /></label>
		<div class="controls">
			<div class="input-group">
				<select class="input-with-feedback" id="contentMainGroup">
					<option>free</option>
					<option>a different group</option>
					<option>why not this other</option>
				</select>
				<span class="input-group-btn">
					<button class="btn btn-warning" type="button">Set Group</button>
				</span>
			</div>
			<span class="help-block"><span class="icon icon-info-sign"></span>&#32;You should set the owner group right now, or I won't be able to know who can see this content.</span>
		</div>
	</div>

</div>