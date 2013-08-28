<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="viewManagers" namespace="/do/Entity" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityManagement" />">
		<s:text name="title.entityManagement" /></a>
	</span>
</h1>

<div id="main">
<h2><a href="<s:url action="initViewEntityTypes" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityAdmin.manager" />&#32;<s:property value="entityManagerName" />"><s:text name="title.entityAdmin.manager" />: <s:property value="entityManagerName" /></a></h2>

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

<s:if test="operationId == 1">
	<h3><s:text name="title.entityTypes.editType.new" /></h3>
</s:if>
<s:else>
	<h3><s:text name="title.entityTypes.editType.edit" /></h3>
</s:else>

<p><s:text name="note.entityTypes.editType.intro.1" />.</p>
<p><s:text name="note.entityTypes.editType.intro.2" /></p>

<s:form action="saveEntityType">

<s:set var="entityType" value="entityType" />
<s:if test="operationId != 1">
	<p class="sr-only">	
		<wpsf:hidden name="entityTypeCode" value="%{#entityType.typeCode}" />
	</p>
</s:if>

<fieldset class="margin-more-top"><legend><s:text name="label.info" /></legend>
	<p>
	<s:if test="operationId == 1">
		<label for="entityTypeCode" class="basic-mint-label"><s:text name="label.code" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" name="entityTypeCode" id="entityTypeCode" value="%{#entityType.typeCode}" cssClass="text" />
	</s:if>
	<s:else>
		<label for="entityTypeCode" class="basic-mint-label"><s:text name="label.code" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" name="entityTypeCode" id="entityTypeCode" value="%{#entityType.typeCode}" cssClass="text" disabled="true" />	
	</s:else>
	</p>
	
	<p>
		<label for="entityTypeDescription" class="basic-mint-label"><s:text name="label.description" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" name="entityTypeDescription" id="entityTypeDescription" value="%{#entityType.typeDescr}" cssClass="text" />
	</p>
</fieldset>

<%-- 
	hookpoint for meta-info and the like
	allowed Plugins: jacms (but so far we have not a check on this)
	
	Based on the Plugin Pattern, we can calculate a proper path for this inclusion
	/WEB-INF/plugins/<plugin_code>/apsadmin/jsp/entity/include/entity-type-entry.jsp 
--%>
<s:if test="null != #hookpoint_plugin_code">
	<s:include value="%{'/WEB-INF/plugins/' + #hookpoint_plugin_code + '/apsadmin/jsp/entity/include/entity-type-entry.jsp'}" />
</s:if>

<fieldset><legend><s:text name="label.attributes" /></legend>
	<s:include value="/WEB-INF/apsadmin/jsp/entity/include/attribute-operations-add.jsp" />
	<s:include value="/WEB-INF/apsadmin/jsp/entity/include/attribute-list.jsp" />
</fieldset>

<p class="centerText">
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" action="saveEntityType" cssClass="button" />
</p>

</s:form>

</div>