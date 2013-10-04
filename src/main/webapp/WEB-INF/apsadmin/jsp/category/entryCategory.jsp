<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1><a href="<s:url action="viewTree" namespace="/do/Category" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.categoryManagement" />"><s:text name="title.categoryManagement" /></a></h1>

<div id="main">

<s:if test="strutsAction == 1">
	<h2 class="margin-more-bottom"><s:text name="title.newCategory" /></h2>
</s:if>
<s:elseif test="strutsAction == 2">
	<h2 class="margin-more-bottom"><s:text name="title.editCategory" /></h2>
</s:elseif>

<s:if test="strutsAction == 2"><s:set var="breadcrumbs_pivotCategoryCode" value="categoryCode" /></s:if>
<s:else><s:set var="breadcrumbs_pivotCategoryCode" value="parentCategoryCode" /></s:else>
<s:include value="/WEB-INF/apsadmin/jsp/category/include/categoryInfo_breadcrumbs.jsp" />

<s:form action="save">
	<s:if test="hasFieldErrors()">
<div class="message message_error">
<h3><s:text name="message.title.FieldErrors" /></h3>	
	<ul>
	<s:iterator value="fieldErrors">
		<s:iterator value="value">
		<li><s:property escape="false" /></li>
		</s:iterator>
	</s:iterator>
	</ul>
</div>
	</s:if>

<p class="sr-only">
	<wpsf:hidden name="strutsAction" />
</p>
<s:if test="getStrutsAction() == 2"><wpsf:hidden name="categoryCode" /></s:if>
<p class="sr-only">
	<wpsf:hidden name="parentCategoryCode" />
</p>

<fieldset><legend><s:text name="label.info" /></legend>
<p>
	<label for="categoryCode" class="basic-mint-label"><s:text name="name.categoryCode" />:</label>
<s:if test="getStrutsAction() != 2">
	<wpsf:textfield useTabindexAutoIncrement="true" name="categoryCode" id="categoryCode" cssClass="text" />
	<wpsf:hidden name="selectedNode" value="%{parentCategoryCode}" />
</s:if>
<s:elseif test="getStrutsAction() == 2">
	<wpsf:textfield useTabindexAutoIncrement="true" name="categoryCode" id="categoryCode" disabled="true" cssClass="text" />
	<wpsf:hidden name="selectedNode" value="%{categoryCode}" />
</s:elseif>
</p>

<s:iterator value="langs">
<p>
	<label for="lang<s:property value="code" />" class="basic-mint-label"><span class="monospace">(<s:property value="code" />)</span> <s:text name="name.categoryTitle" />:</label>
	<wpsf:textfield useTabindexAutoIncrement="true" name="%{'lang'+code}" id="%{'lang'+code}" value="%{titles.get(code)}" cssClass="text" />
</p>
</s:iterator>
</fieldset>

<p><wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" /></p>

</s:form>

</div>