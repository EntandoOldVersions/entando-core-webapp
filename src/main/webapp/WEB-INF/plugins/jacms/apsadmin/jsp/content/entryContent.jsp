<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" namespace="/do/jacms/Content"/>">
			<s:text name="jacms.menu.contentAdmin" />
		</a>&#32;/&#32;
		<s:if test="getStrutsAction() == 1">
			<s:text name="label.new" />
		</s:if>
		<s:else>
			<s:text name="label.edit" />
		</s:else>
	</span>
</h1>
<div id="main">
	<s:if test="hasFieldErrors()">
		<div class="alert alert-danger alert-dismissable fade in">
			<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
			<h2 class="h4 margin-none"><s:text name="message.title.FieldErrors" /></h2>
			<p class="margin-base-vertical"><s:text name="message.content.error" /></p>
		</div>
	</s:if>
	<p class="sr-only"><s:text name="note.editContent" /></p>
	<!--
	<ul class="menu horizontal tab-toggle-bar"><li><a href="#info" id="info_tab_quickmenu" class="tab-toggle"><abbr title="<s:text name="title.contentInfo" />"><s:text name="label.general" /></abbr></a></li><s:iterator value="langs" id="lang"><li><a href="#<s:property value="#lang.code" />_tab" class="tab-toggle"><s:property value="#lang.descr" /></a></li></s:iterator></ul>
	-->
	<s:set var="removeIcon" id="removeIcon"><wp:resourceURL/>administration/common/img/icons/delete.png</s:set>
	<s:form cssClass="tab-container action-form">
		<s:set var="myNameIsJack" value="true" />
		<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/include/snippet-content.jsp" />
		<p class="sr-only">
			<s:hidden name="contentOnSessionMarker" />
		</p>
		<h2 class="sr-only" id="quickmenu"><s:text name="title.quickMenu" /></h2>
		<ul class="nav nav-tabs tab-togglers">
			<li class="sr-only"><a data-toggle="tab" href="#info_tab"><s:text name="title.contentInfo" /></a></li>
			<s:iterator value="langs" var="lang" status="langStatusVar">
				<li <s:if test="#langStatusVar.first"> class="active" </s:if>>
					<a data-toggle="tab" href="#<s:property value="#lang.code" />_tab">
						<s:property value="#lang.descr" />
					</a>
				</li>
			</s:iterator>
		</ul>
		<div class="panel panel-default"><%-- panel default --%>
			<div class="panel-body"><%-- panel body --%>
				<div class="tab-content"><%-- tabs container --%>
					<s:iterator value="langs" var="lang" status="langStatusVar"><%-- lang iterator --%>
						<div id="<s:property value="#lang.code" />_tab" class="tab-pane <s:if test="#langStatusVar.first"> active </s:if>"><%-- tab --%>
							<h2 class="sr-only">
								<s:property value="#lang.descr" />
							</h2>
							<p class="sr-only">
								<a class="sr-only" href="#quickmenu" id="<s:property value="#lang.code" />_tab_quickmenu"><s:text name="note.goBackToQuickMenu" /></a>
							</p>
							<s:iterator value="content.attributeList" var="attribute"><%-- attributes iterator --%>
								<div id="<s:property value="%{'contentedit_'+#lang.code+'_'+#attribute.name}" />"><%-- contentedit div --%>
									<wpsa:tracerFactory var="attributeTracer" lang="%{#lang.code}" /><%-- tracer init --%>
									<s:set var="attributeFieldErrorsVar" value="%{fieldErrors[#attributeTracer.getFormFieldName(#attribute)]}" />
									<s:set var="attributeHasFieldErrorVar" value="#attributeFieldErrorsVar != null && !#attributeFieldErrorsVar.isEmpty()" />
									<s:set var="controlGroupErrorClassVar" value="''" />
									<s:set var="inputErrorClassVar" value="''" />
									<s:if test="#attributeHasFieldErrorVar">
										<s:set var="controlGroupErrorClassVar" value="' has-error'" />
										<s:set var="inputErrorClassVar" value="' input-with-feedback'" />
									</s:if>
									<s:if test="null != #attribute.description"><s:set var="attributeLabelVar" value="#attribute.description" /></s:if>
									<s:else><s:set var="attributeLabelVar" value="#attribute.name" /></s:else>

									<div class="form-group<s:property value="controlGroupErrorClassVar" />"><!-- form group -->
										<s:if test="#attribute.type == 'List' || #attribute.type == 'Monolist'">
												<label class="display-block"><span class="icon icon-list"></span>&#32;<s:property value="#attributeLabelVar" />&#32;<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" /></label>
										</s:if>
										<s:elseif test="#attribute.type == 'Image' || #attribute.type == 'Attach' || #attribute.type == 'CheckBox' || #attribute.type == 'Boolean' || #attribute.type == 'ThreeState' || #attribute.type == 'Composite'">
												<label class="display-block"><s:property value="#attributeLabelVar" />&#32;<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" /></label>
										</s:elseif>
										<s:elseif test="#attribute.type == 'Monotext' || #attribute.type == 'Text' || #attribute.type == 'Longtext' || #attribute.type == 'Hypertext' || #attribute.type == 'Number' || #attribute.type == 'Date' || #attribute.type == 'Timestamp' || #attribute.type == 'Link' || #attribute.type == 'Enumerator'">
												<label class="display-block" for="<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />"><s:property value="#attributeLabelVar" />&#32;<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" /></label>
										</s:elseif>
										<s:if test="#attribute.type == 'Attach'">
											<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/attachAttribute.jsp" />
										</s:if>
										<s:elseif test="#attribute.type == 'Boolean'">
											<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/booleanAttribute.jsp" />
										</s:elseif>
										<s:elseif test="#attribute.type == 'CheckBox'">
											<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/checkBoxAttribute.jsp" />
										</s:elseif>
										<s:elseif test="#attribute.type == 'Date'">
											<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/dateAttribute.jsp" />
										</s:elseif>
										<s:elseif test="#attribute.type == 'Enumerator'">
											<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/enumeratorAttribute.jsp" />
										</s:elseif>
										<s:elseif test="#attribute.type == 'Hypertext'">
											<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/hypertextAttribute.jsp" />
										</s:elseif>
										<s:elseif test="#attribute.type == 'Image'">
											<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/imageAttribute.jsp" />
										</s:elseif>
										<s:elseif test="#attribute.type == 'Link'">
											<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/linkAttribute.jsp" />
										</s:elseif>
										<s:elseif test="#attribute.type == 'Longtext'">
											<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/longtextAttribute.jsp" />
										</s:elseif>
										<s:elseif test="#attribute.type == 'Monotext'">
											<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/monotextAttribute.jsp" />
										</s:elseif>
										<s:elseif test="#attribute.type == 'Number'">
											<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/numberAttribute.jsp" />
										</s:elseif>
										<s:elseif test="#attribute.type == 'Text'">
											<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/textAttribute.jsp" />
										</s:elseif>
										<s:elseif test="#attribute.type == 'ThreeState'">
											<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/threeStateAttribute.jsp" />
										</s:elseif>
										<s:elseif test="#attribute.type == 'Timestamp'">
											<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/timestampAttribute.jsp" />
										</s:elseif>

										<s:elseif test="#attribute.type == 'Composite'">
											<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/compositeAttribute.jsp" />
										</s:elseif>
										<s:elseif test="#attribute.type == 'List'">
											<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/listAttribute.jsp" />
										</s:elseif>
										<s:elseif test="#attribute.type == 'Monolist'">
											<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/monolistAttribute.jsp" />
										</s:elseif>
										<wpsa:hookPoint key="jacms.entryContent.attributeExtra" objectName="hookPointElements_jacms_entryContent_attributeExtra">
											<s:iterator value="#hookPointElements_jacms_entryContent_attributeExtra" var="hookPointElement">
												<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
											</s:iterator>
										</wpsa:hookPoint>
										<s:if test="#attributeFieldErrorsVar">
											<p class="text-danger padding-small-vertical"><s:iterator value="#attributeFieldErrorsVar"><s:property /> </s:iterator></p>
										</s:if>
									</div><!-- form group -->
								</div><!-- contentedit div -->
							</s:iterator><%-- attributes iterator --%>
							<s:set var="showingPageSelectItems" value="showingPageSelectItems" />
							<s:set var="iconImagePath"><wp:resourceURL/>administration/common/img/icons/32x32/content-preview.png</s:set>
							<wpsa:actionParam action="preview" var="previewActionName" >
								<wpsa:actionSubParam name="%{'jacmsPreviewActionLangCode_' + #lang.code}" value="%{#lang.code}" />
							</wpsa:actionParam>
							<div class="margin-base-vertical">
								<s:if test="!#showingPageSelectItems.isEmpty()">
									<s:set var="previewActionPageCodeLabelId">jacmsPreviewActionPageCode_<s:property value="#lang.code" /></s:set>
									<p><label for="<s:property value="#previewActionPageCodeLabelId" />"><s:text name="name.preview.page" /></label>
									<s:select name="%{'jacmsPreviewActionPageCode_' + #lang.code}" id="%{#previewActionPageCodeLabelId}" list="#showingPageSelectItems" listKey="key" listValue="value" />
									<%-- <s:select name="jacmsPreviewActionPageCode" id="%{#previewActionPageCodeLabelId}" list="#showingPageSelectItems" listKey="key" listValue="value" /></p>  --%>
									<wpsf:submit cssClass="button" action="%{#previewActionName}" value="%{getText('label.preview')}" title="%{getText('note.button.previewContent')}" /></p>
								</s:if>
								<s:else>
									<p><s:text name="label.preview.noPreviewPages" /></p>
									<p><wpsf:submit cssClass="button" disabled="true" action="%{#previewActionName}" value="%{getText('label.preview')}" title="%{getText('note.button.previewContent')}" /></p>
								</s:else>
							</div>
						</div><!-- tab -->
					</s:iterator><%-- lang iterator --%>
					<div id="info">
						<h2 class="js_sr-only"><s:text name="title.contentInfo" /> <a href="#quickmenu" id="info_content_goBackToQuickMenu" title="<s:text name="note.goBackToQuickMenu" />"><span class="icon icon-circle-arrow-up"></span></a></h2>
						<div class="subsection">
							<!--  INIZIO BLOCCO SELEZIONE GRUPPI SUPPLEMENTARI ABILITATI ALLA VISUALIZZAZIONE -->
							<fieldset>
								<legend><s:text name="label.extraGroups" /></legend>
								<s:if test="content.groups.size != 0">
									<ul>
									<s:iterator value="content.groups" id="groupName">
										<li>
											<wpsa:actionParam action="removeGroup" var="actionName" >
												<wpsa:actionSubParam name="extraGroupName" value="%{#groupName}" />
											</wpsa:actionParam>
											<s:submit action="%{#actionName}" type="image" src="%{#removeIcon}" value="%{getText('label.remove')}" title="%{getText('label.remove')}" />: <s:property value="%{getGroupsMap()[#groupName].getDescr()}"/>
										</li>
									</s:iterator>
									</ul>
								</s:if>
								<p>
									<label for="extraGroups" class="basic-mint-label"><s:text name="label.join" />&#32;<s:text name="label.group" /></label>
									<s:select name="extraGroupName" id="extraGroups" list="groups"
										listKey="name" listValue="descr" cssClass="text" />
									<s:submit action="joinGroup" value="%{getText('label.join')}" cssClass="button" />
								</p>
							</fieldset>
							<s:action name="showCategoryBlockOnEntryContent" namespace="/do/jacms/Content" executeResult="true"><s:param name="contentOnSessionMarker" value="contentOnSessionMarker" /></s:action>
							<!-- FINE CATEGORIE -->
						</div>
						<wpsa:hookPoint key="jacms.entryContent.tabGeneral" objectName="hookPointElements_jacms_entryContent_tabGeneral">
							<s:iterator value="#hookPointElements_jacms_entryContent_tabGeneral" var="hookPointElement">
								<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
							</s:iterator>
						</wpsa:hookPoint>
					</div>
				</div><%-- tabs container --%>
			</div>
		</div>
		<h2 class="sr-only"><s:text name="title.contentActionsIntro" /></h2>
		<wpsa:hookPoint key="jacms.entryContent.actions" objectName="hookPointElements_jacms_entryContent_actions">
			<s:iterator value="#hookPointElements_jacms_entryContent_actions" var="hookPointElement">
				<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
			</s:iterator>
		</wpsa:hookPoint>
	</s:form>
</div>
