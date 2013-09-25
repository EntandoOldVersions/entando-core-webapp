<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/aps-core" prefix="wp" %>

<s:set name="entityPrototypes" value="entityPrototypes"></s:set>

<s:if test="#entityPrototypes != null && #entityPrototypes.size() > 0">

<div class="panel panel-info">
	<div class="panel-heading">
		<h3 id="fagiano_startReloadReferences" class="panel-title"><s:text name="title.entityAdmin.entityTypes.references" /></h3>
	</div>
	<div class="panel-body">
		<s:text name="note.entityAdmin.entityTypes.references" />

		<s:set var="entityTypesReferencesStatusOk" value="%{false}" />
		<s:iterator value="#entityPrototypes" var="entityTypeTest"><s:if test="getEntityManagerStatus(entityManagerName, #entityTypeTest.typeCode) > 0"><s:set var="entityTypesReferencesStatusOk" value="%{true}" /></s:if></s:iterator>

		<s:if test="%{#entityTypesReferencesStatusOk}">
			<s:text name="note.entity.reload.references" />
			<ul>
				<s:iterator value="entityPrototypes" var="entityType" status="counter">
				<s:if test="getEntityManagerStatus(entityManagerName, #entityType.typeCode) == 1">
					<li>
						<span title="<s:text name="label.references.status.wip" />">
							<s:property value="#entityType.typeDescr"/>&#32;
							<span class="icon icon-spinner"></span>
						</span>
					</li> 
				</s:if>
				<s:elseif test="getEntityManagerStatus(entityManagerName, #entityType.typeCode) == 2">
					<li>
						<a href="<s:url namespace="/do/Entity" action="reloadEntityTypeReferences" anchor="%{#entityAnchor}"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param><s:param name="entityTypeCode"><s:property value="#entityType.typeCode" /></s:param></s:url>" title="<s:text name="label.references.status.ko" />">
						<s:property value="#entityType.typeDescr"/>&#32;<span class="icon icon-exclamation text-warning"></span>
						</a>
					</li> 
				</s:elseif>
				</s:iterator>			
			</ul>
		</s:if>
		<s:else>
			<span class="label label-info"><s:text name="note.entity.all.references.ok" /></label>
		</s:else>
	</div>
</div>
</s:if>