<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

NEW FILE

<s:form action="save" namespace="/do/FileBrowser" method="post" >
	<s:hidden name="currentPath" />
	<s:hidden name="strutsAction" />
	filename <s:textfield name="filename"/>.<s:select list="textFileTypes" name="textFileExtension" /> 
	<br />
	<wpsf:textarea name="fileText" rows="15" cols="50" value="%{fileText}"/>
	<br />
	
	<s:submit name="save" id="save" value="%{getText('label.save')}" />
	<wpsf:submit useTabindexAutoIncrement="true" action="list" value="%{getText('label.cancel')}" />
</s:form>