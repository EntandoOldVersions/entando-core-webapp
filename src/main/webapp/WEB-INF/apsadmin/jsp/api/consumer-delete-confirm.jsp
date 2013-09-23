<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" />"><s:text name="title.apiConsumerManagement" /></a>
		&#32;/&#32;
		<s:text name="title.apiConsumerManagement.trash" />
	</span>
</h1>
<div id="main">
	<s:form action="delete">
		<p class="sr-only"><wpsf:hidden name="consumerKey" /></p>
		<s:set var="consumerVar" value="%{getConsumer(consumerKey)}" />
		<div class="panel panel-default">
			<span class="panel-body display-block">
				<a href="<s:url action="list" namespace="/do/Api/Consumer" />" title="<s:text name="note.goToSomewhere" />:&#32;<s:text name="menu.apisAdmin.consumers" />">
					<span class="icon icon-reply"></span>
					<span class="sr-only"><s:text name="note.goToSomewhere" />:&#32;<s:text name="menu.apisAdmin.consumers" /></span>
				</a>
				&#32;
				<s:text name="note.api.consumer.trash" />:&#32;
				<em><s:property value="#consumerVar.description" /></em> (<code><s:property value="consumerKey" /></code>)
				?
			</span>
			<div class="margin-base-bottom text-center">
				<s:submit type="button" cssClass="btn btn-default">
					<s:text name="label.remove" />
				</s:submit>
			</div>
		</div>
	</s:form>
</div>