<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/aps-core" prefix="wp" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="viewManagers" namespace="/do/Entity" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityManagement" />">
		<s:text name="title.entityManagement" /></a>
	</span>
</h1>

<div id="main">

<h2><a href="<s:url action="initViewEntityTypes" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityAdmin.manager" />&#32;<s:property value="entityManagerName" />"><s:text name="title.entityAdmin.manager" />: <s:property value="entityManagerName" /></a></h2>
<h3 class="margin-more-bottom"><a href="<s:url action="initEditEntityType" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param><s:param name="entityTypeCode"><s:property value="entityType.typeCode" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityTypes.editType.edit" />"><s:text name="title.entityTypes.editType.edit" />: <span class="monospace"><s:property value="entityType.typeCode" /> - <s:property value="entityType.typeDescr" /></span></a></h3>

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

<s:form action="saveAttribute">

<p class="sr-only">
	<wpsf:hidden name="attributeTypeCode" />
	<wpsf:hidden name="strutsAction" />
	<s:if test="null != attributeRoles && attributeRoles.size() > 0">
	<s:iterator value="attributeRoles" id="attributeRole"><wpsf:hidden name="attributeRoles" value="%{#attributeRole}" /></s:iterator>
	</s:if>
	<s:if test="null != disablingCodes && disablingCodes.size() > 0">
	<s:iterator value="disablingCodes" id="disablingCode"><wpsf:hidden name="disablingCodes" value="%{#disablingCode}" /></s:iterator>
	</s:if>
</p>

<s:if test="strutsAction == 2">
<p class="sr-only">
	<wpsf:hidden name="attributeName" />
</p>
</s:if>

<s:if test="strutsAction == 1">
	<s:set name="attribute" value="getAttributePrototype(attributeTypeCode)" />
</s:if>
<s:else>
	<s:set name="attribute" value="entityType.getAttribute(attributeName)" />
</s:else>

<fieldset><legend><s:text name="label.info" /></legend>
	<p>
		<label class="basic-mint-label"><s:text name="label.type" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" cssClass="text" name="attributeTypeCode" value="%{attributeTypeCode}" disabled="true" />
	</p>

	<p>
		<label for="attributeName" class="basic-mint-label"><s:text name="label.code" />:</label>
	<s:if test="strutsAction == 1">
		<wpsf:textfield useTabindexAutoIncrement="true" cssClass="text" name="attributeName" id="attributeName" />
	</s:if>
	<s:else>
		<wpsf:textfield useTabindexAutoIncrement="true" cssClass="text" name="attributeName" value="%{attributeName}" id="attributeName" disabled="true" />
	</s:else>	
	</p>
	<p>
		<label for="attributeDescription" class="basic-mint-label"><s:text name="label.description" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" name="attributeDescription" id="attributeDescription" cssClass="text"/> 
	</p>
	<p>
		<wpsf:checkbox useTabindexAutoIncrement="true" name="required" id="required" cssClass="radiocheck" /><label for="required"><s:text name="Entity.attribute.flag.mandatory.full" /></label>
	</p>

<s:if test="!(#attribute.type == 'List') && !(#attribute.type == 'Monolist')">
	
	<s:if test="isEntityManagerSearchEngineUser() && isIndexableOptionSupported(attributeTypeCode)">
	<p>
		<wpsf:checkbox useTabindexAutoIncrement="true" name="indexable" id="indexable" cssClass="radiocheck" /><label for="indexable"><s:text name="Entity.attribute.flag.indexed.full" /></label>
	</p>
	</s:if>
	
	<s:if test="isSearchableOptionSupported(attributeTypeCode)">
	<p>
		<wpsf:checkbox useTabindexAutoIncrement="true" name="searcheable" id="searcheable" cssClass="radiocheck" /><label for="searcheable"><s:text name="Entity.attribute.flag.searcheable.full" /></label>
	</p>
	</s:if>
</s:if>
</fieldset>

<fieldset><legend><s:text name="name.roles" /></legend>
	<s:set var="freeAttributeRoles" value="%{getFreeAttributeRoleNames()}" />
	<s:if test="null == #freeAttributeRoles || #freeAttributeRoles.isEmpty()">
		<p><s:text name="note.entityAdmin.entityTypes.attribute.roles.none" /></p> 
	</s:if>
	<s:else>

	<s:set name="removeIcon" id="removeIcon"><wp:resourceURL/>administration/common/img/icons/delete.png</s:set>
	
	<p>
		<label for="attributeRoleName" class="basic-mint-label"><s:text name="name.role" />:</label>
		<wpsf:select useTabindexAutoIncrement="true" name="attributeRoleName" id="attributeRoleName" list="#freeAttributeRoles" 
			listKey="name" listValue="%{name + ' - ' + description}" cssClass="text" />
		<wpsf:submit useTabindexAutoIncrement="true" action="addAttributeRole" value="%{getText('label.add')}" cssClass="button" />
	</p>

	<s:if test="null != attributeRoles && attributeRoles.size() > 0">
	<table class="generic" summary="<s:text name="note.entityAdmin.entityTypes.attribute.roles.summary" />">
	<caption><span><s:text name="name.roles" /></span></caption>
		<tr>
			<th><s:text name="label.name" /></th>
			<th><s:text name="label.description" /></th>
			<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>
		</tr>
	<s:iterator value="attributeRoles" id="attributeRole">
		<wpsa:actionParam action="removeAttributeRole" var="actionName" >
			<wpsa:actionSubParam name="attributeRoleName" value="%{#attributeRole}" />
		</wpsa:actionParam>
		<tr>
			<td class="monospace"><s:property value="attributeRole" /></td>
			<td><s:property value="%{getAttributeRole(#attributeRole).description}" /></td>
			<td><wpsf:submit useTabindexAutoIncrement="true" action="%{#actionName}" type="image" src="%{#removeIcon}" value="%{getText('label.remove')}" title="%{getText('label.remove')}" /></td>
		</tr>
	</s:iterator>
	</table>
	</s:if>
	
	</s:else>
</fieldset>

<s:set var="attributeDisablingCodesVar" value="getAttributeDisablingCodes()" ></s:set>
<s:set name="removeIcon" id="removeIcon"><wp:resourceURL/>administration/common/img/icons/delete.png</s:set>

<s:if test="null != #attributeDisablingCodesVar && #attributeDisablingCodesVar.size()>0">
<fieldset><legend><s:text name="name.disablingCodes" /></legend>
	<p>
		<label for="disablingCode" class="basic-mint-label"><s:text name="label.code" />:</label>
		<wpsf:select useTabindexAutoIncrement="true" name="disablingCode" id="disablingCode" list="#attributeDisablingCodesVar" />
		<wpsf:submit useTabindexAutoIncrement="true" action="addAttributeDisablingCode" value="%{getText('label.add')}" cssClass="button" />
	</p>
	
	<s:if test="null != disablingCodes && disablingCodes.size() > 0">
	<table class="generic" summary="<s:text name="note.entityAdmin.entityTypes.attribute.disablingCodes.summary" />">
	<caption><span><s:text name="name.disablingCodes" /></span></caption>
		<tr>
			<th><s:text name="label.name" /></th>
			<th><s:text name="label.description" /></th>
			<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>
		</tr>
	<s:iterator value="disablingCodes" id="disablingCode">
		<wpsa:actionParam action="removeAttributeDisablingCode" var="actionName" >
			<wpsa:actionSubParam name="attributeRoleName" value="%{#disablingCode}" />
		</wpsa:actionParam>
		<tr>
			<td class="monospace"><s:property value="#disablingCode" /></td>
			<td><s:property value="%{#attributeDisablingCodesVar[#disablingCode]}" /></td>
			<td><wpsf:submit useTabindexAutoIncrement="true" action="%{#actionName}" type="image" src="%{#removeIcon}" value="%{getText('label.remove')}" title="%{getText('label.remove')}" /></td>
		</tr>
	</s:iterator>
	</table>
	</s:if>
	
</fieldset>
</s:if>

<s:if test="#attribute.textAttribute">
<s:include value="/WEB-INF/apsadmin/jsp/entity/include/validation-rules-text.jsp" />
</s:if>

<s:elseif test="#attribute.type == 'Number'">
<s:include value="/WEB-INF/apsadmin/jsp/entity/include/validation-rules-number.jsp" />
</s:elseif>

<s:elseif test="#attribute.type == 'Date'">
<s:include value="/WEB-INF/apsadmin/jsp/entity/include/validation-rules-date.jsp" />
</s:elseif>

<s:if test="#attribute.type == 'List' || #attribute.type == 'Monolist'">
<fieldset><legend><s:text name="label.settings" /></legend>
<p>
	<label for="listNestedType" class="basic-mint-label"><s:text name="Entity.attribute.setting.listType" />:</label>	
	<wpsf:select useTabindexAutoIncrement="true" list="getAllowedNestedTypes(#attribute)" name="listNestedType" id="listNestedType" listKey="type" listValue="type" />
</p>
</fieldset>
</s:if>

<s:include value="/WEB-INF/apsadmin/jsp/entity/include/validation-rules-ognl.jsp" />

<p class="centerText">
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.continue')}" cssClass="button" />
</p>

</s:form>

</div>