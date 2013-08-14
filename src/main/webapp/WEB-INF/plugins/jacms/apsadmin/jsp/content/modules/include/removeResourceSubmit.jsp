<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<%-- PULSANTE RIMUOVI --%>
<s:set name="resourceTypeCode"><%= request.getParameter("resourceTypeCode")%></s:set>
<wpsa:actionParam action="removeResource" var="removeResourceActionName" >
	<wpsa:actionSubParam name="parentAttributeName" value="%{#parentAttribute.name}" />
	<wpsa:actionSubParam name="attributeName" value="%{#attribute.name}" />
	<wpsa:actionSubParam name="elementIndex" value="%{#elementIndex}" />
	<wpsa:actionSubParam name="resourceTypeCode" value="%{#resourceTypeCode}" />
	<wpsa:actionSubParam name="resourceLangCode" value="%{#lang.code}" />
</wpsa:actionParam>

<s:submit action="%{#removeResourceActionName}" type="button" title="%{#attribute.name + ': ' + getText('label.clear')}" cssClass="btn btn-warning btn-xs"> 
<s:if test="#resourceTypeCode == 'Image'">
		<span class="icon icon-remove"></span>&#32;
		<s:text name="label.clearImage" />
</s:if>
<s:else>
		<span class="icon icon-remove"></span>&#32;
		<s:text name="label.clearAttach" />
</s:else>
</s:submit>

</div>