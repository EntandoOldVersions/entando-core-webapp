<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1><a href="<s:url action="viewTree" namespace="/do/Page" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.pageManagement" />"><s:text name="title.pageManagement" /></a></h1>

<div id="main">
<h2><s:text name="title.configPage" /></h2>

<s:set var="breadcrumbs_pivotPageCode" value="pageCode" />
<s:include value="/WEB-INF/apsadmin/jsp/portal/include/pageInfo_breadcrumbs.jsp" />

<div class="subsection-light">
<h3><s:text name="title.configPage.youAreDoing" /></h3>

<s:action namespace="/do/Page" name="printPageDetails" executeResult="true" ignoreContextParams="true"><s:param name="selectedNode" value="pageCode"></s:param></s:action>
<s:include value="/WEB-INF/apsadmin/jsp/portal/include/frameInfo.jsp" />

<h3 class="margin-more-bottom margin-more-top"><s:text name="name.showlet" />:&#32;<s:property value="%{getTitle(showlet.type.code, showlet.type.titles)}" /></h3>
<s:form action="saveConfigSimpleParameter">
<p class="sr-only">
	<wpsf:hidden name="pageCode" />
	<wpsf:hidden name="frame" />
	<wpsf:hidden name="showletTypeCode" value="%{showlet.type.code}" />
</p>

<fieldset><legend><s:text name="title.editFrame.settings" /></legend>
<s:iterator value="showlet.type.typeParameters" id="showletParam" >
<p>
	<em><s:property value="#showletParam.descr" />:</em><br />
	<label for="<s:property value="#showletParam.name" />" class="basic-mint-label"><s:property value="#showletParam.name" /></label>
	<wpsf:textfield useTabindexAutoIncrement="true" id="%{#showletParam.name}" name="%{#showletParam.name}" value="%{showlet.config[#showletParam.name]}" />
</p>
</s:iterator>
</fieldset>
<p><wpsf:submit useTabindexAutoIncrement="true" cssClass="button" /></p>

</s:form>

</div>
</div>