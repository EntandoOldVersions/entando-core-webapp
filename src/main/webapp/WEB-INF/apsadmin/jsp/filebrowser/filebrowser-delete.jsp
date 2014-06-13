<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib prefix="jacms" uri="/jacms-apsadmin-core" %>
DELETE

<s:form 
	action="delete"
	namespace="/do/FileBrowser"
	method="post" >
	<s:hidden name="currentPath" value="%{currentPath}" />
	<s:hidden name="filename" value="%{filename}" />
	file:
	currentPath:<s:property value="%{currentPath}" />
	filename:<s:property value="%{filename}" />
	<br/>
	<br/>
	REMOVE?
	<br/>
	<br/>
	<wpsf:submit 
		useTabindexAutoIncrement="true" 
		value="%{getText('label.delete')}"
		/>
	<wpsf:submit 
		useTabindexAutoIncrement="true" 
		action="list"
		value="%{getText('label.cancel')}" 
		/>
</s:form>
