<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set var="targetNS" value="%{'/do/jacms/Content'}" />
<h1><s:text name="jacms.menu.contentAdmin" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>
<h2><s:text name="title.contentManagement.trashContent" /></h2>

<s:form action="deleteContentGroup">

<p class="sr-only">
	<s:iterator var="contentIdToDelete" value="contentIds"><wpsf:hidden name="contentIds" value="%{#contentIdToDelete}" /></s:iterator>
	<wpsf:hidden name="text" />
	<wpsf:hidden name="contentType" />
	<wpsf:hidden name="state" />
	<wpsf:hidden name="onLineState" />
	<wpsf:hidden name="categoryCode" />
	<wpsf:hidden name="viewTypeDescr" />
	<wpsf:hidden name="viewGroup" />
	<wpsf:hidden name="viewCode" />
	<wpsf:hidden name="viewStatus" />
	<wpsf:hidden name="viewCreationDate" />
	<wpsf:hidden name="lastGroupBy" />
	<wpsf:hidden name="lastOrder" />
	<wpsf:hidden name="contentIdToken" />
	<wpsf:hidden name="ownerGroupName" />
	<s:set var="searcheableAttributes" value="searcheableAttributes" ></s:set>
	<s:if test="null != #searcheableAttributes && #searcheableAttributes.size() > 0">
	<s:iterator var="attribute" value="#searcheableAttributes">
		<s:if test="#attribute.textAttribute">
			<s:set name="textInputFieldName" ><s:property value="#attribute.name" />_textFieldName</s:set>
			<wpsf:hidden name="%{#textInputFieldName}" value="%{getSearchFormFieldValue(#textInputFieldName)}" />
		</s:if>
		<s:elseif test="#attribute.type == 'Date'">
			<s:set name="dateStartInputFieldName" ><s:property value="#attribute.name" />_dateStartFieldName</s:set>
			<s:set name="dateEndInputFieldName" ><s:property value="#attribute.name" />_dateEndFieldName</s:set>
			<wpsf:hidden name="%{#dateStartInputFieldName}" value="%{getSearchFormFieldValue(#dateStartInputFieldName)}" />
			<wpsf:hidden name="%{#dateEndInputFieldName}" value="%{getSearchFormFieldValue(#dateEndInputFieldName)}" />
		</s:elseif>
		<s:elseif test="#attribute.type == 'Number'">
			<s:set name="numberStartInputFieldName" ><s:property value="#attribute.name" />_numberStartFieldName</s:set>
			<s:set name="numberEndInputFieldName" ><s:property value="#attribute.name" />_numberEndFieldName</s:set>
			<wpsf:hidden name="%{#numberStartInputFieldName}" value="%{getSearchFormFieldValue(#numberStartInputFieldName)}" />
			<wpsf:hidden name="%{#numberEndInputFieldName}" value="%{getSearchFormFieldValue(#numberEndInputFieldName)}" />
		</s:elseif>
		<s:elseif test="#attribute.type == 'Boolean' || #attribute.type == 'ThreeState'"> 
			<s:set name="booleanInputFieldName" ><s:property value="#attribute.name" />_booleanFieldName</s:set>
			<wpsf:hidden name="%{#booleanInputFieldName}" value="%{getSearchFormFieldValue(#booleanInputFieldName)}" />
		</s:elseif>
	</s:iterator>
	</s:if>
</p>

<p><s:text name="note.trashContent.areYouSure" />?</p>
<ul>
<s:iterator id="contentIdToDelete" value="contentIds">
<s:set name="content" value="%{getContentVo(#contentIdToDelete)}"></s:set>
	<li><span class="monospace"><s:property value="#contentIdToDelete" /></span> &ndash; <s:property value="#content.descr" /> (<s:property value="%{getSmallContentType(#content.typeCode).descr}" />)</li>
</s:iterator>
</ul>
<p><wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.remove')}" cssClass="button" /></p>
</s:form>