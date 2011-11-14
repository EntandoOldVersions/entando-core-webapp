<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<fieldset><legend><s:text name="label.settings" /></legend>
	
	<s:set var="sameAttributesList" value="sameAttributes" />
	
	<p>
		<label for="rangeStartNumber" class="basic-mint-label"><s:text name="note.range.from" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" name="rangeStartNumber" id="rangeStartNumber" cssClass="text"/>
	</p>
	<s:if test="#sameAttributesList != null && #sameAttributesList.size() > 0">
	<p class="margin-more-bottom">
		<label for="rangeStartNumberAttribute" class="basic-mint-label"><s:text name="note.or" />&#32;<s:text name="note.range.from.attribute" />:</label>
		<wpsf:select useTabindexAutoIncrement="true" name="rangeStartNumberAttribute" id="rangeStartNumberAttribute" 
			list="#sameAttributesList" headerKey="" headerValue="%{getText('label.none')}" listKey="name" listValue="name" />
	</p>			
	</s:if>
		
	<p>
		<label for="rangeEndNumber" class="basic-mint-label"><s:text name="note.range.to" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" name="rangeEndNumber" id="rangeEndNumber" cssClass="text" />
	</p>
	<s:if test="#sameAttributesList != null && #sameAttributesList.size() > 0">
	<p class="margin-more-bottom">
		<label for="rangeEndNumberAttribute" class="basic-mint-label"><s:text name="note.or" />&#32;<s:text name="note.range.to.attribute" />:</label>	
		<wpsf:select useTabindexAutoIncrement="true" name="rangeEndNumberAttribute" id="rangeEndNumberAttribute" 
			list="#sameAttributesList" headerKey="" headerValue="%{getText('label.none')}" listKey="name" listValue="name" />
	</p>
	</s:if>
	
	<p>
		<label for="equalNumber" class="basic-mint-label"><s:text name="note.equals.to" />:</label>	
		<wpsf:textfield useTabindexAutoIncrement="true" name="equalNumber" id="equalNumber" cssClass="text" />
	</p>
	<s:if test="#sameAttributesList != null && #sameAttributesList.size() > 0">
	<p>
		<label for="equalNumberAttribute" class="basic-mint-label"><s:text name="note.or" />&#32;<s:text name="note.equals.to.attribute" />:</label>	
		<wpsf:select useTabindexAutoIncrement="true" name="equalNumberAttribute" id="equalNumberAttribute" 
			list="#sameAttributesList" headerKey="" headerValue="%{getText('label.none')}" listKey="name" listValue="name" />
	</p>
	</s:if>
	
</fieldset>