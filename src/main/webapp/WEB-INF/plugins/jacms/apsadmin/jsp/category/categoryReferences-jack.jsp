<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="jacmswpsa" uri="/jacms-apsadmin-core" %>

<h3><s:text name="title.category.contentReferenced" /></h3>

<s:if test="null != references['jacmsContentManagerUtilizers']">
<wpsa:subset source="references['jacmsContentManagerUtilizers']" count="10" objectName="contentReferences" advanced="true" offset="5" pagerId="contentManagerReferences">
<s:set name="group" value="#contentReferences" />

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

<table class="generic" id="contentListTable" summary="<s:text name="note.category.referencedContents.summary" />">
<caption><span><s:text name="title.contentList" /></span></caption>
	<tr>
		<th>
			<s:text name="label.description" />
		</th>
		<th>
			<s:text name="label.code" />
		</th>
		<th>
			<s:text name="label.type" />
		</th>
		<th>
			<s:text name="label.lastEdit" />
		</th>
	</tr>
	<s:iterator var="currentContentIdVar" >
		<jacmswpsa:content contentId="%{#currentContentIdVar}" var="currentContentRecordVar" record="true" />
		<tr>
			<jacmswpsa:content contentId="%{#currentContentRecordVar.id}" var="currentContentVar" authToEditVar="isAuthToEditVar" workVersion="true" />
			<td>
				<s:if test="#isAuthToEditVar">
					<a href="<s:url action="edit" namespace="/do/jacms/Content"><s:param name="contentId" value="#currentContentVar.id" /></s:url>" title="<s:text name="label.edit" />:&#32;<s:property value="#currentContentVar.descr"/>"><s:property value="#currentContentVar.descr"/></a>
				</s:if>
				<s:else><s:property value="#currentContentVar.descr"/></s:else>
				<s:set var="isAuthToEditVar" value="%{false}" />
			</td>
			<td>
				<span class="monospace"><s:property value="#currentContentVar.id"/></span>
			</td>
			<td>
				<s:property value="#currentContentVar.typeDescr"/>
			</td>
			<td class="icon">
				<span class="monospace"><s:date name="#currentContentRecordVar.modify" format="dd/MM/yyyy" /></span>
			</td>
		</tr>
	</s:iterator>
</table>

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

</wpsa:subset>
</s:if>
<s:else>
<p><s:text name="note.category.referencedContents.empty" /></p>
</s:else>

<div class="subsection-light">
<h3><s:text name="title.category.resourcesReferenced" /></h3>
<s:if test="null != references['jacmsResourceManagerUtilizers']">

<wpsa:subset source="references['jacmsResourceManagerUtilizers']" count="10" objectName="resourceReferences" advanced="true" offset="5" pagerId="resourceManagerReferences">
<s:set name="group" value="#resourceReferences" />

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

<table class="generic" id="contentListTable" summary="<s:text name="note.category.referencedResources.summary" />">
<caption><span><s:text name="title.resourceList" /></span></caption>
	<tr>
		<th>
			<s:text name="label.description" />
		</th>
		<th>
			<s:text name="label.code" />
		</th>
		<th>
			<s:text name="label.type" />
		</th>
	</tr>
	<s:iterator var="currentResourceIdVar" >
		<jacmswpsa:resource resourceId="%{#currentResourceIdVar}" var="currentResourceVar" />
		<tr>
			<s:set var="canEditCurrentResource" value="%{false}" />
			<c:set var="currentResourceGroup"><s:property value="#currentResourceVar.mainGroup" escape="false"/></c:set>
			<td>
				<wp:ifauthorized groupName="${currentResourceGroup}" permission="manageResources"><s:set var="canEditCurrentResource" value="%{true}" /></wp:ifauthorized>
				<s:if test="#canEditCurrentResource">
					<a href="<s:url action="edit" namespace="/do/jacms/Resource"><s:param name="resourceId" value="#currentResourceVar.id" /></s:url>" title="<s:text name="label.edit" />:&#32;<s:property value="#currentResourceVar.descr"/>"><s:property value="#currentResourceVar.descr"/></a>
				</s:if>
				<s:else><s:property value="#currentResourceVar.descr"/></s:else>
			</td>
			<td>
				<span class="monospace"><s:property value="#currentResourceVar.id"/></span>
			</td>
			<td>
				<s:property value="#currentResourceVar.type"/>
			</td>
		</tr>
	</s:iterator>
</table>

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

</wpsa:subset>
</s:if>
<s:else>
<p><s:text name="note.category.referencedResources.empty" /></p>
</s:else>
</div>