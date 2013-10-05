<%@ taglib prefix="s" uri="/struts-tags" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="viewShowlets" namespace="/do/Portal/WidgetType" />" 
		title="<s:text name="note.goToSomewhere" />: <s:text name="title.showletManagement" />">
		<s:text name="title.showletManagement" />
		</a>
		&#32;/&#32;<s:text name="title.widgetManagement.type.delete" />
	</span>
</h1>

<div id="main">
<s:form namespace="/do/Portal/WidgetType" action="delete">
	<p class="sr-only">
		<s:hidden name="showletTypeCode" />
	</p>

	<div class="panel panel-default">
		<span class="panel-body display-block">
			<s:text name="note.deleteType.areYouSure" />&#32;<code><s:property value="widgetTypeCode" /></code>? 
			<div class="text-center margin-small-top">
				<s:submit value="%{getText('label.remove')}" cssClass="btn btn-default" />
			</div>
		</span>
	</div>
</s:form>
</div>
