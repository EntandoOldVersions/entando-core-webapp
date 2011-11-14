<%@ taglib prefix="s" uri="/struts-tags" %>
<ul class="noBullet radiocheck">
	<li><input type="radio" id="<s:property value="#paramName"/>_classic" name="<s:property value="#paramName"/>" value="classic" <s:if test="systemParams[#paramName] == 'classic'">checked="checked"</s:if> /><label for="<s:property value="#paramName"/>_classic"><s:text name="treeStyle.classic" /></label></li>
	<li><input type="radio" id="<s:property value="#paramName"/>_request" name="<s:property value="#paramName"/>" value="request" <s:if test="systemParams[#paramName] == 'request'">checked="checked"</s:if> /><label for="<s:property value="#paramName"/>_request"><s:text name="treeStyle.request" /></label></li>
	<!--
	<li><input type="radio" class="radiocheck" id="<s:property value="#paramName"/>_level" name="<s:property value="#paramName"/>" value="level" <s:if test="systemParams[#paramName] == 'level'">checked="checked"</s:if> /><label for="<s:property value="#paramName"/>_level">** LIVELLI **</label></li>
	-->
</ul>