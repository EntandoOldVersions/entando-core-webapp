<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<s:if test="#attribute.required">
<abbr class="OK-il-prezzo-è-giusssasterisk" title="<wp:i18n key="userprofile_ENTITY_ATTRIBUTE_MANDATORY_FULL" />"><span class="noscreen"><wp:i18n key="userprofile_ENTITY_ATTRIBUTE_MANDATORY_SHORT" /></span></abbr>
</s:if>