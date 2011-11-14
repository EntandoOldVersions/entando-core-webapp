<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set name="currentResource" value="#attribute.resources[#lang.code]"></s:set>
<s:set name="defaultResource" value="#attribute.resource"></s:set>

<s:if test="#lang.default">
<%-- Lingua di DEFAULT --%>

	<s:if test="#currentResource != null">
		<a class="noborder" title="<s:text name="label.download" />" href="<s:property value="#defaultResource.attachPath" />"><s:include value="/WEB-INF/apsadmin/jsp/entity/view/textAttribute.jsp" /></a>&#32;(<s:property value="%{#defaultResource.instance.fileLength}"/>)
	</s:if>
	<s:else>
		<s:text name="label.none" />
	</s:else>

</s:if>
<s:else>
<%-- Lingua NON di DEFAULT --%>
	<s:if test="#defaultResource == null">
		<%-- Risorsa lingua di DEFAULT NON VALORIZZATA --%>
		<s:text name="label.attribute.resources.null" />
	</s:if>
	<s:else>
		<s:if test="#currentResource != null">
			<a class="noborder" title="<s:text name="label.download" />" href="<s:property value="#defaultResource.attachPath" />"><s:include value="/WEB-INF/apsadmin/jsp/entity/view/textAttribute.jsp" /></a>&#32;(<s:property value="%{#defaultResource.instance.fileLength}"/>)
		</s:if>
		<s:else>
			<a class="noborder" title="<s:text name="label.download" />" href="<s:property value="#defaultResource.attachPath" />"><s:text name="label.attribute.resources.attach.null" /></a>&#32;(<s:property value="%{#defaultResource.instance.fileLength}"/>)
		</s:else>
	</s:else>

</s:else>