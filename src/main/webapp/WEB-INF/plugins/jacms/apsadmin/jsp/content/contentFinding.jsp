<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%-- radios only --%>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set var="targetNS" value="%{'/do/jacms/Content'}" />
<h1 class="panel title-page"><span class="panel-body display-block"><s:text name="jacms.menu.contentAdmin" />&#32;/&#32;<s:text name="title.contentList" /></span></h1>

<div id="main">

		<s:url action="search" var= "formAction" namespace="do/jacms/Content" />
		<s:form action="%{'/' + #formAction}" cssClass="form-horizontal">

			<p class="sr-only">
				<input type="hidden" name="lastGroupBy" />
				<input type="hidden" name="lastOrder" />
			</p>

			<div class="form-group">

				<label for="text" class="sr-only"><s:text name="label.search.by"/>&#32;<s:text name="label.description"/></label>
				<div class="input-group col-sm-12">
					<span class="input-group-addon">
						<span class="icon icon-file-text-alt icon-large"></span>
					</span>
					<s:textfield name="text" id="text" cssClass="form-control input-lg" placeholder="Content about the topic which TODO label" title="%{getText('label.search.by')} %{getText('label.description')}" />
					<div class="input-group-btn">
						<wpsa:actionParam action="search" var="searchActionName" >
							<wpsa:actionSubParam name="actionCode" value="search" />
						</wpsa:actionParam>
						<s:submit action="%{#searchActionName}" type="button" cssClass="btn btn-primary btn-lg">
							<span class="icon icon-search" title="<s:text name="label.search" />"></span>
						</s:submit>
					</div>
				</div>
				<p class="help-block text-right">
					<button type="button" data-toggle="collapse" data-target="#search-advanced"  class="btn btn-link">
						<s:text name="title.searchFilters" />&#32;<span class="icon-chevron-down"></span>
					</button>
				</p>
			</div>

			<div id="search-advanced" class="collapse in">

				<div class="form-group">
					<label for="contentType" class="form-label col-sm-2 text-right">
						<s:text name="label.type"/>
					</label>
					<div class="col-sm-5 input-group">
						<s:select cssClass="form-control" name="contentType" id="contentType"
							list="contentTypes" listKey="code" listValue="descr"
							headerKey="" headerValue="%{getText('label.all')}" />
						<div class="input-group-btn">
							<wpsa:actionParam action="changeContentType" var="changeContentTypeActionName" >
								<wpsa:actionSubParam name="actionCode" value="changeContentType" />
							</wpsa:actionParam>
							<s:submit action="%{#changeContentTypeActionName}" cssClass="btn btn-default" value="%{getText('label.set')}" />
						</div>
					</div>
				</div>

				<s:set var="searcheableAttributes" value="searcheableAttributes" ></s:set>

				<s:if test="null != #searcheableAttributes && #searcheableAttributes.size() > 0">

					<div class="alert alert-info alert-dismissable fade in">
						<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
						<p>Content type successfully set. TODO label.</p>
					</div>

					<s:iterator var="attribute" value="#searcheableAttributes">
						<s:set var="currentFieldId">entityFinding_<s:property value="#attribute.name" /></s:set>

						<s:if test="#attribute.textAttribute">
							<div class="form-group">
								<s:set name="textInputFieldName"><s:property value="#attribute.name" />_textFieldName</s:set>
								<label for="<s:property value="currentFieldId" />" class="form-label col-sm-2 text-right"><s:property value="#attribute.name" /></label>
								<div class="col-sm-5">
									<s:textfield id="%{currentFieldId}" name="%{#textInputFieldName}" value="%{getSearchFormFieldValue(#textInputFieldName)}" cssClass="form-control" />
								</div>
							</div>
						</s:if>

						<s:elseif test="#attribute.type == 'Date'">
							<pre>https://github.com/eternicode/bootstrap-datepicker - needs patches: see issues</pre>
							<s:set name="dateStartInputFieldName" ><s:property value="#attribute.name" />_dateStartFieldName</s:set>
							<s:set name="dateEndInputFieldName" ><s:property value="#attribute.name" />_dateEndFieldName</s:set>
							<p>
								<label for="<s:property value="%{currentFieldId}" />_dateStartFieldName_cal"><s:text name="note.range.from.attribute" />&#32;<s:property value="#attribute.name" />:</label>
								<s:textfield id="%{currentFieldId}_dateStartFieldName_cal" name="%{#dateStartInputFieldName}" value="%{getSearchFormFieldValue(#dateStartInputFieldName)}" /><span class="inlineNote">dd/MM/yyyy</span>
							</p>
							<p>
								<label for="<s:property value="%{currentFieldId}" />_dateEndFieldName_cal"><s:text name="note.range.to.attribute" />&#32;<s:property value="#attribute.name" />:</label>
								<s:textfield id="%{currentFieldId}_dateEndFieldName_cal" name="%{#dateEndInputFieldName}" value="%{getSearchFormFieldValue(#dateEndInputFieldName)}" /><span class="inlineNote">dd/MM/yyyy</span>
							</p>
						</s:elseif>

						<s:elseif test="#attribute.type == 'Number'">
							<s:set name="numberStartInputFieldName" ><s:property value="#attribute.name" />_numberStartFieldName</s:set>
							<s:set name="numberEndInputFieldName" ><s:property value="#attribute.name" />_numberEndFieldName</s:set>
							<p>
								<label for="<s:property value="currentFieldId" />_start"><s:text name="note.range.from.attribute" />&#32;<s:property value="#attribute.name" />:</label>
								<s:textfield id="%{currentFieldId}_start" name="%{#numberStartInputFieldName}" value="%{getSearchFormFieldValue(#numberStartInputFieldName)}" />
							</p>
							<p>
								<label for="<s:property value="currentFieldId" />_end"><s:text name="note.range.to.attribute" />&#32;<s:property value="#attribute.name" />:</label>
								<s:textfield id="%{currentFieldId}_end" name="%{#numberEndInputFieldName}" value="%{getSearchFormFieldValue(#numberEndInputFieldName)}" />
							</p>
						</s:elseif>

						<s:elseif test="#attribute.type == 'Boolean' || #attribute.type == 'ThreeState'">
							<p>
								<span class="important"><s:property value="#attribute.name" /></span><br />
							</p>
							<s:set name="booleanInputFieldName" ><s:property value="#attribute.name" />_booleanFieldName</s:set>
							<s:set name="booleanInputFieldValue" ><s:property value="%{getSearchFormFieldValue(#booleanInputFieldName)}" /></s:set>
							<ul class="noBullet radiocheck">
								<li><wpsf:radio id="none_%{#booleanInputFieldName}" name="%{#booleanInputFieldName}" value="" checked="%{!#booleanInputFieldValue.equals('true') && !#booleanInputFieldValue.equals('false')}" /><label for="none_<s:property value="#booleanInputFieldName" />" class="normal" ><s:text name="label.bothYesAndNo"/></label></li>
								<li><wpsf:radio id="true_%{#booleanInputFieldName}" name="%{#booleanInputFieldName}" value="true" checked="%{#booleanInputFieldValue == 'true'}" /><label for="true_<s:property value="#booleanInputFieldName" />" class="normal" ><s:text name="label.yes"/></label></li>
								<li><wpsf:radio id="false_%{#booleanInputFieldName}" name="%{#booleanInputFieldName}" value="false" checked="%{#booleanInputFieldValue == 'false'}" /><label for="false_<s:property value="#booleanInputFieldName" />" class="normal"><s:text name="label.no"/></label></li>
							</ul>
						</s:elseif>

					</s:iterator>

				</s:if>


			</div><!--// search-advanced -->

<%--

<div class="subsection-light">
<p class="important">
	<s:text name="label.category" />:<br />
</p>

<!-- INIZIO CATEGORIE -->
<s:action name="showCategoryTreeOnContentFinding" namespace="/do/jacms/Content" executeResult="true"></s:action>
<!-- FINE CATEGORIE -->

</div>

<div class="subsection-light">
<p><label for="contentIdToken"><s:text name="label.code"/>:</label>
<s:textfield name="contentIdToken" id="contentIdToken" /></p>

<s:set var="allowedGroupsVar" value="allowedGroups"></s:set>
<s:if test="null != #allowedGroupsVar && #allowedGroupsVar.size()>1">
<p>
	<label for="ownerGroupName"><s:text name="label.group" />:</label>
	<s:select name="ownerGroupName" id="ownerGroupName" list="#allowedGroupsVar" headerKey="" headerValue="%{getText('label.all')}" listKey="name" listValue="descr" />
</p>
</s:if>

<p>
	<label for="state"><s:text name="label.state"/>:</label>
	<s:select name="state" id="state" list="avalaibleStatus" headerKey="" headerValue="%{getText('label.all')}" listKey="key" listValue="%{getText(value)}" />
</p>
<p>
	<input type="radio" class="radiocheck" name="onLineState" id="approved" <s:if test="('yes' == onLineState)">checked="checked"</s:if> value="yes" /><label for="approved"><s:text name="name.isApprovedContent"/></label>&#32;<input type="radio" name="onLineState" id="notApproved" <s:if test="('no' == onLineState)">checked="checked"</s:if> value="no" /><label for="notApproved"><s:text name="name.isNotApprovedContent"/></label>&#32;<input type="radio" name="onLineState" id="bothApproved" <s:if test="('yes' != onLineState) && ('no' != onLineState)">checked="checked"</s:if> value="" /><label for="bothApproved"><s:text name="name.isApprovedOrNotContent" /></label>
</p>
</div>

</div>
</fieldset>

<fieldset><legend class="accordion_toggler"><s:text name="title.searchResultOptions" /></legend>
<div class="accordion_element">
<ul class="radiocheck noBullet">
	<li><s:checkbox name="viewCode" id="viewCode"></s:checkbox><label for="viewCode"><s:text name="label.code"/></label></li>
	<li><s:checkbox name="viewTypeDescr" id="viewTypeDescr"></s:checkbox><label for="viewTypeDescr"><s:text name="name.contentType"/></label></li>
	<li><s:checkbox name="viewStatus" id="viewStatus"></s:checkbox><label for="viewStatus"><s:text name="name.contentStatus"/></label></li>
	<li><s:checkbox name="viewGroup" id="viewGroup"></s:checkbox><label for="viewGroup"><s:text name="label.group"/></label></li>
	<li><s:checkbox name="viewCreationDate" id="viewCreationDate"></s:checkbox><label for="viewCreationDate"><s:text name="label.creationDate"/></label></li>
</ul>
</div>
</fieldset>

--%>

		</s:form>

		<hr />

		<s:form action="search" >
		<p class="sr-only">
			<s:hidden name="text" />
			<s:hidden name="contentType" />
			<s:hidden name="state" />
			<s:hidden name="onLineState" />
			<s:hidden name="categoryCode" />
			<s:hidden name="viewTypeDescr" />
			<s:hidden name="viewGroup" />
			<s:hidden name="viewCode" />
			<s:hidden name="viewStatus" />
			<s:hidden name="viewCreationDate" />
			<s:hidden name="lastGroupBy" />
			<s:hidden name="lastOrder" />
			<s:hidden name="contentIdToken" />
			<s:hidden name="ownerGroupName" />
			<s:iterator var="attribute" value="#searcheableAttributes">
				<s:if test="#attribute.textAttribute">
					<s:set name="textInputFieldName" ><s:property value="#attribute.name" />_textFieldName</s:set>
					<s:hidden name="%{#textInputFieldName}" value="%{getSearchFormFieldValue(#textInputFieldName)}" />
				</s:if>
				<s:elseif test="#attribute.type == 'Date'">
					<s:set name="dateStartInputFieldName" ><s:property value="#attribute.name" />_dateStartFieldName</s:set>
					<s:set name="dateEndInputFieldName" ><s:property value="#attribute.name" />_dateEndFieldName</s:set>
					<s:hidden name="%{#dateStartInputFieldName}" value="%{getSearchFormFieldValue(#dateStartInputFieldName)}" />
					<s:hidden name="%{#dateEndInputFieldName}" value="%{getSearchFormFieldValue(#dateEndInputFieldName)}" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'Number'">
					<s:set name="numberStartInputFieldName" ><s:property value="#attribute.name" />_numberStartFieldName</s:set>
					<s:set name="numberEndInputFieldName" ><s:property value="#attribute.name" />_numberEndFieldName</s:set>
					<s:hidden name="%{#numberStartInputFieldName}" value="%{getSearchFormFieldValue(#numberStartInputFieldName)}" />
					<s:hidden name="%{#numberEndInputFieldName}" value="%{getSearchFormFieldValue(#numberEndInputFieldName)}" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'Boolean' || #attribute.type == 'ThreeState'">
					<s:set name="booleanInputFieldName" ><s:property value="#attribute.name" />_booleanFieldName</s:set>
					<s:hidden name="%{#booleanInputFieldName}" value="%{getSearchFormFieldValue(#booleanInputFieldName)}" />
				</s:elseif>
			</s:iterator>
		</p>

		<s:if test="hasActionErrors()">
		<div class="message message_error">
		<h2><s:text name="message.title.ActionErrors" /></h2>
			<ul>
			<s:iterator value="ActionErrors">
				<li><s:property escape="false" /></li>
			</s:iterator>
			</ul>
		</div>
		</s:if>
		<s:if test="hasActionMessages()">
		<div class="message message_confirm">
		<h2><s:text name="messages.confirm" /></h2>
		<ul>
			<s:iterator value="actionMessages">
				<li><s:property escape="false" /></li>
			</s:iterator>
		</ul>
		</div>
		</s:if>

		<s:set var="contentIdsVar" value="contents" />

		<wpsa:subset source="#contentIdsVar" count="10" objectName="groupContent" advanced="true" offset="5">
		<s:set name="group" value="#groupContent" />

		<div class="pager">
			<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
			<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
		</div>

		<s:if test="%{#contentIdsVar.size() > 0}">

			<table class="generic" id="contentListTable" summary="<s:text name="note.content.contentList.summary" />">
			<caption><span><s:text name="title.contentList" />&nbsp;<a title="<s:text name="note.goToSomewhere" />: <s:text name="title.searchFilters" />" href="#content_list-changeContentType" name="content_list-search" id="content_list-search" class="noborder"><img src="<wp:resourceURL />administration/common/img/icons/16x16/go-up.png" width="16" height="16" alt=" " /></a></span></caption>
			<tr>
				<th class="icon_double"><abbr title="<s:text name="label.actions" />">&ndash;</abbr></th>
				<th>
				<a href="<s:url action="changeOrder" anchor="content_list_intro" includeParams="all" >
					<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
					<s:param name="lastOrder"><s:property value="lastOrder" /></s:param>
					<s:param name="groupBy">descr</s:param>
					</s:url>"><s:text name="label.description" /></a>
				</th>
			<s:if test="viewCode">
				<th>
				<a href="<s:url action="changeOrder" anchor="content_list_intro" includeParams="all" >
					<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
					<s:param name="lastOrder"><s:property value="lastOrder" /></s:param>
					<s:param name="groupBy">code</s:param>
					</s:url>"><s:text name="label.code" /></a>
				</th>
			</s:if>
				<s:if test="viewTypeDescr"><th><s:text name="label.type" /></th></s:if>
				<s:if test="viewStatus"><th><s:text name="label.state" /></th></s:if>
				<s:if test="viewGroup"><th><s:text name="label.group" /></th></s:if>
			<s:if test="viewCreationDate">
				<th>
				<a href="<s:url action="changeOrder" anchor="content_list_intro" includeParams="all" >
					<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
					<s:param name="lastOrder"><s:property value="lastOrder" /></s:param>
					<s:param name="groupBy">created</s:param>
					</s:url>"><s:text name="label.creationDate" /></a>
				</th>
			</s:if>
				<th>
				<a href="<s:url action="changeOrder" anchor="content_list_intro" includeParams="all" >
					<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
					<s:param name="lastOrder"><s:property value="lastOrder" /></s:param>
					<s:param name="groupBy">lastModified</s:param>
					</s:url>"><s:text name="label.lastEdit" /></a>
				</th>
				<th class="icon"><abbr title="<s:text name="name.onLine" />">P</abbr></th>
			</tr>
			<s:iterator var="contentId">
			<s:set name="content" value="%{getContentVo(#contentId)}"></s:set>
			<tr>
			<td class="icon_double">
			<a title="<s:text name="label.edit" />: <s:property value="#content.id" /> - <s:property value="#content.descr" />" href="<s:url action="edit" namespace="/do/jacms/Content"><s:param name="contentId" value="#content.id" /></s:url>"><img src="<wp:resourceURL/>administration/common/img/icons/edit-content.png" alt="<s:text name="label.edit" />: <s:property value="#content.id" /> - <s:property value="#content.descr" />" /></a>
			<a title="<s:text name="label.copyPaste" />: <s:property value="#content.id" /> - <s:property value="#content.descr" />" href="<s:url action="copyPaste" namespace="/do/jacms/Content"><s:param name="contentId" value="#content.id" /><s:param name="copyPublicVersion" value="'false'" /></s:url>"><img src="<wp:resourceURL/>administration/common/img/icons/edit-copy.png" alt="<s:text name="label.copyPaste" />: <s:property value="#content.id" /> - <s:property value="#content.descr" />" /></a>
			<a title="<s:text name="label.inspect" />: [<s:text name="name.work" />] <s:property value="#content.id" /> - <s:property value="#content.descr" />" href="<s:url action="inspect" namespace="/do/jacms/Content"><s:param name="contentId" value="#content.id" /><s:param name="currentPublicVersion" value="'false'" /></s:url>"><img src="<wp:resourceURL/>administration/common/img/icons/22x22/content-inspect-work.png" alt="<s:text name="label.inspect" />: <s:property value="#content.id" /> - <s:property value="#content.descr" />" /></a>
		<s:if test="#content.onLine">
			<a title="<s:text name="label.inspect" />: [<s:text name="name.onLine" />] <s:property value="#content.id" /> - <s:property value="#content.descr" />" href="<s:url action="inspect" namespace="/do/jacms/Content"><s:param name="contentId" value="#content.id" /><s:param name="currentPublicVersion" value="'true'" /></s:url>"><img src="<wp:resourceURL/>administration/common/img/icons/22x22/content-inspect-online.png" alt="<s:text name="label.inspect" />: <s:property value="#content.id" /> - <s:property value="#content.descr" />" /></a>
		</s:if>
			<wpsa:hookPoint key="jacms.contentFinding.contentRow.actions" objectName="hookpoint_contentFinding_contentRow">
			<s:iterator value="#hookpoint_contentFinding_contentRow" var="hookPointElement">
				<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
			</s:iterator>
			</wpsa:hookPoint>
			</td>
			<td><input type="checkbox" name="contentIds" id="content_<s:property value="#content.id" />" value="<s:property value="#content.id" />" /><label for="content_<s:property value="#content.id" />"><s:property value="#content.descr" /></label></td>
			<s:if test="viewCode"><td><span class="monospace"><s:property value="#content.id" /></span></td></s:if>
			<s:if test="viewTypeDescr"><td><s:property value="%{getSmallContentType(#content.typeCode).descr}" /></td></s:if>
			<s:if test="viewStatus"><td><s:property value="%{getText('name.contentStatus.' + #content.status)}" /></td></s:if>
			<s:if test="viewGroup"><td><s:property value="%{getGroup(#content.mainGroupCode).descr}" /></td></s:if>
			<s:if test="viewCreationDate"><td class="centerText"><span class="monospace"><s:date name="#content.create" format="dd/MM/yyyy HH:mm" /></span></td></s:if>
			<td class="icon"><span class="monospace"><s:date name="#content.modify" format="dd/MM/yyyy HH:mm" /></span></td>

			<s:if test="#content.onLine && #content.sync">
				<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/content-isonline.png</s:set>
				<s:set name="isOnlineStatus" value="%{getText('label.yes')}" />
			</s:if>
			<s:if test="#content.onLine && !(#content.sync)">
				<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/content-isnotsynched.png</s:set>
				<s:set name="isOnlineStatus" value="%{getText('label.yes') + ', ' + getText('note.notSynched')}" />
			</s:if>
			<s:if test="!(#content.onLine)">
				<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/content-isnotonline.png</s:set>
				<s:set name="isOnlineStatus" value="%{getText('label.no')}" />
			</s:if>

			<td class="centerText"><img src="<s:property value="iconImagePath" />" alt="<s:property value="isOnlineStatus" />" title="<s:property value="isOnlineStatus" />" /></td>
			</tr>
			</s:iterator>
			</table>
		</s:if>
		<s:else>

		</s:else>

		<fieldset><legend><s:text name="title.contentActions" /></legend>
		<p class="sr-only"><s:text name="title.contentActionsIntro" /></p>
		<p class="buttons">
		<wp:ifauthorized permission="validateContents">
			<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/32x32/approve.png</s:set>
			<s:submit action="approveContentGroup" type="image" src="%{#iconImagePath}" value="%{getText('label.approve')}" title="%{getText('note.button.approve')}" />
			<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/32x32/suspend.png</s:set>
			<s:submit action="suspendContentGroup" type="image" src="%{#iconImagePath}" value="%{getText('label.suspend')}" title="%{getText('note.button.suspend')}" />
		</wp:ifauthorized>
			<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/32x32/delete.png</s:set>
			<s:submit action="trashContentGroup" type="image" src="%{#iconImagePath}" value="%{getText('label.remove')}" title="%{getText('note.button.delete')}" />
		</p>
		</fieldset>

		<div class="pager">
			<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
		</div>

		</wpsa:subset>

		</s:form>
		</div>
</div>