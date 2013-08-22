<%@ taglib prefix="s" uri="/struts-tags" %>
<%-- file info --%>
<s:property value="#resource.descr" />
<s:set var="fileName" value="#resourceInstance.fileName" />
<s:if test='%{#fileName.length()>24}'>
	<s:set var="fileName" value='%{#fileName.substring(0,10)+"..."+#fileName.substring(#fileName.length()-10)}' />
	<s:property value="#fileName" />
</s:if>
<s:else>
	<s:property value="#fileName" />
</s:else>
	<%-- file dimensions --%>
	<ul>
		<li>
			<s:set var="dimensionId" value="0" />
			<s:set var="resourceInstance" value='%{#resource.getInstance(#dimensionId,null)}' />
			<a href="<s:property value="%{#resource.getImagePath(#dimensionId)}" />">
				<s:text name="label.size.original" />&#32;
				<s:property value='#resourceInstance.fileLength.replaceAll(" ", "&nbsp;")' escapeXml="false" escapeHtml="false" escapeJavaScript="false" />
			</a>
		</li>
		<s:set var="dimensionId" value="null" />
		<s:set var="resourceInstance" value="null" />
		<s:iterator value="#imageDimensionsVar" var="dimInfo">
			<s:set var="dimensionId" value="#dimInfo.idDim" />
			<s:set var="resourceInstance" value='%{#resource.getInstance(#dimensionId,null)}' />
			<s:if test="#resourceInstance != null">
		<li>
				<a href="<s:property value="%{#resource.getImagePath(#dimensionId)}" />">
					<s:property value="#dimInfo.dimx" />x<s:property value="#dimInfo.dimy" />&nbsp;px&#32;
					<s:property value='#resourceInstance.fileLength.replaceAll(" ", "&nbsp;")' escapeXml="false" escapeHtml="false" escapeJavaScript="false" />
				</a>
		</li>
			</s:if>
		</s:iterator>
	</ul>
<%-- // file info --%>
