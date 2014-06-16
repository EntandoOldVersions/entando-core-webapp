<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set value="breadCrumbsTargets" name="breadCrumbsTargetsVar" />
<ol class="breadcrumb margin-none">
	<s:if test="null != #breadCrumbsTargetsVar">
		<li>
			<a href="<s:url namespace="/do/FileBrowser" action="list" />">root</a>
		</li>
		<s:iterator value="#breadCrumbsTargetsVar" var="targetVar" status="statusVar">
			<li class="<s:property value="#statusVar.last ? 'active' : ''" />">
				<s:if test="#statusVar.last">
					<s:property value="#targetVar.value" />
				</s:if>
				<s:else>
					<a href="<s:url namespace="/do/FileBrowser" action="list" >
							<s:param name="currentPath"><s:property escape="true" value="#targetVar.key"/></s:param>
						</s:url>"><s:property value="#targetVar.value" />
					</a>
				</s:else>
			</li>
		</s:iterator>
	</s:if>
	<s:else>
		<li class="active">
			/
		</li>
	</s:else>
</ol>
