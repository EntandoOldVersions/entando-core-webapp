<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>


<a
	href="<s:url namespace="/do/FileBrowser" action="uploadFile" >
		<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/><s:property escape="true" value="%{#file.name}"/></s:param>
	</s:url>">UPLOAD NEW FILE
</a>
<s:form action="edit" namespace="/do/FileBrowser">
	<s:hidden value="%{currentPath}" name="currentPath" />
	filename:<s:textfield name="filename" />
	<s:submit name="createByName" value="createByName" />

</s:form>
	
	
<a
	href="<s:url namespace="/do/FileBrowser" action="newFileEntry" >
		<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/></s:param>
	</s:url>">CREATE NEW FILE
</a>

<a
	href="<s:url namespace="/do/FileBrowser" action="newDirEntry" >
		<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/></s:param>
	</s:url>">CREATE NEW DIR
</a>
</br>


<s:iterator value="fileList" var="file" status="fileStatus">

	</br>
	root:<s:property value="%{isRootResource()}"/>
	
	
	<s:if test="#fileStatus.count == 1 && rootResource">
		this first element is the current directory
		<a
		href="<s:url namespace="/do/FileBrowser" action="list" >
			<s:param name="currentPath"></s:param>
		</s:url>"><s:property escape="false" value="#file.name"/></a>
	</s:if>
	<s:elseif test="#fileStatus.count == 1">
		<a
		href="<s:url namespace="/do/FileBrowser" action="list" >
			<s:param name="currentPath"><s:property escape="true" value="subpathForParent"/></s:param>
		</s:url>"><s:property escape="false" value="#file.name"/>
	</a>
	</s:elseif>
	<s:else>
		<a
		href="<s:url namespace="/do/FileBrowser" action="list" >
			<s:param name="currentPath"><s:property escape="true" value="currentPath"/><s:property escape="true" value="#file.name"/></s:param>
		</s:url>"><s:property escape="false" value="#file.name"/>
	</a>
	</s:else>
	parent: <s:property escape="false" value="#file.parent"/>
	</br>
	Absolute Path: <s:property escape="false" value="#file.absolutePath"/>
	</br>
	path: <s:property escape="false" value="#file.path"/>
	</br>

	directory:<s:property escape="false" value="#file.directory"/>
	</br>

	hidden:<s:property escape="false" value="#file.hidden"/>
	</br>
	

	nomefile: <s:property escape="false" value="#file.name"/>
	</br>
	download:
	<a

		href="<wp:resourceURL/><s:property escape="false" value="currentPath"/><s:property escape="false" value="#file.name"/>"><s:property escape="false" value="#file.name"/>
	</a>
	</br>
	<a
		href="<s:url namespace="/do/FileBrowser" action="edit" >
			<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/>
				</s:param>
			<s:param name="filename"> <s:property escape="false" value="#file.name"/>
			</s:param>
		</s:url>">EDIT: <s:property escape="false" value="#file.name"/>
	</a>
	</br>
	currentPath + filename <s:property escape="true" value="%{currentPath + File.separator +  #file.name}"/>
	</br>
	size: <s:property escape="false" value="#file.length()"/>
	</br>

	last modify date:<s:date name="%{new java.util.Date(#file.lastModified())}" format="EEEE dd/MMM/yyyy, HH:mm:ss" />
	</br>

	last modify (long):<s:property escape="false" value="#file.lastModified()"/>
	</br></br>
	<a
		href="<s:url namespace="/do/FileBrowser" action="deleteEntry" >
			<s:param name="currentPath"><s:property escape="true" value="%{currentPath}"/>
				</s:param>
			<s:param name="filename"><s:property escape="false" value="#file.name"/>
			</s:param>
		</s:url>">DELETE : <s:property escape="false" value="#file.name"/>
	</a>
	</br>

</form>
</s:iterator>
