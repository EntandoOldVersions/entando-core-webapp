<%@ taglib prefix="s" uri="/struts-tags" %>

<s:set value="breadCrumbsTargets" name="breadCrumbsTargetsVar" />

<s:if test="null != #breadCrumbsTargetsVar">
	<a href="<s:url namespace="/do/FileBrowser" action="list" />">**ROOT**</a>
<s:iterator value="#breadCrumbsTargetsVar" var="targetVar" status="statusVar">
	&nbsp;&nbsp;&ndash;>&nbsp;&nbsp;
	<s:if test="#statusVar.last"><s:property value="#targetVar.value" /></s:if>
	<s:else>
	<a href="<s:url namespace="/do/FileBrowser" action="list" >
			<s:param name="currentPath"><s:property escape="true" value="#targetVar.key"/></s:param>
		</s:url>"><s:property value="#targetVar.value" />
	</a>
	</s:else>
</s:iterator>
</s:if>
<s:else>
	**START NAVIGATION**
</s:else>