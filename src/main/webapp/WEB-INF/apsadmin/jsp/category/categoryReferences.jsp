<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<h1><a href="<s:url action="viewTree" namespace="/do/Category" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.categoryManagement" />"><s:text name="title.categoryManagement" /></a></h1>

<div id="main">

<div class="message message_error">
<h2><s:text name="message.title.ActionErrors" /></h2>
<p><s:text name="message.note.resolveReferences" />:</p>

</div>

<s:include value="/WEB-INF/apsadmin/jsp/category/include/categoryInfo-references.jsp" />

</div>