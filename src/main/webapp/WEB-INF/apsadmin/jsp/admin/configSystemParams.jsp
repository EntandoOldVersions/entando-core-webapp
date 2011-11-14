<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<h1><s:text name="title.generalSettings.settings" /></h1>

<div id="main">

<s:if test="hasActionMessages()">
<div class="message message_confirm">
<h2><s:text name="messages.confirm" /></h2>	
<ul>
	<s:iterator value="actionMessages">
		<li><s:property escape="false" /></li>
	</s:iterator>
</ul>
</div>
</s:if>

<s:form action="updateSystemParams">
<fieldset class="margin-more-top"><legend><s:text name="name.pages" /></legend>
<div>

<p class="important"><s:text name="sysconfig.legend.systemPages" />:</p>
<p>
	<label for="homePageCode" class="basic-mint-label"><s:text name="sysconfig.homePageCode" />:</label>
	<s:set name="paramName" value="'homePageCode'" />
	<s:include value="/WEB-INF/apsadmin/jsp/admin/selectPageParamBlock.jsp" />
</p>

<p>
	<label for="notFoundPageCode" class="basic-mint-label"><s:text name="sysconfig.notFoundPageCode" />:</label>
	<s:set name="paramName" value="'notFoundPageCode'" />
	<s:include value="/WEB-INF/apsadmin/jsp/admin/selectPageParamBlock.jsp" />
</p>

<p>
	<label for="errorPageCode" class="basic-mint-label"><s:text name="sysconfig.errorPageCode" />:</label>
	<s:set name="paramName" value="'errorPageCode'" />
	<s:include value="/WEB-INF/apsadmin/jsp/admin/selectPageParamBlock.jsp" />
</p>

<p>
	<label for="loginPageCode" class="basic-mint-label"><s:text name="sysconfig.loginPageCode" />:</label>
	<s:set name="paramName" value="'loginPageCode'" />
	<s:include value="/WEB-INF/apsadmin/jsp/admin/selectPageParamBlock.jsp" />
</p>

<p class="important"><s:text name="sysconfig.URLstyle" />:</p>
<s:set name="paramName" value="'urlStyle'" />
<ul class="noBullet">
	<li><input type="radio" class="radiocheck" id="urlStyle_classic" name="urlStyle" value="classic" <s:if test="systemParams['urlStyle'] == 'classic'">checked="checked"</s:if> /><label for="urlStyle_classic"><s:text name="URLstyle.classic" /></label></li>
	<li><input type="radio" class="radiocheck" id="urlStyle_breadcrumbs" name="urlStyle" value="breadcrumbs" <s:if test="systemParams['urlStyle'] == 'breadcrumbs'">checked="checked"</s:if> /><label for="urlStyle_breadcrumbs"><s:text name="URLstyle.breadcrumbs" /></label></li>	
</ul>

<p class="important"><s:text name="sysconfig.lang.browser" />:</p>
<s:set name="paramName" value="'startLangFromBrowser'" />
	<s:include value="/WEB-INF/apsadmin/jsp/admin/booleanParamBlock.jsp" />
	
</div>
</fieldset>

<fieldset><legend><s:text name="sysconfig.legend.privacyModule" /></legend>
<div>
<s:set name="paramName" value="'extendedPrivacyModuleEnabled'" />
<p>
	<s:include value="/WEB-INF/apsadmin/jsp/admin/simpleCheckboxParamBlock.jsp" /><label for="extendedPrivacyModuleEnabled"><s:text name="label.active" /></label>
</p>

<p>
	<label for="maxMonthsSinceLastAccess" class="basic-mint-label"><s:text name="sysconfig.maxMonthsSinceLastAccess" />:</label>
	<s:set name="paramName" value="'maxMonthsSinceLastAccess'" />
	<s:include value="/WEB-INF/apsadmin/jsp/admin/textParamBlock.jsp" />
</p>

<p>
	<label for="maxMonthsSinceLastPasswordChange" class="basic-mint-label"><s:text name="sysconfig.maxMonthsSinceLastPasswordChange" />:</label>
	<s:set name="paramName" value="'maxMonthsSinceLastPasswordChange'" />
	<s:include value="/WEB-INF/apsadmin/jsp/admin/textParamBlock.jsp" />
</p>
</div>
</fieldset>

<fieldset><legend><s:text name="sysconfig.legend.misc" /></legend>
<div>
<p class="important"><s:text name="sysconfig.chooseYourEditor" />:</p>
<ul class="noBullet radiocheck">
	<li><input type="radio" id="hypertextEditor_none" name="hypertextEditor" value="none" <s:if test="systemParams['hypertextEditor'] == 'none'">checked="checked"</s:if> /><label for="hypertextEditor_none"><s:text name="label.none" /></label></li>
	<li><input type="radio" id="hypertextEditor_fckeditor" name="hypertextEditor" value="fckeditor" <s:if test="systemParams['hypertextEditor'] == 'fckeditor'">checked="checked"</s:if> /><label for="hypertextEditor_fckeditor"><s:text name="name.editor.fckeditor" /></label></li>
	<li><input type="radio" id="hypertextEditor_hoofed" name="hypertextEditor" value="hoofed" <s:if test="systemParams['hypertextEditor'] == 'hoofed'">checked="checked"</s:if> /><label for="hypertextEditor_hoofed"><s:text name="name.editor.hoofed" /></label></li>
</ul>
</div>

<div>
<p class="important"><s:text name="sysconfig.chooseYourPagesTreeStyle" />:</p>
<s:set name="paramName" value="'treeStyle_page'" />
<s:include value="/WEB-INF/apsadmin/jsp/admin/treeStyleParamBlock.jsp" />
</div>

<div>
<p class="important"><s:text name="sysconfig.chooseYourCategoriesTreeStyle" />:</p>
<s:set name="paramName" value="'treeStyle_category'" />
<s:include value="/WEB-INF/apsadmin/jsp/admin/treeStyleParamBlock.jsp" />
</div>

</fieldset>

<wpsa:hookPoint key="core.configSystemParams" objectName="hookPointElements_core_configSystemParams">
<s:iterator value="#hookPointElements_core_configSystemParams" var="hookPointElement">
	<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
</s:iterator>
</wpsa:hookPoint>

<p class="centerText"><wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" /></p>
</s:form>

</div>