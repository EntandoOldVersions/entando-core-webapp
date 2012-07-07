<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h3><s:text name="title.userManagement.userList" /></h3>

<s:if test="hasActionErrors()">
<div class="message message_error">
<h4><s:text name="message.title.ActionErrors" /></h4>
	<ul>
		<s:iterator value="actionErrors">
			<li><s:property escape="false" /></li>
		</s:iterator>
	</ul>
</div>	
</s:if>

<s:if test="hasFieldErrors()">
<div class="message message_error">
<h4><s:text name="message.title.ActionErrors" /></h4>
	<ul>
		<s:iterator value="fieldErrors">
			<li><s:property escape="false" /></li>
		</s:iterator>
	</ul>
</div>
</s:if>

<s:form>
<p class="noscreen">
	<wpsf:hidden name="text" />
	<wpsf:hidden name="authName" />
</p>

<s:set name="removeIcon" id="removeIcon"><wp:resourceURL/>administration/common/img/icons/list-remove.png</s:set>

<s:set var="authorizedUsersVar" value="authorizedUsers" />

<s:if test="%{#authorizedUsersVar.size() > 0}">
<ul>
<s:iterator id="user" value="#authorizedUsersVar">
	<li>
		<wpsa:actionParam action="removeUser" var="actionName" >
			<wpsa:actionSubParam name="username" value="%{#user.username}" />
		</wpsa:actionParam>
		<wpsf:submit useTabindexAutoIncrement="true" action="%{#actionName}" type="image" src="%{#removeIcon}" value="%{getText('label.remove')}" title="%{getText('label.remove')}" />: <s:property value="#user" />
	</li>
</s:iterator>
</ul>
</s:if>

</s:form>

<s:form action="search">

<h4><s:text name="title.userManagement.searchUsers" /></h4>
<p class="noscreen">
	<wpsf:hidden name="authName" />
</p>
<p><label for="text" class="basic-mint-label label-search"><s:text name="label.search.by"/>&#32;<s:text name="label.username"/>:</label>
<wpsf:textfield useTabindexAutoIncrement="true" name="text" id="text" cssClass="text" /></p>
<p>
	<wpsf:submit useTabindexAutoIncrement="true" action="search" value="%{getText('label.search')}" cssClass="button" />
</p>

</s:form>

<s:form action="search">
<p class="noscreen">
	<wpsf:hidden name="text" />
	<wpsf:hidden name="authName" />
</p>
<div class="subsection-light">
	
<wpsa:subset source="users" count="10" objectName="groupUser" advanced="true" offset="5">
<s:set name="group" value="#groupUser" />

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

<table class="generic" summary="<s:text name="note.configAuthority.summary" />">
<caption><span><s:text name="title.userManagement.userList" /></span></caption>
<tr>
	<th><s:text name="label.username" /></th>
	<th><s:text name="label.date.registration" /></th>
	<th><s:text name="label.date.lastLogin" /></th>
	<th><s:text name="label.date.lastPasswordChange" /></th>
	<th class="icon"><abbr title="<s:text name="label.state" />">S</abbr></th>	
</tr>
<s:iterator id="user">

<s:if test="!#user.japsUser">
	<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-notjAPSUser.png</s:set>
	<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.notjAPSUser" /></s:set>
</s:if>
<s:elseif test="#user.disabled">
	<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-notActive.png</s:set>
	<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.notActive" /></s:set>	
</s:elseif>
<s:elseif test="!#user.accountNotExpired">
	<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-expiredAccount.png</s:set>
	<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.expiredAccount" /></s:set>	
</s:elseif>
<s:elseif test="!#user.credentialsNotExpired">
	<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-expiredPassword.png</s:set>
	<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.expiredPassword" /></s:set>	
</s:elseif>
<s:elseif test="!#user.disabled">
	<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-active.png</s:set>
	<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.active" /></s:set>
</s:elseif>

<tr>
	<td><input type="radio" name="username" id="<s:property value="#user.username" />" value="<s:property value="#user.username"/>" /><label for="<s:property value="#user.username" />"><s:property value="#user" /></label></td>
	<td class="centerText monospace">
		<s:if test="#user.japsUser">
			<s:date name="#user.creationDate" format="dd/MM/yyyy" />
		</s:if>
		<s:else><abbr title="<s:text name="label.none" />">&ndash;</abbr></s:else>
	</td>
	<td class="centerText monospace">
		<s:if test="#user.japsUser && #user.lastAccess != null">
			<s:date name="#user.lastAccess" format="dd/MM/yyyy" />
		</s:if>
		<s:else><abbr title="<s:text name="label.none" />">&ndash;</abbr></s:else>
	</td>
	<td class="centerText monospace">
		<s:if test="#user.japsUser && #user.lastPasswordChange != null">
			<s:date name="#user.lastPasswordChange" format="dd/MM/yyyy" />
		</s:if>
		<s:else><abbr title="<s:text name="label.none" />">&ndash;</abbr></s:else>
	</td>
	<td class="icon"><img src="<s:property value="#statusIconImagePath" />" alt="<s:property value="#statusIconText" />" title="<s:property value="#statusIconText" />" /></td>
</tr>
</s:iterator>
</table>

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

</wpsa:subset>

<p><wpsf:submit useTabindexAutoIncrement="true" action="addUser" value="%{getText('label.add')}" cssClass="button" /></p>

</div>

</s:form>