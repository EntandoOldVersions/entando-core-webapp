<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core"  %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" />">File Browser</a>
		&#32;/&#32;
		File
	</span>
</h1>
<div id="main">

	<s:include value="/WEB-INF/apsadmin/jsp/filebrowser/include/breadcrumbs.jsp" />

	<s:form
		action="upload"
		namespace="/do/FileBrowser"
		method="post"
		enctype="multipart/form-data"
		cssClass="margin-base-top form-horizontal">

			<div class="form-group">
				<div class="col-xs-12">
					<s:hidden name="currentPath" />
					<label for="file-upload">New File</label>
					<s:file name="upload" id="file-upload" cssClass="form-control" />
				</div>
			</div>

			<div class="form-group">
				<div class="col-xs-12 col-sm-4 col-md-3 margin-small-vertical">
					<wpsf:submit type="button" cssClass="btn btn-primary btn-block">
						<span class="icon fa fa-save"></span>&#32;
						<s:text name="label.save" />
					</wpsf:submit>
				</div>
				<div class="col-xs-12 col-sm-4 col-md-3 margin-small-vertical">
					<wpsf:submit type="button" action="list" cssClass="btn btn-link">
						<s:text name="label.cancel" />
					</wpsf:submit>
				</div>
			</div>

	</s:form>
</div>
