<%@ taglib prefix="s" uri="/struts-tags" %>

	<label class="btn btn-default <s:if test="systemParams[#paramName] == 'classic'"> active</s:if>" for="<s:property value="#paramName"/>_classic">
		<input type="radio" id="<s:property value="#paramName"/>_classic" name="<s:property value="#paramName"/>" value="classic" <s:if test="systemParams[#paramName] == 'classic'">checked="checked"</s:if> />
		<s:text name="treeStyle.classic" />
	</label>
	<label class="btn btn-default <s:if test="systemParams[#paramName] == 'request'"> active</s:if>" for="<s:property value="#paramName"/>_request">
		<input type="radio" id="<s:property value="#paramName"/>_request" name="<s:property value="#paramName"/>" value="request" <s:if test="systemParams[#paramName] == 'request'">checked="checked"</s:if> />
		<s:text name="treeStyle.request" />
	</label>
	<%--
<div class="radio">
<input type="radio" class="radiocheck" id="<s:property value="#paramName"/>_level" name="<s:property value="#paramName"/>" value="level" <s:if test="systemParams[#paramName] == 'level'">checked="checked"</s:if> /><label for="<s:property value="#paramName"/>_level">** LIVELLI **</label>
</div>
	--%>