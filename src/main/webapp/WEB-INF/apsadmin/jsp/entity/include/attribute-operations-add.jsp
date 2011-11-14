<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<p>
	<label for="attributeTypeCode" class="basic-mint-label"><s:text name="label.type" />:</label>
	<wpsf:select useTabindexAutoIncrement="true" list="attributeTypes" name="attributeTypeCode" id="attributeTypeCode" listKey="type" listValue="type"></wpsf:select>
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.add')}" action="addAttribute" cssClass="button" />
</p>