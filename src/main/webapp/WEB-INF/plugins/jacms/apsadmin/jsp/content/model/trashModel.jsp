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
	<div class="alert alert-warning">
		<p>
			<s:text name="note.deleteContentModel.areYouSure" />:&#32;
			
			<code><s:property value="modelId" /></code>&#32;
			<span class="text-strong text-info"><s:property value="description" /></span>
			?
		<a class="pull-right text-info" href="<s:url action="list" namespace="/do/jacms/ContentModel"/>" 
			title="<s:text name="note.goToSomewhere" />: <s:text name="title.contentModels" />"><span class="icon icon-remove"></span></a>
			
		</p>
	</div>
	<div class="text-center margin-large-top">
	<s:submit action="delete" value="%{getText('label.remove')}" cssClass="btn btn-primary" />
	</div>
</s:form>
