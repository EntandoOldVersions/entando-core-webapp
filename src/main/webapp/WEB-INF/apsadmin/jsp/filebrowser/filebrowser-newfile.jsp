<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib prefix="jacms" uri="/jacms-apsadmin-core" %>
NEW FILE

<s:form 
	action="save"
	namespace="/do/FileBrowser"
	method="post" >
	<s:hidden name="currentPath" value="%{currentPath}" />
	filename <s:textfield name="filename"/> 
	
	<wpsf:textarea name="fileText" rows="15" cols="50" value="%{fileText}"/>
	</br>
	
	<s:submit name="save" id="save" >save</s:submit>
	<wpsf:submit 
		useTabindexAutoIncrement="true" 
		action="list"
		value="%{getText('label.cancel')}" 
		/>
</s:form>