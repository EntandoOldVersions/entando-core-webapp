<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<s:if test="null == #operationButtonDisabled">
	<s:set var="operationButtonDisabled" value="false" />
</s:if>

<wpsa:actionParam action="moveListElement" var="actionName" >
	<wpsa:actionSubParam name="attributeName" value="%{#attribute.name}" />
	<wpsa:actionSubParam name="listLangCode" value="%{#lang.code}" />
	<wpsa:actionSubParam name="elementIndex" value="%{#elementIndex}" />
	<wpsa:actionSubParam name="movement" value="UP" />
</wpsa:actionParam>
<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/go-up-disabled-<s:property value="%{#operationButtonDisabled}" />.png</s:set>
<wpsf:submit useTabindexAutoIncrement="true" disabled="%{#operationButtonDisabled}" action="%{#actionName}" type="image" src="%{#iconImagePath}" value="%{getText('label.moveUp')}" title="%{getText('label.moveInPositionNumber')}: %{#elementIndex}" />

<wpsa:actionParam action="moveListElement" var="actionName" >
	<wpsa:actionSubParam name="attributeName" value="%{#attribute.name}" />
	<wpsa:actionSubParam name="listLangCode" value="%{#lang.code}" />
	<wpsa:actionSubParam name="elementIndex" value="%{#elementIndex}" />
	<wpsa:actionSubParam name="movement" value="DOWN" />
</wpsa:actionParam>
<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/go-down-disabled-<s:property value="%{#operationButtonDisabled}" />.png</s:set>
<wpsf:submit useTabindexAutoIncrement="true" disabled="%{#operationButtonDisabled}" action="%{#actionName}" type="image" src="%{#iconImagePath}" value="%{getText('label.moveDown')}" title="%{getText('label.moveInPositionNumber')}: %{#elementIndex+2}" />

<wpsa:actionParam action="removeListElement" var="actionName" >
	<wpsa:actionSubParam name="attributeName" value="%{#attribute.name}" />
	<wpsa:actionSubParam name="listLangCode" value="%{#lang.code}" />
	<wpsa:actionSubParam name="elementIndex" value="%{#elementIndex}" />
</wpsa:actionParam>
<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/delete-disabled-<s:property value="%{#operationButtonDisabled}" />.png</s:set>
<wpsf:submit useTabindexAutoIncrement="true" disabled="%{#operationButtonDisabled}" action="%{#actionName}" type="image" src="%{#iconImagePath}" value="%{getText('label.remove')}" title="%{getText('label.remove')}" />