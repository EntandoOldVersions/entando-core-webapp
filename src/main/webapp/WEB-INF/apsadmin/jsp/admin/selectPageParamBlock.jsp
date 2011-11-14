<%@ taglib prefix="s" uri="/struts-tags" %>
<select name="<s:property value="#paramName"/>" id="<s:property value="#paramName"/>" class="text">
	<s:iterator id="page" value="freePages">
		<option <s:if test="systemParams[#paramName] == #page.code">selected="selected"</s:if> 
			value="<s:property value="#page.code"/>"><s:if test="!#page.showable"> [i]</s:if><s:property value="#page.getShortFullTitle(currentLang.code)"/></option>
	</s:iterator>
</select>