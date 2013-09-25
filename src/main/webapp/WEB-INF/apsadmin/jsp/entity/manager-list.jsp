<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<s:property value="%{'title.' + entityManagerName + '.management'}" />
	</span>
</h1>

<div id="main">

<p><s:text name="note.entities.intro" /></p>

<s:if test="hasFieldErrors()">
<div class="message message_error">	
<h2><s:text name="message.title.FieldErrors" /></h2>
		<ul>
			<s:iterator value="fieldErrors">
				<s:iterator value="value">
		            <li><s:property escape="false" /></li>
				</s:iterator>
			</s:iterator>
		</ul>
</div>
</s:if>

<p>
	<a href="<s:url namespace="/do/BaseAdmin" action="reloadEntitiesReferences" />"><s:text name="note.entityAdmin.entityManagers.reload" /></a>
</p>

<table class="generic" summary="<s:text name="note.entityAdmin.entityManagers.list.summary" />">
<caption><span><s:text name="title.entityAdmin.entityManagers.list" /></span></caption>
<tr>
	<th><s:text name="label.description" /></th>
	<th class="icon"><abbr title="<s:text name="label.references.long" />"><s:text name="label.references.short" /></abbr></th>
</tr>
<s:iterator value="entityManagers" var="entityManager" status="counter">
	<s:set var="entityAnchor" value="%{'entityCounter'+#counter.count}" />
	<tr>
		<td>
			<a id="<s:property value="#entityAnchor" />" href="<s:url namespace="/do/Entity" action="initViewEntityTypes" ><s:param name="entityManagerName" value="#entityManager" /></s:url>"><s:text name="%{#entityManager}.name" /></a>
		</td>
		
		<td class="icon">
<s:if test="getEntityManagerStatus(#entityManager) == 1">
			<a href="
					<s:url action="viewManagers" namespace="/do/Entity" anchor="%{#entityAnchor}" /> 
				" title="<s:text name="label.references.status.wip" />"><img src="<wp:resourceURL />administration/common/img/icons/generic-status-wip.png" alt="<s:text name="label.references.status.wip" />" /></a>
</s:if>
<s:elseif test="getEntityManagerStatus(#entityManager) == 2">
			<a href="
					<s:url action="reloadEntityManagerReferences" namespace="/do/Entity" anchor="%{#entityAnchor}">
						<s:param name="entityManagerName" value="#entityManager" />
					</s:url>
				" title="<s:text name="label.references.status.ko" />"><img src="<wp:resourceURL />administration/common/img/icons/generic-status-ko.png" alt="<s:text name="label.references.status.ko" />" /></a>	
</s:elseif>
<s:elseif test="getEntityManagerStatus(#entityManager) == 0">
			<a href="
					<s:url action="reloadEntityManagerReferences" namespace="/do/Entity" anchor="%{#entityAnchor}">
						<s:param name="entityManagerName" value="#entityManager" />
					</s:url>
				" title="<s:text name="label.references.status.ok" />"><img src="<wp:resourceURL />administration/common/img/icons/generic-status-ok.png" alt="<s:text name="label.references.status.ok" />" /></a>
</s:elseif>
		</td>
		
		<%-- 
		- -
		<a href="<s:url action="search" namespace="/do/Entity" ><s:param name="entityManagerName" value="#entityManager" /></s:url>">**RICERCA ELEMENTI**</a>
		--%>
	</tr>
</s:iterator>
</table>

</div>