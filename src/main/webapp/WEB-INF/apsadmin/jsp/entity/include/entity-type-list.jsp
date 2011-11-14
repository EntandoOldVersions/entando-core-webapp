<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<h2><s:text name="title.entityAdmin.manager" />: <s:property value="entityManagerName" /></h2>

<p><s:text name="note.entityTypes.intro.1" /></p>
<p><s:text name="note.entityTypes.intro.2" /></p>

	<s:if test="hasFieldErrors()">
<div class="message message_error">	
<h3><s:text name="message.title.FieldErrors" /></h3>
		<ul>
			<s:iterator value="fieldErrors">
				<s:iterator value="value">
		            <li><s:property escape="false" /></li>
				</s:iterator>
			</s:iterator>
		</ul>
</div>
	</s:if>

<p><a href="<s:url namespace="/do/Entity" action="initAddEntityType" ><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>"><s:text name="menu.entityAdmin.entityTypes.new" /></a></p>

<s:if test="%{entityPrototypes.size > 0}">

<table class="generic" summary="<s:text name="note.entityAdmin.entityTypes.list.summary" />">
<caption><span><s:text name="title.entityAdmin.entityTypes.list" /></span></caption>
	<tr>
		<th class="tinyColumn60"><s:text name="label.code" /></th>
		<th><s:text name="label.description" /></th>
		<th class="icon"><abbr title="<s:text name="label.references.long" />"><s:text name="label.references.short" /></abbr></th>
		<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>
	</tr> 

	<s:iterator value="entityPrototypes" var="entityType" status="counter">
	<s:set var="entityAnchor" value="%{'entityCounter'+#counter.count}" />
	<tr>
		<td class="centerText tinyColumn60"><span class="monospace"><s:property value="#entityType.typeCode" /></span></td>
		<td><a id="<s:property value="#entityAnchor" />" href="
				<s:url namespace="/do/Entity" action="initEditEntityType">
					<s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param>
					<s:param name="entityTypeCode"><s:property value="#entityType.typeCode" /></s:param>
				</s:url>
			" title="<s:text name="label.edit" />: <s:property value="#entityType.typeDescr" />"><s:property value="#entityType.typeDescr" /></a>
		</td>
		<td class="icon">
<s:if test="getEntityManagerStatus(entityManagerName, #entityType.typeCode) == 1">
			<a href="
					<s:url namespace="/do/Entity" action="initViewEntityTypes" anchor="%{#entityAnchor}"> 
						<s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param>
					</s:url> 
				" title="<s:text name="label.references.status.wip" />"><img src="<wp:resourceURL />administration/common/img/icons/generic-status-wip.png" alt="<s:text name="label.references.status.wip" />" /></a> 
</s:if>
<s:elseif test="getEntityManagerStatus(entityManagerName, #entityType.typeCode) == 2">
			<a href="
				<s:url namespace="/do/Entity" action="reloadEntityTypeReferences" anchor="%{#entityAnchor}">
					<s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param>
					<s:param name="entityTypeCode"><s:property value="#entityType.typeCode" /></s:param>
				</s:url>
				" title="<s:text name="label.references.status.ko" />"><img src="<wp:resourceURL />administration/common/img/icons/generic-status-ko.png" alt="<s:text name="label.references.status.ko" />" /></a> 
</s:elseif>
<s:elseif test="getEntityManagerStatus(entityManagerName, #entityType.typeCode) == 0">
			<a href="
				<s:url namespace="/do/Entity" action="reloadEntityTypeReferences" anchor="%{#entityAnchor}">
					<s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param>
					<s:param name="entityTypeCode"><s:property value="#entityType.typeCode" /></s:param>
				</s:url>
				" title="<s:text name="label.references.status.ok" />"><img src="<wp:resourceURL />administration/common/img/icons/generic-status-ok.png" alt="<s:text name="label.references.status.ok" />" /></a>				
</s:elseif>

		</td>	
		<td class="icon">
			<a href="
				<s:url namespace="/do/Entity" action="trashEntityType">
					<s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param>
					<s:param name="entityTypeCode"><s:property value="#entityType.typeCode" /></s:param>
				</s:url>
			" title="<s:text name="label.remove" />: <s:property value="#entityType.typeDescr" />"><img src="<wp:resourceURL />administration/common/img/icons/delete.png" alt="<s:text name="label.alt.clear" />" /></a> 
		</td>
	</tr>
	</s:iterator>
</table>

</s:if>
<s:else>
	<p><s:text name="note.entityTypes.modelList.empty" /></p> 
</s:else>

<s:include value="/WEB-INF/apsadmin/jsp/entity/include/entity-type-references-operations-reload.jsp" />