<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<li class="<s:property value="#liClassName" /> tree_node_flag">

<s:if test="null == #openTreeActionName"><s:set name="openTreeActionName" value="'openCloseTreeNode'" /></s:if>
<s:if test="null == #closeTreeActionName"><s:set name="closeTreeActionName" value="'openCloseTreeNode'" /></s:if>

<s:if test="!#currentRoot.open && !#currentRoot.empty">
	<a class="noborder" href="<s:url action="%{#openTreeActionName}">
	<s:param name="%{#treeNodeExtraParamName}" value="%{#treeNodeExtraParamValue}" />
	<s:param name="treeNodeActionMarkerCode" value="'open'" /><s:param name="targetNode" value="#currentRoot.code" /><s:param name="treeNodesToOpen" value="treeNodesToOpen" /></s:url>"><img src="<wp:resourceURL/>administration/common/img/icons/list-add.png" alt="Open Tree" title="Open Tree" /></a>
</s:if>
<s:elseif test="#currentRoot.open && !#currentRoot.empty">
	<a class="noborder" href="<s:url action="%{#closeTreeActionName}">
	<s:param name="%{#treeNodeExtraParamName}" value="%{#treeNodeExtraParamValue}" />
	<s:param name="treeNodeActionMarkerCode" value="'close'" /><s:param name="targetNode" value="#currentRoot.code" /><s:param name="treeNodesToOpen" value="treeNodesToOpen" /></s:url>"><img src="<wp:resourceURL/>administration/common/img/icons/list-remove.png" alt="Close Tree" title="Close Tree" /></a>
</s:elseif>

<input type="radio" name="<s:property value="#inputFieldName" />" id="fagianonode_<s:property value="#currentRoot.code" />" value="<s:property value="#currentRoot.code" />" <s:if test="#currentRoot.children.length > 0">class="subTreeToggler tree_<s:property value="#currentRoot.code" />" </s:if> <s:if test="#currentRoot.code == #selectedTreeNode"> checked="checked"</s:if> /><label for="fagianonode_<s:property value="#currentRoot.code" />"><s:property value="getTitle(#currentRoot.code, #currentRoot.titles)" /></label>
<s:if test="#currentRoot.children.length > 0">
	<ul class="treeToggler" id="tree_<s:property value="#currentRoot.code" />">
		<s:iterator value="#currentRoot.children" id="node">
			<s:set name="currentRoot" value="#node" />
			<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder-request-links.jsp" />
		</s:iterator>
	</ul>
</s:if>
</li>