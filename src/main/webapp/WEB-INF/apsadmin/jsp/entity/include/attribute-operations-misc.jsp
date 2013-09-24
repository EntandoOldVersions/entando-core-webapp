<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>


	<wpsa:actionParam action="moveAttribute" var="actionName" >
		<wpsa:actionSubParam name="attributeIndex" value="%{#elementIndex}" />
		<wpsa:actionSubParam name="movement" value="UP" />
	</wpsa:actionParam>
	<wpsf:submit  action="%{#actionName}" type="button" value="%{getText('label.moveUp')}" title="%{getText('label.moveInPositionNumber')}: %{#elementIndex}" cssClass="btn btn-default">
	<span class="icon icon-sort-up"></span>
	</wpsf:submit>

	<wpsa:actionParam action="moveAttribute" var="actionName" >
		<wpsa:actionSubParam name="attributeIndex" value="%{#elementIndex}" />
		<wpsa:actionSubParam name="movement" value="DOWN" />
	</wpsa:actionParam>
	<wpsf:submit  action="%{#actionName}" type="button" value="%{getText('label.moveDown')}" title="%{getText('label.moveInPositionNumber')}: %{#elementIndex+2}" cssClass="btn btn-default">
	<span class="icon icon-sort-down"></span>
	</wpsf:submit>

	<wpsa:actionParam action="removeAttribute" var="actionName" >
		<wpsa:actionSubParam name="attributeIndex" value="%{#elementIndex}" />
	</wpsa:actionParam>
	<wpsf:submit  action="%{#actionName}" type="button" value="%{getText('label.remove')}" title="%{getText('label.remove')}" cssClass="btn btn-warning">
	<span class="icon icon-remove-sign"></span>
	</wpsf:submit>
