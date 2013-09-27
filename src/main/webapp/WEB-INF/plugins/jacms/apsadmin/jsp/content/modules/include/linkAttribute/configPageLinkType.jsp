<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<s:set var="thirdTitleVar">
	<s:text name="title.configureLinkAttribute" />&#32;(<s:text name="title.step2of2" />)
</s:set>
<s:include value="linkAttributeConfigIntro.jsp"/>
<s:form>
	<s:if test="hasFieldErrors()">
		<div class="alert alert-danger alert-dismissable fade in">
			<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
			<h2 class="h4 margin-none"><s:text name="message.title.FieldErrors" /></h4>
			<%--
			<ul class="margin-none margin-base-top">
				<s:iterator value="fieldErrors">
					<s:iterator value="value">
									<li><s:property escape="false" /></li>
					</s:iterator>
				</s:iterator>
			</ul>
			--%>
		</div>
	</s:if>
	<p class="sr-only">
		<wpsf:hidden name="contentOnSessionMarker" />
		<s:if test="contentId == null">
			<wpsf:hidden name="linkType" value="2"/>
		</s:if>
		<s:else>
			<wpsf:hidden name="contentId"/>
			<wpsf:hidden name="linkType" value="4"/>
		</s:else>
		<s:iterator value="treeNodesToOpen" var="treeNodeToOpenVar"><wpsf:hidden name="treeNodesToOpen" value="%{#treeNodeToOpenVar}"/></s:iterator>
	</p>
	<div class="col-xs-12">
		<div class="form-group">
			<%-- <fieldset><legend><s:text name="title.pageTree" /></legend> --%>
				<label class="display-block">
					<s:text name="note.choosePageToLink" />
					<s:if test="contentId != null">&#32;<s:text name="note.choosePageToLink.forTheContent" />:
					<s:property value="contentId"/> &ndash; <s:property value="%{getContentVo(contentId).descr}"/></s:if>
				</label>
				<s:set var="pageTreeStyleVar"><wp:info key="systemParam" paramName="treeStyle_page" /></s:set>
				<ul id="pageTree" class="icons-ul list-unstyled">
					<s:set name="inputFieldName" value="'selectedNode'" />
					<s:set name="selectedTreeNode" value="selectedNode" />
					<s:set name="liClassName" value="'page'" />
					<s:set var="treeItemIconName" value="'icon-folder-close'" />

					<s:if test="#pageTreeStyleVar == 'classic'">
					<s:set name="currentRoot" value="allowedTreeRootNode" />
					<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder.jsp" />
					</s:if>
					<s:elseif test="#pageTreeStyleVar == 'request'">
					<s:set name="currentRoot" value="showableTree" />
					<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder-request-submits.jsp" />
					</s:elseif>
				</ul>
			<%-- </fieldset> --%>
		</div>
		<div class="help help-block">
			<s:include value="linkAttributeConfigReminder.jsp" />
		</div>
	</div>
	<div class="form-group">
		<div class="col-xs-12 col-sm-4 col-md-3 margin-small-vertical">
			<s:submit type="button" action="joinPageLink" cssClass="btn btn-primary btn-block">
				<span class="icon  icon-save"></span>&#32;
				<s:text name="label.confirm" />
			</s:submit>
		</div>
	</div>
</s:form>