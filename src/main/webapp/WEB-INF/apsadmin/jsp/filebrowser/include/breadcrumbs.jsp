<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set value="breadCrumbsTargets" name="breadCrumbsTargetsVar" />
<p class="sr-only">You are here:</p>
<ol class="breadcrumb margin-none">
	<s:if test="null != #breadCrumbsTargetsVar">
		<li>
			<a href="<s:url namespace="/do/FileBrowser" action="list" />">root</a>
		</li>
		<s:iterator value="#breadCrumbsTargetsVar" var="targetVar" status="statusVar">
			<li>
				<s:if test="!#statusVar.last">
					<a href="<s:url namespace="/do/FileBrowser" action="list" >
							<s:param name="currentPath"><s:property escape="true" value="#targetVar.key"/></s:param>
						</s:url>"><s:property value="#targetVar.value" />
					</a>
				</s:if>
				<s:else>
					<s:property escape="false" value="#targetVar.value" />
				</s:else>
			</li>
		</s:iterator>
	</s:if>
	<s:else>
		<li>
			root
		</li>
	</s:else>
</ol>
