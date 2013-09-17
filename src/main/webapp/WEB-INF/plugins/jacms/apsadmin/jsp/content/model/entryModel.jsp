<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib prefix="jacms" uri="/jacms-apsadmin-core" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" namespace="/do/jacms/ContentModel" />">
		<s:text name="title.contentModels" />
		</a>&#32;/&#32;
		<s:if test="strutsAction == 1">
			<s:text name="title.contentModels.new" />
		</s:if>
		<s:if test="strutsAction == 2">
			<s:text name="title.contentModels.edit" />
		</s:if> 
	</span>
</h1>

<div id="main">        

<s:form action="save" namespace="/do/jacms/ContentModel" class="form-horizontal" >
<s:if test="hasFieldErrors()">
	<div class="alert alert-danger alert-dismissable">
		<button type="button" class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
		<p><s:text name="message.title.FieldErrors" /></p>
	</div>
</s:if>
<p class="sr-only">
	<s:hidden name="strutsAction" />
	<s:if test="strutsAction == 2">
		<s:hidden name="modelId" />  
	</s:if>
</p>

<fieldset class="col-xs-12"><legend><s:text name="label.info" /></legend>
	
	<div class="form-group<s:property value="controlGroupErrorClassVar" />">
		<s:set var="modelIdFieldErrorsVar" value="%{fieldErrors['modelId']}" />
		<s:set var="modelIdHasFieldErrorVar" value="#modelIdFieldErrorsVarmodelIdFieldErrorsVar != null && !#modelIdFieldErrorsVar.isEmpty()" />
		<s:set var="controlGroupErrorClassVar" value="%{#modelIdFieldErrorsVar ? ' has-error' : ''}" />
		<label class="control-label" for="modelId"><s:text name="contentModel.id" /></label>
		<s:textfield name="modelId" id="modelId" disabled="%{getStrutsAction() == 2}" cssClass="form-control" />
		<s:if test="#modelIdHasFieldErrorVar">
		  <p class="text-danger padding-small-vertical"><s:iterator value="#modelIdFieldErrorsVar"><s:property /> </s:iterator></p>
		</s:if>
	</div>
	<div class="form-group has-warning">
		<label for="contentType" class="control-label"><s:text name="contentModel.type" />:</label>
		<div class="input-group">
		<s:select id="contentType" list="smallContentTypes" name="contentType" 
			listKey="code" listValue="descr" cssClass="form-control" />
			<span class="input-group-btn">
				<s:submit type="button" action="lockContentType" cssClass="btn btn-warning" value="%{getText('label.set')}"/>
			</span>
		</div>
		<span class="help-block"><span class="icon icon-info-sign"></span>&#32;<s:text name="note.contentModel.assist.intro" /></span>
	</div> 
	<div class="form-group<s:property value="controlGroupErrorClassVar" />">
		<s:set var="descriptionFieldErrorsVar" value="%{fieldErrors['description']}" />
		<s:set var="descriptionFieldErrorsVar" value="#descriptionFieldErrorsVar!= null && !#descriptionFieldErrorsVar.isEmpty()" />
		<s:set var="controlGroupErrorClassVar" value="%{#descriptionFieldErrorsVar ? ' has-error' : ''}" />
		<label for="description" class="control-label"><s:text name="label.description" />:</label>
		<s:textfield name="description" id="description" cssClass="form-control" />
		<s:if test="#descriptionHasFieldErrorVar">
		  <p class="text-danger padding-small-vertical"><s:iterator value="#descriptionFieldErrorsVar"><s:property /> </s:iterator></p>
		</s:if>
	</div>
	<div class="form-group<s:property value="controlGroupErrorClassVar" />">
		<s:set var="contentShapeFieldErrorsVar" value="%{fieldErrors['contentShape']}" />
		<s:set var="contentShapeHasFieldErrorVar" value="#contentModelFieldErrorsVar != null && !#contentModelFieldErrorsVar.isEmpty()" />
		<label for="contentShape" class="control-label"><s:text name="contentModel.label.shape" />:</label>
		<s:textarea name="contentShape" id="contentShape" cols="50" rows="10" cssClass="form-control" />
		<span class="help-block"><span class="icon icon-info-sign"></span>&#32;
			<s:if test="strutsAction == 2 || (strutsAction == 1 && null != contentType)">(<s:text name="note.contentModel.help" />)&#32;</s:if>
			<s:text name="note.contentModel.contentAssist" />:&#32;<em class="important"><s:text name="label.on" /></em>.&#32;
				<s:if test="strutsAction == 2 || (strutsAction == 1 && null != contentType)">[<s:text name="note.contentModel.attributeHelp" />:&#32;<em class="important"><s:text name="label.on" /></em>]</s:if>
				<s:else>[<s:text name="note.contentModel.attributeHelp" />:&#32;<em class="important"><s:text name="label.off" /></em>]</s:else>
		</span>
		<s:if test="#contentShapeHasFieldErrorVar">
		  <p class="text-danger padding-small-vertical"><s:iterator value="#contentModelFieldErrorsVar"><s:property /> </s:iterator></p>
		</s:if>
	</div>
	<div class="form-group">
		<label for="newModel_stylesheet" class="control-label"><s:text name="contentModel.label.stylesheet" />:</label>
		<s:textfield name="stylesheet" id="newModel_stylesheet" cssClass="form-control" />
	</div>
</fieldset>

<div class="form-group">
	<div class="col-xs-12 col-sm-4 col-md-3 margin-small-vertical">
		<s:submit type="button" cssClass="btn btn-primary btn-block">
			<span class="icon icon-save"></span>&#32;
			<s:text name="label.save" />
		</s:submit>
	</div>
</div>

<s:if test="#myClient == 'advanced'">
<p class="centerText"><s:text name="label.or" />&#32;<a href="#jacms-content-model-detail-shortcut" id="jacms-content-model-detail-shortcut"><s:text name="note.contentModel.detailsdownload" /></a></p>
</s:if>	

</s:form>
</div>