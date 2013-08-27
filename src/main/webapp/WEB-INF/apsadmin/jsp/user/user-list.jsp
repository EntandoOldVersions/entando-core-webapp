<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set var="targetNS" value="%{'/do/User'}" />
<h1><s:text name="title.userManagement" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

<div id="main">

<s:form action="search">
<s:if test="hasActionErrors()">
<div class="message message_error">	
<h2><s:text name="message.title.ActionErrors" /></h2>
	<ul>
		<s:iterator value="actionErrors">
			<li><s:property escape="false" /></li>
		</s:iterator>
	</ul>
</div>
</s:if>

<p><label for="username" class="basic-mint-label label-search"><s:text name="label.search.by"/>&#32;<s:text name="label.username"/>:</label>
<wpsf:textfield useTabindexAutoIncrement="true" name="username" id="username" cssClass="text" /></p>

<wpsa:hookPoint key="core.user-list.form-field" objectName="hookPointElements_core_user_list_form_fields">
<s:iterator value="#hookPointElements_core_user_list_form_fields" var="hookPointElement">
	<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
</s:iterator>
</wpsa:hookPoint>

<fieldset>
	<legend class="accordion_toggler"><s:text name="title.searchFilters" /></legend>
	<div class="accordion_element">
		<p>
			<%--
			<label for="withProfile" class="basic-mint-label"><s:text name="userprofile.note.search.hasProfile"/>:</label>
			<wpsf:select useTabindexAutoIncrement="true" name="withProfile" id="withProfile" list="#{1:getText('label.yes'),0:getText('label.no')}" headerKey="" headerValue="%{getText('label.bothYesAndNo')}" />
			--%>
			<wpsf:radio cssClass="radiocheck" id="userprofile_src_withProfile_yes" name="withProfile" value="1" checked="%{withProfile.toString().equalsIgnoreCase('1')}" useTabindexAutoIncrement="true" />
			<label for="userprofile_src_withProfile_yes"><s:text name="userprofile.label.search.usersWithProfile" /></label>
			<wpsf:radio id="userprofile_src_withProfile_no" name="withProfile" value="0" checked="%{withProfile.toString().equalsIgnoreCase('0')}" useTabindexAutoIncrement="true" />
			<label for="userprofile_src_withProfile_no"><s:text name="userprofile.label.search.usersWithoutProfile" /></label>
			<wpsf:radio id="userprofile_src_withProfile_both" name="withProfile" value="" checked="%{withProfile==null}" useTabindexAutoIncrement="true" />
			<label for="userprofile_src_withProfile_both"><s:text name="userprofile.label.search.usersAllProfile" /></label>
		</p>
		<p>
			<label for="userprofile_src_entityPrototypes" class="basic-mint-label"><s:text name="userprofile.note.search.profileType" />:</label>
			<wpsf:select useTabindexAutoIncrement="true" id="userprofile_src_entityPrototypes" list="entityPrototypes" name="entityTypeCode" headerKey="" headerValue="%{getText('label.all')}" listKey="typeCode" listValue="typeDescr" cssClass="text" />
			<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.set')}" cssClass="button" action="changeProfileType" />
		</p>
		<div class="subsection">
			<s:set var="searcheableAttributes" value="searcheableAttributes" ></s:set>
			<s:if test="null != #searcheableAttributes && #searcheableAttributes.size() > 0">
				<s:iterator var="attribute" value="#searcheableAttributes">
					<%-- Text Attribute --%>
					<s:if test="#attribute.textAttribute">
						<s:set var="currentAttributeHtmlId">userprofile_src_<s:property value="#attribute.name" /></s:set>
						<s:set name="textInputFieldName"><s:property value="#attribute.name" />_textFieldName</s:set>
							<p>
								<label for="<s:property value="#currentAttributeHtmlId" />" class="basic-mint-label"><s:property value="#attribute.name" />:</label>
							<wpsf:textfield useTabindexAutoIncrement="true" id="%{#currentAttributeHtmlId}" name="%{#textInputFieldName}" value="%{getSearchFormFieldValue(#textInputFieldName)}" cssClass="text" />
						</p>
					</s:if>

					<%-- Date Attribute --%>
					<s:elseif test="#attribute.type == 'Date'">
						<s:set var="currentAttributeHtmlId">userprofile_src_<s:property value="#attribute.name" /></s:set>
						<s:set name="dateStartInputFieldName" ><s:property value="#attribute.name" />_dateStartFieldName</s:set>
						<s:set name="dateEndInputFieldName" ><s:property value="#attribute.name" />_dateEndFieldName</s:set>
							<p>
								<label for="<s:property value="%{#currentAttributeHtmlId+'_dateStartFieldName_cal'}" />" class="basic-mint-label">
								<s:property value="#attribute.name" />&#32;<s:text name="userprofile.from.date" />:
							</label>
							<wpsf:textfield useTabindexAutoIncrement="true" id="%{#currentAttributeHtmlId}_dateStartFieldName_cal" name="%{#dateStartInputFieldName}" value="%{getSearchFormFieldValue(#dateStartInputFieldName)}" cssClass="text" />
							<span class="inlineNote"><s:text name="userprofile.date.pattern" /></span>
						</p>
						<p>
							<label for="<s:property value="%{#currentAttributeHtmlId+'_dateEndFieldName_cal'}" />" class="basic-mint-label">
								<s:property value="#attribute.name" />&#32;<s:text name="userprofile.to.date" />:
							</label>
							<wpsf:textfield useTabindexAutoIncrement="true" id="%{#currentAttributeHtmlId}_dateEndFieldName_cal" name="%{#dateEndInputFieldName}" value="%{getSearchFormFieldValue(#dateEndInputFieldName)}" cssClass="text" />
							<span class="inlineNote"><s:text name="userprofile.date.pattern" /></span>
						</p>
					</s:elseif>

					<%-- Number Attribute --%>
					<s:elseif test="#attribute.type == 'Number'">
						<s:set var="currentAttributeHtmlId">userprofile_src_<s:property value="#attribute.name" /></s:set>
						<s:set name="numberStartInputFieldName" ><s:property value="#attribute.name" />_numberStartFieldName</s:set>
						<s:set name="numberEndInputFieldName" ><s:property value="#attribute.name" />_numberEndFieldName</s:set>
							<p>
								<label for="<s:property value="%{#currentAttributeHtmlId+'_start'}" />" class="basic-mint-label">
								<s:property value="#attribute.name" />&#32;<s:text name="userprofile.from.value" />:
							</label>
							<wpsf:textfield useTabindexAutoIncrement="true" id="%{#currentAttributeHtmlId}_start" name="%{#numberStartInputFieldName}" value="%{getSearchFormFieldValue(#numberStartInputFieldName)}" cssClass="text" />
						</p>
						<p>
							<label for="<s:property value="%{#currentAttributeHtmlId+'_end'}" />" class="basic-mint-label">
								<s:property value="#attribute.name" />&#32;<s:text name="userprofile.to.value" />:
							</label>
							<wpsf:textfield useTabindexAutoIncrement="true" id="%{#currentAttributeHtmlId}_end" name="%{#numberEndInputFieldName}" value="%{getSearchFormFieldValue(#numberEndInputFieldName)}" cssClass="text" />
						</p>
					</s:elseif>

					<s:elseif test="#attribute.type == 'Boolean' || #attribute.type == 'ThreeState'">
						<p>
							<span class="important"><s:property value="#attribute.name" /></span>
						</p>
						<s:set name="booleanInputFieldName" ><s:property value="#attribute.name" />_booleanFieldName</s:set>
						<s:set name="booleanInputFieldValue" ><s:property value="%{getSearchFormFieldValue(#booleanInputFieldName)}" /></s:set>
						<ul class="noBullet">
							<li><wpsf:radio useTabindexAutoIncrement="true" id="none_%{#booleanInputFieldName}" name="%{#booleanInputFieldName}" value="" checked="%{!#booleanInputFieldValue.equals('true') && !#booleanInputFieldValue.equals('false')}" cssClass="radiocheck" /><label for="none_<s:property value="#booleanInputFieldName" />" class="normal" ><s:text name="label.bothYesAndNo"/></label></li>
							<li><wpsf:radio useTabindexAutoIncrement="true" id="true_%{#booleanInputFieldName}" name="%{#booleanInputFieldName}" value="true" checked="%{#booleanInputFieldValue == 'true'}" cssClass="radiocheck" /><label for="true_<s:property value="#booleanInputFieldName" />" class="normal" ><s:text name="label.yes"/></label></li>
							<li><wpsf:radio useTabindexAutoIncrement="true" id="false_%{#booleanInputFieldName}" name="%{#booleanInputFieldName}" value="false" checked="%{#booleanInputFieldValue == 'false'}" cssClass="radiocheck" /><label for="false_<s:property value="#booleanInputFieldName" />" class="normal"><s:text name="label.no"/></label></li>
						</ul>
					</s:elseif>
				</s:iterator>
			</s:if>
			<s:else>
				<p>
					<s:text name="userprofile.note.searchAdvanced.chooseType" />
				</p>
			</s:else>
		</div>

	</div>
</fieldset>

<p>
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.search')}" cssClass="button" />
</p>

<div class="subsection-light">

<wpsa:subset source="searchResult" count="10" objectName="groupUserVar" advanced="true" offset="5">
<s:set name="group" value="#groupUserVar" />

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

<table class="generic" summary="<s:text name="note.userList.summary" />">
<caption><span><s:text name="title.userManagement.userList" /></span></caption>
<tr>
	<th><s:text name="label.username" /></th>
	<th><s:text name="label.name" /></th>
	<th><s:text name="label.mail" /></th>
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
</tr>

<wp:ifauthorized permission="editUserProfile" var="hasEditProfilePermission" />
<s:iterator id="usernameVar">
<s:set var="userVar" value="%{getUser(#usernameVar)}" />
<s:set var="userProfileVar" value="%{getUserProfile(#usernameVar)}" />

<s:if test="!#userVar.entandoUser">
	<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-notjAPSUser.png</s:set>
	<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.notEntandoUser" /></s:set>
</s:if>
<s:elseif test="#userVar.disabled">
	<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-notActive.png</s:set>
	<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.notActive" /></s:set>	
</s:elseif>
<s:elseif test="!#userVar.accountNotExpired">
	<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-expiredAccount.png</s:set>
	<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.expiredAccount" /></s:set>	
</s:elseif>
<s:elseif test="!#userVar.credentialsNotExpired">
	<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-expiredPassword.png</s:set>
	<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.expiredPassword" /></s:set>	
</s:elseif>
<s:elseif test="!#userVar.disabled">
	<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-active.png</s:set>
	<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.active" /></s:set>
</s:elseif>

<tr>
	<td><a href="<s:url action="edit"><s:param name="username" value="#usernameVar"/></s:url>" title="<s:text name="label.edit" />: <s:property value="#usernameVar" />" ><s:property value="#userVar" /></a></td>
	<td>
		<s:if test="null != #userProfileVar"><s:property value="#userProfileVar.getValue(#userProfileVar.fullNameAttributeName)"/></s:if>
		<s:else><abbr title="<s:text name="userprofile.label.noProfile" />">&ndash;</abbr></s:else>
	</td>
	<td class="monospace"><s:if test="null != #userProfileVar">
		<s:set var="mailVar" value="#userProfileVar.getValue(#userProfileVar.mailAttributeName)" />
		<s:if test="#mailVar.length()>16"><abbr title="<s:property value="#mailVar" />"><s:property value="%{#mailVar.substring(0,8) + '...' + #mailVar.substring(#mailVar.length()-8)}" /></abbr></s:if>
		<s:else><s:property value="#mailVar"/></s:else></s:if><s:else><abbr title="<s:text name="userprofile.label.noProfile" />">&ndash;</abbr></s:else>
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
		title="<s:text name="userprofile.label.editProfile" />:&#32;<s:property value="#userProfileVar.getValue(#userProfileVar.firstNameAttributeName)"/>&#32;<s:property value="#userProfileVar.getValue(#userProfileVar.surnameAttributeName)"/>"><img src="<wp:resourceURL/>administration/common/img/icons/22x22/edit.png" alt="<s:text name="userprofile.label.editProfile" />" /></a></c:if>
	<s:if test="null != #userProfileVar"><a href="<s:url action="view" namespace="/do/userprofile"><s:param name="username" value="#usernameVar"/></s:url>"
		title="<s:text name="userprofile.label.viewProfile" />: <s:property value="#usernameVar" />"><img src="<wp:resourceURL/>administration/common/img/icons/22x22/detail.png" alt="<s:text name="userprofile.label.viewProfile" />" /></a></s:if>
	</td>
	<td class="icon"><img src="<s:property value="#statusIconImagePath" />" alt="<s:property value="#statusIconText" />" title="<s:property value="#statusIconText" />" /></td>
	<td class="icon"><a href="<s:url namespace="/do/User/Auth" action="edit"><s:param name="username" value="#usernameVar"/></s:url>" title="<s:text name="note.configureAuthorizationsFor" />: <s:property value="#usernameVar" />"><img src="<wp:resourceURL />administration/common/img/icons/authorizations.png" alt="<s:text name="note.configureAuthorizationsFor" />: <s:property value="#usernameVar" />" /></a></td>
	<td class="icon"><a href="<s:url action="trash"><s:param name="username" value="#usernameVar"/></s:url>" title="<s:text name="label.remove" />: <s:property value="#usernameVar" />"><img src="<wp:resourceURL />administration/common/img/icons/delete.png" alt="<s:text name="label.alt.clear" />" /></a></td>
</tr>
<s:set var="userVar" value="null" />
<s:set var="userProfileVar" value="null" />
</s:iterator>
</table>

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

</wpsa:subset>

</div>

</s:form>

</div>