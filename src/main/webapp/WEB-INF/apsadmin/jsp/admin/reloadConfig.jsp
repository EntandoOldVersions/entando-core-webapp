<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<h1><s:text name="menu.reload.config" /></h1>

<s:if test="1 == reloadingResult">
<p class="message message_confirm">
	<span class="noscreen"><s:text name="messages.confirm" />: </span><s:text name="message.reloadConfig.ok" />.
</p>
</s:if>
<s:else>
<p class="message message_error">
	<span class="noscreen"><s:text name="messages.error" />: </span><s:text name="message.reloadConfig.ko" />.
</p>
</s:else>