<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="initViewEntityTypes" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityAdmin.manager" />&#32;<s:property value="entityManagerName" />">
		<s:text name="%{'title.' + entityManagerName + '.management'}" />
		</a>&#32;|&#32;
		<s:if test="strutsAction == 2">
		<a href="<s:url action="initEditEntityType" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param><s:param name="entityTypeCode"><s:property value="entityType.typeCode" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityTypes.editType.edit" />">
		</s:if>

		<s:text name="title.entityTypes.editType.edit" />: 
		<code><s:property value="entityType.typeCode" /> - <s:property value="entityType.typeDescr" /></code>
		
		<s:if test="strutsAction == 2">
		</a>
		</s:if>
	</span>
</h1>
<div id="main">

<s:form action="saveCompositeAttribute" cssClass="form-horizontal">

<s:if test="hasFieldErrors()">
	<div class="alert alert-danger alert-dismissable">
		<button type="button" class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
		<ul>
			<s:iterator value="fieldErrors">
				<s:iterator value="value">
		            <li><s:property escape="false" /></li>
				</s:iterator>
			</s:iterator>
		</ul>
	</div>
</s:if>

<s:set name="listAttribute" value="listAttribute" />
<s:set name="compositeAttribute" value="compositeAttributeOnEdit" />

<s:text name="note.workingOnAttribute" />:&#32;
<code>
<s:if test="null != #listAttribute"><s:property value="#compositeAttribute.type" />,&#32;<s:text name="note.workingOnAttributeIn" />&#32;<s:property value="#listAttribute.name" /> (<s:property value="#listAttribute.type" />)</s:if>
<s:else><s:property value="#compositeAttribute.name" /></s:else>
</code>

<fieldset class="margin-more-top"><legend><s:text name="label.info" /></legend>
	<div class="form-group">
		<div class="col-xs-12">
			<label for="compositeAttribute.type"><s:text name="label.type" />:</label>
			<wpsf:textfield cssClass="form-control" id="compositeAttribute.type" name="compositeAttribute.type" value="%{#compositeAttribute.type}" disabled="true" />
		</div>
	</div>
</fieldset>

<fieldset><legend><s:text name="label.attributes" /></legend>
	<div class="form-group">
	<div class="col-xs-12">
		<label for="attributeTypeCode"><s:text name="label.type" />:</label>
	
		<div class="input-group">
			<s:select list="allowedAttributeElementTypes" id="attributeTypeCode" name="attributeTypeCode" listKey="type" listValue="type" cssClass="form-control"/>
			<span class="input-group-btn">
				<s:submit type="button" value="%{getText('label.add')}" action="addAttributeElement" cssClass="btn btn-default" />
			</span>
		</div>
	</div>
	</div>

<s:if test="#compositeAttribute.attributes.size > 0">
	<table class="generic" id="fagiano_compositeTypesList">
	<tr>
		<th><s:text name="label.code" /></th>
		<th><s:text name="label.type" /></th>
		<th class="icon"><abbr title="<s:text name="Entity.attribute.flag.mandatory.full" />"><s:text name="Entity.attribute.flag.mandatory.short" /></abbr></th>
		<th class="icon" colspan="3"><abbr title="<s:text name="label.actions" />">&ndash;</abbr></th>
	</tr>

<s:iterator value="#compositeAttribute.attributes" var="attribute" status="elementStatus">
	<tr>
		<td class="monospace"><s:property value="#attribute.name" /></td>
 		<td class="monospace"><s:property value="#attribute.type" /></td>
 		
		<s:if test="#attribute.required">
			<s:set var="tmpStatus">yes</s:set>
		</s:if>
		<s:else>
			<s:set var="tmpStatus">no</s:set>
		</s:else>
		<td class="icon"><img src="<wp:resourceURL />administration/common/img/icons/<s:property value="#attribute.required" />.png" alt="<s:text name="label.%{#tmpStatus}" />" title="<s:text name="label.%{#tmpStatus}" />" /></td>
 		
		<s:set name="elementIndex" value="#elementStatus.index" />
		<s:include value="/WEB-INF/apsadmin/jsp/entity/include/attribute-operations-misc-composite.jsp" />
	</tr>
</s:iterator>

	</table>
</s:if>
</fieldset>

<div class="form-group">
  <div class="col-xs-12 col-sm-4 col-md-3 margin-small-vertical">
    <s:submit type="button" cssClass="btn btn-primary btn-block" action="saveCompositeAttribute" >
      <span class="icon icon-save"></span>&#32;
      <s:text name="label.save" />
    </s:submit>
  </div>
</div>

</s:form>
</div>