<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<fieldset><legend><s:text name="label.metadata" /></legend>

<s:set var="freeViewerPagesVar" value="freeViewerPages" />

<p>
	<label for="viewPageCode" class="basic-mint-label"><s:text name="name.viewPageCode" />:</label> 
	<s:if test="#freeViewerPagesVar.size() > 0">
	<wpsf:select useTabindexAutoIncrement="true" name="viewPageCode" id="viewPageCode" list="#freeViewerPagesVar" listKey="code" listValue="%{getShortFullTitle(currentLang.code)}" value="%{#entityType.viewPage}" />
	</s:if>
	<s:else><s:text name="label.none" /></s:else>
</p>

<s:set var="contentModelsVar" value="%{getContentModels(#entityType.typeCode)}" />

<p>
	<label for="defaultModelId" class="basic-mint-label"><s:text name="name.defaultModelId" />:</label> 
	<s:if test="#contentModelsVar.size() > 0">
	<wpsf:select useTabindexAutoIncrement="true" name="defaultModelId" id="defaultModelId" list="#contentModelsVar" listKey="id" listValue="description" value="%{#entityType.defaultModel}" />
	</s:if>
	<s:else><s:text name="label.none" /></s:else>
</p>

<p>
	<label for="listModelId" class="basic-mint-label"><s:text name="name.listModelId" />:</label> 
	<s:if test="#contentModelsVar.size() > 0">
	<wpsf:select useTabindexAutoIncrement="true" name="listModelId" id="listModelId" list="#contentModelsVar" listKey="id" listValue="description" value="%{#entityType.listModel}" />
	</s:if>
	<s:else><s:text name="label.none" /></s:else>
</p>

</fieldset>