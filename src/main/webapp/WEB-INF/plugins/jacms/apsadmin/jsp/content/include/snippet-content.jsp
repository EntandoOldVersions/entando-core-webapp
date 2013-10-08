<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<s:set var="contentDescriptionVar" value="%{content.descr}" />
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
		<s:if test="!#myNameIsJack">
			<a href="<s:url action="backToEntryContent" ><s:param name="contentOnSessionMarker" value="contentOnSessionMarker" /></s:url>" title="<s:text name="note.content.backToEdit" />" >
		</s:if>
			<s:property value="content.descrDisablingTemporarily" />
		<s:if test="!#myNameIsJack">
			</a>
		</s:if>
			<span id="contentDescription-text">
				<a data-container="contentDescription-text" href="#contentDescription-input" data-swapon="contentDescription-input" data-swapon-fade="true" class="text-warning" id="contentDescription-readonly">
					<span class="icon icon-edit"></span>&#32;
					<span data-swapon-role="text">
						<s:if test="#contentDescriptionVar!=null"><s:property value="#contentDescriptionVar" /></s:if>
						<s:else><s:text name="note.provide.description" /></s:else>
					</span>
				</a>
				<span class="text-warning" <s:if test="#contentDescriptionVar!=null"> style="display: none;" </s:if>>,&#32;<s:text name="note.provide.description.usedefault" />.</span>
				&#32;
			</span>
			<span id="contentDescription-input" style="display: none;" class="input-group has-warning margin-small-bottom">
				<input class="form-control" type="text" name="descr" value="<s:property value="#descr" />" id="contentDescription" />
				<span class="input-group-btn">
					<button class="btn btn-warning" id="contentDescription-confirm" data-swapon="contentDescription-text" data-swapon-fade="true" data-container="contentDescription-input" value="Set Description" ><s:text name="label.setDescription" /></button>
				</span>
			</span>
				(<s:property value="content.typeDescr" />)&#32;&middot;&#32;
				<abbr title="<s:text name="name.version" />">v</abbr><s:property value="content.version" />&#32;
				<s:text name="note.lastEditor" />&#32;
				<s:set var="lastEditorVar" value="content.lastEditor" scope="page" />
				<wp:ifauthorized permission="superuser" var="authorizedSuperUserVar" />
				<c:if test="${!empty lastEditorVar && authorizedSuperUserVar}"><a href="<s:url action="edit" namespace="/do/User"><s:param name="username" value="content.lastEditor"/></s:url>" title="<s:text name="label.edit" />: <s:property value="content.lastEditor" />"></c:if>
				<c:choose>
					<c:when test="${empty lastEditorVar || (lastEditorVar eq sessionScope.currentUser)}"><s:property value="content.lastEditor" /> <span class="text-muted">(<s:text name="label.you" />)</span></c:when>
					<c:otherwise><s:property value="content.lastEditor" /></c:otherwise>
				</c:choose>
				<c:if test="${!empty lastEditorVar && authorizedSuperUserVar}"></a></c:if>

		<s:if test="content.onLine">
		&#32;&middot;&#32;<s:text name="note.lastApprovedIntro" />&#32;<a href="<s:url action="inspect" namespace="/do/jacms/Content" ><s:param name="contentId" value="content.id" /><s:param name="currentPublicVersion" value="'true'" /></s:url>"><s:text name="note.lastApproved" /></a>
		</s:if>
		<s:if test="%{null != content.mainGroup}">&#32;&middot;&#32;<s:text name="label.mainGroup" />: <s:property value="%{getGroup(content.mainGroup).descr}" /></s:if>

		<s:if test="%{null == content.mainGroup}">
			<hr />
			<div class="form-group has-warning">
				<label class="control-label" for="contentMainGroup"><s:text name="label.ownerGroup" /></label>
				<div class="input-group">
					<s:select name="mainGroup" id="contentMainGroup" list="allowedGroups" value="%{'free'}"
						listKey="name" listValue="descr" cssClass="form-control" />
					<span class="input-group-btn">
						<s:submit
							action="configureMainGroup"
							type="button"
							title="Set Group"
							cssClass="btn btn-warning">
								<s:text name="label.setGroup" />
						</s:submit>
					</span>
				</div>
				<span class="help-block"><span class="icon icon-info-sign"></span>&#32;<s:text name="note.set.MainGroup" />.</span>
			</div>
		</s:if>

	</div>
</div>
