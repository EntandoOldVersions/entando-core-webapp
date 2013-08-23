<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
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
		<s:iterator value="treeNodesToOpen" var="treeNodeToOpenVar"><s:hidden name="treeNodesToOpen" value="%{#treeNodeToOpenVar}"/></s:iterator>
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
				<ul id="categoryTree" class="icons-ul list-unstyled">
					<s:set name="inputFieldName" value="'categoryCode'" />
					<s:set name="selectedTreeNode" value="categoryCode" />
					<s:set name="liClassName" value="'category'" />
					<s:set name="treeItemIconName" value="'icon-folder-close'" />

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
		<p><a href="<s:url action="new" >
		<s:param name="resourceTypeCode" >Attach</s:param><s:param name="contentOnSessionMarker" value="contentOnSessionMarker" /></s:url>" 
		class="btn btn-default" title="<s:text name="label.new" />&#32;<s:text name="label.attach" />"><span class="icon icon-plus-sign"></span>&#32;<s:text name="label.new" />&#32;<s:text name="label.attach" /></a></p>
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

<s:if test="onEditContent"><h3><s:text name="title.chooseAttach" /></h3><div class="list-group"></s:if>
<s:if test="!onEditContent"><ul></s:if>	
<s:iterator var="resourceid" status="status">
<s:set name="resource" value="%{loadResource(#resourceid)}"></s:set>
<s:set name="resourceInstance" value="%{#resource.getInstance()}"></s:set>
	<s:if test="onEditContent">	
	<a href="<s:url action="joinResource" namespace="/do/jacms/Content/Resource"><s:param name="resourceId" value="%{#resourceid}" /><s:param name="contentOnSessionMarker" value="contentOnSessionMarker" /></s:url>" 
	title="<s:text name="label.use"/>" class="list-group-item" >
		<s:if test="!#resource.categories.empty">
		<div class="row"><div class="col-lg-12">
			<s:iterator var="category_resource" value="#resource.categories">
					<span class="label label-default label-sm pull-left padding-small-top padding-small-bottom margin-small-right margin-small-bottom">
						<span class="icon icon-tag"></span>&#32;
						<s:property value="%{#category_resource.getTitle(currentLang.code)}"/></span>
			</s:iterator>	
		</div></div>				
		</s:if>
		<div class="row">
		<div class="col-lg-12">
				<s:set var="fileDescr" value="#resource.descr" />
				<s:if test='%{#fileDescr.length()>90}'>
					<s:set var="fileDescr" value='%{#fileDescr.substring(0,30)+"..."+#fileDescr.substring(#fileDescr.length()-30)}' />
					<abbr title="<s:property value="#resource.descr" />">
					<s:property value="#fileDescr" /></abbr>
				</s:if>
				<s:else>
					<s:property value="#resource.descr" />
				</s:else>
				<s:set var="fileName" value="#resourceInstance.fileName" />
				<s:if test='%{#fileName.length()>25}'>
					<s:set var="fileName" value='%{#fileName.substring(0,10)+"..."+#fileName.substring(#fileName.length()-10)}' />
					<code class="margin-small-bottom"><abbr title="<s:property value="#resourceInstance.fileName" />"><s:property value="#fileName" /></abbr></code>
				</s:if>
				<s:else>
					<code><s:property value="#fileName" /></code>
				</s:else>
				<span class="badge">
				<s:property value="%{#resourceInstance.fileLength.replaceAll(' ', '&nbsp;')}"  escapeXml="false" escapeHtml="false" escapeJavaScript="false" />
				</span>
			</div>
		</div>
	</a>
	</s:if>
	<s:if test="!onEditContent">
		<li class="list-group-item">
		<div class="row">
			<div class="col-xs-10 col-lg-8">
			<s:if test="!#resource.categories.empty">
					<s:iterator var="category_resource" value="#resource.categories">
						<span class="label label-default label-sm pull-left padding-small-top padding-small-bottom margin-small-right margin-small-bottom">
							<span class="icon icon-tag"></span>&#32;
						<s:property value="%{#category_resource.getTitle(currentLang.code)}"/></span>
					</s:iterator>						
			</s:if>
			</div>
			<div class="col-xs-2 col-lg-4 text-right no-margin">
				<a href="<s:url action="trash" namespace="/do/jacms/Resource" >
						<s:param name="resourceId" value="%{#resourceid}" />
						<s:param name="resourceTypeCode" value="%{#resource.type}" />
						<s:param name="text" value="%{text}" />
						<s:param name="categoryCode" value="%{categoryCode}" />
						<s:param name="fileName" value="%{fileName}" />
						<s:param name="ownerGroupName" value="%{ownerGroupName}" />
						<s:param name="treeNodesToOpen" value="%{treeNodesToOpen}" />
					</s:url>" title="<s:text name="label.remove" />: <s:property value="#resource.descr" /> "><span class="icon icon-remove text-warning"></span></a>
			</div>
		</div>
		<div class="row">
		<div class="col-lg-12">
			<a href="<s:url action="edit" namespace="/do/jacms/Resource"><s:param name="resourceId" value="%{#resourceid}" /></s:url>" title="<s:text name="label.edit" />: <s:property value="#resource.descr" /> ">
			<span class="icon icon-edit"></span>&#32;<s:property value="#resource.descr" /></a>
			<p class="margin-none">
			<a href="<s:property value="%{#resource.documentPath}" />" title="<s:text name="label.download" />: <s:property value="#resourceInstance.fileName" />" class="pull-left margin-small-top">
			<span class="icon icon-download-alt"></span>&#32;
				<s:set var="fileName" value="#resourceInstance.fileName" />
				<s:if test='%{#fileName.length()>25}'>
					<s:set var="fileName" value='%{#fileName.substring(0,10)+"..."+#fileName.substring(#fileName.length()-10)}' />
					<code><abbr title="<s:property value="#resourceInstance.fileName" />"><s:property value="#fileName" /></abbr></code>
				</s:if>
				<s:else>
				<code><s:property value="#resourceInstance.fileName" /></code>
				</s:else>
			</a>
			<span class="badge pull-right margin-small-top">
				<s:property value="%{#resourceInstance.fileLength.replaceAll(' ', '&nbsp;')}" escapeXml="false" escapeHtml="false" escapeJavaScript="false" />
			</span>
			</p>
		</div>
		</div>
		</li>
	</s:if>
</s:iterator>
<s:if test="onEditContent"></div></s:if>
<s:if test="!onEditContent"></ul></s:if>	
<div class="pager clear margin-more-top">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

</wpsa:subset>

</s:form>

</div>