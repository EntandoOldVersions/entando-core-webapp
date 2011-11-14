<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<s:set var="details_pivotPage" value="pageToShow" />

<dl class="table-display">
	<dt><s:text name="name.pageCode" /></dt>
		<dd><s:property value="#details_pivotPage.code" /></dd>
	<dt><s:text name="name.pageTitle" /></dt>
		<dd>
<s:iterator value="langs" status="pageInfo_rowStatus" var="lang">
		<s:if test="#pageInfo_rowStatus.index != 0">, </s:if><span class="monospace">(<abbr title="<s:property value="descr" />"><s:property value="code" /></abbr>)</span> <s:property value="#details_pivotPage.getTitles()[#lang.code]" />
</s:iterator>
		</dd>
	<dt><s:text name="label.ownerGroup" /></dt>
		<dd><s:property value="systemGroups[#details_pivotPage.group].descr" /></dd>
	<dt><s:text name="label.extraGroups" /></dt>
		<dd>
			<s:if test="#details_pivotPage.extraGroups.size() != 0">
				<s:iterator value="#details_pivotPage.extraGroups" id="groupName" status="groupStatus">
					<s:property value="systemGroups[#groupName].descr"/><s:if test="!#groupStatus.last">,&#32;</s:if> 
				</s:iterator>
			</s:if>
			<s:else>
				<abbr title="<s:text name="note.viewOnlyGroups.notAvailable" />">&ndash;</abbr>
			</s:else>
		</dd>
	<dt><s:text name="name.pageModel" /></dt>
		<dd><s:property value="#details_pivotPage.model.descr" /></dd>

<s:set var="freeViewerPage" ><s:property value="{isFreeViewerPage(#details_pivotPage)}" /></s:set>
<s:if test="#freeViewerPage.equals('[true]')">
	<s:set var="freeViewerPageIconImagePath" id="freeViewerPageIconImagePath"><wp:resourceURL/>administration/common/img/icons/true.png</s:set>
	<s:set var="freeViewerPageBooleanStatus" value="%{getText('label.yes')}" />
</s:if>
<s:elseif test="#freeViewerPage.equals('[false]')" >
	<s:set var="freeViewerPageIconImagePath" id="freeViewerPageIconImagePath"><wp:resourceURL/>administration/common/img/icons/false.png</s:set>
	<s:set var="freeViewerPageBooleanStatus" value="%{getText('label.no')}" />
</s:elseif>

	<dt><s:text name="name.isViewerPage" /></dt>
		<dd><img src="<s:property value="#freeViewerPageIconImagePath" />" alt="<s:property value="freeViewerPageBooleanStatus" />" title="<s:property value="freeViewerPageBooleanStatus" />" /></dd>	
			
<s:if test="#details_pivotPage.showable">
	<s:set var="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/true.png</s:set>
	<s:set var="booleanStatus" value="%{getText('label.yes')}" />
</s:if>
<s:else>
	<s:set var="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/false.png</s:set>
	<s:set var="booleanStatus" value="%{getText('label.no')}" />
</s:else>

	<dt><s:text name="name.isShowablePage" /></dt>
		<dd><img src="<s:property value="iconImagePath" />" alt="<s:property value="booleanStatus" />" title="<s:property value="booleanStatus" />" /></dd>

<s:if test="#details_pivotPage.useExtraTitles">
	<s:set var="useExtraTitlesIconImagePath" id="useExtraTitlesIconImagePath"><wp:resourceURL/>administration/common/img/icons/true.png</s:set>
	<s:set var="useExtraTitlesBooleanStatus" value="%{getText('label.yes')}" />
</s:if>
<s:else>
	<s:set var="useExtraTitlesIconImagePath" id="useExtraTitlesIconImagePath"><wp:resourceURL/>administration/common/img/icons/false.png</s:set>
	<s:set var="useExtraTitlesBooleanStatus" value="%{getText('label.no')}" />
</s:else>

	<dt><abbr lang="en" title="<s:text name="name.SEO.full" />"><s:text name="name.SEO.short" /></abbr>:&#32;<s:text name="name.useBetterTitles" /></dt>
		<dd><img src="<s:property value="useExtraTitlesIconImagePath" />" alt="<s:property value="useExtraTitlesBooleanStatus" />" title="<s:property value="useExtraTitlesBooleanStatus" />" /></dd>

</dl>