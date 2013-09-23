<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="viewManagers" namespace="/do/Entity" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityManagement" />">
			<s:text name="title.entityAdmin.manage" /></a>&#32;/&#32;
		<s:text name="title.entityAdmin.manager" />: <code><s:property value="entityManagerName" /></code>
	</span>
</h1>

<div class="panel panel-default">
	<div class="panel-body">
		<s:text name="note.entityTypes.intro.1" />
		<s:text name="note.entityTypes.intro.2" />
	</div>
</div>

<s:if test="hasFieldErrors()">
	<div class="alert alert-danger alert-dismissable">
		<button type="button" class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
		<p><s:text name="message.title.FieldErrors" /></p>
		<ul>
			<s:iterator value="fieldErrors">
				<s:iterator value="value">
		            <li><s:property escape="false" /></li>
				</s:iterator>
			</s:iterator>
		</ul>
	</div>
</s:if>

<a href="<s:url namespace="/do/Entity" action="initAddEntityType" ><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>" class="btn btn-default">
<span class="icon icon-plus-sign"></span>&#32;
<s:text name="menu.entityAdmin.entityTypes.new" />
</a>

<s:if test="%{entityPrototypes.size > 0}">
<div class="table-responsive">
<table class="table table-bordered" summary="<s:text name="note.entityAdmin.entityTypes.list.summary" />">
<caption><s:text name="title.entityAdmin.entityTypes.list" /></caption>
	<tr>
		<th class="text-center padding-large-left padding-large-right col-xs-4 col-sm-3 col-md-2 col-lg-2"><abbr title="<s:text name="label.actions" />">&ndash;</abbr></th>
		<th class="text-right"><s:text name="label.code" /></th>
		<th><s:text name="label.description" /></th>
		<th class="text-center"><abbr title="<s:text name="label.references.long" />"><s:text name="label.references.short" /></abbr></th>
	</tr> 

	<s:iterator value="entityPrototypes" var="entityType" status="counter">
	<s:set var="entityAnchor" value="%{'entityCounter'+#counter.count}" />
	<tr>
		<td class="text-center text-nowrap">
			<div class="btn-group btn-group-xs">
				<%-- edit --%>
				<a class="btn btn-default" id="<s:property value="#entityAnchor" />" href="
				<s:url namespace="/do/Entity" action="initEditEntityType">
					<s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param>
					<s:param name="entityTypeCode"><s:property value="#entityType.typeCode" /></s:param>
				</s:url>
				" title="<s:text name="label.edit" />: <s:property value="#entityType.typeDescr" />">
					<span class="sr-only"><s:text name="label.edit" />&#32;<s:property value="#entityType.typeDescr" /></span>
					<span class="icon icon-edit"></span>
				</a>
			</div>
			<%-- remove --%>
			<div class="btn-group btn-group-xs">
			<a href="
				<s:url namespace="/do/Entity" action="trashEntityType">
					<s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param>
					<s:param name="entityTypeCode"><s:property value="#entityType.typeCode" /></s:param>
				</s:url>
				" title="<s:text name="label.remove" />: <s:property value="#entityType.typeDescr" />" class="btn btn-warning">
				<span class="icon icon-remove-circle"></span>&#32;
				<span class="sr-only"><s:text name="label.alt.clear" /></span>
				</a>
			</div>
		</td>
		<td class="text-right text-nowrap">
			<code><s:property value="#entityType.typeCode" /></code>
		</td>
		<td><s:property value="#entityType.typeDescr" /></td>
		<th class="text-center">
		<s:if test="getEntityManagerStatus(entityManagerName, #entityType.typeCode) == 1">
			<a href="
					<s:url namespace="/do/Entity" action="initViewEntityTypes" anchor="%{#entityAnchor}"> 
						<s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param>
					</s:url> 
				" title="<s:text name="label.references.status.wip" />"><s:text name="label.references.status.wip" /></a> 
		</s:if>
		<s:elseif test="getEntityManagerStatus(entityManagerName, #entityType.typeCode) == 2">
			<a href="
				<s:url namespace="/do/Entity" action="reloadEntityTypeReferences" anchor="%{#entityAnchor}">
					<s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param>
					<s:param name="entityTypeCode"><s:property value="#entityType.typeCode" /></s:param>
				</s:url>
				" title="<s:text name="label.references.status.ko" />"><s:text name="label.references.status.ko" /></a> 
		</s:elseif>
		<s:elseif test="getEntityManagerStatus(entityManagerName, #entityType.typeCode) == 0">
			<a href="
				<s:url namespace="/do/Entity" action="reloadEntityTypeReferences" anchor="%{#entityAnchor}">
					<s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param>
					<s:param name="entityTypeCode"><s:property value="#entityType.typeCode" /></s:param>
				</s:url>
				" title="<s:text name="label.references.status.ok" />">
				<span class="btn btn-default btn-xs" title="<s:text name="label.references.status.ok" />">
				<span class="icon icon-ok text-success">
				<span class="sr-only"><s:text name="label.references.status.ok" /></span>
				</span>
				</span>
				</a>				
		</s:elseif>

		</td>	
	</tr>
	</s:iterator>
</table>
</div>
</s:if>
<s:else>
	<p><s:text name="note.entityTypes.modelList.empty" /></p> 
</s:else>

<s:include value="/WEB-INF/apsadmin/jsp/entity/include/entity-type-references-operations-reload.jsp" />