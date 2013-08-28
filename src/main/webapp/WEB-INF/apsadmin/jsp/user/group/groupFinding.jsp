<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<h1 class="panel panel-default title-page"><span class="panel-body display-block"><s:text name="title.groupManagement" /></span></h1>

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

<s:if test="%{groups.size > 0}">
	<table class="generic" summary="<s:text name="note.groupList.summary" />">
	<caption><span><s:text name="title.groupManagement.groupList" /></span></caption>
	<tr>
		<th><s:text name="label.group" /></th>
		<th><s:text name="label.description" /></th>	
		<th class="icon"><abbr title="<s:text name="label.detail" />">D</abbr></th>
		<th class="icon"><abbr title="<s:text name="label.users" />">U</abbr></th>
		<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>	
	</tr>
	<s:iterator id="group" value="groups">
	<tr>
		<td>
			<a href="<s:url action="edit"><s:param name="name" value="#group.name"/></s:url>" ><s:property value="#group.name" /></a>
		</td>
		<td><s:property value="#group.descr" /></td>
		<td class="icon"><a href="<s:url action="detail"><s:param name="name" value="#group.name"/></s:url>" title="<s:text name="note.detailsFor" />: <s:property value="#group.name" />"><img src="<wp:resourceURL />administration/common/img/icons/22x22/detail.png" alt="<s:text name="note.detailsFor" />: <s:property value="#group.name" />" /></a></td>
		<td class="icon"><a href="<s:url namespace="/do/Group/Auth" action="config"><s:param name="authName" value="#group.name"/></s:url>" title="<s:text name="note.manageUsersFor" />: <s:property value="#group.name" />"><img src="<wp:resourceURL />administration/common/img/icons/users.png" alt="<s:text name="note.manageUsersFor" />: <s:property value="#group.name" />" /></a></td>
		<td class="icon"><a href="<s:url action="trash"><s:param name="name" value="#group.name"/></s:url>"  title="<s:text name="label.remove" />: <s:property value="#group.name" />"><img src="<wp:resourceURL />administration/common/img/icons/delete.png" alt="<s:text name="label.alt.clear" />" /></a></td>
	</tr>
	</s:iterator>
	</table>
</s:if>
<s:else>
	<p>
		<s:text name="noGroups.found" />
	</p>
</s:else>

</div>