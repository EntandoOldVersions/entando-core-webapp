<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<h1><s:text name="title.widgetManagement" /></h1>

<div id="main">

<s:if test="hasFieldErrors()">
	<div class="alert alert-danger alert-dismissable">
		<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
		<h2 class="h4 margin-none"><s:text name="message.title.ActionErrors" /></h2>
		<ul class="margin-base-vertical">
		<s:iterator value="actionErrors">
			<li><s:property escape="false" /></li>
		</s:iterator>
		<s:iterator value="fieldErrors">
			<s:iterator value="value">
			<li><s:property escape="false" /></li>
			</s:iterator>
		</s:iterator>
		</ul>
	</div>
</s:if>

<s:set var="pluginTitleCheck" value="'false'" />
<s:set var="showletFlavours" value="showletFlavours" />
<s:set var="showletTypeApiMappingsVar" value="showletTypeApiMappings" />

<s:iterator var="showletFlavour" value="#showletFlavours">
<s:set var="firstType" value="%{#showletFlavour.get(0)}"></s:set>

<div class="panel panel-default">
	<div class="panel-heading">
		<h2 class="panel-title">
			<s:if test="%{#firstType.optgroup == 'stockShowletCode'}">
				<s:text name="title.showletManagement.showlets.stock" />
			</s:if>
			<s:elseif test="%{#firstType.optgroup == 'customShowletCode'}">
				<s:text name="title.showletManagement.showlets.custom" />
			</s:elseif>
			<s:elseif test="%{#firstType.optgroup == 'userShowletCode'}">
				<s:text name="title.showletManagement.showlets.user" />
			</s:elseif>
			<s:else>
				<s:if test="#pluginTitleCheck.equals('false')">
					<s:text name="title.showletManagement.showlets.plugin" />
				</s:if>
				<s:set var="pluginTitleCheck" value="'true'" ></s:set>
				<wpsa:set var="pluginPropertyName" value="%{getText(#firstType.optgroup + '.name')}" />	
				<wpsa:set var="pluginPropertyCode" value="%{getText(#firstType.optgroup + '.code')}" />		
				<s:text name="#pluginPropertyName" />
			</s:else>
		</h2>
	</div>
<ul class="list-group">
<s:iterator var="showletType" value="#showletFlavour" >
<s:set var="showletUtilizers" value="getShowletUtilizers(#showletType.key)" ></s:set>

	<li class="list-group-item">
	<div class="row">

		<div class="col-sm-6 col-lg-6">

		<a href="<s:url namespace="/do/Portal/WidgetType" action="edit"><s:param name="showletTypeCode" value="#showletType.key" /></s:url>" title="<s:text name="label.configWidget" />" class="" ><span class="icon icon-cog"></span>
		<s:property value="#showletType.value" /></a>
		
		<span class="badge"><s:property value="#showletUtilizers.size()" /></span>
		<%--<s:property value="%{getGroup(getShowletType(#showletType.key).mainGroup).descr}" />--%>
		</div>

		<div class="col-sm-6 col-lg-6">
		<div class="btn-group btn-group-xs pull-right">
		
		<s:if test="#showletUtilizers != null && #showletUtilizers.size() > 0">
			<a href="<s:url namespace="/do/Portal/WidgetType" action="viewShowletUtilizers"><s:param name="showletTypeCode" value="#showletType.key" /></s:url>" title="<s:text name="title.showletManagement.howmanypages.goToSee" />: <s:property value="#showletType.value" />" class="btn btn-default"><span class="icon icon-info"></span></a>
		</s:if>
		
		<wp:ifauthorized permission="superuser">
		<s:set var="concreteShowletTypeVar" value="%{getShowletType(#showletType.key)}"></s:set>
		
			<s:if test="#concreteShowletTypeVar.isLogic()">
				<s:set var="relatedApiMethodVar" value="#showletTypeApiMappingsVar[#concreteShowletTypeVar.parentType.code]" />
			</s:if>
			<s:elseif test="null != #concreteShowletTypeVar.typeParameters && #concreteShowletTypeVar.typeParameters.size() > 0">
				<s:set var="relatedApiMethodVar" value="#showletTypeApiMappingsVar[#concreteShowletTypeVar.code]" />
			</s:elseif>
			<s:if test="null != #relatedApiMethodVar">
				<s:if test="#concreteShowletTypeVar.isLogic()">
					<s:url action="newService" namespace="/do/Api/Service" var="newServiceUrlVar">
						<s:param name="resourceName" value="#relatedApiMethodVar.resourceName" />
						<s:param name="namespace" value="#relatedApiMethodVar.namespace" />
						<s:param name="showletTypeCode" value="#concreteShowletTypeVar.code" />
					</s:url>
				</s:if>
				<s:else>
					<s:url action="newService" namespace="/do/Api/Service" var="newServiceUrlVar">
						<s:param name="resourceName" value="#relatedApiMethodVar.resourceName" />
						<s:param name="namespace" value="#relatedApiMethodVar.namespace" />
					</s:url>
				</s:else>
				<a href="<s:property value="#newServiceUrlVar" escape="false" />" title="<s:text name="note.api.apiMethodList.createServiceFromMethod" />: <s:property value="#relatedApiMethodVar.methodName" />" class="btn btn-default"><span class="icon icon-code-fork"></span></a>
				<s:set var="newServiceUrlVar" value="null" />
			</s:if>
			<s:set var="relatedApiMethodVar" value="null" />
		
			<s:if test="null != #concreteShowletTypeVar.typeParameters && #concreteShowletTypeVar.typeParameters.size() > 0">
				<a href="<s:url namespace="/do/Portal/WidgetType" action="new"><s:param name="parentShowletTypeCode" value="#showletType.key" /></s:url>" title="<s:text name="label.userShowlet.new.from" />: <s:property value="#showletType.value" />" class="btn btn-default"><span class="icon icon-puzzle-piece"></span></a>
			</s:if>
			<s:if test="#firstType.optgroup == 'userShowletCode' && !#concreteShowletTypeVar.isLocked() && (#showletUtilizers == null || #showletUtilizers.size() == 0)">
				<a href="<s:url namespace="/do/Portal/WidgetType" action="trash"><s:param name="showletTypeCode" value="#showletType.key" /></s:url>" title="<s:text name="label.remove" />: <s:property value="#showletType.value" />" class="btn btn-warning" ><span class="icon icon-remove-circle"></span></a>
			</s:if>
			</wp:ifauthorized>
			<wpsa:hookPoint key="core.showletType.list.table.td" objectName="hookPointElements_core_showletType_list_table_td">
			<s:iterator value="#hookPointElements_core_showletType_list_table_td" var="hookPointElement">
				<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
			</s:iterator>
			</wpsa:hookPoint>
			</div>
		</div>

		</div>
	</li>
</s:iterator>
<s:set var="showletUtilizers"></s:set>
</ul>
</div>
</s:iterator>

</div>
