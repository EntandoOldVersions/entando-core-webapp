<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>


<a href="<s:url namespace="/do/FileBrowser" action="uploadFile" >
		<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/><s:property escape="true" value="%{#file.name}"/></s:param>
	</s:url>">UPLOAD NEW FILE
</a>
<s:form action="edit" namespace="/do/FileBrowser">
	<s:hidden name="currentPath" />
	filename:<s:textfield name="filename" />
	<s:submit name="createByName" value="createByName" />
</s:form>

<br />

<a href="<s:url namespace="/do/FileBrowser" action="newFileEntry" >
		<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/></s:param>
	</s:url>">CREATE NEW FILE
</a>
&nbsp;&ndash;&nbsp;
<a href="<s:url namespace="/do/FileBrowser" action="newDirEntry" >
		<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/></s:param>
	</s:url>">CREATE NEW DIR
</a>
<br />
<br />
<s:include value="/WEB-INF/apsadmin/jsp/filebrowser/include/breadcrumbs.jsp" />
<br />
<br />

<s:iterator value="filesAttributes" var="fileAttributesVar" status="fileStatus">
	
	<s:if test="#fileAttributesVar.directory">DIRECTORY</s:if><s:else>FILE</s:else>
	
	<s:if test="#fileAttributesVar.directory">
	<!-- THIS IS A DIRECTORY -->
	<a href="<s:url namespace="/do/FileBrowser" action="list" >
			<s:param name="currentPath"><s:property escape="true" value="currentPath"/><s:property escape="true" value="#fileAttributesVar.name"/></s:param>
		</s:url>"><s:property escape="false" value="#fileAttributesVar.name"/>
	</a>
	<br />
	</s:if>
	
	<s:else>
	<!-- THIS IS A FILE -->
	<s:property escape="false" value="#fileAttributesVar.name"/>
	<br />
	last modify date:<s:date name="%{#fileAttributesVar.lastModifiedTime}" format="EEEE dd/MMM/yyyy, HH:mm:ss" />
	<br />
	size: <s:property escape="false" value="#fileAttributesVar.length()"/>
	<br />
	</s:else>
	
	<s:if test="!#fileAttributesVar.directory">
	<%--download:--%>
	<a href="<wp:resourceURL/><s:property escape="false" value="currentPath"/><s:property escape="false" value="#fileAttributesVar.name"/>">DOWNLOAD</a>
	&nbsp;&ndash;&nbsp;
	<a href="<s:url namespace="/do/FileBrowser" action="edit" >
			<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/></s:param>
			<s:param name="filename"> <s:property escape="false" value="#fileAttributesVar.name"/></s:param>
		</s:url>">EDIT</a>
	&nbsp;&ndash;&nbsp;
	</s:if>
	
	<a href="<s:url namespace="/do/FileBrowser" action="deleteEntry" >
			<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/></s:param>
			<s:param name="filename"><s:property escape="false" value="#fileAttributesVar.name"/></s:param>
			<s:param name="deleteFile" value="%{!#fileAttributesVar.directory}" />
		</s:url>">DELETE</a>
	<br />
	<br />
	
</form>
</s:iterator>
