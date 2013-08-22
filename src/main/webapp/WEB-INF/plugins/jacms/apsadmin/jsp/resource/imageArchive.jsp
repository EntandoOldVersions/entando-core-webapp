<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="jacms" uri="/jacms-apsadmin-core" %>

<s:if test="onEditContent">
	<s:set var="targetNS" value="%{'/do/jacms/Content'}" />
	<h1 class="panel panel-default title-page"><span class="panel-body display-block">
	<s:text name="jacms.menu.contentAdmin" />&#32;/&#32;
	<s:if test="getStrutsAction() == 1"><s:text name="label.new" /></s:if><s:else><s:text name="label.edit" /></s:else>&#32;/&#32;
	<s:property value="%{getText('title.' + resourceTypeCode + 'Management')}" />
	</span></h1>
	<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/include/snippet-content.jsp" />
</s:if>

<s:if test="!onEditContent">
	<s:set var="targetNS" value="%{'/do/jacms/Resource'}" />
	<s:set var="targetParamName" value="%{'resourceTypeCode'}" />
	<s:set var="targetParamValue" value="resourceTypeCode" />
	<h1 class="panel panel-default title-page"><span class="panel-body display-block"><s:property value="%{getText('title.' + resourceTypeCode + 'Management')}" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></span></h1>
</s:if>

<s:form action="search" cssClass="form-horizontal">
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
	<div class="form-group">

		<label for="text" class="sr-only"><s:text name="label.search.by"/>&#32;<s:text name="label.description"/></label>
		<div class="input-group col-sm-12">
			<span class="input-group-addon">
				<span class="icon icon-file-text-alt icon-large"></span>
			</span>
			<s:textfield name="text" id="text" cssClass="form-control input-lg" placeholder="TODO Description" title="%{getText('label.search.by')} %{getText('label.description')}" />
			<div class="input-group-btn">
				<s:submit type="button" cssClass="btn btn-primary btn-lg">
					<span class="icon icon-search" title="<s:text name="label.search" />"></span>
				</s:submit>
			</div>
		</div>
		<p class="help-block text-right">
			<button type="button" data-toggle="collapse" data-target="#search-advanced"  class="btn btn-link">
				<s:text name="title.searchFilters" />&#32;<span class="icon-chevron-down"></span>
			</button>
		</p>
	</div>
	<div id="search-advanced" class="collapse">

		<div class="form-group">
			<s:set var="allowedGroupsVar" value="allowedGroups"></s:set>
			<s:if test="null != #allowedGroupsVar && #allowedGroupsVar.size()>1">
				<label for="ownerGroupName" class="control-label col-sm-2 text-right"><s:text name="label.group" /></label>
				<div class="col-sm-5">
					<s:select name="ownerGroupName" id="ownerGroupName" list="#allowedGroupsVar" headerKey="" headerValue="%{getText('label.all')}" listKey="name" listValue="descr" cssClass="form-control" />
				</div>
			</s:if>
		</div>

		<div class="form-group">
			<label for="fileName" class="control-label col-sm-2 text-right"><s:text name="label.filename" /></label>
			<div class="col-sm-5">
				<s:textfield name="fileName" id="fileName" cssClass="form-control"/>
			</div>
		</div>

		<div class="form-group">
			<label class="control-label col-sm-2 text-right">
				<s:text name="label.category" />
			</label>
			<div class="col-sm-5">
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

		<div class="form-group">
			<div class="col-sm-5 col-sm-offset-2">
				<s:submit type="button" cssClass="btn btn-primary">
					<span class="icon icon-search"></span>&#32;<s:text name="label.search" />
				</s:submit>
			</div>
		</div>
	</div>
</s:form>

<s:if test="onEditContent">
	<wp:ifauthorized permission="manageResources">
		<a href="
			<s:url action="new" >
				<s:param name="resourceTypeCode" >Image</s:param><s:param name="contentOnSessionMarker" value="contentOnSessionMarker" />
			</s:url>"
			class="btn btn-default">
			<span class="icon icon-plus-sign"></span>&#32;
			<s:text name="label.new" />&#32;<s:text name="label.image" />
		</a>
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

		<s:url var="URLedit" action="edit" namespace="/do/jacms/Resource">
			<s:param name="resourceId" value="%{#resourceid}" />
		</s:url>
		<s:url var="URLuse" action="joinResource" namespace="/do/jacms/Content/Resource">
			<s:param name="resourceId" value="%{#resourceid}" />
			<s:param name="contentOnSessionMarker" value="contentOnSessionMarker" />
		</s:url>

		<s:url var="URLtrash" action="trash" namespace="/do/jacms/Resource">
			<s:param name="resourceId" value="%{#resourceid}" />
			<s:param name="resourceTypeCode" value="%{#resource.type}" />
			<s:param name="text" value="%{text}" />
			<s:param name="categoryCode" value="%{categoryCode}" />
			<s:param name="fileName" value="%{fileName}" />
			<s:param name="ownerGroupName" value="%{ownerGroupName}" />
			<s:param name="treeNodesToOpen" value="%{treeNodesToOpen}" />
		</s:url>

		<div class="col-lg-3">
			<div class="panel panel-default text-center">

			<s:if test="!onEditContent">
				<div class="panel-heading text-right padding-small-vertical padding-small-right">
					<a href="<s:property value="URLtrash" escape="false" />" class="icon icon-remove text-warning">
						<span class="sr-only">Delete</span>
					</a>
				</div>
			</s:if>

				<%-- Dimension forced for img thumbnail --%>
				<img src="<s:property value="%{#resource.getImagePath(1)}"/>" alt=" " style="height:90px;max-width:130px" class="margin-small-top" />

				<div class="btn-group margin-small-vertical">
				<s:if test="!onEditContent">
					<a href="<s:property value="URLedit" escape="false" />"
						 class="btn btn-default"
						 title="<s:text name="label.edit" />: <s:property value="#resource.descr" />">
						<span class="icon icon-edit"></span>&#32;
						<s:text name="label.edit" />
					</a>
				</s:if>
				<s:else>
					<a href="<s:property value="URLuse" escape="false" />"
						 class="btn btn-primary"
						 title="<s:text name="note.joinThisToThat" />:	<s:property value="content.descr" />" >
						<span class="icon icon-picture"></span>&#32;
						<s:text name="label.use"/>
					</a>
				</s:else>
					<button type="button" class="btn btn-info" data-toggle="popover" data-title="<s:property value="#resource.descr" />">
						<span class="icon icon-info"></span>
						<span class="sr-only"><s:text name="label.info" /></span>
					</button>
				</div>

				<s:set var="fileInfo">
					<s:include value="imageArchive-file-info.jsp" />
				</s:set>

				<script>
					$("[data-toggle=popover]").popover({
						html: true,
						content: '<s:property value="fileInfo" escape="false" />'
					});
				</script>

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