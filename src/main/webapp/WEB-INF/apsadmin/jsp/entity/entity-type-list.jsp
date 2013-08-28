<%@ taglib uri="/struts-tags" prefix="s" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="viewManagers" namespace="/do/Entity" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityManagement" />">
		<s:text name="title.entityAdmin.manage" /></a>
	</span>
</h1>

<div id="main">

<s:include value="/WEB-INF/apsadmin/jsp/entity/include/entity-type-list.jsp" />

</div>