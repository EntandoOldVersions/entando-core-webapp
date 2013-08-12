<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="jacms" uri="/jacms-apsadmin-core" %>

<s:if test="onEditContent">
<s:set var="targetNS" value="%{'/do/jacms/Content'}" />
<h1 class="panel title-page"><s:text name="jacms.menu.contentAdmin" />&#32;/&#32;<s:text name="title.contentEditing" /></h1>
<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/include/snippet-content.jsp" />

<%--
 	<s:if test="content.id == null"> NUOVO </s:if>
	<s:else> CON ID '<s:property value="content.id" />' </s:else>
  --%>
<h3 class="margin-bit-bottom"><s:text name="title.chooseImage" /></h3>
</s:if>

<s:if test="!onEditContent">
	<s:set var="targetNS" value="%{'/do/jacms/Resource'}" />
	<s:set var="targetParamName" value="%{'resourceTypeCode'}" />
	<s:set var="targetParamValue" value="resourceTypeCode" />
	<h1 class="panel title-page"><s:property value="%{getText('title.resourceManagement.' + resourceTypeCode)}" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>
</s:if>

<s:form action="search" cssClass="tab-container action-form">
<s:set var="categoryTreeStyleVar" ><wp:info key="systemParam" paramName="treeStyle_category" /></s:set>

<p class="sr-only">
<s:hidden name="resourceTypeCode" />
<s:if test="#categoryTreeStyleVar == 'request'">
<s:iterator value="treeNodesToOpen" var="treeNodeToOpenVar">
<s:hidden name="treeNodesToOpen" value="%{#treeNodeToOpenVar}"/>
</s:iterator>
</s:if>
<s:hidden name="contentOnSessionMarker" />
</p>
<p>
	<label for="text" class="label-control"><s:text name="label.search.by"/>&#32;<s:text name="label.description"/>:</label>
	<s:textfield name="text" id="text" cssClass="text" />
</p>

<fieldset><legend class="accordion_toggler"><s:text name="title.searchFilters" /></legend>
<div class="accordion_element">

<s:set var="allowedGroupsVar" value="allowedGroups"></s:set>
<s:if test="null != #allowedGroupsVar && #allowedGroupsVar.size()>1">
<p>
	<label for="ownerGroupName" class="label-control"><s:text name="label.group" />:</label>
	<s:select useTabindexAutoIncrement="true" name="ownerGroupName" id="ownerGroupName" list="#allowedGroupsVar"
		headerKey="" headerValue="%{getText('label.all')}" listKey="name" listValue="descr" cssClass="text" />
</p>
</s:if>

<p>
	<label for="fileName" class="label-control"><s:text name="label.filename" />:</label>
	<s:textfield useTabindexAutoIncrement="true" name="fileName" id="fileName" cssClass="text" />
</p>
<div class="subsection-light">
<p class="important">
	<s:text name="label.category" />:
</p>

<ul id="categoryTree">
	<s:set name="inputFieldName" value="'categoryCode'" />
	<s:set name="selectedTreeNode" value="categoryCode" />
	<s:set name="liClassName" value="'category'" />
	<s:if test="#categoryTreeStyleVar == 'classic'">
	<s:set name="currentRoot" value="categoryRoot" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder.jsp" />
	</s:if>
	<s:elseif test="#categoryTreeStyleVar == 'request'">
	<s:set name="currentRoot" value="showableTree" />
	<s:set name="openTreeActionName" value="'openCloseCategoryTreeNodeOnResourceFinding'" />
	<s:set name="closeTreeActionName" value="'openCloseCategoryTreeNodeOnResourceFinding'" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder-request-submits.jsp" />
	</s:elseif>
</ul>
</div>
</div>
</fieldset>
<p><s:submit useTabindexAutoIncrement="true" value="%{getText('label.search')}" cssClass="button" /></p>

</s:form>

<s:if test="onEditContent">
	<wp:ifauthorized permission="manageResources">
		<p><a href="<s:url action="new" >
		<s:param name="resourceTypeCode" >Image</s:param><s:param name="contentOnSessionMarker" value="contentOnSessionMarker" /></s:url>" 
		class="btn btn-default" title="<s:text name="label.new" />&#32;<s:text name="label.image" />"><span class="icon icon-plus-sign"></span>&#32;<s:text name="label.new" />&#32;<s:text name="label.image" /></a></p>
	</wp:ifauthorized>
</s:if>
<s:form action="search">
<p class="sr-only">
	<s:hidden name="text" />
	<s:hidden name="categoryCode" />
	<s:hidden name="resourceTypeCode" />
	<s:hidden name="fileName" />
	<s:hidden name="ownerGroupName" />
<s:if test="#categoryTreeStyleVar == 'request'">
	<s:iterator value="treeNodesToOpen" var="treeNodeToOpenVar">
	<s:hidden name="treeNodesToOpen" value="%{#treeNodeToOpenVar}"/>
	</s:iterator>
</s:if>
	<s:hidden name="contentOnSessionMarker" />
</p>

<wpsa:subset source="resources" count="10" objectName="groupResource" advanced="true" offset="5" >
<s:set name="group" value="#groupResource" />
<div class="pager margin-more-bottom">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

<div class="row">
	<s:set var="imageDimensionsVar" value="imageDimensions" />
	<s:iterator var="resourceid" status="status">
	<s:set name="resource" value="%{loadResource(#resourceid)}" />
	<s:set var="resourceInstance" value='%{#resource.getInstance(0,null)}' />
	<s:set var="URLoriginal" value="%{#resource.getImagePath(0)}" />
	<s:url var="URLedit" action="edit" namespace="/do/jacms/Resource"><s:param name="resourceId" value="%{#resourceid}" /></s:url>
	<s:url var="URLtrash" action="trash" namespace="/do/jacms/Resource">
		<s:param name="resourceId" value="%{#resourceid}" />
		<s:param name="resourceTypeCode" value="%{#resource.type}" />
		<s:param name="text" value="%{text}" />
		<s:param name="categoryCode" value="%{categoryCode}" />
		<s:param name="fileName" value="%{fileName}" />
		<s:param name="ownerGroupName" value="%{ownerGroupName}" />
		<s:param name="treeNodesToOpen" value="%{treeNodesToOpen}" /></s:url>
		<div class="col-lg-3">
		<div class="thumbnail text-center margin-base-bottom">
			<%-- Dimension forced for img on thumbnail --%>
			<img src="<s:property value="%{#resource.getImagePath(1)}"/>" alt=" " style="height:90px;"/>	
			<div class="caption">
			<p class="btn-group margin-small-vertical">
				<s:if test="onEditContent">
					<a href="<s:url action="joinResource" namespace="/do/jacms/Content/Resource">
					<s:param name="resourceId" value="%{#resourceid}" />
					<s:param name="contentOnSessionMarker" value="contentOnSessionMarker" /></s:url>" 
					class="btn btn-primary" 
					title="<s:text name="note.joinThisToThat" />: 
					<s:property value="content.descr" />" >Choose</a>
				</s:if>
				<%-- <s:text name="label.size.original" /> --%>
				<s:if test="!onEditContent">
					<s:if test="#myClient == 'advanced'">
						<%//TODO insert icon and i18n label for "permalink" --%>
						<a class="imageInfoToggler" href="<s:property value="URLoriginal" />" ><img src="<wp:resourceURL />administration/common/img/icons/22x22/detail.png" alt="<s:text name="label.view" />" title="<s:text name="label.view" />" /></a>
					</s:if>
					<s:else>
						<a href="<s:property value="%{#resource.getImagePath(0)}" />" ><s:text name="label.size.original" /></a><br />
					</s:else>
					<span class="sr-only">, </span>
					<a href="<s:property value="URLedit" escape="false" />"><img src="<wp:resourceURL />administration/common/img/icons/edit-content.png" alt="<s:text name="label.edit" />" title="<s:text name="label.edit" />" /></a>
					<span class="sr-only">, </span>
					<a href="<s:property value="URLtrash" escape="false" />"><img src="<wp:resourceURL />administration/common/img/icons/delete.png" alt="<s:text name="label.remove" />" title="<s:text name="label.remove" />" /></a>
					
					<div class="fileinfo">
						<s:set var="fileName" value="#resourceInstance.fileName" />
						<s:if test='%{#fileName.length()>24}'>
						<s:set var="fileName" value='%{#fileName.substring(0,10)+"..."+#fileName.substring(#fileName.length()-10)}' />
							<span class="monospace fileName cursor" title="<s:property value="#resourceInstance.fileName" />"><s:property value="#fileName" /></span>
						</s:if>
						<s:else>
							<span class="monospace fileName">
								<s:property value="#fileName" />
							</span>
						</s:else>
						<span class="monospace fileLength">
							<s:property value="%{#resourceInstance.fileLength.replaceAll(' ', '&nbsp;')}"  escapeXml="false" escapeHtml="false" escapeJavaScript="false" />
						</span>
					</div>
					<div class="imageInfo monospace">
						<span class="slidecrab-closer"><s:text name="label.close" /></span>
						<ul>
							<s:set var="dimensionId" value="0" />
							<s:set var="resourceInstance" value='%{#resource.getInstance(#dimensionId,null)}' />
							<%//TODO check if reaplaceAll of spaces with &nbsp; is a good thing  %>
							<li>
								<a href="<s:property value="%{#resource.getImagePath(#dimensionId)}" />"><span class="filehandler"><s:text name="label.size.original" /></span><span class="filesize"><s:property value='#resourceInstance.fileLength.replaceAll(" ", "&nbsp;")' escapeXml="false" escapeHtml="false" escapeJavaScript="false" /></span></a>
							</li>
							<s:set var="dimensionId" value="null" />
							<s:set var="resourceInstance" value="null" />
							<s:iterator value="#imageDimensionsVar" var="dimInfo">
								<s:set var="dimensionId" value="#dimInfo.idDim" />
								<s:set var="resourceInstance" value='%{#resource.getInstance(#dimensionId,null)}' />
								<s:if test="#resourceInstance != null">
							<li>
									<a href="<s:property value="%{#resource.getImagePath(#dimensionId)}" />"><span class="filehandler"><s:property value="#dimInfo.dimx" />x<s:property value="#dimInfo.dimy" />&nbsp;px</span><span class="filesize"><s:property value='#resourceInstance.fileLength.replaceAll(" ", "&nbsp;")' escapeXml="false" escapeHtml="false" escapeJavaScript="false" /></span></a>
									<%//TODO check if reaplaceAll of spaces with &nbsp; is a good thing  %>				
							</li>
								</s:if>
							</s:iterator>
						</ul>
					</div>
				</s:if>
				<s:set var="info-img"><s:property value="#resource.descr" /></s:set>
				<button type="button" class="btn btn-default" data-toggle="popover" 
				data-html="true" data-content="Ciao" title="" 
				data-original-title="Image info">Info</button>
		</p>
		</div>
		</div>
	</div>
</s:iterator>
</div>


<div class="pager clear margin-more-top">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

</wpsa:subset>

</s:form>

<wp:ifauthorized permission="superuser" >
<s:if test="!onEditContent">
<s:action name="openAdminProspect" namespace="/do/jacms/Resource/Admin" ignoreContextParams="true" executeResult="true">
	<s:param name="resourceTypeCode" value="resourceTypeCode" ></s:param>
</s:action>
</s:if>
</wp:ifauthorized>

</div>