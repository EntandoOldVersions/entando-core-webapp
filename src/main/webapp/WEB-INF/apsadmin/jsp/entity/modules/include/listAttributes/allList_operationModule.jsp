<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<s:if test="null == #operationButtonDisabled">
	<s:set var="operationButtonDisabled" value="false" />
</s:if>
<div class="btn-toolbar">
	<div class="btn-group btn-group-sm">
		<wpsa:actionParam action="moveListElement" var="actionName" >
			<wpsa:actionSubParam name="attributeName" value="%{#attribute.name}" />
			<wpsa:actionSubParam name="listLangCode" value="%{#lang.code}" />
			<wpsa:actionSubParam name="elementIndex" value="%{#elementIndex}" />
			<wpsa:actionSubParam name="movement" value="UP" />
		</wpsa:actionParam>
		<s:submit disabled="%{#operationButtonDisabled}" action="%{#actionName}" type="button" cssClass="btn btn-default" value="%{getText('label.moveUp')}" title="%{getText('label.moveInPositionNumber')}: %{#elementIndex}">
		<span class="icon icon-sort-up"></span></s:submit>
		
		<wpsa:actionParam action="moveListElement" var="actionName" >
			<wpsa:actionSubParam name="attributeName" value="%{#attribute.name}" />
			<wpsa:actionSubParam name="listLangCode" value="%{#lang.code}" />
			<wpsa:actionSubParam name="elementIndex" value="%{#elementIndex}" />
			<wpsa:actionSubParam name="movement" value="DOWN" />
		</wpsa:actionParam>
		<s:submit disabled="%{#operationButtonDisabled}" action="%{#actionName}" type="button" cssClass="btn btn-default" value="%{getText('label.moveDown')}" title="%{getText('label.moveInPositionNumber')}: %{#elementIndex+2}">
		<span class="icon icon-sort-down"></span></s:submit>
	</div>
	<div class="btn-group btn-group-sm">	
		<wpsa:actionParam action="removeListElement" var="actionName" >
			<wpsa:actionSubParam name="attributeName" value="%{#attribute.name}" />
			<wpsa:actionSubParam name="listLangCode" value="%{#lang.code}" />
			<wpsa:actionSubParam name="elementIndex" value="%{#elementIndex}" />
		</wpsa:actionParam>
		<s:submit disabled="%{#operationButtonDisabled}" action="%{#actionName}" type="button" cssClass="btn btn-default btn-warning" value="%{getText('label.remove')}" title="%{getText('label.remove')}">
		<span class="icon icon-remove-sign"></span></s:submit>
	</div>
</div>