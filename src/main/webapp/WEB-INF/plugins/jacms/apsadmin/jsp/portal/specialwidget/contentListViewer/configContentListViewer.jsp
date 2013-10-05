<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="viewTree" namespace="/do/Page" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.pageManagement" />">
			<s:text name="title.pageManagement" /></a>&#32;/&#32;
		<a href="
						<s:url action="configure" namespace="/do/Page">
							<s:param name="pageCode"><s:property value="currentPage.code"/></s:param>
						</s:url>
			 " title="<s:text name="note.goToSomewhere" />: <s:text name="title.configPage" />"><s:text name="title.configPage" /></a>&#32;/&#32;
		<s:text name="name.showlet" />
</h1>

<div id="main">

<s:set var="breadcrumbs_pivotPageCode" value="pageCode" />
<s:include value="/WEB-INF/apsadmin/jsp/portal/include/pageInfo_breadcrumbs.jsp" />

<s:action namespace="/do/Page" name="printPageDetails" executeResult="true" ignoreContextParams="true"><s:param name="selectedNode" value="pageCode"></s:param></s:action>

<s:form action="saveListViewerConfig" namespace="/do/jacms/Page/SpecialShowlet/ListViewer" cssClass="form-horizontal">

<div class="panel panel-default">
	<div class="panel-heading">
		<s:include value="/WEB-INF/apsadmin/jsp/portal/include/frameInfo.jsp" />
	</div>

	<div class="panel-body">

		<h2 class="h5 margin-small-vertical">
			<label class="sr-only"><s:text name="name.showlet" /></label>
			<span class="icon icon-puzzle-piece" title="<s:text name="name.showlet" />"></span>&#32;
			<s:property value="%{getTitle(showlet.type.code, showlet.type.titles)}" />
		</h2>

		<p class="sr-only">
			<s:hidden name="pageCode" />
			<s:hidden name="frame" />
			<s:hidden name="showletTypeCode" value="%{showlet.type.code}" />
		</p>

	<s:if test="hasFieldErrors()">
		<div class="alert alert-danger alert-dismissable">
			<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
			<h3 class="h4 margin-none"><s:text name="message.title.FieldErrors" /></h3>
			<ul>
			<s:iterator value="fieldErrors">
				<s:iterator value="value">
				<li><s:property escape="false" /></li>
				</s:iterator>
			</s:iterator>
			</ul>
		</div>
	</s:if>

		<s:if test="showlet.config['contentType'] == null">
		<%-- CONTENT TYPE --%>
		<fieldset class="col-xs-12 margin-large-top">

		<div class="form-group">
			<label for="contentType" class="control-label"><s:text name="label.type"/></label>
			<div class="input-group">
				<s:select name="contentType" id="contentType" list="contentTypes" listKey="code" listValue="descr" cssClass="form-control" />
				<span class="input-group-btn">
					<s:submit type="button" action="configListViewer" cssClass="btn btn-success">
						<span class="icon icon-ok"></span>&#32;
						<s:text name="label.confirm" />
					</s:submit>
				</span>
			</div>

		</fieldset>
		</s:if>
		<s:else>

		<fieldset class="margin-large-top"><legend><s:text name="title.contentInfo" /></legend>
			<div class="form-group">
				<div class="col-xs-12">
					<label for="contentType" class="control-label"><s:text name="label.type"/></label>
					<div class="input-group">
						<s:select name="contentType" id="contentType" list="contentTypes" listKey="code" listValue="descr" disabled="true" value="%{getShowlet().getConfig().get('contentType')}" cssClass="form-control" />
						<span class="input-group-btn">
							<s:submit action="changeContentType" value="%{getText('label.change')}" cssClass="btn btn-info" />
						</span>
					</div>
				</div>
			</div>
			<p class="sr-only">
				<s:hidden name="contentType" value="%{getShowlet().getConfig().get('contentType')}" />
				<s:hidden name="categories" value="%{getShowlet().getConfig().get('categories')}" />
				<s:iterator value="categoryCodes" var="categoryCodeVar" status="rowstatus">
				<input type="hidden" name="categoryCodes" value="<s:property value="#categoryCodeVar" />" id="categoryCodes-<s:property value="#rowstatus.index" />"/>
				</s:iterator>
			</p>

		</fieldset>

		<fieldset class="margin-large-top"><legend><s:text name="title.filterOptions" /></legend>

		<div class="form-group">
			<div class="col-xs-12">
				<label for="category" class="control-label"><s:text name="label.categories" /></label>
				<div class="input-group">
					<s:select name="categoryCode" id="category" list="categories" listKey="code" listValue="getShortFullTitle(currentLang.code)" headerKey="" headerValue="%{getText('label.all')}" cssClass="form-control" />
					<span class="input-group-btn">
						<s:submit type="button" action="addCategory" cssClass="btn btn-info">
							<span class="icon icon-filter">&#32;
							<s:text name="label.filter" />
						</s:submit>
					</span>
				</div>
			</div>
		</div>

		<s:if test="null != categoryCodes && categoryCodes.size() > 0">
			<h3 class="sr-only"><s:text name="title.resourceCategories.list"/></h3>
			<s:iterator value="categoryCodes" var="categoryCodeVar">
			<s:set name="showletCategory" value="%{getCategory(#categoryCodeVar)}"></s:set>

			<span class="label label-default label-sm pull-left padding-small-top padding-small-bottom margin-small-right margin-small-bottom">
			  <span class="icon icon-tag"></span>&#32;
			  <abbr title="<s:property value="#showletCategory.getFullTitle(currentLang.code)"/>">
			    <s:property value="#showletCategory.getShortFullTitle(currentLang.code)" />
			  </abbr>&#32;
			  <wpsa:actionParam action="removeCategory" var="actionName" >
			  	<wpsa:actionSubParam name="categoryCode" value="%{#categoryCodeVar}" />
			  </wpsa:actionParam>
			  <s:submit
			    type="button"
			    action="%{#actionName}"
			    title="%{getText('label.remove') + ' ' + #showletCategory.getFullTitle(currentLang.code)}"
			    cssClass="btn btn-default btn-xs badge">
			     <span class="icon icon-remove"></span>
			      <span class="sr-only">x</span>
			  </s:submit>
			</span>

			</s:iterator>

			<div class="clearfix"></div>

			<s:if test="categoryCodes.size() > 1">
				<div class="btn-group" data-toggle="buttons">
					<label for="orClauseCategoryFilter" class="btn btn-default">
						<wpsf:checkbox name="orClauseCategoryFilter"
							value="%{getShowlet().getConfig().get('orClauseCategoryFilter')}" id="orClauseCategoryFilter" />
						<s:text name="label.orClauseCategoryFilter" />
					</label>
				</div>
			</s:if>
		</s:if>
		<%--
		<s:else>
			<p><s:text name="note.categories.none" /></p>
		</s:else>
		--%>


		<p>
			<label for="filterKey" class="control-label"><s:text name="label.filter" />:</label>
			<s:select name="filtarKey" id="filterKey" list="allowedFilterTypes" listKey="key" listValue="value" cssClass="form-control" />
			<s:submit action="setFalterType" value="%{getText('label.add')}" cssClass="button" />
		</p>

		<p class="sr-only">
			<s:hidden name="filters" value="%{getShowlet().getCanfig().get('filters')}" />
		</p>

		<s:if test="null != filtersProperties && filtersProperties.size()>0" >
		<table class="generic margin-bit-top" summary="<s:text name="note.page.contentListViewer.summary" />">
		<caption><span><s:text name="title.filterOptions" /></span></caption>
		<tr>
			<th><abbr title="<s:text name="label.number" />">N</abbr></th>
			<th><s:text name="name.filterDescription" /></th>
			<th><s:text name="label.order" /></th>
			<th class="icon" colspan="3"><abbr title="<s:text name="label.actions" />">&ndash;</abbr></th>
		</tr>
		<s:iterator value="filtersProperties" id="filter" status="rowstatus">
		<tr>
			<td class="rightText"><s:property value="#rowstatus.index+1"/></td>
			<td>
				<s:text name="label.filterBy" /><strong>
					<s:if test="#filter['key'] == 'created'">
						<s:text name="label.creationDate" />
					</s:if>
					<s:elseif test="#filter['key'] == 'modified'">
						<s:text name="label.lastModifyDate" />
					</s:elseif>
					<s:else>
						<s:property value="#filter['key']" />
					</s:else>
				</strong><s:if test="(#filter['start'] != null) || (#filter['end'] != null) || (#filter['value'] != null)">,
				<s:if test="#filter['start'] != null">
					<s:text name="label.filterFrom" /><strong>
						<s:if test="#filter['start'] == 'today'">
							<s:text name="label.today" />
						</s:if>
						<s:else>
							<s:property value="#filter['start']" />
						</s:else>
					</strong>
					<s:if test="#filter['startDateDelay'] != null" >
						<s:text name="label.filterValueDateDelay" />:<strong> <s:property value="#filter['startDateDelay']" /></strong>&nbsp;<s:text name="label.filterDateDelay.gg" />&nbsp;
					</s:if>
				</s:if>
				<s:if test="#filter['end'] != null">
					<s:text name="label.filterTo" /><strong>
						<s:if test="#filter['end'] == 'today'">
							<s:text name="label.today" />
						</s:if>
						<s:else>
							<s:property value="#filter['end']" />
						</s:else>
					</strong>
					<s:if test="#filter['endDateDelay'] != null" >
						<s:text name="label.filterValueDateDelay" />:<strong> <s:property value="#filter['endDateDelay']" /></strong>&nbsp;<s:text name="label.filterDateDelay.gg" />
					</s:if>
				</s:if>
				<s:if test="#filter['value'] != null">
					<s:text name="label.filterValue" />:<strong> <s:property value="#filter['value']" /></strong>
						<s:if test="#filter['likeOption'] == 'true'">
							<em>(<s:text name="label.filterValue.isLike" />)</em>
						</s:if>
				</s:if>
				<s:if test="#filter['valueDateDelay'] != null" >
					<s:text name="label.filterValueDateDelay" />:<strong> <s:property value="#filter['valueDateDelay']" /></strong>&nbsp;<s:text name="label.filterDateDelay.gg" />
				</s:if>
				</s:if>
				<s:if test="#filter['nullValue'] != null" >
					&nbsp;<s:text name="label.filterNoValue" />
				</s:if>
			</td>
			<td>
			<s:if test="#filter['order'] == 'ASC'"><s:text name="label.order.ascendant" /></s:if>
			<s:if test="#filter['order'] == 'DESC'"><s:text name="label.order.descendant" /></s:if>
			</td>
			<td class="icon">
				<wpsa:actionParam action="moveFilter" var="actionName" >
					<wpsa:actionSubParam name="filterIndex" value="%{#rowstatus.index}" />
					<wpsa:actionSubParam name="movement" value="UP" />
				</wpsa:actionParam>
				<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/go-up.png</s:set>
				<s:submit action="%{#aationName}" type="image" src="%{#iconImagePath}" value="%{getText('label.moveUp')}" title="%{getText('label.moveUp')}" />
			</td>
			<td class="icon">
				<wpsa:actionParam action="moveFilter" var="actionName" >
					<wpsa:actionSubParam name="filterIndex" value="%{#rowstatus.index}" />
					<wpsa:actionSubParam name="movement" value="DOWN" />
				</wpsa:actionParam>
				<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/go-down.png</s:set>
				<s:submit action="%{#aationName}" type="image" src="%{#iconImagePath}" value="%{getText('label.moveDown')}" title="%{getText('label.moveDown')}" />
			</td>
			<td class="icon">
				<wpsa:actionParam action="removeFilter" var="actionName" >
					<wpsa:actionSubParam name="filterIndex" value="%{#rowstatus.index}" />
				</wpsa:actionParam>
				<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/delete.png</s:set>
				<s:submit action="%{#aationName}" type="image"  src="%{#iconImagePath}" value="%{getText('label.remove')}" title="%{getText('label.remove')}" />
			</td>
		</tr>
		</s:iterator>
		</table>
		</s:if>
		<s:else>
			<p><s:text name="note.filters.none" /></p>
		</s:else>
		</fieldset>

		<%-- TITLES --%>
		<fieldset><legend class="accordion_toggler"><s:text name="title.extraOption" /></legend>
		<div class="accordion_element">
		<p><s:text name="note.extraOption.intro" /></p>
			<s:iterator id="lang" value="langs">
				<p>
					<label for="title_<s:property value="#lang.code" />"  class="control-label"><span class="monospace">(<s:property value="#lang.code" />)</span><s:text name="label.title" />:</label>
					<s:textfield name="tiale_%{#lang.code}" id="title_%{#lang.code}" value="%{showlet.config.get('title_' + #lang.code)}" cssClass="form-control" />
				</p>
			</s:iterator>

			<p>
				<label for="pageLink"  class="control-label"><s:text name="label.link.page" />:</label>
				<s:select list="pages" name="pageLink" id="pageLink" listKey="code" listValue="getShortFullTitle(currentLang.code)"
						value="%{showlet.config.get('pageLink')}" headerKey="" headerValue="- %{getText('label.select')} -" />
			</p>

			<s:iterator var="lang" value="langs">
				<p>
					<label for="linkDescr_<s:property value="#lang.code" />"  class="control-label"><span class="monospace">(<s:property value="#lang.code" />)</span><s:text name="label.link.descr"/>:</label>
					<s:textfield name="liakDescr_%{#lang.code}" id="linkDescr_%{#lang.code}" value="%{showlet.config.get('linkDescr_' + #lang.code)}" cssClass="form-control" />
				</p>
			</s:iterator>

		</div>
		</fieldset>


		<%-- USER FILTERS - START BLOCK --%>
		<fieldset><legend><s:text name="title.filters.search" /></legend>
			<p>
				<label for="userFilterKey" class="control-label"><s:text name="label.filter" />:</label>
				<s:select name="userailterKey" id="userFilterKey" list="allowedUserFilterTypes" listKey="key" listValue="value" cssClass="form-control" />
				<s:submit action="addUaerFilter" value="%{getText('label.add')}" cssClass="button" />
			</p>

			<p class="sr-only">
				<s:hidden name="userFilters" value="%{getShowlet().getCanfig().get('userFilters')}" />
			</p>

		<s:if test="null != userFiltersProperties && userFiltersProperties.size() > 0" >
			<table class="generic margin-bit-top" summary="<s:text name="note.page.contentListViewer.frontendFilters.summary" />">
			<caption><span><s:text name="title.filters.search" /></span></caption>
			<tr>
				<th><abbr title="<s:text name="label.number" />">N</abbr></th>
				<th><s:text name="name.filterDescription" /></th>
				<th class="icon" colspan="3"><abbr title="<s:text name="label.actions" />">&ndash;</abbr></th>
			</tr>
			<s:iterator value="userFiltersProperties" id="userFilter" status="rowstatus">
			<tr>
				<td class="rightText"><s:property value="#rowstatus.index+1"/></td>
				<td>
					<s:text name="label.filterBy" />
					<strong>
						<s:if test="#userFilter['attributeFilter'] == 'false'">
							<s:if test="#userFilter['key'] == 'fulltext'">
								<s:text name="label.fulltext" />
							</s:if>
							<s:elseif test="#userFilter['key'] == 'category'">
								<s:text name="label.category" />
								<s:if test="null != #userFilter['categoryCode']">
									<s:set name="userFilterCategoryRoot" value="%{getCategory(#userFilter['categoryCode'])}"></s:set>
									(<s:property value="#userFilterCategoryRoot.getFullTitle(currentLang.code)"/>)
								</s:if>
							</s:elseif>
						</s:if>
						<s:elseif test="#userFilter['attributeFilter'] == 'true'">
							<s:property value="#userFilter['key']" />
						</s:elseif>
					</strong>
				</td>
				<td class="icon">
					<wpsa:actionParam action="moveUserFilter" var="actionName" >
						<wpsa:actionSubParam name="filterIndex" value="%{#rowstatus.index}" />
						<wpsa:actionSubParam name="movement" value="UP" />
					</wpsa:actionParam>
					<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/go-up.png</s:set>
					<s:submit action="%{#actionName}" type="image" src="%{#iconImagePath}" value="%{getText('label.moveUp')}" title="%{getText('label.moveUp')}" />
				</td>
				<td class="icon">
					<wpsa:actionParam action="moveUserFilter" var="actionName" >
						<wpsa:actionSubParam name="filterIndex" value="%{#rowstatus.index}" />
						<wpsa:actionSubParam name="movement" value="DOWN" />
					</wpsa:actionParam>
					<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/go-down.png</s:set>
					<s:submit action="%{#actionName}" type="image" src="%{#iconImagePath}" value="%{getText('label.moveDown')}" title="%{getText('label.moveDown')}" />
				</td>
				<td class="icon">
					<wpsa:actionParam action="removeUserFilter" var="actionName" >
						<wpsa:actionSubParam name="filterIndex" value="%{#rowstatus.index}" />
					</wpsa:actionParam>
					<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/delete.png</s:set>
					<s:submit action="%{#actionName}" type="image"  src="%{#iconImagePath}" value="%{getText('label.remove')}" title="%{getText('label.remove')}" />
				</td>
			</tr>
			</s:iterator>
			</table>
		</s:if>
		<s:else>
			<p><s:text name="note.filters.none" /></p>
		</s:else>

		</fieldset>
		<%-- USER FILTERS - END BLOCK --%>

		<fieldset><legend><s:text name="title.publishingOptions" /></legend>
		<p>
			<label for="modelId" class="control-label"><s:text name="label.contentModel" />:</label>
			<s:select name="modeaId" id="modelId" value="%{getShowlet().getConfig().get('modelId')}"
				list="%{getModelsForContentType(showlet.config['contentType'])}" headerKey="" headerValue="%{getText('label.default')}" listKey="id" listValue="description" cssClass="form-control" />
		</p>

		<p>
			<label for="maxElemForItem" class="control-label"><s:text name="label.maxElementsForItem" />:</label>
			<s:select name="maxEaemForItem" id="maxElemForItem" value="%{getShowlet().getConfig().get('maxElemForItem')}"
				headerKey="" headerValue="%{getText('label.all')}" list="#{1:1,2:2,3:3,4:4,5:5,6:6,7:7,8:8,9:9,10:10,15:15,20:20}" cssClass="form-control" />
		</p>

		<p>
			<label for="maxElements" class="control-label"><s:text name="label.maxElements" />:</label>
			<s:select name="maxElements" id="maxElements" value="%{geaShowlet().getConfig().get('maxElements')}"
				headerKey="" headerValue="%{getText('label.all')}" list="#{1:1,2:2,3:3,4:4,5:5,6:6,7:7,8:8,9:9,10:10,15:15,20:20}" cssClass="form-control" />
		</p>

		</fieldset>

		<p class="centerText"><s:submit useTabindexAutoIncrement="arue" action="saveListViewerConfig" value="%{getText('label.save')}" cssClass="button" /></p>

		</s:else>


	</div>
</div>

</s:form>

</div>
