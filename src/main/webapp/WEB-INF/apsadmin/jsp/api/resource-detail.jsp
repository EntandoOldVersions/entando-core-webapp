<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<h1><s:text name="title.apiResourceManagement" /></h1>

<s:if test="hasActionMessages()">
<div class="message message_confirm">
<h2><s:text name="messages.confirm" /></h2>	
<ul>
	<s:iterator value="actionMessages">
		<li><s:property escape="false" /></li>
	</s:iterator>
</ul>
</div>
</s:if>

<s:set var="apiResourceVar" value="apiResource" />

NAME <s:property value="#apiResourceVar.resourceName" />
<br />
DESCRIPTION <s:property value="#apiResourceVar.description" />
<br />
SOURCE <s:property value="#apiResourceVar.source" />
<br />
PLUGIN <s:property value="#apiResourceVar.pluginCode" />
<br />
RESOURE URI
<br />
<wp:info key="systemParam" paramName="applicationBaseURL" />api/rs/<wp:info key="defaultLang" />/<s:property value="#apiResourceVar.resourceName" />
<br />
EXTENSION:
<br />
".xml" FOR XML RESPONSE FORMAT (DEFAULT)
<br />
".json" FOR JSON RESPONSE FORMAT
<br />
-----------------------------------
<s:set var="GETMethodVar" value="#apiResourceVar.getMethod" />
<s:set name="methodVar" value="#GETMethodVar" />
<br />
HTTP GET METHOD
<s:if test="null == #GETMethodVar" >
<br />
NOT AVAILABLE
</s:if>
<s:else> 
<br />
AVAILABLE
<br />
<s:include value="/WEB-INF/apsadmin/jsp/api/include/resource-method-detail.jsp" />

<br />
<a href="<s:url action="responseSchema" namespace="/do/Api/Resource">
       <s:param name="resourceName" value="#GETMethodVar.resourceName" />
       <s:param name="httpMethod" value="#GETMethodVar.httpMethod" />
   </s:url>" >RESPONSE BODY SCHEMA</a>

</s:else>

<br />
-----------------------------------
<s:set var="POSTMethodVar" value="#apiResourceVar.postMethod" />
<s:set name="methodVar" value="#POSTMethodVar" />
<br />
HTTP POST METHOD
<s:if test="null == #POSTMethodVar" >
<br />
NOT AVAILABLE
</s:if>
<s:else> 
<br /> 
AVAILABLE
<br />
<s:include value="/WEB-INF/apsadmin/jsp/api/include/resource-method-detail.jsp" />

<br />
<a href="<s:url action="requestSchema" namespace="/do/Api/Resource">
       <s:param name="resourceName" value="#POSTMethodVar.resourceName" />
       <s:param name="httpMethod" value="#POSTMethodVar.httpMethod" />
   </s:url>" >REQUEST BODY SCHEMA</a>

<br />
<a href="<s:url action="responseSchema" namespace="/do/Api/Resource">
       <s:param name="resourceName" value="#POSTMethodVar.resourceName" />
       <s:param name="httpMethod" value="#POSTMethodVar.httpMethod" />
   </s:url>" >RESPONSE BODY SCHEMA</a>

</s:else>

<br />
-----------------------------------
<s:set var="PUTMethodVar" value="#apiResourceVar.putMethod" />
<s:set name="methodVar" value="#PUTMethodVar" />
<br />
HTTP PUT METHOD
<s:if test="null == #PUTMethodVar" >
<br />
NOT AVAILABLE
</s:if>
<s:else> 
<br /> 
AVAILABLE
<br />
<s:include value="/WEB-INF/apsadmin/jsp/api/include/resource-method-detail.jsp" />

<br />
<a href="<s:url action="requestSchema" namespace="/do/Api/Resource">
       <s:param name="resourceName" value="#PUTMethodVar.resourceName" />
       <s:param name="httpMethod" value="#PUTMethodVar.httpMethod" />
   </s:url>" >REQUEST BODY SCHEMA</a>

<br />
<a href="<s:url action="responseSchema" namespace="/do/Api/Resource">
       <s:param name="resourceName" value="#PUTMethodVar.resourceName" />
       <s:param name="httpMethod" value="#PUTMethodVar.httpMethod" />
   </s:url>" >RESPONSE BODY SCHEMA</a>

</s:else>

<br />
-----------------------------------
<s:set var="DELETEMethodVar" value="#apiResourceVar.deleteMethod" />
<s:set name="methodVar" value="#DELETEMethodVar" />
<br />
HTTP DELETE METHOD
<s:if test="null == #DELETEMethodVar" >
<br />
NOT AVAILABLE
</s:if>
<s:else> 
<br /> 
AVAILABLE
<br />
<s:include value="/WEB-INF/apsadmin/jsp/api/include/resource-method-detail.jsp" />

<br />
<a href="<s:url action="responseSchema" namespace="/do/Api/Resource">
       <s:param name="resourceName" value="#DELETEMethodVar.resourceName" />
       <s:param name="httpMethod" value="#DELETEMethodVar.httpMethod" />
   </s:url>" >RESPONSE BODY SCHEMA</a>

</s:else>

<br />
<br />
-----------------------------------
<br />
UPDATE ALL METHOD STATUS
<br />

<s:form namespace="/do/Api/Resource" action="updateAllMethodStatus">
<wpsf:hidden name="resourceName" value="%{#apiResourceVar.resourceName}" />
ACTIVE? <wpsf:checkbox name="active" value="true" />
<br />
<s:select name="methodAuthority" list="methodAuthorityOptions" listKey="key" listValue="value" />
<wpsf:submit action="updateAllMethodStatus" useTabindexAutoIncrement="true" value="%{getText('label.update')}" cssClass="button" />
<wpsf:submit action="resetAllMethodStatus" useTabindexAutoIncrement="true" value="%{getText('label.reset')}" cssClass="button" />
</s:form>