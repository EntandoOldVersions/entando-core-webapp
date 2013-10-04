<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>

<%--
<p><s:text name="note.workingOn" />: <em><s:if test="!#myNameIsJack"><a href="<s:url action="backToEntryContent" ><s:param name="contentOnSessionMarker" value="contentOnSessionMarker" /></s:url>" title="<s:text name="note.content.backToEdit" />" ></s:if><s:property value="content.descr" /><s:if test="!#myNameIsJack"></a></s:if></em> (<s:property value="content.typeDescr" />) <abbr title="<s:text name="name.version" />">v</abbr><s:property value="content.version" />&#32;<s:text name="note.lastEditor" />&#32;<wp:ifauthorized permission="superuser"><a href="<s:url action="edit" namespace="/do/User"><s:param name="username" value="content.lastEditor"/></s:url>" title="<s:text name="label.edit" />: <s:property value="content.lastEditor" />"></wp:ifauthorized><s:property value="content.lastEditor" /><wp:ifauthorized permission="superuser"></a></wp:ifauthorized>
<s:if test="content.onLine">
<br /><s:text name="note.lastApprovedIntro" />&#32;<a href="<s:url action="inspect" namespace="/do/jacms/Content" ><s:param name="contentId" value="content.id" /><s:param name="currentPublicVersion" value="'true'" /></s:url>"><s:text name="note.lastApproved" /></a>
</s:if><span class="sr-only">.</span></p>
--%>
<s:set var="attributeFieldErrorsVar" value="%{fieldErrors['descr']}" />
<s:set var="attributeHasFieldErrorVar" value="#attributeFieldErrorsVar != null && !#attributeFieldErrorsVar.isEmpty()" />
<s:set var="controlGroupErrorClassVar" value="' panel-default'" />
<s:set var="inputErrorClassVar" value="''" />
<s:if test="#attributeHasFieldErrorVar">
	<s:set var="controlGroupErrorClassVar" value="' panel-danger'" />
	<s:set var="inputErrorClassVar" value="' input-with-feedback'" />
</s:if>
<div class="panel<s:property value="#controlGroupErrorClassVar" />">
	<div class="panel-body">
		<s:if test="!#myNameIsJack"><a href="<s:url action="backToEntryContent" ><s:param name="contentOnSessionMarker" value="contentOnSessionMarker" /></s:url>" title="<s:text name="note.content.backToEdit" />" ></s:if><s:property value="content.descrDisablingTemporarily" /><s:if test="!#myNameIsJack"></a></s:if>
			<span id="contentDescription-text">
				<a data-container="contentDescription-text" href="#contentDescription-input" data-swapon="contentDescription-input" class="text-warning" id="contentDescription-readonly"><span class="icon icon-edit"></span>&#32;
						<%/* FIXME: substitute the value of contentDescriptionVar with something... */%>
						<s:set var="contentDescriptionVar" value="%{descr}" />
						<s:set var="contentDescriptionVar" value="%{''}" />
						<s:property value="#contentDescriptionVar" />
						<span data-swapon-role="text"><s:if test="#contentDescriptionVar"><s:property value="#contentDescriptionVar" /></s:if><s:else>Provide a description</s:else></span></a><span class="text-warning" <s:if test="#contentDescriptionVar"> style="display: none;" </s:if> >, or I will use the title as a default.</span>
				&#32;
				(<s:property value="content.typeDescr" />) <abbr title="<s:text name="name.version" />">v</abbr><s:property value="content.version" />&#32;<s:text name="note.lastEditor" />&#32;<wp:ifauthorized permission="superuser"><a href="<s:url action="edit" namespace="/do/User"><s:param name="username" value="content.lastEditor"/></s:url>" title="<s:text name="label.edit" />: <s:property value="content.lastEditor" />"></wp:ifauthorized><s:property value="content.lastEditor" /> you<%-- TODO content.lastEditor should be == current user if this is a new content --%><wp:ifauthorized permission="superuser"></a></wp:ifauthorized>
			</span>

			<div id="contentDescription-input" style="display: none;" class="input-group has-warning">
				<input class="form-control" type="text" name="descr" value="<s:property value="#descr" />" id="contentDescription" />
				<span class="input-group-btn">
					<button class="btn btn-warning" id="contentDescription-confirm" data-swapon="contentDescription-text" data-container="contentDescription-input" value="Set Description" >Set Description</button>
				</span>
			</div>

		<s:if test="content.onLine">
		&#32;&middot;&#32;<s:text name="note.lastApprovedIntro" />&#32;<a href="<s:url action="inspect" namespace="/do/jacms/Content" ><s:param name="contentId" value="content.id" /><s:param name="currentPublicVersion" value="'true'" /></s:url>"><s:text name="note.lastApproved" /></a>
		</s:if>
		<s:if test="%{null != content.mainGroup}">&#32;&middot;&#32;Main group: <s:property value="%{getGroup(content.mainGroup).descr}" /></s:if>

	<s:if test="%{null == content.mainGroup}">
	<hr />
	<div class="form-group has-warning">
		<label class="control-label" for="contentMainGroup"><s:text name="label.ownerGroup" /></label>
		<div class="input-group">
			<s:select name="mainGroup" id="contentMainGroup" list="allowedGroups" value="%{'free'}"
				listKey="name" listValue="descr" cssClass="form-control" />
			<span class="input-group-btn">
				<s:submit action="configureMainGroup" type="button" value="Set Group" title="Set Group" cssClass="btn btn-warning" />
			</span>
		</div>
		<span class="help-block"><span class="icon icon-info-sign"></span>&#32;You should set the owner group right now, or some things will get sketchy.</span>
	</div>
	</s:if>

	</div>
</div>
