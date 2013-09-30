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
		<s:submit disabled="%{#operationButtonDisabled}" action="%{#actionName}" type="button" cssClass="btn btn-default" title="%{getText('label.moveInPositionNumber')}: %{#elementIndex}">
		<span class="icon icon-sort-up"></span>
		<span class="sr-only"><s:text name="label.moveInPositionNumber" />: <s:property value="%{#elementIndex}" /></span>
		</s:submit>

		<wpsa:actionParam action="moveListElement" var="actionName" >
			<wpsa:actionSubParam name="attributeName" value="%{#attribute.name}" />
			<wpsa:actionSubParam name="listLangCode" value="%{#lang.code}" />
			<wpsa:actionSubParam name="elementIndex" value="%{#elementIndex}" />
			<wpsa:actionSubParam name="movement" value="DOWN" />
		</wpsa:actionParam>
		<s:submit disabled="%{#operationButtonDisabled}" action="%{#actionName}" type="button" cssClass="btn btn-default" title="%{getText('label.moveInPositionNumber')}: %{#elementIndex+2}">
		<span class="icon icon-sort-down"></span>
		<span class="sr-only"><s:text name="label.moveInPositionNumber" />: <s:property value="%{#elementIndex}" /></span>
		</s:submit>
	</div>
	<div class="btn-group btn-group-sm">
		<wpsa:actionParam action="removeListElement" var="actionName" >
			<wpsa:actionSubParam name="attributeName" value="%{#attribute.name}" />
			<wpsa:actionSubParam name="listLangCode" value="%{#lang.code}" />
			<wpsa:actionSubParam name="elementIndex" value="%{#elementIndex}" />
		</wpsa:actionParam>
		<s:submit disabled="%{#operationButtonDisabled}" action="%{#actionName}" type="button" cssClass="btn btn-default btn-warning" title="%{getText('label.remove')}: %{#elementIndex}">
		<span class="icon icon-remove-circle"></span>
		<span class="sr-only"><s:text name="label.remove" />: <s:property value="%{#elementIndex}" /></span>
		</s:submit>
	</div>
</div>