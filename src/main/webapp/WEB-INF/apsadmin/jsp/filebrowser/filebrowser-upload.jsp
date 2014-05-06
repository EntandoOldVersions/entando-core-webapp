<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

UPLOAD

<s:form action="upload" namespace="/do/FileBrowser" method="post" enctype="multipart/form-data">
	<s:hidden name="currentPath" />
	upload:
	<s:file name="upload" id="upload" label="label.file"/>
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" />
	<wpsf:submit useTabindexAutoIncrement="true" action="list" value="%{getText('label.cancel')}" />
</s:form>
