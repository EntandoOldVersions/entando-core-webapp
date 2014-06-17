<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
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
		cssClass="margin-base-top form-horizontal"
		action="save"
		namespace="/do/FileBrowser"
		method="post"
		>
		<div class="form-group">
			<div class="col-xs-12">
				<s:hidden name="currentPath" />
				<s:hidden name="strutsAction" />
				<label for="filename" class="display-block">Name</label>
				<div class="row">
					<div class="col-md-9">
						<wpsf:textfield
							name="filename"
							id="filename"
							cssClass="form-control col-md-9" />
					</div>
					<div class="col-md-3">
						<label for="file-extension" class="sr-only">Extension</label>
						<wpsf:select
							id="file-extension"
							list="textFileTypes"
							name="textFileExtension"
							cssClass="form-control col-md-3" />
					</div>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="col-xs-12">
				<label for="file-content">Content</label>
				<wpsf:textarea
					cssClass="form-control"
					id="file-content"
					placeholder="file content here..."
					name="fileText"
					rows="15"
					cols="50"
					value="%{fileText}"/>
			</div>
		</div>


		<div class="form-group">
			<div class="col-xs-12 col-sm-4 col-md-3 margin-small-vertical">
				<wpsf:submit type="button" action="save" cssClass="btn btn-primary btn-block">
					<span class="icon fa fa-save"></span>&#32;
					<s:text name="label.save" />
				</wpsf:submit>
			</div>
			<div class="col-xs-12 col-sm-4 col-md-3 margin-small-vertical">
				<wpsf:submit
					action="list"
					value="%{getText('label.cancel')}"
					cssClass="btn btn-link" />
			</div>
		</div>

	</s:form>

</div>
