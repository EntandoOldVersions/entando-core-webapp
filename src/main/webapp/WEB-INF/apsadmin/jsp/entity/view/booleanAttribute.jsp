<%@ taglib prefix="s" uri="/struts-tags" %>

<s:if test="#lang.default">
<p>
<s:if test="%{#attribute.value == true}">
<s:text name="label.yes"/>
</s:if>
<s:else>
<s:text name="label.no"/>
</s:else>
</p>
</s:if>
<s:else>
	<p>
	<s:text name="EntityAttribute.monolang.defaultValue"/>
	</p>
</s:else>