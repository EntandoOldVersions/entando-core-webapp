<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="jacmswpsa" uri="/jacms-apsadmin-core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" namespace="/do/jacms/Content"/>">
			<s:text name="jacms.menu.contentAdmin" />
		</a>&#32;/&#32;
		<s:text name="title.inspection" />&#32;
		<s:if test="currentPublicVersion"><s:text name="name.version.onLine" /></s:if>
		<s:else><s:text name="name.version.work" /></s:else>
	</span>
</h1>
<div id="main"><%-- #main --%>
<%--
<h2><s:text name="title.inspection" />&#32;<s:if test="currentPublicVersion"><s:text name="name.version.onLine" /></s:if><s:else><s:text name="name.version.work" /></s:else></h2>
--%>
<s:if test="content == null"><%-- content is null --%>
	<div class="alert alert-warning">
		<h2 class="h3 margin-none"><s:text name="title.error" /></h2>
		<p class="margin-base-top"><s:text name="message.noContentToInspect.found" /></p>
	</div>
</s:if><%-- content is null --%>
<s:else><%-- content not null --%>
	<p><s:text name="note.workingOn" />:&#32;<em class="important"><s:property value="content.descr"/></em> (<s:property value="content.typeDescr"/>)</p>
	<h3 class="sr-only"><s:text name="title.quickMenu" /></h3>
	<ul class="sr-only">
		<li><a href="#jpcontentinspection_metadata"><abbr title="<s:text name="metadata.full" />"><s:text name="metadata" /></abbr></a></li>
		<li><a href="#jpcontentinspection_referral_contents"><s:text name="title.referencingContents" /></a></li>
		<li><a href="#jpcontentinspection_referring_conts"><s:text name="title.referencedContents" /></a></li>
		<li><a href="#jpcontentinspection_pages"><s:text name="title.referencedPages" /></a></li>
		<li><a href="#jpcontentinspection_contents"><s:text name="title.content" /></a></li>
		<li><a href="#jpcontentinspection_referencing_pages"><s:text name="title.referencingPages" /></a></li>
	</ul>

	<p class="sr-only" id="jpcontentinspection_metadata"><s:text name="title.metadata" /></p>

	<dl class="dl-horizontal">
		<dt><s:text name="label.key" /></dt>
			<dd><s:property value="content.id" /></dd>
		<dt><s:text name="label.description" /></dt>
			<dd><s:property value="content.descr" /></dd>
		<dt><s:text name="label.lastEdit" /></dt>
			<dd><s:date name="content.lastModified" format="dd/MM/yyyy HH:mm" /></dd>
		<dt><s:text name="label.creationDate" /></dt>
			<dd><s:date name="content.created" format="dd/MM/yyyy HH:mm" /></dd>
		<dt><s:text name="label.editor" /></dt>
			<dd><s:property value="content.lastEditor" /></dd>
		<dt><s:text name="name.version" /></dt>
			<dd><s:property value="content.version" /></dd>
		<dt><s:text name="label.mainGroup" /></dt>
			<dd><s:property value="content.mainGroup" /></dd>
	</dl>

<fieldset><legend><s:text name="label.info" /></legend>
	<p><span class="important"><s:text name="label.viewgroups" /></span></p>
	<s:if test="!content.groups.empty">
		<ul class="noBullet">
		<s:iterator var="curViewGroupCode" value="content.groups" >
			<s:set var="curViewGroup" value="getGroup(#curViewGroupCode)" ></s:set>
			<s:if test="null != #curViewGroup">
				<li><s:property value="#curViewGroup.descr" /> (<s:property value="#curViewGroup.name"/>)</li>
			</s:if>
		</s:iterator>
		</ul>
	</s:if>
	<s:else>
		<p><s:text name="note.noViewGroups"/></p>
	</s:else>

	<p><span class="important"><s:text name="label.categories" /></span></p>
	<s:if test="!content.categories.empty">
		<ul class="noBullet">
		<s:iterator var="curCategory" value="content.categories">
			<li><s:property value="%{#curCategory.getFullTitle(currentLang.code)}"/></li>
		</s:iterator>
		</ul>
	</s:if>
	<s:else>
		<p><s:text name="label.none" /></p>
	</s:else>
</fieldset>

<fieldset><legend><s:text name="title.references" /></legend>
	<p class="important" id="jpcontentinspection_referral_contents"><s:text name="title.referencedContents" /></p>

	<s:set var="referencedContentsIdVar" value="referencedContentsId" ></s:set>
	<s:if test="!#referencedContentsIdVar.empty">
		<ul class="noBullet">
			<s:iterator var="curReferencedContentId" value="#referencedContentsIdVar">
				<li>
					<jacmswpsa:content contentId="%{#curReferencedContentId}" var="curReferencedContent" authToEditVar="isAuthToEditVar" workVersion="true" />
					<s:if test="#isAuthToEditVar">
						<s:url var="contentEditActionURL" action="edit" namespace="/do/jacms/Content"><s:param name="contentId" value="#curReferencedContent.id" /></s:url>
						<a href="<s:property value="#contentEditActionURL" />" title="<s:text name="label.edit" />:&#32;<s:property value="#curReferencedContent.descr" />"><s:property value="#curReferencedContent.descr" />&#32;(<s:property value="#curReferencedContent.id" />)</a>
					</s:if>
					<s:else>
						<s:property value="#curReferencedContent.descr" />&#32;(<s:property value="#curReferencedContent.id" />)
					</s:else>
				</li>
			</s:iterator>
		</ul>
	</s:if>
	<s:else>
		<p><s:text name="label.none" /></p>
	</s:else>

	<p class="important" id="jpcontentinspection_pages"><s:text name="title.referencedPages" /></p>

	<s:set var="referencedPagesVar" value="referencedPages" ></s:set>

	<s:if test="!#referencedPagesVar.empty">
		<ul class="noBullet">
			<s:iterator var="curReferencedPage" value="#referencedPagesVar">
				<li>
					<s:set var="canEdit" value="%{false}" />
					<c:set var="curReferencingPageMainGroupCode"><s:property value="#curReferencedPage.group" escape="false"/></c:set>
					<wp:ifauthorized groupName="${curReferencingPageMainGroupCode}" permission="managePages"><s:set var="canEdit" value="%{true}" /></wp:ifauthorized>
					<s:if test="#canEdit">
						<s:url var="pageEditURL" action="viewTree" namespace="/do/Page"><s:param name="selectedNode" value="#curReferencedPage.code" /></s:url>
						<a href="<s:property value="#pageEditURL" />" title="<s:text name="label.edit" />:&#32;<s:property value="#curReferencedPage.getFullTitle(currentLang.code)"/>&#32;(<s:property value="#curReferencedPage.code" />)"><s:property value="#curReferencedPage.getFullTitle(currentLang.code)"/>&#32;(<s:property value="#curReferencedPage.code" />)</a>
					</s:if>
					<s:else>
						<s:property value="#curReferencedPage.getFullTitle(currentLang.code)" />&#32;(<s:property value="#curReferencedPage.code" />)
					</s:else>
				</li>
			</s:iterator>
		</ul>
	</s:if>
	<s:else>
		<p><s:text name="label.none" /></p>
	</s:else>

</fieldset>

<fieldset><legend><s:text name="title.referencesExternal" /></legend>

	<p class="important" id="jpcontentinspection_referring_conts"><s:text name="title.referencingContents" /></p>

	<s:set var="referencingContentsIdVar" value="referencingContentsId" ></s:set>

	<s:if test="!#referencingContentsIdVar.empty">
		<ul class="noBullet">
			<s:iterator var="curReferencingContentId" value="#referencingContentsIdVar">
				<jacmswpsa:content contentId="%{#curReferencingContentId}" var="curReferencingContent" authToEditVar="isAuthToEditVar" workVersion="true" />
				<li>
					<s:if test="#isAuthToEditVar">
						<s:url var="contentEditActionURL" action="edit" namespace="/do/jacms/Content"><s:param name="contentId" value="#curReferencingContent.id" /></s:url>
						<a href="<s:property value="#contentEditActionURL" />" title="<s:text name="label.edit" />:&#32;<s:property value="#curReferencingContent.descr" />"><s:property value="#curReferencingContent.descr" />&#32;(<s:property value="#curReferencingContent.id" />)</a>
					</s:if>
					<s:else>
						<s:property value="#curReferencingContent.descr" />&#32;(<s:property value="#curReferencingContent.id" />)
					</s:else>
				</li>
			</s:iterator>
		</ul>
	</s:if>
	<s:else>
		<p><s:text name="label.none" /></p>
	</s:else>

	<p class="important" id="jpcontentinspection_referencing_pages"><s:text name="title.referencingPages" /></p>

	<s:set var="referencingPagesVar" value="referencingPages" ></s:set>

	<s:if test="!#referencingPagesVar.empty">
		<ul class="noBullet">
			<s:iterator var="curReferencingPage" value="#referencingPagesVar">
				<li>
					<s:set var="canEdit" value="%{false}" />
					<c:set var="curReferencingPageMainGroupCode"><s:property value="#curReferencingPage.group" escape="false"/></c:set>
					<wp:ifauthorized groupName="${curReferencingPageMainGroupCode}" permission="managePages"><s:set var="canEdit" value="%{true}" /></wp:ifauthorized>
					<s:if test="#canEdit">
						<s:url var="pageEditURL" action="viewTree" namespace="/do/Page"><s:param name="selectedNode" value="#curReferencingPage.code" /></s:url>
						<a href="<s:property value="#pageEditURL" />" title="<s:text name="label.edit" />:&#32;<s:property value="#curReferencingPage.getFullTitle(currentLang.code)"/>&#32;(<s:property value="#curReferencingPage.code" />)"><s:property value="#curReferencingPage.getFullTitle(currentLang.code)"/>&#32;(<s:property value="#curReferencingPage.code" />)</a>
					</s:if>
					<s:else>
						<s:property value="#curReferencingPage.getFullTitle(currentLang.code)" />&#32;(<s:property value="#curReferencingPage.code" />)
					</s:else>
				</li>
			</s:iterator>
		</ul>
	</s:if>
	<s:else>
		<p><s:text name="label.none" /></p>
	</s:else>

</fieldset>

	<div class="tab-container"><%-- tab container --%>
		<p class="sr-only" id="jpcontentinspection_contents"><s:text name="title.content" /></p>
		<ul class="nav nav-tabs tab-togglers" id="tab-togglers">
			<s:iterator value="langs" var="lang" status="langStatusVar">
				<li <s:if test="#langStatusVar.first"> class="active" </s:if>>
					<a data-toggle="tab" href="#<s:property value="#lang.code" />_tab">
						<s:property value="#lang.descr" />
					</a>
				</li>
			</s:iterator>
		</ul>

			<div class="panel panel-default" id="tab-container"><%-- panel --%>
				<div class="panel-body"><%-- panel body --%>
					<div class="tab-content"><%-- tabs content --%>
						<s:iterator var="lang" value="langs" status="langStatusVar"><%-- lang iterator --%>
							<div id="<s:property value="#lang.code" />_tab" class="tab-pane <s:if test="#langStatusVar.first"> active </s:if>"><%-- tab --%>
								<h3 class="sr-only"><s:property value="#lang.descr" /> (<a class="backLink" href="#quickmenu" id="<s:property value="#lang.code" />_tab_quickmenu"><s:text name="note.goBackToQuickMenu" /></a>)</h3>
								<s:iterator value="content.attributeList" var="attribute" status="attributeListStatus"><%-- content.attributeList iterator --%>
									<div class="form-group"><%-- form-group --%>
										<wpsa:tracerFactory var="attributeTracer" lang="%{#lang.code}" /><%-- tracer init --%>
										<s:if test="null != #attribute.description"><s:set var="attributeLabelVar" value="#attribute.description" /></s:if>
										<s:else><s:set var="attributeLabelVar" value="#attribute.name" /></s:else>
										<label><s:property value="#attributeLabelVar" /></label>
									 	<div class="input-group"><%--input-group --%>
											<s:if test="#attribute.type == 'Monotext' || #attribute.type == 'Text' || #attribute.type == 'Longtext' || #attribute.type == 'Enumerator'">
												<s:if test="#lang.default">
													<div>
														<s:include value="/WEB-INF/apsadmin/jsp/entity/view/textAttribute.jsp" />
													</div>
												</s:if>
												<s:else>
													<s:if test="%{(#attribute.isMultilingual()) && (#attribute.getTextForLang(#lang.code)!=null)}">
															<div>
																<s:include value="/WEB-INF/apsadmin/jsp/entity/view/textAttribute.jsp" />
															</div>
													</s:if>
													<s:else>
															<div class="text-muted">
																<s:property value="#attribute.getText()" />
														</div>
													</s:else>
												</s:else>
											</s:if>
											<s:elseif test="#attribute.type == 'Attach'">
												<p><s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/view/attachAttribute.jsp" /></p>
											</s:elseif>
											<s:elseif test="#attribute.type == 'Boolean' || #attribute.type == 'CheckBox'">
												<s:include value="/WEB-INF/apsadmin/jsp/entity/view/checkBoxAttribute.jsp" />
											</s:elseif>
											<s:elseif test="#attribute.type == 'Date'">
												<p><s:include value="/WEB-INF/apsadmin/jsp/entity/view/dateAttribute.jsp" /></p>
											</s:elseif>
											<s:elseif test="#attribute.type == 'Hypertext'">
												<div><s:include value="/WEB-INF/apsadmin/jsp/entity/view/hypertextAttribute.jsp" /></div>
											</s:elseif>
											<s:elseif test="#attribute.type == 'Image'">
												<p><s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/view/imageAttribute.jsp" /></p>
											</s:elseif>
											<s:elseif test="#attribute.type == 'Link'">
												<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/view/linkAttribute.jsp" />
											</s:elseif>
											<s:elseif test="#attribute.type == 'Number'">
												<p><s:include value="/WEB-INF/apsadmin/jsp/entity/view/numberAttribute.jsp" /></p>
											</s:elseif>
											<s:elseif test="#attribute.type == 'ThreeState'">
												<s:include value="/WEB-INF/apsadmin/jsp/entity/view/threeStateAttribute.jsp" />
											</s:elseif>
											<s:elseif test="#attribute.type == 'Timestamp'">
												<s:include value="/WEB-INF/apsadmin/jsp/entity/view/timestampAttribute.jsp" />
											</s:elseif>

											<s:elseif test="#attribute.type == 'Composite'">
												<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/view/compositeAttribute.jsp" />
											</s:elseif>
											<s:elseif test="#attribute.type == 'List'">
												<s:include value="/WEB-INF/apsadmin/jsp/entity/view/listAttribute.jsp" />
											</s:elseif>
											<s:elseif test="#attribute.type == 'Monolist'">
												<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/view/monolistAttribute.jsp" />
											</s:elseif>
										</div><%--input-group --%>
									</div><%-- form-group --%>
									<s:if test="!#attributeListStatus.last"><hr /></s:if>
								</s:iterator><%-- content.attributeList iterator --%>
							</div><%-- tab --%>
						</s:iterator><%-- lang iterator --%>
					</div><%-- tabs content --%>
				</div><%-- panel body --%>
		</div><%-- panel --%>
	</div><%-- tabs container --%>
	</s:else><%-- content is not null --%>
</div><%-- #main --%>