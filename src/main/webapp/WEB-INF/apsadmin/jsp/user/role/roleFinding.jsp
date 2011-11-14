<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<s:set var="targetNS" value="%{'/do/Role'}" />
<h1><s:text name="title.roleManagement" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

<div id="main">

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

<table class="generic" summary="<s:text name="note.roleList.summary" />">
<caption><span><s:text name="title.roleManagement.roleList" /></span></caption>
<tr>
	<th><s:text name="name.role" /></th>
	<th><s:text name="label.description" /></th>	
	<th class="icon"><abbr title="<s:text name="label.users" />">U</abbr></th>
	<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>
</tr>
<s:iterator id="role" value="roles">
<tr>
	<td><a href="<s:url action="edit"><s:param name="name" value="#role.name"/></s:url>" ><s:property value="#role.name" /></a></td>
 	<td><s:property value="#role.description" /></td>
	<td class="icon"><a href="<s:url namespace="/do/Role/Auth" action="config"><s:param name="authName" value="#role.name"/></s:url>" title="<s:text name="note.assignToUsers" />: <s:property value="#role.name" />"><img src="<wp:resourceURL />administration/common/img/icons/users.png" alt="<s:text name="note.assignToUsers" />: <s:property value="#role.name" />" /></a></td>
	<td class="icon"><a href="<s:url action="trash"><s:param name="name" value="#role.name"/></s:url>"  title="<s:text name="label.remove" />: <s:property value="#role.name" />"><img src="<wp:resourceURL />administration/common/img/icons/delete.png" alt="<s:text name="label.alt.clear" />" /></a></td>
</tr>
</s:iterator>
</table>

</div>