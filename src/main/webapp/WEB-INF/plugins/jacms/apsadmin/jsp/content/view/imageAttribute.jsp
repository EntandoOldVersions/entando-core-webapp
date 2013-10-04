<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<s:set var="currentResource" value="#attribute.resources[#lang.code]" />
<s:set var="defaultResource" value="#attribute.resource" />
<s:if test="#currentResource != null">
	<img
		class="img-thumbnail"
		src="<s:property value="#defaultResource.getImagePath('1')"/>" 
		alt="<s:property value="#defaultResource.descr"/>" />
	<span class="sr-only">
		<abbr 
			title="<s:text name="label.img.text.long" />">
			<s:text name="label.img.text.short" /></abbr>:&#32;
	</span>
	<s:include value="/WEB-INF/apsadmin/jsp/entity/view/textAttribute.jsp" />
</s:if>
<s:else>
	<span class="text-muted"><s:text name="label.none" /></span>
</s:else>