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
		action="save"
		namespace="/do/FileBrowser"
		cssClass="margin-base-top form-horizontal"
		>
		<div class="form-group">
			<div class="col-xs-12">
					<s:hidden name="currentPath" />
					<s:hidden name="filename" />
					<s:hidden name="strutsAction" />
					<label>Filename</label>
					<p class="form-control-static">
						<s:property value="filename" />
						&#32;
						<a

							title="Download: <s:property value="#fileVar.name"/>"
							href="<s:url namespace="/do/FileBrowser" action="download" >
								<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/></s:param>
								<s:param name="filename"> <s:property escape="false" value="filename"/></s:param>
							</s:url>">
								<span class="icon fa fa-download"></span>
									<span class="sr-only">
										Download: <s:property value="#fileVar.name"/>
									</span>
						</a>
					</p>
			</div>
		</div>
		<div class="form-group">
			<div class="col-xs-12">
				<label for="file-content">Content</label>
				<wpsf:textarea
					name="fileText"
					rows="20"
					cols="50"
					value="%{fileText}"
					cssClass="form-control"
					/>
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
