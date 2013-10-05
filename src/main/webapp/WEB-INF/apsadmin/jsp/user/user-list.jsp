<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url namespace="/do/BaseAdmin" action="settings" />"><s:text name="menu.configure" /></a>
		&#32;/&#32;
		<s:text name="title.userManagement" />
	</span>
</h1>
<s:form action="search" cssClass="form-horizontal">
	<s:if test="hasActionErrors()">
		<div class="alert alert-warning alert-dismissable fade in">
			<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
			<h2 class="h4 margin-none"><s:text name="message.title.ActionErrors" /></h2>
			<ul class="margin-base-vertical">
				<s:iterator value="actionErrors">
					<li><s:property escape="false" /></li>
				</s:iterator>
			</ul>
		</div>
	</s:if>
	<div class="form-group">
		<label for="search-username" class="sr-only"><s:text name="label.search.by"/>&#32;<s:text name="label.username"/></label>
		<div class="input-group col-sm-12 col-md-12">
			<span class="input-group-addon">
				<span class="icon icon-file-text-alt icon-large" title="<s:text name="label.search.by"/>&#32;<s:text name="label.username"/>"></span>
			</span>
			<input type="text" name="text" value="" id="text" class="form-control input-lg" title="<s:text name="label.search.by"/>&#32;<s:text name="label.username"/>" placeholder="Description">
			<div class="input-group-btn">
				<s:submit type="button" name="username" id="search-username" cssClass="btn btn-primary btn-lg">
					<span class="icon icon-search" title="<s:text name="label.search" />"></span>
				</s:submit>
			</div>
		</div>
		<p class="help-block text-right">
			<button type="button" data-toggle="collapse" data-target="#search-advanced" class="btn btn-link">
				<s:text name="title.searchFilters" />&#32;<span class="icon-chevron-down"></span>
			</button>
		</p>
	</div>
	<s:set var="searcheableAttributes" value="searcheableAttributes" />
	<s:set var="searcheableAttributesPageScope" value="%{#searcheableAttributes}" scope="page" />
	<div id="search-advanced" class="collapse">
		<div class="form-group">
			<div class="clearfix"></div>
			<label class="control-label col-sm-2 text-right">Users</label>
			<div class="btn-group col-lg-10" data-toggle="buttons">
					<label class="btn btn-default <s:if test="%{withProfile==null}"> active </s:if>">
						<wpsf:radio id="" name="withProfile" value="" checked="%{withProfile==null}" />
						&#32;<s:text name="label.userprofile.search.usersAllProfile" />
					</label>
					<label class="btn btn-default <s:if test="%{withProfile.toString().equalsIgnoreCase('1')}"> active </s:if>">
						<wpsf:radio id="" name="withProfile" value="1" checked="%{withProfile.toString().equalsIgnoreCase('1')}" />
						&#32;<s:text name="label.userprofile.search.usersWithProfile" />
					</label>
					<label class="btn btn-default <s:if test="%{withProfile.toString().equalsIgnoreCase('0')}"> active </s:if>">
						<wpsf:radio id="" name="withProfile" value="0" checked="%{withProfile.toString().equalsIgnoreCase('0')}"  />
						&#32;<s:text name="label.userprofile.search.usersWithoutProfile" />
					</label>
			</div>
		</div>
		<div class="form-group">
			<label for="userprofile_src_entityPrototypes" class="control-label col-sm-2 text-right"><s:text name="note.userprofile.search.profileType" /></label>
			<div class="col-sm-5 input-group">
				<s:select id="userprofile_src_entityPrototypes" list="entityPrototypes" name="entityTypeCode" headerKey="" headerValue="%{getText('label.all')}" listKey="typeCode" listValue="typeDescr" cssClass="form-control" />
				<div class="input-group-btn">
					<s:submit type="button" cssClass="btn btn-default" action="changeProfileType">
						<s:text name="label.set" />
					</s:submit>
				</div>
			</div>
		</div>
		<c:if test="${empty searcheableAttributesPageScope}">
			<div class="form-group">
				<div class="col-lg-offset-2 col-sm-5 input-group">
					<span class="text-info">
						<s:text name="note.userprofile.searchAdvanced.chooseType" />
					</span>
				</div>
			</div>
		</c:if>
		<s:if test="null != #searcheableAttributes && #searcheableAttributes.size() > 0">
			<s:iterator value="#searcheableAttributes" var="attribute">
				<%-- Text Attribute --%>
					<s:if test="#attribute.textAttribute">
						<s:set var="currentAttributeHtmlId" value="%{'userprofile_src_'+#attribute.name}" />
						<s:set var="textInputFieldName" value="%{#attribute.name+'_textFieldName'}" />
						<div class="form-group">
							<label class="control-label col-sm-2 text-right" for="<s:property value="#currentAttributeHtmlId" />">
								<s:property value="#attribute.name" />
							</label>
							<div class="col-sm-5">
								<s:textfield
									id="%{#currentAttributeHtmlId}"
									name="%{#textInputFieldName}"
									value="%{getSearchFormFieldValue(#textInputFieldName)}"
									cssClass="form-control" />
							</div>
						</div>
					</s:if>
				<%-- Date Attribute --%>
					<s:elseif test="#attribute.type == 'Date'">
						<s:set var="currentAttributeHtmlId" value="%{'userprofile_src_'+#attribute.name}" />
						<s:set var="dateStartInputFieldName" value="%{#attribute.name+'_dateStartFieldName'}" />
						<s:set var="dateEndInputFieldName" value="%{#attribute.name+'_dateEndFieldName'}" />
							<div class="form-group">
								<label class="control-label col-sm-2 text-right"><s:property value="#attribute.name" /></label>
									<div class="col-lg-3">
											<label class="sr-only" for="<s:property value="%{#currentAttributeHtmlId+'_dateStartFieldName_cal'}" />">
										<s:property value="#attribute.name" />&#32;<s:text name="label.userprofile.from.date" />
									</label>
										<wpsf:textfield
											cssClass="form-control"
											placeholder="%{getText('label.userprofile.from.date')}"
											title="%{#attribute.name+' '+getText('label.userprofile.from.date')}"
											id="%{#currentAttributeHtmlId}_dateStartFieldName_cal"
											name="%{#dateStartInputFieldName}"
											value="%{getSearchFormFieldValue(#dateStartInputFieldName)}" />
									</div>
									<div class="col-lg-3">
										<label class="sr-only" for="<s:property value="%{#currentAttributeHtmlId+'_dateEndFieldName_cal'}" />">
											<s:property value="#attribute.name" />&#32;<s:text name="label.userprofile.to.date" />
										</label>
											<wpsf:textfield
												cssClass="form-control"
												placeholder="%{getText('label.userprofile.to.date')}"
												title="%{#attribute.name+' '+getText('label.userprofile.to.date')}"
												id="%{#currentAttributeHtmlId}_dateEndFieldName_cal"
												name="%{#dateEndInputFieldName}"
												value="%{getSearchFormFieldValue(#dateEndInputFieldName)}" />
									</div>
									<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
										<span class="help-block"><s:text name="label.userprofile.date.pattern" /></span>
									</div>
							</div>
					</s:elseif>
				<%-- Number Attribute --%>
					<s:elseif test="#attribute.type == 'Number'">
						<s:set var="currentAttributeHtmlId" value="%{'userprofile_src_'+#attribute.name}" />
						<s:set var="numberStartInputFieldName" value="%{#attribute.name+'_numberStartFieldName'}" />
						<s:set var="numberEndInputFieldName" value="%{#attribute.name+'_numberEndFieldName'}" />
							<div class="form-group">
								<label class="control-label col-sm-2 text-right"><s:property value="#attribute.name" /></label>
								<div class="col-lg-2">
									<label class="sr-only" for="<s:property value="%{#currentAttributeHtmlId+'_start'}" />"><s:property value="#attribute.name" />&#32;<s:text name="label.userprofile.from.value" /></label>
									<wpsf:textfield title="%{#attribute.name+' '+getText('label.userprofile.from.value')}" id="%{#currentAttributeHtmlId}_start" name="%{#numberStartInputFieldName}" value="%{getSearchFormFieldValue(#numberStartInputFieldName)}" cssClass="form-control" placeholder="%{getText('label.userprofile.from.value')}" />
								</div>
								<div class="col-lg-2">
									<label class="sr-only" for="<s:property value="%{#currentAttributeHtmlId+'_end'}" />"><s:property value="#attribute.name" />&#32;<s:text name="label.userprofile.to.value" /></label>
									<wpsf:textfield title="%{#attribute.name+' '+getText('label.userprofile.to.value')}" id="%{#currentAttributeHtmlId}_end" name="%{#numberEndInputFieldName}" value="%{getSearchFormFieldValue(#numberEndInputFieldName)}" cssClass="form-control" placeholder="%{getText('label.userprofile.to.value')}" />
								</div>
							</div>
					</s:elseif>
				<%-- Boolean & ThreeState --%>
					<s:elseif test="#attribute.type == 'Boolean' || #attribute.type == 'ThreeState'">
						<s:set var="booleanInputFieldName" value="%{#attribute.name+'_booleanFieldName'}" />
						<s:set var="booleanInputFieldValue" value="%{getSearchFormFieldValue(#booleanInputFieldName)}" />
						<div class="form-group">
							<label class="control-label col-sm-2 text-right"><s:property value="#attribute.name" /></label>
							<div class="btn-group col-lg-10" data-toggle="buttons">
								<label class="btn btn-default <s:if test="%{!#booleanInputFieldValue.equals('true') && !#booleanInputFieldValue.equals('false')}"> active </s:if>">
									<wpsf:radio id="none_%{#booleanInputFieldName}" name="%{#booleanInputFieldName}" value="" checked="%{!#booleanInputFieldValue.equals('true') && !#booleanInputFieldValue.equals('false')}" />
									&#32;<s:text name="label.bothYesAndNo"/>
								</label>
								<label class="btn btn-default <s:if test="%{#booleanInputFieldValue == 'true'}"> active </s:if>">
									<wpsf:radio id="true_%{#booleanInputFieldName}" name="%{#booleanInputFieldName}" value="true" checked="%{#booleanInputFieldValue == 'true'}" />
									&#32;<s:text name="label.yes"/>
								</label>
								<label class="btn btn-default <s:if test="%{#booleanInputFieldValue == 'false'}"> active </s:if>">
									<wpsf:radio id="false_%{#booleanInputFieldName}" name="%{#booleanInputFieldName}" value="false" checked="%{#booleanInputFieldValue == 'false'}" />
									&#32;<s:text name="label.no"/>
								</label>
							</div>
						</div>
					</s:elseif>
			</s:iterator>
		</s:if>
		<div class="form-group">
			<div class="col-sm-5 col-sm-offset-2">
				<s:submit type="button" cssClass="btn btn-primary">
					<span class="icon icon-search" />&#32;<s:text name="label.search" />
				</s:submit>
			</div>
		</div>
	</div>
	<wpsa:subset source="searchResult" count="10" objectName="groupUserVar" advanced="true" offset="5">
		<s:set var="group" value="#groupUserVar" />
		<div class="text-center">
			<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
			<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
		</div>
		<div class="table-responsive">
			<wp:ifauthorized permission="editUserProfile" var="hasEditProfilePermission" />
			<table class="table table-bordered" summary="<s:text name="note.userList.summary" />">
				<caption><span><s:text name="title.userManagement.userList" /></span></caption>
				<tr>
					<th><s:text name="label.username" /></th>
					<th><s:text name="label.name" /></th>
					<th><s:text name="label.email" /></th>
					<%--
					<th><s:text name="label.date.registration" /></th>
					<th><s:text name="label.date.lastLogin" /></th>
					<th><s:text name="label.date.lastPasswordChange" /></th>
					--%>
					<wpsa:hookPoint key="core.user-list.table.th" objectName="hookPointElements_core_user_list_table_th">
						<s:iterator value="#hookPointElements_core_user_list_table_th" var="hookPointElement">
							<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
						</s:iterator>
					</wpsa:hookPoint>
					<th class="icon"><abbr title="<s:text name="label.profile" />">P</abbr></th>
					<th class="icon"><abbr title="<s:text name="label.state" />">S</abbr></th>
					<th class="icon"><abbr title="<s:text name="label.authorizations" />">A</abbr></th>
					<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>
					<s:iterator var="usernameVar">
						<s:set var="userVar" value="%{getUser(#usernameVar)}" />
						<s:set var="userProfileVar" value="%{getUserProfile(#usernameVar)}" />
						<s:if test="null == #userVar || #userVar.disabled">
							<s:set var="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-notActive.png</s:set>
							<s:set var="statusIconText" id="statusIconText"><s:text name="note.userStatus.notActive" /></s:set>
						</s:if>
						<s:elseif test="!#userVar.entandoUser">
							<s:set var="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-notjAPSUser.png</s:set>
							<s:set var="statusIconText" id="statusIconText"><s:text name="note.userStatus.notEntandoUser" /></s:set>
						</s:elseif>
						<s:elseif test="!#userVar.accountNotExpired">
							<s:set var="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-expiredAccount.png</s:set>
							<s:set var="statusIconText" id="statusIconText"><s:text name="note.userStatus.expiredAccount" /></s:set>
						</s:elseif>
						<s:elseif test="!#userVar.credentialsNotExpired">
							<s:set var="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-expiredPassword.png</s:set>
							<s:set var="statusIconText" id="statusIconText"><s:text name="note.userStatus.expiredPassword" /></s:set>
						</s:elseif>
						<s:elseif test="!#userVar.disabled">
							<s:set var="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-active.png</s:set>
							<s:set var="statusIconText" id="statusIconText"><s:text name="note.userStatus.active" /></s:set>
						</s:elseif>
						<tr>
							<td>
								<s:if test="null == #userVar">
								<a href="<s:url action="edit"><s:param name="username" value="#usernameVar"/></s:url>" title="<s:text name="label.edit" />: <s:property value="#usernameVar" />" ><s:property value="#userVar" /></a>
								</s:if>
								<s:else><s:property value="#usernameVar" /></s:else>
							</td>
							<td>
								<s:if test="null != #userProfileVar"><s:property value="#userProfileVar.getValue(#userProfileVar.fullNameAttributeName)"/></s:if>
								<s:else><abbr title="<s:text name="label.noProfile" />">&ndash;</abbr></s:else>
							</td>
							<td class="monospace"><s:if test="null != #userProfileVar">
								<s:set var="mailVar" value="#userProfileVar.getValue(#userProfileVar.mailAttributeName)" />
								<s:if test="#mailVar.length()>16"><abbr title="<s:property value="#mailVar" />"><s:property value="%{#mailVar.substring(0,8) + '...' + #mailVar.substring(#mailVar.length()-8)}" /></abbr></s:if>
								<s:else><s:property value="#mailVar"/></s:else></s:if><s:else><abbr title="<s:text name="label.noProfile" />">&ndash;</abbr></s:else>
							</td>
							<%--
							<td class="centerText monospace">
								<s:if test="#userVar.entandoUser">
									<s:date name="#userVar.creationDate" format="dd/MM/yyyy" />
								</s:if>
								<s:else><abbr title="<s:text name="label.none" />">&ndash;</abbr></s:else>
							</td>
							<td class="centerText monospace">
								<s:if test="#userVar.entandoUser && #userVar.lastAccess != null">
									<s:date name="#userVar.lastAccess" format="dd/MM/yyyy" />
								</s:if>
								<s:else><abbr title="<s:text name="label.none" />">&ndash;</abbr></s:else>
							</td>
							<td class="centerText monospace">
								<s:if test="#userVar.entandoUser && #userVar.lastPasswordChange != null">
									<s:date name="#userVar.lastPasswordChange" format="dd/MM/yyyy" />
								</s:if>
								<s:else><abbr title="<s:text name="label.none" />">&ndash;</abbr></s:else>
							</td>
							--%>
							<wpsa:hookPoint key="core.user-list.table.td" objectName="hookPointElements_core_user_list_table_td">
								<s:iterator value="#hookPointElements_core_user_list_table_td" var="hookPointElement">
									<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
								</s:iterator>
							</wpsa:hookPoint>
							<td class="icon_double">
								<c:if test="${hasEditProfilePermission}"><a href="<s:url action="edit" namespace="/do/userprofile"><s:param name="username" value="#usernameVar"/></s:url>"
									title="<s:text name="label.editProfile" />:&#32;<s:property value="#userProfileVar.getValue(#userProfileVar.firstNameAttributeName)"/>&#32;<s:property value="#userProfileVar.getValue(#userProfileVar.surnameAttributeName)"/>"><img src="<wp:resourceURL/>administration/common/img/icons/22x22/edit.png" alt="<s:text name="label.editProfile" />: <s:property value="#usernameVar" />" /></a></c:if>
								<s:if test="null != #userProfileVar"><a href="<s:url action="view" namespace="/do/userprofile"><s:param name="username" value="#usernameVar"/></s:url>"
									title="<s:text name="label.viewProfile" />: <s:property value="#usernameVar" />"><img src="<wp:resourceURL/>administration/common/img/icons/22x22/detail.png" alt="<s:text name="label.viewProfile" />: <s:property value="#usernameVar" />" /></a></s:if>
							</td>
							<td class="icon"><img src="<s:property value="#statusIconImagePath" />" alt="<s:property value="#statusIconText" />" title="<s:property value="#statusIconText" />" /></td>
							<td class="icon"><a href="<s:url namespace="/do/User/Auth" action="edit"><s:param name="username" value="#usernameVar"/></s:url>" title="<s:text name="note.configureAuthorizationsFor" />: <s:property value="#usernameVar" />"><img src="<wp:resourceURL />administration/common/img/icons/authorizations.png" alt="<s:text name="note.configureAuthorizationsFor" />: <s:property value="#usernameVar" />" /></a></td>
							<td class="icon"><a href="<s:url action="trash"><s:param name="username" value="#usernameVar"/></s:url>" title="<s:text name="label.remove" />: <s:property value="#usernameVar" />"><img src="<wp:resourceURL />administration/common/img/icons/delete.png" alt="<s:text name="label.alt.clear" />" /></a></td>
						</tr>
						<s:set var="userVar" value="null" />
						<s:set var="userProfileVar" value="null" />
					</s:iterator>
				</tr>
			</table>
		</div>
		<div class="text-center">
			<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
		</div>
	</wpsa:subset>
</s:form>