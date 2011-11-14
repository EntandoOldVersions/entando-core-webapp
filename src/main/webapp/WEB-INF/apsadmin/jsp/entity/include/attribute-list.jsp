<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/aps-core" prefix="wp" %>

<s:if test="null != entityType.attributeList && entityType.attributeList.size() > 0">

<table class="generic" summary="<s:text name="note.entityTypes.list.summary" />" id="fagiano_entityTypesList">
<caption><span><s:text name="label.attributes" /></span></caption>
<tr>
	<th class="icon"><abbr title="<s:text name="label.edit" />">M</abbr></th>
	<th><s:text name="label.code" /></th>
	<th><s:text name="label.type" /></th>
	<th><s:text name="name.roles" /></th>
	<th class="icon"><abbr title="<s:text name="Entity.attribute.flag.mandatory.full" />"><s:text name="Entity.attribute.flag.mandatory.short" /></abbr></th>
	<th class="icon"><abbr title="<s:text name="Entity.attribute.flag.searcheable.full" />"><s:text name="Entity.attribute.flag.searcheable.short" /></abbr></th>
	<th class="icon" colspan="3"><abbr title="<s:text name="label.actions" />">&ndash;</abbr></th>
</tr>

<s:iterator value="#entityType.attributeList" var="attribute" status="elementStatus">
<tr>
	<td class="icon">
		<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL />administration/common/img/icons/edit-content.png</s:set>		
		<wpsa:actionParam action="editAttribute" var="actionName" >
			<wpsa:actionSubParam name="attributeName" value="%{#attribute.name}" />
		</wpsa:actionParam>
		<wpsf:submit useTabindexAutoIncrement="true" action="%{#actionName}" type="image" src="%{#iconImagePath}" value="%{getText('label.edit')}" title="%{getText('label.edit')}: %{#attribute.name}" />
	</td>
	<td class="monospace"><s:property value="#attribute.name" /></td>
	<td class="monospace">
	<s:property value="#attribute.type" />
	<s:if test="#attribute.type == 'Monolist' || #attribute.type == 'List'">: <s:property value="#attribute.nestedAttributeTypeCode" /></s:if>
	</td>
	
	<s:if test="null == #attribute.roles || #attribute.length() == 0"><td class="monospace centerText"><abbr title="<s:text name="label.none" />">&ndash;</abbr></td></s:if>
	<s:else>
	<td>
		<ul class="noBullet">
		<s:iterator value="#attribute.roles" var="attributeRoleName">
			<li><span class="monospace"><s:property value="#attributeRoleName" /> &ndash; </span><s:property value="%{getAttributeRole(#attributeRoleName).description}" /></li>
		</s:iterator>
		</ul>
	</td>
	</s:else>
	
	<s:if test="#attribute.required">
		<s:set var="tmpStatus">yes</s:set>
	</s:if>
	<s:else>
		<s:set var="tmpStatus">no</s:set>
	</s:else>
	<td class="icon"><img src="<wp:resourceURL />administration/common/img/icons/<s:property value="#attribute.required" />.png" alt="<s:text name="label.%{#tmpStatus}" />" title="<s:text name="label.%{#tmpStatus}" />" /></td>

	<s:if test="#attribute.searcheable">
		<s:set var="tmpStatus">yes</s:set>
	</s:if>
	<s:else>
		<s:set var="tmpStatus">no</s:set>
	</s:else>
	<td class="icon"><img src="<wp:resourceURL />administration/common/img/icons/<s:property value="#attribute.searcheable" />.png" alt="<s:text name="label.%{#tmpStatus}" />" title="<s:text name="label.%{#tmpStatus}" />" /></td>	

	<s:set name="elementIndex" value="#elementStatus.index" />
	<s:include value="/WEB-INF/apsadmin/jsp/entity/include/attribute-operations-misc.jsp" />
</tr>
</s:iterator>

</table>

</s:if>