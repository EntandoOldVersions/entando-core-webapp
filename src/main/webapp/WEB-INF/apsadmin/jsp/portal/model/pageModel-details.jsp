<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" namespace="/do/PageModel"></s:url>"
		title="<s:text name="note.goToSomewhere" />: <s:text name="title.pageModelManagement" />">
		<s:text name="title.pageModelManagement" /></a>
		&#32;/&#32;
		<s:text name="title.pageModelDetail" />
	</span>
</h1>
<div class="form-horizontal">
	<div class="form-group">
		<label class="control-label col-lg-3 col-md-3"><s:text name="label.code" /></label>
		<div class="col-md-9 col-lg-9 form-control-static">
			<code><s:property value="code" /></code>
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-lg-3 col-md-3"><s:text name="label.description" /></label>
		<div class="col-md-9 col-lg-9 form-control-static">
			<s:property value="description" />
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-lg-3 col-md-3"><s:text name="label.pluginCode" /></label>
		<div class="col-md-9 col-lg-9 form-control-static">
			<s:property value="pluginCode" />
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-lg-3 col-md-3"><s:text name="label.configuration" /> ** THIS FIELD HAS TO BE REMOVED **</label>
		<div class="col-md-9 col-lg-9 form-control-static">
			<s:property value="xmlConfiguration" />
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-lg-3 col-md-3"><s:text name="label.template" /></label>
		<div class="col-md-9 col-lg-9 form-control-static">
			<s:property value="template" />
		</div>
	</div>
	<wpsa:hookPoint key="core.pageModelDetails" objectName="hookPointElements_core_pageModelDetails">
		<s:iterator value="#hookPointElements_core_pageModelDetails" var="hookPointElementVar">
			<wpsa:include value="%{#hookPointElementvar.filePath}"></wpsa:include>
		</s:iterator>
	</wpsa:hookPoint>
</div>
<s:include value="/WEB-INF/apsadmin/jsp/portal/model/include/pageModel-references.jsp" />