<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="viewShowlets" namespace="/do/Portal/WidgetType" />" 
		title="<s:text name="note.goToSomewhere" />: <s:text name="title.showletManagement" />">
		<s:text name="title.showletManagement" /></a>
		<s:if test="strutsAction == 2">
		&#32;/&#32;<s:text name="title.showletManagement.edit" />
		&#32;/&#32;<wpsa:widgetType key="%{showletTypeCode}" var="showletTypeVar" />
			<s:property value="#showletTypeVar.titles[currentLang.code]" />
		</s:if>
		<s:else>&#32;/&#32;
			<s:text name="title.newShowletType" />
		</s:else>
	</span>
</h1>

<div id="main">

<p>
<s:if test="strutsAction != 2">
	<s:text name="title.newShowletType.from" />:&#32;
	<s:if test="strutsAction == 1">
		<wpsa:widgetType var="parentShowletTypeVar" key="%{parentShowletTypeCode}" />
		<em><s:property value="%{getTitle(#parentShowletTypeVar.code, #parentShowletTypeVar.titles)}" /></em>
	</s:if>
	<s:elseif test="strutsAction == 3">
	<s:property value="%{getTitle(showletToCopy.type.code, showletToCopy.type.titles)}" />	<wpsa:page var="pageVar" key="%{pageCode}" />
	<s:text name="note.showletType.page"/>:&#32;<em class="important"><s:property value="%{getTitle(#pageVar.code, #pageVar.titles)}" /></em>,&#32;<s:text name="note.showletType.position" />:&#32;<em class="important"><s:property value="framePos" /></em>
	</s:elseif>
</s:if>
</p>
<s:form action="save" namespace="/do/Portal/WidgetType" class="form-horizontal" >

<wp:ifauthorized permission="superuser"><s:set var="isSuperuserVar" value="%{true}" /></wp:ifauthorized>

	<s:if test="hasActionErrors()">
		<div class="alert alert-danger alert-dismissable">
			<button type="button" class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
			<p><s:text name="message.title.ActionErrors" /></p>
		</div>
	</s:if>
	<s:if test="hasFieldErrors()">
		<div class="alert alert-danger alert-dismissable">
			<button type="button" class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
			<p><s:text name="message.title.FieldErrors" /></p>
		</div>
	</s:if>

<p class="sr-only">
	<s:hidden name="strutsAction" />
	<s:if test="strutsAction == 1">
		<s:hidden name="parentShowletTypeCode" />
	</s:if>
	<s:elseif test="strutsAction == 2">
		<s:hidden name="showletTypeCode" />
	</s:elseif>
	<s:elseif test="strutsAction == 3">
		<s:hidden name="pageCode" />
		<s:hidden name="framePos" />
	</s:elseif>
</p>

<fieldset class="col-xs-12"><legend><s:text name="label.info" /></legend>
	<s:set var="controlGroupErrorClassVar" value="''" />
	<s:if test="#pageCodeHasFieldErrorVar">
	  <s:set var="controlGroupErrorClassVar" value="' has-error'" />
	</s:if>

	<s:if test="strutsAction != 2">
		<p>
			<label for="showletTypeCode" class="control-label"><s:text name="label.code" /></label>
			<s:textfield id="showletTypeCode" name="showletTypeCode" cssClass="form-control" />
		</p>
	</s:if>
	
	<div class="form-group">
		<label for="showlet-title-en" class="control-label"><code class="label label-info">en</code>&#32;<s:text name="label.title" /></label>
		<s:textfield id="showlet-title-en" name="englishTitle" cssClass="form-control" />
	</div>
	
	<div class="form-group">
		<label for="showlet-title-it" class="control-label"><code class="label label-info">it</code>&#32;<s:text name="label.title" /></label>
		<s:textfield id="showlet-title-it" name="italianTitle" cssClass="form-control" />
	</div>

	<div class="form-group">
		<label for="showlet-maingroup" class="control-label"><s:text name="label.group" /></label>
		<s:select name="mainGroup" id="showlet-maingroup" list="groups" listKey="name" listValue="descr" cssClass="form-control" disabled="%{!#isSuperuserVar}" />
	</div>
	
	<s:if test="#showletTypeVar.logic && strutsAction == 2">
	<div class="form-group">
	    <label class="control-label"><s:text name="label.showletType.parentType" /></label>
		<p class="form-control-static"><s:property value="#showletTypeVar.parentType.titles[currentLang.code]" /></p>
	</div>
	</s:if>
	
</fieldset>

<s:if test="strutsAction != 2 || #showletTypeVar.logic">
<fieldset class="col-xs-12"><legend><s:text name="title.showletType.settings" /></legend>
	<s:if test="strutsAction == 1">
		<s:set var="parentShowletType" value="%{getShowletType(parentShowletTypeCode)}" />
		<s:iterator value="#parentShowletType.typeParameters" var="showletParam" >
			<div class="form-group">
				<label for="<s:property value="#showletParam.name" />" class="control-label"><s:property value="#showletParam.name" /></label>
				<s:textfield id="%{#showletParam.name}" name="%{#showletParam.name}" value="%{#request.parameters[#showletParam.name]}" cssClass="form-control" />
				<s:if test="#showletParam.descr != ''">
					<span class="help-block"><span class="icon icon-info-sign"></span>&#32;
					<s:property value="#showletParam.descr" />
					</span>
				</s:if>
			</div>
		</s:iterator>
	</s:if>
	<s:elseif test="strutsAction == 2">
		<s:iterator value="#showletTypeVar.parentType.typeParameters" var="showletParam" >
			<div class="form-group">
				<s:if test="#isSuperuserVar && #showletTypeVar.userType">
				<label for="<s:property value="#showletParam.name" />" class="control-label"><s:property value="#showletParam.name" /></label>
				<s:textfield id="%{#showletParam.name}" name="%{#showletParam.name}" value="%{#showletTypeVar.config[#showletParam.name]}" cssClass="form-control" />
				</s:if>
				<s:else>
				<span class="text-important"><s:property value="#showletParam.name" /></span>&#32;
				<s:property value="%{#showletTypeVar.config[#showletParam.name]}" />
				</s:else>
				<s:if test="#showletParam.descr != ''">
					<span class="help-block"><span class="icon icon-info-sign"></span>&#32;<s:property value="#showletParam.descr" /></span>
				</s:if>
			</div>
		</s:iterator>
		<s:set var="isSuperuserVar" value="%{false}" />
	</s:elseif>
	<s:elseif test="strutsAction == 3">
		<s:iterator value="showletToCopy.type.typeParameters" var="showletParam" >
			<div class="form-group">
				<s:if test="#showletParam.descr != ''">
					<label class="label-control"><s:property value="#showletParam.descr" /></label>
				</s:if>
				<p class="form-control-static">
				<span class="text-strong">
				<s:property value="#showletParam.name" />:&#32;
				</span>
				<s:property value="%{showletToCopy.config[#showletParam.name]}" />
				</p>
			</div>
		</s:iterator>
	</s:elseif>
</fieldset>
</s:if>

<wpsa:hookPoint key="core.showletType.entry" objectName="hookPointElements_core_showlet_entry">
<s:iterator value="#hookPointElements_core_showlet_entry" var="hookPointElement">
	<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
</s:iterator>
</wpsa:hookPoint>

<div class="row">
	<div class="form-group">
	 	<div class="col-xs-12 col-sm-4 col-md-3 margin-small-vertical">
	    <s:submit type="button" cssClass="btn btn-primary btn-block">
	      <span class="icon icon-save"></span>&#32;
	      <s:text name="label.save" />
	    </s:submit>
	    </div>

		<s:if test="strutsAction == 3">
			<div class="col-xs-12 col-sm-4 col-md-3 margin-small-vertical">
				<wpsa:actionParam action="save" var="actionName" >
					<wpsa:actionSubParam name="replaceOnPage" value="true" />
				</wpsa:actionParam>
				<s:submit type="button" action="%{#actionName}" cssClass="btn btn-default btn-block">
			      <span class="icon icon-exchange"></span>&#32;
			      <s:text name="label.save.replace" />
			    </s:submit>
			</div>
		</s:if>
		
	</div>
</div>
</s:form>
</div>
