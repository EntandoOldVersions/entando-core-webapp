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
<s:set name="iconImagePath" id="iconImagePath"><%= request.getParameter("iconImagePath")%></s:set>
<wpsf:submit useTabindexAutoIncrement="true" type="image" action="%{#chooseResourceActionName}" 
	value="%{getText('label.choose')}" title="%{#attribute.name + ': ' + getText('label.choose')}" src="%{#iconImagePath}" />