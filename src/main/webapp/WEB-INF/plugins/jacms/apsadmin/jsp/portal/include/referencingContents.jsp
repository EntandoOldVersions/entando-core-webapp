<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="jacmswpsa" uri="/jacms-apsadmin-core" %>

<h3><s:text name="title.referencedContents" /></h3>

<s:if test="!#referencingContentsId.empty">
	<wpsa:subset source="#referencingContentsId" count="10" objectName="contentReferencesGroup" advanced="true" offset="5" pagerId="referencingContentsId">
	<s:set name="group" value="#contentReferencesGroup" />
	<div class="pager">
		<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
		<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
	</div>

	<div class="table-responsive">
		<table class="table table-bordered" id="contentListTable" summary="<s:text name="note.resources.referencingContent.summary" />">
		<caption class="sr-only"><s:text name="title.contentList" /></caption>
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/common/contentReferencesTable_header.jsp" />
			<s:iterator var="currentContentIdVar" value="#referencingContentsId">
				<jacmswpsa:content contentId="%{currentContentIdVar}" record="true" var="currentContentRecordVar" />
				<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/common/contentReferencesTable_row.jsp" />
			</s:iterator>
		</table>
	</div>

	<div class="pager">
		<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
	</div>
	</wpsa:subset>

</s:if>
<s:else>
<p><s:text name="note.referencedContent.empty" /></p>
</s:else>