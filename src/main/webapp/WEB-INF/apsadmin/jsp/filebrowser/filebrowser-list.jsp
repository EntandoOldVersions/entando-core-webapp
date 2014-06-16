<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		File Browser
	</span>
</h1>
<div id="main">
	<%-- what is this?
	<s:form action="edit" namespace="/do/FileBrowser">
		<s:hidden name="currentPath" />
		filename:<s:textfield name="filename" />
		<s:submit name="createByName" value="createByName" />
	</s:form>
	--%>

	<s:include value="/WEB-INF/apsadmin/jsp/filebrowser/include/breadcrumbs.jsp" />
	<s:set var="filesAttributes" value="filesAttributes" />
	<s:if test="#filesAttributes.length>0">
		<div class="table-responsive">
			<table class="table table-hover">
				<thead>
					<tr class="sr-only">
						<th>Actions</th>
						<th>Name</th>
						<th>Last edit</th>
						<th>Size</th>
					</tr>
					<s:if test="currentPath!=''">
						<tr>
							<th></th>
							<th colspan="3">
								<a href="<s:url namespace="/do/FileBrowser" action="list" >
							<s:param name="currentPath"><s:property escape="true" value="breadCrumbsTargets.get(breadCrumbsTargets.size()-2).key"/></s:param>
						</s:url>">
									<span class="icon fa fa-share fa-rotate-270"></span>
									&#32;
									up ..
								</a>
							</th>
						</tr>
					</s:if>
				</thead>
	</s:if>
				<s:iterator value="#filesAttributes" var="fileAttributesVar" status="fileStatus">
					<tr>
							<td class="text-right text-nowrap col-xs-1 col-sm-1 col-md-1 col-lg-1 ">
								<s:if test="!#fileAttributesVar.directory">
									<div class="btn-group btn-group-xs">
										<%-- edit
											<s:if test="%{isTextFile(#fileAttributesVar.name)}" >
												<a
													class="btn btn-default"
													title="Edit: <s:property value="#fileAttributesVar.name"/>"
													href="<s:url namespace="/do/FileBrowser" action="edit" >
														<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/></s:param>
														<s:param name="filename"> <s:property escape="false" value="#fileAttributesVar.name"/></s:param>
													</s:url>">
														<span class="icon fa fa-pencil-square-o"></span>
														<span class="sr-only">
															Edit: <s:property value="#fileAttributesVar.name"/>
														</span>
												</a>
											</s:if>
										--%>
										<%--download:--%>
											<a
												class="btn btn-default"
												title="Download: <s:property value="#fileAttributesVar.name"/>"
												href="<s:url namespace="/do/FileBrowser" action="download" >
													<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/></s:param>
													<s:param name="filename"> <s:property escape="false" value="#fileAttributesVar.name"/></s:param>
												</s:url>">
													<span class="icon fa fa-download"></span>
														<span class="sr-only">
															Download: <s:property value="#fileAttributesVar.name"/>
														</span>
											</a>
									</div>
								</s:if>
								<div class="btn-group btn-group-xs">
									<a
										class="btn btn-warning"
										title="Delete: <s:property value="#fileAttributesVar.name"/>"
										href="<s:url namespace="/do/FileBrowser" action="deleteEntry" >
											<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/></s:param>
											<s:param name="filename"><s:property escape="false" value="#fileAttributesVar.name"/></s:param>
											<s:param name="deleteFile" value="%{!#fileAttributesVar.directory}" />
										</s:url>">
										<span class="icon fa fa-times-circle-o"></span>
										<span class="sr-only">
											Delete: <s:property value="#fileAttributesVar.name"/>
										</span>
									</a>
								</div>
							</td>

						<%-- name --%>
							<td>
								<s:if test="#fileAttributesVar.directory">
									<a class="display-block" href="<s:url namespace="/do/FileBrowser" action="list" >
											<s:param name="currentPath"><s:property escape="true" value="currentPath"/><s:property escape="true" value="#fileAttributesVar.name"/></s:param>
										</s:url>">
											<span class="icon fa fa-folder"></span>
											<span class="sr-only">Folder</span>
											<s:property value="#fileAttributesVar.name"/>
									</a>
								</s:if>
								<s:else>
									<span class="sr-only">File</span>
										<s:if test="%{isTextFile(#fileAttributesVar.name)}" >
											<a
												class="display-block"
												title="Edit: <s:property value="#fileAttributesVar.name"/>"
												href="<s:url namespace="/do/FileBrowser" action="edit" >
													<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/></s:param>
													<s:param name="filename"> <s:property escape="false" value="#fileAttributesVar.name"/></s:param>
												</s:url>">
													<span class="icon fa fa-file-text"></span>
													<s:property value="#fileAttributesVar.name"/>
											</a>
										</s:if>
										<s:else>
												<a
												class="display-block"
												title="Download: <s:property value="#fileAttributesVar.name"/>"
												href="<s:url namespace="/do/FileBrowser" action="download" >
													<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/></s:param>
													<s:param name="filename"> <s:property escape="false" value="#fileAttributesVar.name"/></s:param>
												</s:url>">
													<span class="icon fa fa-file-archive"></span>
													<s:property value="#fileAttributesVar.name"/>
											</a>
										</s:else>
								</s:else>
							</td>
						<%-- last edit --%>
							<td class="text-center" title="<s:date name="%{#fileAttributesVar.lastModifiedTime}" format="dd/MM/yyyy, HH:mm:ss" />">
								<s:if test="#fileAttributesVar.directory">
									<span class="sr-only">N.A</span>
								</s:if>
								<s:else>
									<code>
										<s:date name="%{#fileAttributesVar.lastModifiedTime}" nice="true" format="EEEE dd/MMM/yyyy, HH:mm:ss" />
									</code>
								</s:else>
							</td>
						<%-- size --%>
							<td>
								<s:if test="#fileAttributesVar.directory">
									<span class="sr-only">N.A</span>
								</s:if>
								<s:else>
									<s:property value="#fileAttributesVar.length()"/>
								</s:else>
							</td>
				</s:iterator>
	<s:if test="#filesAttributes.length>0">
			</table>
		</div>
	</s:if>

	<div class="">
		<p class="btn-group btn-group-sm">
			<a
				class="btn btn-default"
				href="<s:url namespace="/do/FileBrowser" action="uploadFile" >
				<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/><s:property escape="true" value="%{#file.name}"/></s:param>
			</s:url>">
				<span class="icon fa fa-upload"></span>&#32;
				Upload a file
			</a>
			<a
				class="btn btn-default"
				href="<s:url namespace="/do/FileBrowser" action="newFileEntry" >
					<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/></s:param>
				</s:url>">
					<span class="icon fa fa-file-text"></span>&#32;
					New Text File
			</a>
			<a
				class="btn btn-default"
				href="<s:url namespace="/do/FileBrowser" action="newDirEntry" >
					<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/></s:param>
				</s:url>">
					<span class="icon fa fa-folder"></span>&#32;
					New Dir
			</a>
		</p>
	</div>
</div>
