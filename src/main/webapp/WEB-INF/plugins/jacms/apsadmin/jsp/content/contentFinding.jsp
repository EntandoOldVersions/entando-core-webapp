<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%-- radios + checkboxes only --%>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set var="targetNS" value="%{'/do/jacms/Content'}" />
<h1 class="panel panel-default title-page"><span class="panel-body display-block"><s:text name="jacms.menu.contentAdmin" />&#32;/&#32;<s:text name="title.contentList" /></span></h1>

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

			<div id="search-advanced" class="collapse">

				<div class="form-group">
					<label for="contentType" class="control-label col-sm-2 text-right">
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

					<%-- restore when we can dimiss it with a timeout
					<div class="alert alert-info alert-dismissable fade in">
						<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
						<p>Content type successfully set. TODO label.</p>
					</div>
					--%>
					<s:iterator var="attribute" value="#searcheableAttributes">
						<s:set var="currentFieldId">entityFinding_<s:property value="#attribute.name" /></s:set>

						<s:if test="#attribute.textAttribute">
							<div class="form-group">
								<s:set name="textInputFieldName"><s:property value="#attribute.name" />_textFieldName</s:set>
								<label for="<s:property value="currentFieldId" />" class="control-label col-sm-3 text-right"><s:property value="#attribute.name" /></label>
								<div class="col-sm-4">
									<s:textfield id="%{currentFieldId}" name="%{#textInputFieldName}" value="%{getSearchFormFieldValue(#textInputFieldName)}" cssClass="form-control" />
								</div>
							</div>
						</s:if>

						<s:elseif test="#attribute.type == 'Date'">
							<s:set name="dateStartInputFieldName" ><s:property value="#attribute.name" />_dateStartFieldName</s:set>
							<s:set name="dateEndInputFieldName" ><s:property value="#attribute.name" />_dateEndFieldName</s:set>

							<div class="form-group">
								<label for="<s:property value="%{currentFieldId}" />_dateStartFieldName_cal" class="control-label col-sm-5 text-right"><s:text name="note.range.from.attribute" />&#32;<s:property value="#attribute.name" /></label>
								<div class="col-sm-2">
									<s:textfield id="%{currentFieldId}_dateStartFieldName_cal" name="%{#dateStartInputFieldName}" value="%{getSearchFormFieldValue(#dateStartInputFieldName)}" cssClass="form-control datepicker" placeholder="dd/mm/yyyy" />
								</div>
							</div>
							<div class="form-group">
								<label for="<s:property value="%{currentFieldId}" />_dateEndFieldName_cal" class="control-label col-sm-5 text-right"><s:text name="note.range.to.attribute" />&#32;<s:property value="#attribute.name" /></label>
								<div class="col-sm-2">
									<s:textfield id="%{currentFieldId}_dateEndFieldName_cal" name="%{#dateEndInputFieldName}" value="%{getSearchFormFieldValue(#dateEndInputFieldName)}" cssClass="form-control datepicker" placeholder="dd/mm/yyyy" />
								</div>
							</div>
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

				<div class="form-group">
					<label for="contentType" class="control-label col-sm-2 text-right">
						<s:text name="label.category" />
					</label>
					<div class="col-sm-5">
						<s:action name="showCategoryTreeOnContentFinding" namespace="/do/jacms/Content" executeResult="true"></s:action>
					</div>
				</div>

				<div class="form-group">
					<label for="contentIdToken" class="control-label col-sm-2 text-right"><s:text name="label.code"/></label>
					<div class="col-sm-5">
						<s:textfield name="contentIdToken" id="contentIdToken" cssClass="form-control" placeholder="CNG12" />
					</div>
				</div>

				<s:set var="allowedGroupsVar" value="allowedGroups"></s:set>
				<s:if test="null != #allowedGroupsVar && #allowedGroupsVar.size()>1">
				<div class="form-group">
					<label for="ownerGroupName" class="control-label col-sm-2 text-right"><s:text name="label.group" /></label>
					<div class="col-sm-5">
						<s:select name="ownerGroupName" id="ownerGroupName" list="#allowedGroupsVar" headerKey="" headerValue="%{getText('label.all')}" listKey="name" listValue="descr" cssClass="form-control" />
					</div>
				</div>
				</s:if>

				<div class="form-group">
					<label for="state" class="control-label col-sm-2 text-right"><s:text name="label.state"/></label>
					<div class="col-sm-5">
						<s:select name="state" id="state" list="avalaibleStatus" headerKey="" headerValue="%{getText('label.all')}" listKey="key" listValue="%{getText(value)}" cssClass="form-control" />
					</div>
				</div>

				<div class="form-group">
					<div class="btn-group col-sm-5 col-sm-offset-2" data-toggle="buttons">
						<label class="btn btn-default">
							<input type="radio" name="onLineState" id="approved" <s:if test="('yes' == onLineState)">checked="checked"</s:if> value="yes" />&#32;
							<s:text name="name.isApprovedContent"/>
						</label>
						<label class="btn btn-default">
							<input type="radio" name="onLineState" id="notApproved" <s:if test="('no' == onLineState)">checked="checked"</s:if> value="no" />&#32;
							<s:text name="name.isNotApprovedContent"/>
						</label>
						<label class="btn btn-default active">
							<input type="radio" name="onLineState" id="bothApproved" <s:if test="('yes' != onLineState) && ('no' != onLineState)">checked="checked"</s:if> value="" />&#32;
							<s:text name="name.isApprovedOrNotContent" />
						</label>
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-5 col-sm-offset-2">
						<s:submit action="%{#searchActionName}" type="button" cssClass="btn btn-primary">
							<span class="icon icon-search"></span>&#32;<s:text name="label.search" />
						</s:submit>
					</div>
				</div>

			</div><!--// search-advanced -->

			<hr />

			<p class="help-block text-right">
				<button type="button" data-toggle="collapse" data-target="#search-configure-results" class="btn btn-link">
					<s:text name="title.searchResultOptions" />&#32;<span class="icon-chevron-down"></span>
				</button>
			</p>

			<div id="search-configure-results" class="collapse">

				<div class="form-group col-sm-12">
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-default" for="viewCode">
							<wpsf:checkbox name="viewCode" id="viewCode" />&#32;
							<s:text name="label.code" />
						</label>
						<label class="btn btn-default">
							<wpsf:checkbox name="viewTypeDescr" id="viewTypeDescr" />&#32;
							<s:text name="name.contentType" />
						</label>
						<label class="btn btn-default">
							<wpsf:checkbox name="viewStatus" id="viewStatus" />&#32;
							<s:text name="name.contentStatus" />
						</label>
						<label class="btn btn-default">
							<wpsf:checkbox name="viewGroup" id="viewGroup" />&#32;
							<s:text name="label.group"/>
						</label>
						<label class="btn btn-default">
							<wpsf:checkbox name="viewCreationDate" id="viewCreationDate" />&#32;
							<s:text name="label.creationDate"/>
						</label>
					</div>
				</div>

				<div class="form-group col-sm-12">
					<s:submit action="%{#searchActionName}" type="button" cssClass="btn btn-primary">
							<span class="icon icon-search"></span>&#32;<s:text name="label.search" />
					</s:submit>
				</div>

			</div>

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
		<div class="alert alert-danger alert-dismissable fade in">
			<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
			<h2 class="h4 margin-none">
				<s:text name="message.title.ActionErrors" />
			</h2>
			<ul class="margin-base-vertical">
			<s:iterator value="ActionErrors">
				<li><s:property escape="false" /></li>
			</s:iterator>
			</ul>
		</div>
		</s:if>
		<s:if test="hasActionMessages()">
		<div class="alert alert-success alert-dismissable fade in">
			<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
			<h2 class="h4 margin-none"><s:text name="messages.confirm" /></h2>
			<ul class="margin-base-vertical">
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

		<div class="table-responsive">
			<table class="table table-bordered" id="contentListTable" summary="<s:text name="note.content.contentList.summary" />">
			<caption class="sr-only"><s:text name="title.contentList" /></caption>
			<tr>
				<th class="text-center padding-large-left padding-large-right"><abbr title="<s:text name="label.actions" />">&ndash;</abbr></th>
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
				<th class="text-center">
				<a href="<s:url action="changeOrder" anchor="content_list_intro" includeParams="all" >
					<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
					<s:param name="lastOrder"><s:property value="lastOrder" /></s:param>
					<s:param name="groupBy">created</s:param>
					</s:url>"><s:text name="label.creationDate" /></a>
				</th>
			</s:if>
				<th class="text-center">
				<a href="<s:url action="changeOrder" anchor="content_list_intro" includeParams="all" >
					<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
					<s:param name="lastOrder"><s:property value="lastOrder" /></s:param>
					<s:param name="groupBy">lastModified</s:param>
					</s:url>"><s:text name="label.lastEdit" /></a>
				</th>
				<th class="text-center">
					<abbr title="<s:text name="name.onLine" />">P</abbr>
				</th>
			</tr>
			<s:iterator var="contentId">
			<s:set name="content" value="%{getContentVo(#contentId)}"></s:set>
			<tr>
			<td class="text-center text-nowrap">
				<div class="btn-group btn-group-xs">
					<a class="btn btn-default" title="<s:text name="label.edit" />: <s:property value="#content.id" /> - <s:property value="#content.descr" />" href="<s:url action="edit" namespace="/do/jacms/Content"><s:param name="contentId" value="#content.id" /></s:url>">
						<span class="icon icon-edit"></span>
						<span class="sr-only"><s:text name="label.edit" />: <s:property value="#content.id" /> - <s:property value="#content.descr" /></span>
					</a>
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu text-left" role="menu">
						<li>
							<a title="<s:text name="label.copyPaste" />: <s:property value="#content.id" /> - <s:property value="#content.descr" />" href="<s:url action="copyPaste" namespace="/do/jacms/Content"><s:param name="contentId" value="#content.id" /><s:param name="copyPublicVersion" value="'false'" /></s:url>">
								<span class="icon icon-fixed-width icon-paste"></span>
								<s:text name="label.copyPaste" /><span class="sr-only">: <s:property value="#content.id" /> - <s:property value="#content.descr" /></span>
							</a>
						</li>
						<li>
							<a title="<s:text name="label.inspect" />: [<s:text name="name.work" />] <s:property value="#content.id" /> - <s:property value="#content.descr" />" href="<s:url action="inspect" namespace="/do/jacms/Content"><s:param name="contentId" value="#content.id" /><s:param name="currentPublicVersion" value="'false'" /></s:url>">
								<span class="icon icon-fixed-width icon-info"></span>
								<s:text name="label.inspect" />&#32;<s:text name="name.work" />
							</a>
						</li>
						<li>
							<a title="<s:text name="label.inspect" />: [<s:text name="name.onLine" />] <s:property value="#content.id" /> - <s:property value="#content.descr" />" href="<s:url action="inspect" namespace="/do/jacms/Content"><s:param name="contentId" value="#content.id" /><s:param name="currentPublicVersion" value="'true'" /></s:url>">
								<span class="icon icon-fixed-width icon-info"></span>
								<s:text name="label.inspect" />&#32;<s:text name="name.onLine" />
							</a>
						</li>
						<wpsa:hookPoint key="jacms.contentFinding.contentRow.actions" objectName="hookpoint_contentFinding_contentRow">
						<li class="divider"></li>
							<s:iterator value="#hookpoint_contentFinding_contentRow" var="hookPointElement">
								<li>
									<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
								</li>
							</s:iterator>
						</wpsa:hookPoint>
					</ul>
				</div>
			</td>
			<td>
				<label>
					<input type="checkbox" name="contentIds" id="content_<s:property value="#content.id" />" value="<s:property value="#content.id" />" />&#32;
					<s:property value="#content.descr" />
				</label>
			</td>
			<s:if test="viewCode">
				<td>
					<code><s:property value="#content.id" /></code>
				</td>
			</s:if>
			<s:if test="viewTypeDescr">
				<td>
					<s:property value="%{getSmallContentType(#content.typeCode).descr}" />
				</td>
			</s:if>
			<s:if test="viewStatus">
				<td>
					<s:property value="%{getText('name.contentStatus.' + #content.status)}" />
				</td>
			</s:if>
			<s:if test="viewGroup">
				<td>
					<s:property value="%{getGroup(#content.mainGroupCode).descr}" />
				</td>
			</s:if>
			<s:if test="viewCreationDate">
				<td class="text-center text-nowrap">
					<code><s:date name="#content.create" format="dd/MM/yyyy HH:mm" /></code>
				</td>
			</s:if>
			<td class="text-center text-nowrap">
				<code><s:date name="#content.modify" format="dd/MM/yyyy HH:mm" /></code>
			</td>

			<s:if test="#content.onLine && #content.sync">
				<s:set name="iconName" id="iconName">ok</s:set>
				<s:set name="textVariant" id="textVariant">success</s:set>
				<s:set name="isOnlineStatus" value="%{getText('label.yes')}" />
			</s:if>
			<s:if test="#content.onLine && !(#content.sync)">
				<s:set name="iconName" id="iconName">adjust</s:set>
				<s:set name="textVariant" id="textVariant">info</s:set>
				<s:set name="isOnlineStatus" value="%{getText('label.yes') + ', ' + getText('note.notSynched')}" />
			</s:if>
			<s:if test="!(#content.onLine)">
				<s:set name="iconName" id="iconName">pause</s:set>
				<s:set name="textVariant" id="textVariant">warning</s:set>
				<s:set name="isOnlineStatus" value="%{getText('label.no')}" />
			</s:if>

			<td class="text-center">
				<span class="icon icon-<s:property value="iconName" /> text-<s:property value="textVariant" />" title="<s:property value="isOnlineStatus" />"></span>
				<span class="sr-only"><s:property value="isOnlineStatus" /></span>
			</td>
			</tr>
			</s:iterator>
			</table>
		</div>
		</s:if>

		<fieldset>
			<legend class="sr-only"><s:text name="title.contentActions" /></legend>
			<p class="sr-only"><s:text name="title.contentActionsIntro" /></p>
			<div class="btn-toolbar">
			<wp:ifauthorized permission="validateContents">
				<div class="btn-group margin-small-vertical">
					<s:submit action="approveContentGroup" type="button" title="%{getText('note.button.approve')}" cssClass="btn btn-success">
						<span class="icon icon-ok"></span>
						<s:text name="label.approve" />
					</s:submit>
					<s:submit action="suspendContentGroup" type="button" title="%{getText('note.button.suspend')}" cssClass="btn btn-warning">
						<span class="icon icon-pause"></span>
						<s:text name="label.suspend" />
					</s:submit>
				</div>
			</wp:ifauthorized>
				<div class="btn-group margin-small-vertical">
					<s:submit action="trashContentGroup" type="button" title="%{getText('note.button.delete')}" cssClass="btn btn-link">
						<span class="icon icon-remove-sign"></span>
						<s:text name="label.remove" />
					</s:submit>
				</div>
			</div>
		</fieldset>

		<div class="pager">
			<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
		</div>

		</wpsa:subset>

		</s:form>
		</div>
</div>