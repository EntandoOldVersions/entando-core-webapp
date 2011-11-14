<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<li class="<s:property value="#liClassName" /> tree_node_flag">

<s:if test="null == #openTreeActionName"><s:set name="openTreeActionName" value="'openCloseTreeNode'" /></s:if>
<s:if test="null == #closeTreeActionName"><s:set name="closeTreeActionName" value="'openCloseTreeNode'" /></s:if>

<s:if test="!#currentRoot.open && !#currentRoot.empty">
<wpsa:actionParam action="%{#openTreeActionName}" var="openTreeAction" >
	<wpsa:actionSubParam name="%{#treeNodeExtraParamName}" value="%{#treeNodeExtraParamValue}" />	
	<wpsa:actionSubParam name="targetNode" value="%{#currentRoot.code}" />
	<wpsa:actionSubParam name="treeNodeActionMarkerCode" value="open" />
</wpsa:actionParam>
<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/list-add.png</s:set>
<wpsf:submit useTabindexAutoIncrement="true" action="%{#openTreeAction}" type="image" src="%{#iconImagePath}" value="%{getText('label.open')}" title="%{getText('label.open')}" />
</s:if>
<s:elseif test="#currentRoot.open && !#currentRoot.empty">
<wpsa:actionParam action="%{#closeTreeActionName}" var="closeTreeAction" >
	<wpsa:actionSubParam name="%{#treeNodeExtraParamName}" value="%{#treeNodeExtraParamValue}" />
	<wpsa:actionSubParam name="targetNode" value="%{#currentRoot.code}" />
	<wpsa:actionSubParam name="treeNodeActionMarkerCode" value="close" />
</wpsa:actionParam>
<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/list-remove.png</s:set>
<wpsf:submit useTabindexAutoIncrement="true" action="%{#closeTreeAction}" type="image" src="%{#iconImagePath}" value="%{getText('label.close')}" title="%{getText('label.close')}" />
</s:elseif>

<input type="radio" name="<s:property value="#inputFieldName" />" id="fagianonode_<s:property value="#currentRoot.code" />" value="<s:property value="#currentRoot.code" />" <s:if test="#currentRoot.children.length > 0">class="subTreeToggler tree_<s:property value="#currentRoot.code" />" </s:if> <s:if test="#currentRoot.code == #selectedTreeNode"> checked="checked"</s:if> /><label for="fagianonode_<s:property value="#currentRoot.code" />"><s:property value="getTitle(#currentRoot.code, #currentRoot.titles)" /></label>
<s:if test="#currentRoot.children.length > 0">
	<ul class="treeToggler" id="tree_<s:property value="#currentRoot.code" />">
		<s:iterator value="#currentRoot.children" id="node">
			<s:set name="currentRoot" value="#node" />
			<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder-request-submits.jsp" />
		</s:iterator>
	</ul>
</s:if>
</li>