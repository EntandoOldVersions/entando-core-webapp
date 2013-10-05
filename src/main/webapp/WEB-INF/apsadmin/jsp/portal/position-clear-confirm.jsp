<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set name="NScurrent" value="#context['struts.actionMapping'].getNamespace()" />

<s:if test="%{#NScurrent == '/do/Portal/WidgetType'}">
<h1><a href="<s:url action="viewWidgets" namespace="/do/Portal/WidgetType" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.widgetManagement" />"><s:text name="title.widgetManagement" /></a></h1>
</s:if>
<s:elseif test="%{#NScurrent == '/do/Page'}">
<h1><a href="<s:url action="viewTree" namespace="/do/Page" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.pageManagement" />"><s:text name="title.pageManagement" /></a></h1>
</s:elseif>

<div id="main">

<h2><s:text name="title.widgetManagement.position.clear" /></h2>

<s:form action="deleteShowletFromPage">
<p class="sr-only">
	<wpsf:hidden name="pageCode"/>
	<wpsf:hidden name="frame" />
	<wpsf:hidden name="showletTypeCode" />
</p>

<p>
	<s:text name="note.clearPosition.areYouSure.position" />&#32;<em class="important">&#32;<s:property value="frame" />&#32;&ndash;&#32;<s:property value="%{getPage(pageCode).model.getFrames()[frame]}"/></em>
	<s:text name="note.clearPosition.areYouSure.page" />&#32;<em class="important"><s:property value="%{getPage(pageCode).getTitle(currentLang.getCode())}" /></em>
	<s:set var="showletType" value="%{getShowletType(showletTypeCode)}"></s:set>
	<s:if test="null != #showletType">
		<s:text name="note.clearPosition.areYouSure.widget" />&#32;<em class="important"><s:property value="%{getTitle(#showletType.getCode(), #showletType.getTitles())}" /></em>
	</s:if>	
	?
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.clear')}" cssClass="button" />
</p>
</s:form>

</div>
