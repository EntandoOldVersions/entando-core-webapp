<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<p><s:text name="note.youAreHere" />: 

<s:set value="%{getBreadCrumbsTargets(#breadcrumbs_pivotPageCode)}" name="breadCrumbsTargets" ></s:set>
<s:iterator value="#breadCrumbsTargets" id="target" status="rowstatus">
<s:if test="%{#rowstatus.index != 0}"> &raquo; </s:if>
<s:if test="%{!isUserAllowed(#target)}">
<s:property value="getTitle(#target.code, #target.titles)" />
</s:if>
<s:else>
<a href="<s:url namespace="/do/Page" action="viewTree" ><s:param name="selectedNode"><s:property value="#target.code" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:property value="getTitle(#target.code, #target.titles)" />"><s:property value="getTitle(#target.code, #target.titles)" /></a>
<wpsa:page key="%{#target.code}" property="void" var="isVoid" />
	<s:if test="!#isVoid">
		<a class="noborder" href="<wp:info key="systemParam" paramName="applicationBaseURL" /><s:property value="currentLang.code"/>/<s:property value="#target.code" />.wp" title="<s:text name="note.goToPortal" />: <s:property value="getTitle(#target.code, #target.titles)" />"><img src="<wp:resourceURL />administration/common/img/icons/16x16/emblem-web.png" alt="<s:text name="note.goToPortal" />: <s:property value="getTitle(#target.code, #target.titles)" />" class="alignBottom" /></a> 
	</s:if>
</s:else>
</s:iterator>
</p>