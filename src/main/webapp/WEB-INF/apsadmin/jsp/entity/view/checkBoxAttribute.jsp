<%@ taglib prefix="s" uri="/struts-tags" %>

<s:if test="#lang.default">
<s:set name="checkedValue" value="%{#attribute.booleanValue != null && #attribute.booleanValue ==true}" />
<p>
<s:if test="%{#checkedValue}">
<s:text name="label.yes"/>
</s:if>
<s:else>
<s:text name="label.no"/>
</s:else>
</p>
</s:if>
<s:else>
<p>
	<s:text name="EntityAttribute.monolang.defaultValue" />
</p>
</s:else>