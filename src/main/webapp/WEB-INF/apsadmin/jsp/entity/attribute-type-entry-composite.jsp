<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="initViewEntityTypes" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityAdmin.manager" />&#32;<s:property value="entityManagerName" />">
		<s:text name="%{'title.' + entityManagerName + '.management'}" />
		</a>
	</span>
</h1>
<div id="main">

<h3><a href="<s:url action="initEditEntityType" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param><s:param name="entityTypeCode"><s:property value="entityType.typeCode" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityTypes.editType.edit" />"><s:text name="title.entityTypes.editType.edit" />: <span class="monospace"><s:property value="entityType.typeCode" /> - <s:property value="entityType.typeDescr" /></span></a></h3>

<s:form action="saveCompositeAttribute">

<s:if test="hasFieldErrors()">
<div class="message message_error">	
<h4><s:text name="message.title.FieldErrors" /></h4>
		<ul>
			<s:iterator value="fieldErrors">
				<s:iterator value="value">
		            <li><s:property escape="false" /></li>
				</s:iterator>
			</s:iterator>
		</ul>
</div>
</s:if>

<s:set name="listAttribute" value="listAttribute" />
<s:set name="compositeAttribute" value="compositeAttributeOnEdit" />

<p><s:text name="note.workingOnAttribute" />:&#32;

<s:if test="null != #listAttribute"><span class="monospace"><s:property value="#compositeAttribute.type" /></span>,&#32;<s:text name="note.workingOnAttributeIn" />&#32;<span class="monospace"><s:property value="#listAttribute.name" /> (<s:property value="#listAttribute.type" />)</span></s:if>

<s:else><span class="monospace"><s:property value="#compositeAttribute.name" /></span></s:else>
</p>

<fieldset class="margin-more-top"><legend><s:text name="label.info" /></legend>
	<p>
		<label for="compositeAttribute.type" class="basic-mint-label"><s:text name="label.type" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" cssClass="text" id="compositeAttribute.type" name="compositeAttribute.type" value="%{#compositeAttribute.type}" disabled="true" />
	</p>

</fieldset>

<fieldset><legend><s:text name="label.attributes" /></legend>

	<p>
		<label for="attributeTypeCode" class="basic-mint-label"><s:text name="label.type" />:</label>
		<wpsf:select useTabindexAutoIncrement="true" list="allowedAttributeElementTypes" id="attributeTypeCode" name="attributeTypeCode" listKey="type" listValue="type"/>
		<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.add')}" action="addAttributeElement" cssClass="button" />
	</p>

<s:if test="#compositeAttribute.attributes.size > 0">
	<table class="generic" summary="<s:text name="note.entityAdmin.compositeAttribute.list.summary" />" id="fagiano_compositeTypesList">
	<caption><span><s:text name="label.attributes" /></span></caption>
	<tr>
		<th><s:text name="label.code" /></th>
		<th><s:text name="label.type" /></th>
		<th class="icon"><abbr title="<s:text name="Entity.attribute.flag.mandatory.full" />"><s:text name="Entity.attribute.flag.mandatory.short" /></abbr></th>
		<th class="icon" colspan="3"><abbr title="<s:text name="label.actions" />">&ndash;</abbr></th>
	</tr>

<s:iterator value="#compositeAttribute.attributes" var="attribute" status="elementStatus">
	<tr>
		<td class="monospace"><s:property value="#attribute.name" /></td>
 		<td class="monospace"><s:property value="#attribute.type" /></td>
 		
		<s:if test="#attribute.required">
			<s:set var="tmpStatus">yes</s:set>
		</s:if>
		<s:else>
			<s:set var="tmpStatus">no</s:set>
		</s:else>
		<td class="icon"><img src="<wp:resourceURL />administration/common/img/icons/<s:property value="#attribute.required" />.png" alt="<s:text name="label.%{#tmpStatus}" />" title="<s:text name="label.%{#tmpStatus}" />" /></td>
 		
		<s:set name="elementIndex" value="#elementStatus.index" />
		<s:include value="/WEB-INF/apsadmin/jsp/entity/include/attribute-operations-misc-composite.jsp" />
	</tr>
</s:iterator>

	</table>
</s:if>
</fieldset>

<p class="centerText">
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" action="saveCompositeAttribute" cssClass="button" />
</p>

</s:form>
</div>