<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/aps-core" prefix="wp" %>

<s:set name="entityPrototypes" value="entityPrototypes"></s:set>

<s:if test="#entityPrototypes != null && #entityPrototypes.size() > 0">

<h3 id="fagiano_startReloadReferences"><s:text name="title.entityAdmin.entityTypes.references" /></h3>

<p>
	<s:text name="note.entityAdmin.entityTypes.references" />
</p>

<s:set var="entityTypesReferencesStatusOk" value="%{false}" />
<s:iterator value="#entityPrototypes" var="entityTypeTest"><s:if test="getEntityManagerStatus(entityManagerName, #entityTypeTest.typeCode) > 0"><s:set var="entityTypesReferencesStatusOk" value="%{true}" /></s:if></s:iterator>

<s:if test="%{#entityTypesReferencesStatusOk}">
	<p><s:text name="note.entity.reload.references" /></p>
	<ul>
		<s:iterator value="entityPrototypes" var="entityType" status="counter">
			<s:if test="getEntityManagerStatus(entityManagerName, #entityType.typeCode) == 1">
				<li><a href="<s:url namespace="/do/Entity" action="initViewEntityTypes" anchor="%{#entityAnchor}"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>" title="<s:text name="label.references.status.wip" />"><s:property value="#entityType.typeDescr"/>&#32;<img src="<wp:resourceURL />administration/common/img/icons/generic-status-wip.png" alt="<s:text name="label.references.status.wip" />" /></a></li> 
			</s:if>
			<s:elseif test="getEntityManagerStatus(entityManagerName, #entityType.typeCode) == 2">
				<li><a href="<s:url namespace="/do/Entity" action="reloadEntityTypeReferences" anchor="%{#entityAnchor}"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param><s:param name="entityTypeCode"><s:property value="#entityType.typeCode" /></s:param></s:url>" title="<s:text name="label.references.status.ko" />"><s:property value="#entityType.typeDescr"/>&#32;<img src="<wp:resourceURL />administration/common/img/icons/generic-status-ko.png" alt="<s:text name="label.references.status.ko" />" /></a></li> 
			</s:elseif>
		</s:iterator>			
	</ul>
</s:if>
<s:else>
	<p><s:text name="note.entity.all.references.ok" /></p>
</s:else>

</s:if>