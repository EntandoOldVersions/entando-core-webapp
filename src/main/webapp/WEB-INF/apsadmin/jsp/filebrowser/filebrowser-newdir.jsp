<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib prefix="jacms" uri="/jacms-apsadmin-core" %>
NEW DIR

<s:form 
	action="createDir"
	namespace="/do/FileBrowser"
	method="post" >
	<s:hidden name="currentPath" value="%{currentPath}" />
	dir <s:textfield name="dirname"/> 
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