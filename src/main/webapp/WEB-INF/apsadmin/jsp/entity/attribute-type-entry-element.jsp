<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="viewManagers" namespace="/do/Entity" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityManagement" />">
		<s:text name="title.entityManagement" /></a>
	</span>
</h1>

<div id="main">

<h2><a href="<s:url action="initViewEntityTypes" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityAdmin.manager" />&#32;<s:property value="entityManagerName" />"><s:text name="title.entityAdmin.manager" />: <s:property value="entityManagerName" /></a></h2>
<h3><a href="<s:url action="initEditEntityType" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param><s:param name="entityTypeCode"><s:property value="entityType.typeCode" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityTypes.editType.edit" />"><s:text name="title.entityTypes.editType.edit" />: <span class="monospace"><s:property value="entityType.typeCode" /> - <s:property value="entityType.typeDescr" /></span></a></h3>

<s:set name="listAttribute" value="listAttribute" />
<s:set name="attributeElement" value="attributeElement" />
<p class="margin-more-bottom"><s:text name="note.workingOnAttribute" />:&#32;<span class="monospace"><s:property value="#attributeElement.type" /></span>,&#32;<s:text name="note.workingOnAttributeIn" />&#32;<span class="monospace"><s:property value="#listAttribute.name" /> (<s:property value="#listAttribute.type" />)</span></p>

<s:form action="saveListElement">

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

<p class="sr-only">
	<wpsf:hidden name="attributeName"/>
	<wpsf:hidden name="attributeTypeCode"/>
	<wpsf:hidden name="strutsAction"/>
</p>

<s:if test="isEntityManagerSearchEngineUser() && isIndexableOptionSupported(attributeTypeCode)">
<fieldset><legend><s:text name="label.info" /></legend>

	<p>
		<label for="attributeTypeCode" class="basic-mint-label"><s:text name="label.type" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" id="attributeTypeCode" name="attributeTypeCode" value="%{attributeTypeCode}" disabled="true" cssClass="text" />
	</p>
	<p>
		<wpsf:checkbox useTabindexAutoIncrement="true" name="indexable" id="indexable" cssClass="radiocheck" /><label for="indexable"><s:text name="Entity.attribute.flag.indexed.full" /></label>
	</p>

</fieldset>
</s:if>

<s:if test="#attributeElement.textAttribute">
<s:set var="attribute" value="#attributeElement"></s:set>
<s:include value="/WEB-INF/apsadmin/jsp/entity/include/validation-rules-text.jsp"/>
</s:if>

<s:elseif test="#attributeElement.type == 'Number'">
<s:include value="/WEB-INF/apsadmin/jsp/entity/include/validation-rules-number.jsp"/>
</s:elseif>

<s:elseif test="#attributeElement.type == 'Date'">
<s:include value="/WEB-INF/apsadmin/jsp/entity/include/validation-rules-date.jsp"/>
</s:elseif>

<s:include value="/WEB-INF/apsadmin/jsp/entity/include/validation-rules-ognl.jsp"/>

<p class="centerText">
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.continue')}" cssClass="button" />
</p>

</s:form>

</div>