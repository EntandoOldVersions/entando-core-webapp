<%@ taglib uri="/struts-tags" prefix="s" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<s:property value="%{'title.' + entityManagerName + '.management'}" />
	</span>
</h1>

<div id="main">

<s:include value="/WEB-INF/apsadmin/jsp/entity/include/entity-type-list.jsp" />

</div>