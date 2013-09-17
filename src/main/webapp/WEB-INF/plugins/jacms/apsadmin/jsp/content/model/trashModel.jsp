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

<s:form>
	<p class="sr-only">	
		<s:hidden name="modelId"/>
	</p>
	<div class="panel panel-default">
	<span class="panel-body display-block">
		<a href="<s:url action="list" namespace="/do/jacms/ContentModel"/>" 
		title="<s:text name="note.goToSomewhere" />: <s:text name="title.contentModels" />"><span class="icon icon-reply"></span></a>

		<s:text name="note.deleteContentModel.areYouSure" />:&#32;<code><s:property value="modelId" /></code>&#32;<s:property value="description" /> (<s:property value="%{getSmallContentType(getContentModel(modelId).contentType).descr}" />)? 
		<div class="text-center margin-small-top">
		<s:submit useTabindexAutoIncrement="true" action="delete" value="%{getText('label.remove')}" cssClass="btn btn-default" />
		</div>
	</span>
	</div>
</s:form>
