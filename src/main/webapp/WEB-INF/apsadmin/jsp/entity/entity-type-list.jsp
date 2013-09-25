<%@ taglib uri="/struts-tags" prefix="s" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="initViewEntityTypes" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityAdmin.manager" />&#32;<s:property value="entityManagerName" />">
		<s:text name="%{'title.' + entityManagerName + '.management'}" />
		</a>
	</span>
</h1>

<div id="main">

<s:include value="/WEB-INF/apsadmin/jsp/entity/include/entity-type-list.jsp" />

</div>