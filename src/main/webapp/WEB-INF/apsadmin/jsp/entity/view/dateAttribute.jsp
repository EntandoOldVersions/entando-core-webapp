<%@ taglib prefix="s" uri="/struts-tags" %>

<s:if test="#lang.default">
	<s:property value="#attribute.getFormattedDate('dd/MM/yyyy')" />
</s:if>
<s:else>
	<s:text name="EntityAttribute.monolang.defaultValue" />
</s:else>