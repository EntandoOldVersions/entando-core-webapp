<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

DELETE

<s:form action="delete" namespace="/do/FileBrowser" method="post" >
	<s:hidden name="deleteFile" />
	<s:hidden name="currentPath" />
	<s:hidden name="filename" />
	file:
	currentPath:<s:property value="%{currentPath}" />
	<br />
	<s:if test="deleteFile">FILE</s:if><s:else>DIRECTORY</s:else>:
	<s:property value="%{filename}" />
	<br />
	<br />
	REMOVE?
	<br />
	<br />
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.delete')}" />
	<wpsf:submit useTabindexAutoIncrement="true" action="list" value="%{getText('label.cancel')}" />
</s:form>
