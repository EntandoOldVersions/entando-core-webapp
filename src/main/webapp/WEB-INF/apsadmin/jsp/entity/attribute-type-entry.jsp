<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/aps-core" prefix="wp" %>


<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<s:property value="%{'title.' + entityManagerName + '.management'}" />&#32;/&#32;
		<a href="<s:url action="initEditEntityType" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param><s:param name="entityTypeCode"><s:property value="entityType.typeCode" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityTypes.editType.edit" />"><s:text name="title.entityTypes.editType.edit" />: <code><s:property value="entityType.typeCode" /> - <s:property value="entityType.typeDescr" /></code></a>
	</span>
</h1>

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

<s:form action="saveAttribute">

<p class="sr-only">
	<s:hidden name="attributeTypeCode" />
	<s:hidden name="strutsAction" />
	<s:if test="null != attributeRoles && attributeRoles.size() > 0">
	<s:iterator value="attributeRoles" id="attributeRole"><s:hidden name="attributeRoles" value="%{#attributeRole}" /></s:iterator>
	</s:if>
	<s:if test="null != disablingCodes && disablingCodes.size() > 0">
	<s:iterator value="disablingCodes" id="disablingCode"><s:hidden name="disablingCodes" value="%{#disablingCode}" /></s:iterator>
	</s:if>
</p>

<s:if test="strutsAction == 2">
	<p class="sr-only">
		<s:hidden name="attributeName" />
	</p>
</s:if>

<s:if test="strutsAction == 1">
	<s:set name="attribute" value="getAttributePrototype(attributeTypeCode)" />
</s:if>
<s:else>
	<s:set name="attribute" value="entityType.getAttribute(attributeName)" />
</s:else>

<fieldset class="col-xs-12"><legend><s:text name="label.info" /></legend>
	<div class="form-group">
		<label><s:text name="label.type" /></label>
		<wpsf:textfield cssClass="form-control" name="attributeTypeCode" value="%{attributeTypeCode}" disabled="true" />
	</div>

	<div class="form-group">
		<label for="attributeName"><s:text name="label.code" /></label>
		<s:if test="strutsAction == 1">
			<wpsf:textfield cssClass="form-control" name="attributeName" id="attributeName" />
		</s:if>
		<s:else>
			<wpsf:textfield cssClass="form-control" name="attributeName" value="%{attributeName}" id="attributeName" disabled="true" />
		</s:else>	
	</div>
	<div class="form-group">
		<label for="attributeDescription"><s:text name="label.description" /></label>
		<wpsf:textfield name="attributeDescription" id="attributeDescription" cssClass="form-control"/> 
	</div>

	<ul>
		<li class="checkbox">
			<label for="required"><s:text name="Entity.attribute.flag.mandatory.full" />
			<wpsf:checkbox name="required" id="required" cssClass="radiocheck" /></label>
		</li>
		<s:if test="!(#attribute.type == 'List') && !(#attribute.type == 'Monolist')">
			
			<s:if test="isEntityManagerSearchEngineUser() && isIndexableOptionSupported(attributeTypeCode)">
			<li class="checkbox">
				<label for="indexable"><s:text name="Entity.attribute.flag.indexed.full" />
				<wpsf:checkbox name="indexable" id="indexable" cssClass="radiocheck" /></label>
			</li>
			</s:if>
			
			<s:if test="isSearchableOptionSupported(attributeTypeCode)">
			<li class="checkbox">
				<label for="searcheable"><s:text name="Entity.attribute.flag.searcheable.full" /><wpsf:checkbox name="searcheable" id="searcheable" cssClass="radiocheck" /></label>
			</li>
			</s:if>

		</s:if>
	</ul>
</fieldset>

<fieldset class="col-xs-12"><legend><s:text name="name.roles" /></legend>
	<s:set var="freeAttributeRoles" value="%{getFreeAttributeRoleNames()}" />
	<s:if test="null == #freeAttributeRoles || #freeAttributeRoles.isEmpty()">
		<p><s:text name="note.entityAdmin.entityTypes.attribute.roles.none" /></p> 
	</s:if>
	<s:else>

		<div class="form-group">
			<label for="attributeRoleName"><s:text name="name.role" />:</label>
			<wpsf:select name="attributeRoleName" id="attributeRoleName" list="#freeAttributeRoles" 
				listKey="name" listValue="%{name + ' - ' + description}" cssClass="text" />
			<wpsf:submit action="addAttributeRole" value="%{getText('label.add')}" cssClass="button" />
		</div>

		<s:if test="null != attributeRoles && attributeRoles.size() > 0">
		<table class="generic">
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
				<td><wpsf:submit action="%{#actionName}" type="button" value="%{getText('label.remove')}" title="%{getText('label.remove')}" /></td>
			</tr>
		</s:iterator>
		</table>
		</s:if>
	
	</s:else>
</fieldset>

<s:set var="attributeDisablingCodesVar" value="getAttributeDisablingCodes()" ></s:set>

<s:if test="null != #attributeDisablingCodesVar && #attributeDisablingCodesVar.size()>0">
<fieldset class="col-xs-12"><legend><s:text name="name.disablingCodes" /></legend>
	<div class="form-group">
		<label for="disablingCode"><s:text name="label.code" />:</label>
		<wpsf:select name="disablingCode" id="disablingCode" list="#attributeDisablingCodesVar" />
		<wpsf:submit action="addAttributeDisablingCode" value="%{getText('label.add')}" cssClass="button" />
	</div>
	
	<s:if test="null != disablingCodes && disablingCodes.size() > 0">
	<table class="generic">
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
				<td><wpsf:submit action="%{#actionName}" value="%{getText('label.remove')}" title="%{getText('label.remove')}" /></td>
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
<fieldset class="col-xs-12"><legend><s:text name="label.settings" /></legend>
<div class="form-group">
	<label for="listNestedType"><s:text name="Entity.attribute.setting.listType" />:</label>	
	<wpsf:select list="getAllowedNestedTypes(#attribute)" name="listNestedType" id="listNestedType" listKey="type" listValue="type" />
</div>
</fieldset>
</s:if>

<s:include value="/WEB-INF/apsadmin/jsp/entity/include/validation-rules-ognl.jsp" />

<p class="centerText">
	<wpsf:submit value="%{getText('label.continue')}" cssClass="button" />
</p>
<div class="form-group">
  <div class="col-xs-12 col-sm-4 col-md-3 margin-small-vertical">
    <s:submit type="button" cssClass="btn btn-primary btn-block">
      <s:text name="label.continue" />
    </s:submit>
  </div>
</div>

</s:form>

</div>