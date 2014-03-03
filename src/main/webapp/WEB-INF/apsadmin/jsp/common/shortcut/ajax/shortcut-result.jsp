<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<wpsa:shortcut key="%{shortcutCode}" var="current"/>

{
    "action": "<s:property value="strutsAction"/>",
    "errors": [
		<s:if test="hasFieldErrors()">
			<s:iterator value="fieldErrors" status="fieldStatus">
				<s:iterator value="value" status="valueStatus">
					"<s:property escape="false" escapeJavaScript="true" />"<s:if test="%{!(#valueStatus.last)}">,</s:if>
				</s:iterator><s:if test="%{!(#fieldStatus.last)}">,</s:if>
			</s:iterator>
		</s:if>
		<s:if test="hasActionErrors()">
			<s:if test="hasFieldErrors()">,</s:if>
			<s:iterator value="actionErrors" status="valueStatus">
				"<s:property escape="false" escapeJavaScript="true" />"<s:if test="%{!(#valueStatus.last)}">,</s:if>
			</s:iterator>
		</s:if>
    
    ],
    "position": <s:property value="position"/><s:if test="null !=  #current">,
    "shortcut": {
        "actionName": "<s:property value="#current.actionName"/>",
        "description": "<s:property value="#current.description"/>",
        "descriptionKey": "<s:text name="#current.descriptionKey" />",
        "id": "<s:property value="#current.id"/>",
        "longDescription": "<s:property value="#current.longDescription"/>",
        "longDescriptionKey": "<s:text name="#current.longDescriptionKey" />",
        "menuSection": {
            "description": "<s:property value="#current.menuSection.description"/>",
            "descriptionKey": "<s:text name="#current.menuSection.descriptionKey" />",
            "id": "<s:property value="#current.menuSection.id"/>",
            "longDescription": "<s:property value="#current.menuSection.longDescription"/>",
            "longDescriptionKey": "<s:text name="#current.menuSection.longDescriptionKey" />"
        },
        "menuSectionCode": "<s:property value="#current.menuSectionCode"/>",
        "namespace": "<s:property value="#current.namespace"/>",
        "parameters": <s:property value="#current.parameters"/>,
        "requiredPermission": "<s:property value="#current.requiredPermission"/>",
        "source": "<s:property value="#current.source"/>"
    }
</s:if>
 
}