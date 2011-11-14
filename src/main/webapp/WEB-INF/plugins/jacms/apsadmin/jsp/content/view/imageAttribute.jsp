<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set name="currentResource" value="#attribute.resources[#lang.code]"></s:set>
<s:set name="defaultResource" value="#attribute.resource"></s:set>
	<s:if test="#currentResource != null">
		<img src="<s:property value="#defaultResource.getImagePath('1')"/>" alt="<s:property value="#defaultResource.descr"/>" />
		<abbr title="<s:text name="label.img.text.long" />"><s:text name="label.img.text.short" /></abbr>:&#32;<s:include value="/WEB-INF/apsadmin/jsp/entity/view/textAttribute.jsp" />
	</s:if>
	<s:else>
	<s:text name="label.none" />
	</s:else>