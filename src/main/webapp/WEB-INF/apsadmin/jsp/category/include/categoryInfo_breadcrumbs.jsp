<%@ taglib prefix="s" uri="/struts-tags" %>

<p><s:text name="note.youAreHere" />: 

<s:set value="%{getBreadCrumbsTargets(#breadcrumbs_pivotCategoryCode)}" name="breadCrumbsTargets" ></s:set>
<s:iterator value="#breadCrumbsTargets" id="target" status="rowstatus">
<s:if test="%{#rowstatus.index != 0}"> &raquo; </s:if>
<a href="<s:url namespace="/do/Category" action="viewTree" ><s:param name="selectedNode"><s:property value="#target.code" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:property value="getTitle(#target.code, #target.titles)" />"><s:property value="getTitle(#target.code, #target.titles)" /></a>
</s:iterator>
</p>