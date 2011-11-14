<%@ taglib prefix="s" uri="/struts-tags" %>
<ul class="noBullet">
	<li><input type="radio" class="radiocheck" id="<s:property value="#paramName"/>_true" name="<s:property value="#paramName"/>" value="true" <s:if test="systemParams[#paramName]">checked="checked"</s:if> /><label for="<s:property value="#paramName"/>_true"><s:text name="label.yes" /></label></li>
	<li><input type="radio" class="radiocheck" id="<s:property value="#paramName"/>_false" name="<s:property value="#paramName"/>" value="false" <s:if test="systemParams[#paramName] == 'false'">checked="checked"</s:if> /><label for="<s:property value="#paramName"/>_false"><s:text name="label.no" /></label></li>
</ul>