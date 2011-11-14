<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<wpsa:actionParam action="addListElement" var="actionName" >
	<wpsa:actionSubParam name="attributeName" value="%{#attribute.name}" />
	<wpsa:actionSubParam name="listLangCode" value="%{#lang.code}" />
</wpsa:actionParam>

<wpsf:submit useTabindexAutoIncrement="true" action="%{#actionName}" value="%{getText('label.add')}" cssClass="button" />