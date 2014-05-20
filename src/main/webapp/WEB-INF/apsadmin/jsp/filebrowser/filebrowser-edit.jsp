<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<s:form action="save" namespace="/do/FileBrowser">
	<s:hidden name="currentPath" />
	<s:hidden name="filename" />
	<s:hidden name="strutsAction" />
	currentPath:<s:property value="currentPath" />
	<br />
	file:<s:property value="filename" />
	<br />
	<wpsf:textarea name="fileText" rows="15" cols="50" value="%{fileText}"/>
	<br />
	<s:submit name="save" id="save" value="%{getText('label.save')}" />
	<wpsf:submit useTabindexAutoIncrement="true" action="list" value="%{getText('label.cancel')}" />
</s:form>
