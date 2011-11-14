<%@ taglib prefix="s" uri="/struts-tags" %>
<dl class="table-display">
	<dt><s:text name="name.position" /></dt>
	<dd><s:property value="frame"/></dd>

	<dt><s:text name="label.description" /></dt>
	<dd><s:property value="currentPage.getModel().getFrames()[frame]"/></dd>
</dl>