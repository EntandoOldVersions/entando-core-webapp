<%@ taglib prefix="s" uri="/struts-tags" %>

<h1><s:text name="title.myProfile" /></h1>

<div id="main">
<h2 class="margin-more-bottom"><s:text name="title.changePassword" /></h2>

<div class="message message_confirm">
	<h3><s:text name="messages.confirm" /></h3>	
	<p><s:text name="message.passwordChanged" /></p>
</div>

<br /><br /><br />
<s:if test="!#session.currentUser.credentialsNotExpired">
<a href="<s:url action="logout" />" >E' NECESSARIO RILOGARSI</a>
<br /><br />

</s:if>
</div>