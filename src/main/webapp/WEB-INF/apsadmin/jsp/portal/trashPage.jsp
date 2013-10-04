<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1><a href="<s:url action="viewTree" namespace="/do/Page" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.pageManagement" />"><s:text name="title.pageManagement" /></a></h1>

<div id="main">

<h2><s:text name="title.pageManagement.pageTrash" /></h2>

<s:form action="delete">
<p class="sr-only">
	<wpsf:hidden name="selectedNode"/>
	<wpsf:hidden name="nodeToBeDelete" />
</p>
<p>
	<s:text name="note.deletePage.areYouSure" />&#32;<em class="important"><s:property value="%{getPage(nodeToBeDelete).getTitle(currentLang.getCode())}" /></em>?
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('page.options.delete')}" cssClass="button" />
</p>
</s:form>

</div>