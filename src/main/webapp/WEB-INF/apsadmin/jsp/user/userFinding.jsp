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

<p><label for="text" class="basic-mint-label label-search"><s:text name="label.search.by"/>&#32;<s:text name="label.username"/>:</label>
<wpsf:textfield useTabindexAutoIncrement="true" name="text" id="text" cssClass="text" /></p>

<p>
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.search')}" cssClass="button" />
</p>

<div class="subsection-light">

<wpsa:subset source="users" count="10" objectName="groupUser" advanced="true" offset="5">
<s:set name="group" value="#groupUser" />

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

<table class="generic" summary="<s:text name="note.userList.summary" />">
<caption><span><s:text name="title.userManagement.userList" /></span></caption>
<tr>
	<th><s:text name="label.username" /></th>
	
	<th><s:text name="label.date.registration" /></th>
	<th><s:text name="label.date.lastLogin" /></th>
	<th><s:text name="label.date.lastPasswordChange" /></th>
<wpsa:hookPoint key="core.userFinding.list.table.th" objectName="hookPointElements_core_userFinding_list_table_th">
<s:iterator value="#hookPointElements_core_userFinding_list_table_th" var="hookPointElement">
	<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
</s:iterator>
</wpsa:hookPoint>
	<th class="icon"><abbr title="<s:text name="label.state" />">S</abbr></th>	
	<th class="icon"><abbr title="<s:text name="label.authorizations" />">A</abbr></th>	
	<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>	
</tr>
<s:iterator id="user">

<s:if test="!#user.japsUser">
	<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-notjAPSUser.png</s:set>
	<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.notEntandoUser" /></s:set>
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
	<td><a href="<s:url action="edit"><s:param name="username" value="#user.username"/></s:url>" title="<s:text name="label.edit" />: <s:property value="#user.username" />" ><s:property value="#user" /></a></td>
	
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
<wpsa:hookPoint key="core.userFinding.list.table.td" objectName="hookPointElements_core_userFinding_list_table_td">
<s:iterator value="#hookPointElements_core_userFinding_list_table_td" var="hookPointElement">
	<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
</s:iterator>
</wpsa:hookPoint>
	<td class="icon"><img src="<s:property value="#statusIconImagePath" />" alt="<s:property value="#statusIconText" />" title="<s:property value="#statusIconText" />" /></td>
	<td class="icon"><a href="<s:url namespace="/do/User/Auth" action="edit"><s:param name="username" value="#user.username"/></s:url>" title="<s:text name="note.configureAuthorizationsFor" />: <s:property value="#user.username" />"><img src="<wp:resourceURL />administration/common/img/icons/authorizations.png" alt="<s:text name="note.configureAuthorizationsFor" />: <s:property value="#user.username" />" /></a></td>
	<td class="icon"><a href="<s:url action="trash"><s:param name="username" value="#user.username"/></s:url>" title="<s:text name="label.remove" />: <s:property value="#user.username" />"><img src="<wp:resourceURL />administration/common/img/icons/delete.png" alt="<s:text name="label.alt.clear" />" /></a></td>
</tr>
</s:iterator>
</table>

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

</wpsa:subset>

</div>

</s:form>

</div>