<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" namespace="/do/jacms/ContentModel" />">
		<s:text name="title.contentModels" /></a>
		&#32;/&#32;
		<s:text name="title.contentModels.remove" />
	</span>
</h1>

<div id="main">
<div class="alert alert-danger alert-dismissable fade in">
	<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
	<h2 class="h4 margin-none">
		<s:text name="message.title.ActionErrors" />
	</h2>
	<p class="margin-base-vertical">
		<p><s:text name="contentModel.tip" /></p>
	</p>
</div>

<ul>
	<s:iterator id="contentId" value="referencedContentsOnPages">
		<li> 
			<s:if test="%{referencingPages[#contentId].size == 1}">
				<s:text name="contentModel.reference.page" />
			</s:if>
			<s:else>
				<s:text name="contentModel.reference.pages" />:
			</s:else>
			<s:iterator id="page" value="referencingPages[#contentId]">
			
			<s:set name="pageGroup" value="#page.group"></s:set>
			<wp:ifauthorized groupName="${pageGroup}">&#32;<a href="<s:url action="new" namespace="/do/Page"/>?selectedNode=<s:property value="#page.code" />&amp;action:configure=true"></wp:ifauthorized>
			<s:property value="#page.titles[currentLang.code]" />
			<wp:ifauthorized groupName="${pageGroup}"></a></wp:ifauthorized>
			<s:if test="%{referencingPages[#contentId].size > 1}">,</s:if>&#32;
			</s:iterator>
			<s:set name="content" value="%{getContentVo(#contentId)}"></s:set>
			<s:text name="contentModel.reference.by" />&#32;<s:property value="#content.id" /> &ndash; <s:property value="#content.descr" />
			
		</li>
	</s:iterator>
</ul>

</div>

</div>