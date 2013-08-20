<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<wpsa:actionParam action="addListElement" var="actionName" >
	<wpsa:actionSubParam name="attributeName" value="%{#attribute.name}" />
	<wpsa:actionSubParam name="listLangCode" value="%{#lang.code}" />
</wpsa:actionParam>

<s:submit type="button" action="%{#actionName}" cssClass="btn btn-default" ><span class="icon icon-plus-sign-alt"></span>&#32;<s:text name="label.add" /></s:submit>