<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" namespace="/do/Portal/GuiFragment"></s:url>"
		title="<s:text name="note.goToSomewhere" />: <s:text name="title.Portal.guiFragmentManagement" />">
		<s:text name="title.guiFragmentManagement" /></a>
		&#32;/&#32;
		<s:text name="title.guiFragmentDetail" />
	</span>
</h1>
<div class="form-horizontal">
	<div class="form-group">
		<label class="control-label col-lg-3 col-md-3"><s:text name="label.guiFragment" /></label>
		<div class="col-md-9 col-lg-9 form-control-static">
			<code><s:property value="code" /></code>
		</div>
	</div>
	
	<div class="form-group">
		<label class="control-label col-lg-3 col-md-3"><s:text name="label.widgetType" /></label>
		<div class="col-md-9 col-lg-9 form-control-static">
			<s:set value="%{getWidgetType(widgetTypeCode)}" var="widgetTypeVar" />
			<s:property value="getTitle(#widgetTypeVar.code, #widgetTypeVar.titles)" />
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-lg-3 col-md-3"><s:text name="label.pluginCode" /></label>
		<div class="col-md-9 col-lg-9 form-control-static">
			<s:property value="pluginCode"/>
		</div>
	</div>
	<!-- 
	<wpsa:hookPoint key="core.groupDetails" objectName="hookPointElements_core_groupDetails">
		<s:iterator value="#hookPointElements_core_groupDetails" var="hookPointElement">
			<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
		</s:iterator>
	</wpsa:hookPoint>
	 -->
</div>
<s:include value="/WEB-INF/apsadmin/jsp/portal/guifragment/include/guiFragmentInfo-references.jsp" />