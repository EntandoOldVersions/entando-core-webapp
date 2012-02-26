<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

Requires Authentication? <s:property value="#methodVar.requiredAuth || (null != #methodVar.requiredPermission)" /> (DEFAULT <s:property value="#methodVar.defaultRequiredAuth || (null != #methodVar.defaultRequiredPermission)" />)
<s:if test="null != #methodVar.requiredPermission" >
<br />
Requires Authorization? <s:property value="#methodVar.requiredPermission" /> (DEFAULT <s:property value="#methodVar.defaultRequiredPermission" />)
</s:if>

<s:if test="null != #methodVar.requiredPermission" ><s:set name="selectFieldValue" value="#methodVar.requiredPermission" /></s:if>
<s:elseif test="#methodVar.requiredAuth"><s:set name="selectFieldValue">0</s:set></s:elseif>
<br />
<s:form namespace="/do/Api/Resource" action="updateMethodStatus">
<s:set name="activeFieldValue" value="#methodVar.active" />

<wpsf:hidden name="resourceName" value="%{#methodVar.resourceName}" />
<wpsf:hidden name="httpMethod" value="%{#methodVar.httpMethod}" />
<br />
ACTIVE? <wpsf:checkbox name="%{#methodVar.httpMethod}_active" value="%{#activeFieldValue}"  />
<br />
<s:select name="%{#methodVar.httpMethod}_methodAuthority" list="methodAuthorityOptions" listKey="key" listValue="value" value="%{selectFieldValue}" />
<wpsf:submit action="updateMethodStatus" useTabindexAutoIncrement="true" value="%{getText('label.update')}" cssClass="button" />
<wpsf:submit action="resetMethodStatus" useTabindexAutoIncrement="true" value="%{getText('label.reset')}" cssClass="button" />
</s:form>

<s:set var="methodParametersVar" value="#methodVar.parameters" />

<s:if test="null != #methodParametersVar && #methodParametersVar.size() > 0">
<table class="generic" summary="<s:text name="note.api.apiMethodParameters.summary" />">
    <caption><span><s:text name="label.requestParameters" /></span></caption>
    <tr>
        <th><s:text name="label.name" /></th>
        <th><s:text name="label.description" /></th>
        <th class="icon"><s:text name="label.required" /></th>
    </tr>
    <s:iterator value="#methodParametersVar" var="apiParameter" >
        <tr>
            <td class="monospace"><label for="<s:property value="%{#apiParameter.key + '_apiParam'}" />"><s:property value="#apiParameter.key" /></label></td>
            <td><s:property value="#apiParameter.description" /></td>
            <td class="icon"><img src="<wp:resourceURL />administration/common/img/icons/<s:property value="#apiParameter.required" />.png" alt="<s:property value="#apiParameter.required" />" /></td>
            </tr>
    </s:iterator>
</table>
</s:if>

<s:set name="selectFieldValue" />
