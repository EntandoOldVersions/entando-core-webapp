<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<fieldset><legend><s:text name="label.settings" /></legend>
	
	<s:set var="sameAttributesList" value="sameAttributes" />
	
	<p>
		<label for="rangeStartDate_cal" class="basic-mint-label"><s:text name="note.range.from" />:</label>
		<s:date name="rangeStartDate" format="dd/MM/yyyy" var="rangeStartDateValue" />
		<wpsf:textfield useTabindexAutoIncrement="true" name="rangeStartDate" id="rangeStartDate_cal" value="%{#rangeStartDateValue}" cssClass="text"/><span class="inlineNote">dd/MM/yyyy</span>
	</p>
	<s:if test="#sameAttributesList != null && #sameAttributesList.size() > 0">
	<p class="margin-more-bottom">
		<label for="rangeStartDateAttribute" class="basic-mint-label"><s:text name="note.or" />&#32;<s:text name="note.range.from.attribute" />:</label>
		<wpsf:select useTabindexAutoIncrement="true" name="rangeStartDateAttribute" id="rangeStartDateAttribute" 
			list="#sameAttributesList" headerKey="" headerValue="%{getText('label.none')}" listKey="name" listValue="name" />
	</p>
	</s:if>
	
	<p>
		<label for="rangeEndDate_cal" class="basic-mint-label"><s:text name="note.range.to" />:</label>
		<s:date name="rangeEndDate" format="dd/MM/yyyy" var="rangeEndDateValue" />
		<wpsf:textfield useTabindexAutoIncrement="true" name="rangeEndDate" id="rangeEndDate_cal" value="%{#rangeEndDateValue}" cssClass="text" /><span class="inlineNote">dd/MM/yyyy</span>
	</p>
	<s:if test="#sameAttributesList != null && #sameAttributesList.size() > 0">
	<p class="margin-more-bottom">
		<label for="rangeEndDateAttribute" class="basic-mint-label"><s:text name="note.or" />&#32;<s:text name="note.range.to.attribute" />:</label>
		<wpsf:select useTabindexAutoIncrement="true" name="rangeEndDateAttribute" id="rangeEndDateAttribute" 
			list="#sameAttributesList" headerKey="" headerValue="%{getText('label.none')}" listKey="name" listValue="name" />
	</p>
	</s:if>
	
	<p>
		<label for="equalDate_cal" class="basic-mint-label"><s:text name="note.equals.to" />:</label>
		<s:date name="equalDate" format="dd/MM/yyyy" var="equalDateValue" />
		<wpsf:textfield useTabindexAutoIncrement="true" name="equalDate" id="equalDate_cal" value="%{#equalDateValue}" cssClass="text" /><span class="inlineNote">dd/MM/yyyy</span>
	</p>
	<s:if test="#sameAttributesList != null && #sameAttributesList.size() > 0">
	<p>
		<label for="equalDateAttribute" class="basic-mint-label"><s:text name="note.or" />&#32;<s:text name="note.equals.to.attribute" />:</label>	
		<wpsf:select useTabindexAutoIncrement="true" name="equalDateAttribute" id="equalDateAttribute" 
			list="#sameAttributesList" headerKey="" headerValue="%{getText('label.none')}" listKey="name" listValue="name" />
	</p>
	</s:if>
	
</fieldset>