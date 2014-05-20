<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

NEW DIR

<s:form action="createDir" namespace="/do/FileBrowser" method="post" >
	<s:hidden name="currentPath" />
	<s:hidden name="strutsAction" />
	dir <s:textfield name="dirname"/> 
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.new')}" />
	<wpsf:submit useTabindexAutoIncrement="true" action="list" value="%{getText('label.cancel')}" />
</s:form>