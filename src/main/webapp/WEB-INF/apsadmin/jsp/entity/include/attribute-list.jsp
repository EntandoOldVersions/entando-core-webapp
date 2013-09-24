<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/aps-core" prefix="wp" %>

<s:if test="null != entityType.attributeList && entityType.attributeList.size() > 0">

<table class="table table-bordered">
<tr>
	<th class="text-center text-nowrap"><abbr title="<s:text name="label.actions" />">&ndash;</abbr></th>
	<th class="text-right"><s:text name="label.code" /></th>
	<th><s:text name="label.type" /></th>
	<th><s:text name="name.roles" /></th>
	<th class="text-center text-nowrap" class="text-center text-nowrap"><abbr title="<s:text name="Entity.attribute.flag.mandatory.full" />"><s:text name="Entity.attribute.flag.mandatory.short" /></abbr></th>
	<th class="text-center text-nowrap"><abbr title="<s:text name="Entity.attribute.flag.searcheable.full" />"><s:text name="Entity.attribute.flag.searcheable.short" /></abbr></th>
</tr>

<s:iterator value="#entityType.attributeList" var="attribute" status="elementStatus">
<tr>
	<td class="text-center text-nowrap">
	<div class="btn-group btn-group-xs">
		<wpsa:actionParam action="editAttribute" var="actionName" >
			<wpsa:actionSubParam name="attributeName" value="%{#attribute.name}" />
		</wpsa:actionParam>
		<wpsf:submit action="%{#actionName}" type="button" title="%{getText('label.edit')}: %{#attribute.name}" cssClass="btn btn-default" >
		<span class="icon icon-edit"></span>
		<span class="sr-only"><s:text name="label.edit" />: <s:property value="#attribute.name" /></span>
		</wpsf:submit>
	
		<s:set name="elementIndex" value="#elementStatus.index" />
		<s:include value="/WEB-INF/apsadmin/jsp/entity/include/attribute-operations-misc.jsp" />
	</div>
	</td>
	<td class="text-right"><code><s:property value="#attribute.name" /></code></td>
	<td>
	<s:property value="#attribute.type" />
	<s:if test="#attribute.type == 'Monolist' || #attribute.type == 'List'">: <s:property value="#attribute.nestedAttributeTypeCode" /></s:if>
	</td>
	
	<s:if test="null == #attribute.roles || #attribute.length() == 0"><td class="centerText"><abbr title="<s:text name="label.none" />">&ndash;</abbr></td></s:if>
	<s:else>
	<td>
		<ul class="noBullet">
		<s:iterator value="#attribute.roles" var="attributeRoleName">
			<li><span class="monospace"><s:property value="#attributeRoleName" /> &ndash; </span><s:property value="%{getAttributeRole(#attributeRoleName).description}" /></li>
		</s:iterator>
		</ul>
	</td>
	</s:else>
	
	<td class="text-center">
		<s:if test="#attribute.required">
			<span class="icon icon-ok" title="<s:text name="label.yes" />"></span>
		</s:if> 
		<s:else>
			<span class="icon icon-minus" title="<s:text name="label.no" />"></span>
		</s:else>
	</td>
	<td class="text-center">
		<s:if test="#attribute.searcheable">
			<span class="icon icon-ok" title="<s:text name="label.yes" />"></span>
		</s:if> 
		<s:else>
			<span class="icon icon-minus" title="<s:text name="label.no" />"></span>
		</s:else>
	</td>
</tr>
</s:iterator>

</table>

</s:if>