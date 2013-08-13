<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<%-- PULSANTE CERCA RISORSA --%>
<s:set name="resourceTypeCode"><%= request.getParameter("resourceTypeCode")%></s:set>
<wpsa:actionParam action="chooseResource" var="chooseResourceActionName" >
	<wpsa:actionSubParam name="parentAttributeName" value="%{#parentAttribute.name}" />
	<wpsa:actionSubParam name="attributeName" value="%{#attribute.name}" />
	<wpsa:actionSubParam name="elementIndex" value="%{#elementIndex}" />
	<wpsa:actionSubParam name="resourceTypeCode" value="%{#resourceTypeCode}" />
	<wpsa:actionSubParam name="resourceLangCode" value="%{#lang.code}" />
</wpsa:actionParam>
<s:submit action="%{#chooseResourceActionName}" type="button" title="%{#attribute.name + ': ' + getText('label.choose')}" cssClass="btn btn-default"> 
<s:if test="#resourceTypeCode == 'Image'">
		<span class="icon icon-picture"></span>&#32;
		<s:text name="label.chooseImage" />
</s:if>
<s:else>
		<span class="icon icon-paper-clip"></span>&#32;
		<s:text name="label.chooseAttach" />
</s:else>
</s:submit>
