<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<s:form action="save" namespace="/do/FileBrowser">
	<s:hidden name="currentPath" value="%{currentPath}" />
	currentPath:<s:property value="currentPath" />
	<s:hidden name="filename" value="%{filename}"/>
	</br>
	fileText:<s:property value="fileText" />
	</br>
	
	<wpsf:textarea name="fileText" rows="15" cols="50" value="%{fileText}"/>
	</br>
	<s:submit name="save" id="save" >save</s:submit>
	<wpsf:submit 
		useTabindexAutoIncrement="true"
		action="list"
		value="%{getText('label.cancel')}" 
		/>
</s:form>
