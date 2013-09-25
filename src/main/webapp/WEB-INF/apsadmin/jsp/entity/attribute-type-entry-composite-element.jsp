<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<s:property value="%{'title.' + entityManagerName + '.management'}" />
	</span>
</h1>

<div id="main">

<h2><a href="<s:url action="initViewEntityTypes" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityAdmin.manager" />&#32;<s:property value="entityManagerName" />"><s:text name="title.entityAdmin.manager" />: <s:property value="entityManagerName" /></a></h2>
<h3><a href="<s:url action="initEditEntityType" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param><s:param name="entityTypeCode"><s:property value="entityType.typeCode" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityTypes.editType.edit" />"><s:text name="title.entityTypes.editType.edit" />: <span class="monospace"><s:property value="entityType.typeCode" /> - <s:property value="entityType.typeDescr" /></span></a></h3>

<s:set name="listAttribute" value="listAttribute" />
<s:set name="compositeAttribute" value="compositeAttributeOnEdit" />
<p><s:text name="note.workingOnAttribute" />:&#32;
<s:if test="null != #listAttribute"><span class="monospace"><s:property value="#compositeAttribute.type" /></span>,&#32;<s:text name="note.workingOnAttributeIn" />&#32;<span class="monospace"><s:property value="#listAttribute.name" /> (<s:property value="#listAttribute.type" />)</span></s:if>
<s:else><span class="monospace"><s:property value="#compositeAttribute.name" /></span></s:else>
</p>

<s:set name="attribute" value="getAttributePrototype(attributeTypeCode)" />

<s:form action="saveAttributeElement">

<s:if test="hasFieldErrors()">
	<div class="message message_error">	
	<h5><s:text name="message.title.FieldErrors" /></h5>
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
	<wpsf:hidden name="attributeTypeCode" />
	<wpsf:hidden name="strutsAction" />
</p>

<fieldset class="margin-more-top"><legend><s:text name="label.info" /></legend>
	<p>
		<label for="attributeType" class="basic-mint-label"><s:text name="label.type" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" cssClass="text" id="attributeType" name="attributeType" value="%{attributeTypeCode}" disabled="true" />
	</p>
	<p>
		<label for="attributeName" class="basic-mint-label"><s:text name="label.code" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" name="attributeName" id="attributeName" cssClass="text"/> 
	</p>
	<p>
		<label for="attributeDescription" class="basic-mint-label"><s:text name="label.description" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" name="attributeDescription" id="attributeDescription" cssClass="text"/> 
	</p>
	<p>
		<wpsf:checkbox useTabindexAutoIncrement="true" name="required" id="required" cssClass="radiocheck"/>&#32;<label for="required"><s:text name="Entity.attribute.flag.mandatory.full" /></label>
	</p>
	<s:if test="isEntityManagerSearchEngineUser() && isIndexableOptionSupported(attributeTypeCode)">
	<p>
		<wpsf:checkbox useTabindexAutoIncrement="true" name="indexable" id="indexable" cssClass="radiocheck"/>&#32;<label for="indexable"><s:text name="Entity.attribute.flag.indexed.full" /></label>
	</p>
	</s:if>
</fieldset>

<s:if test="#attribute.textAttribute">
<s:include value="/WEB-INF/apsadmin/jsp/entity/include/validation-rules-text.jsp" />
</s:if>

<s:elseif test="#attribute.type == 'Number'">
<s:include value="/WEB-INF/apsadmin/jsp/entity/include/validation-rules-number.jsp" />
</s:elseif>

<s:elseif test="#attribute.type == 'Date'">
<s:include value="/WEB-INF/apsadmin/jsp/entity/include/validation-rules-date.jsp" />
</s:elseif>

<s:include value="/WEB-INF/apsadmin/jsp/entity/include/validation-rules-ognl.jsp" />

<p class="centerText">
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" />
</p>

</s:form>
</div>