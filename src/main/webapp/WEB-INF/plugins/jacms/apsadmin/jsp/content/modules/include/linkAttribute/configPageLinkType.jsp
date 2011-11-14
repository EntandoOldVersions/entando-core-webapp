<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<s:include value="linkAttributeConfigIntro.jsp"/>
<h3><s:text name="title.configureLinkAttribute" />&#32;(<s:text name="title.step2of2" />)</h3>
<s:include value="linkAttributeConfigReminder.jsp" />
<p class="margin-more-bottom">
	<s:text name="note.choosePageToLink" />
	<s:if test="contentId != null">&#32;<s:text name="note.choosePageToLink.forTheContent" />: <s:property value="contentId"/> &ndash; <s:property value="%{getContentVo(contentId).descr}"/></s:if>
</p>

<s:form cssClass="action-form">
<s:if test="hasFieldErrors()">
	<div class="message message_error">
	<h4><s:text name="message.title.FieldErrors" /></h4>
		<ul>
			<s:iterator value="fieldErrors">
				<s:iterator value="value">
		            <li><s:property escape="false" /></li>
				</s:iterator>
			</s:iterator>
		</ul>
	</div>
</s:if>

<p class="noscreen">
	<s:if test="contentId == null">
		<wpsf:hidden name="linkType" value="2"/>
	</s:if>
	<s:else>
		<wpsf:hidden name="contentId"/>
		<wpsf:hidden name="linkType" value="4"/>
	</s:else>
	<s:iterator value="treeNodesToOpen" var="treeNodeToOpenVar"><wpsf:hidden name="treeNodesToOpen" value="%{#treeNodeToOpenVar}"/></s:iterator>
</p>
<fieldset><legend><s:text name="title.pageTree" /></legend>

<s:set var="pageTreeStyleVar" ><wp:info key="systemParam" paramName="treeStyle_page" /></s:set>

<ul id="pageTree">
	<s:set name="inputFieldName" value="'selectedNode'" />
	<s:set name="selectedTreeNode" value="selectedNode" />
	<s:set name="liClassName" value="'page'" />
	<s:if test="#pageTreeStyleVar == 'classic'">
	<s:set name="currentRoot" value="allowedTreeRootNode" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder.jsp" />
	</s:if>
	<s:elseif test="#pageTreeStyleVar == 'request'">
	<s:set name="currentRoot" value="showableTree" />
	<s:set name="openTreeActionName" value="'openCloseTreeOnConfigPageLink'" />
	<s:set name="closeTreeActionName" value="'openCloseTreeOnConfigPageLink'" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder-request-submits.jsp" />
	</s:elseif>
</ul>

</fieldset>

<p class="centerText"><wpsf:submit useTabindexAutoIncrement="true" action="joinPageLink" value="%{getText('label.confirm')}" cssClass="button" /></p>

</s:form>
</div>