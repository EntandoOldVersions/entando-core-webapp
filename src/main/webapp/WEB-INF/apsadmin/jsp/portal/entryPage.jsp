<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1><a href="<s:url action="viewTree" namespace="/do/Page" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.pageManagement" />"><s:text name="title.pageManagement" /></a></h1>

<div id="main">

<s:if test="strutsAction == 1">
	<h2><s:text name="title.newPage" /></h2>
</s:if>
<s:elseif test="strutsAction == 2">
	<h2><s:text name="title.editPage" /></h2>
</s:elseif>
<s:elseif test="strutsAction == 3">
	<h2><s:text name="title.pastePage" /></h2>
	<%-- INDICAZIONE PAGINA DA COPIARE... --%>
</s:elseif>

<s:if test="strutsAction == 2"><s:set var="breadcrumbs_pivotPageCode" value="pageCode" /></s:if>
<s:else><s:set var="breadcrumbs_pivotPageCode" value="parentPageCode" /></s:else>
<s:include value="/WEB-INF/apsadmin/jsp/portal/include/pageInfo_breadcrumbs.jsp" />

<div class="subsection">

<s:form action="save">
	<s:if test="hasActionErrors()">
<div class="message message_error">
<h3><s:text name="message.title.ActionErrors" /></h3>	
	<ul>
	<s:iterator value="actionErrors">
		<li><s:property escape="false" /></li>
	</s:iterator>
	</ul>
</div>
	</s:if>
	<s:if test="hasFieldErrors()">
<div class="message message_error">
<h3><s:text name="message.title.FieldErrors" /></h3>	
	<ul>
	<s:iterator value="fieldErrors">
		<s:iterator value="value">
		<li><s:property escape="false" /></li>
		</s:iterator>
	</s:iterator>
	</ul>
</div>
	</s:if>
<p class="noscreen">
	<wpsf:hidden name="selectedNode" />
	<wpsf:hidden name="strutsAction" />
	<wpsf:hidden name="copyPageCode" />
	<wpsf:hidden name="parentPageCode" />
	<wpsf:hidden name="groupSelectLock" />
	<s:if test="strutsAction == 2">
		<wpsf:hidden name="pageCode" />
	</s:if>
	<s:iterator value="extraGroups" id="groupName"><s:hidden name="extraGroups" value="%{#groupName}" /></s:iterator>
	<s:if test="strutsAction == 3">
		<wpsf:hidden name="group" />
		<wpsf:hidden name="model" />
		<wpsf:hidden name="defaultShowlet" />
		<wpsf:hidden name="showable" />
		<wpsf:hidden name="useExtraTitles" />
	</s:if>
</p>
<fieldset><legend><s:text name="label.info" /></legend>
<p>
	<label for="pageCode" class="basic-mint-label"><s:text name="name.pageCode" />:</label>
	<wpsf:textfield useTabindexAutoIncrement="true" name="pageCode" id="pageCode" disabled="%{getStrutsAction() == 2}" cssClass="text" />
</p>
<s:iterator value="langs">
<p>
	<label for="lang<s:property value="code" />" class="basic-mint-label"><span class="monospace">(<s:property value="code" />)</span> <s:text name="name.pageTitle" />:</label>
	<wpsf:textfield useTabindexAutoIncrement="true" name="%{'lang'+code}" id="%{'lang'+code}" value="%{titles.get(code)}" cssClass="text" />
</p>
</s:iterator>

<s:if test="strutsAction == 3">
</fieldset>
</s:if>

<s:if test="strutsAction != 3">

<p>
	<label for="group" class="basic-mint-label"><s:text name="label.ownerGroup" />:</label>
	<wpsf:select useTabindexAutoIncrement="true" name="group" id="group" list="allowedGroups" listKey="name" listValue="descr" disabled="%{groupSelectLock}" cssClass="text"></wpsf:select>
	<s:if test="groupSelectLock"><wpsf:hidden name="group" /></s:if>
</p>
</fieldset>

<fieldset><legend><s:text name="label.extraGroups" /></legend>
<s:if test="extraGroups.size() != 0">
<ul>
<s:iterator value="extraGroups" id="groupName">
	<li>
		<wpsa:actionParam action="removeExtraGroup" var="actionName" >
			<wpsa:actionSubParam name="extraGroupName" value="%{#groupName}" />
		</wpsa:actionParam>
		<s:set name="removeIcon" id="removeIcon"><wp:resourceURL/>administration/common/img/icons/list-remove.png</s:set>
		<wpsf:submit useTabindexAutoIncrement="true" action="%{#actionName}" type="image" src="%{#removeIcon}" value="%{getText('label.remove')}" title="%{getText('label.remove')}" />: <s:property value="%{getSystemGroups()[#groupName].getDescr()}"/> 
	</li>
</s:iterator>
</ul>
</s:if>
<p>
	<label for="extraGroups" class="basic-mint-label"><s:text name="label.join" />&#32;<s:text name="label.group" />:</label>
	<wpsf:select useTabindexAutoIncrement="true" name="extraGroupName" id="extraGroups" list="groups" 
		listKey="name" listValue="descr" cssClass="text" />
	<wpsf:submit useTabindexAutoIncrement="true" action="joinExtraGroup" value="%{getText('label.join')}" cssClass="button" />
</p>

</fieldset>

<fieldset><legend><s:text name="label.settings" /></legend>
<p>
	<label for="model" class="basic-mint-label"><s:text name="name.pageModel" />:</label>
	<wpsf:select useTabindexAutoIncrement="true" name="model" id="model" list="pageModels" listKey="code" listValue="descr" cssClass="text"></wpsf:select>
</p>

<ul class="noBullet">
	<li><wpsf:checkbox useTabindexAutoIncrement="true" name="defaultShowlet" id="defaultShowlet" cssClass="radiocheck" /><label for="defaultShowlet"><s:text name="name.hasDefaultShowlets" /></label></li>
	<li><wpsf:checkbox useTabindexAutoIncrement="true" name="viewerPage" id="viewerPage" cssClass="radiocheck" /><label for="viewerPage"><s:text name="name.isViewerPage" /></label></li>
	<li><wpsf:checkbox useTabindexAutoIncrement="true" name="showable" id="showable" cssClass="radiocheck" /><label for="showable"><s:text name="name.isShowablePage" /></label></li>
	<li><wpsf:checkbox useTabindexAutoIncrement="true" name="useExtraTitles" id="useExtraTitles" cssClass="radiocheck" /> <label for="useExtraTitles"><abbr lang="en" title="<s:text name="name.SEO.full" />"><s:text name="name.SEO.short" /></abbr>:&#32;<s:text name="name.useBetterTitles" /></label></li>
</ul>
</fieldset>

</s:if>

<p class="centerText"><wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" /></p>
</s:form>

</div>

</div>