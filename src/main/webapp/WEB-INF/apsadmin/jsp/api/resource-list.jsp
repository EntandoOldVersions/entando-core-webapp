<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<h1><s:text name="title.apiResourceManagement" /></h1>
<div id="main">
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
    <s:if test="hasActionErrors()">
        <div class="message message_error">
            <h2><s:text name="message.title.ActionErrors" /></h2>
            <ul>
                <s:iterator value="actionErrors">
                    <li><s:property escape="false" /></li>
                </s:iterator>
            </ul>
        </div>
    </s:if>
    
    <s:set var="resourceFlavoursVar" value="resourceFlavours" />
    <s:if test="#resourceFlavoursVar.size() > 0">
        <table class="generic" summary="<s:text name="note.api.apiResourceList.summary" />">
            <caption><span><s:text name="title.api.apiResourceList" /></span></caption>
            <tr>
                <th><s:text name="name.api.resource" /></th>
                <th><s:text name="label.description" /></th>
                <th><s:text name="label.flavour" /></th>
                <th class="icon">GET</th>
                <th class="icon">POST</th>
                <th class="icon">PUT</th>
                <th class="icon">DELETE</th>
                
                <!--
                <th><s:text name="label.active" /></th>
                <th class="icon"><abbr title="<s:text name="label.actions" />">&ndash;</abbr></th>
                -->
            </tr>
            <s:iterator var="resourceFlavourVar" value="#resourceFlavoursVar">
                <s:iterator var="resourceVar" value="#resourceFlavourVar" >
                    <tr>
                        <td class="monospace">
                            <a href="<s:url action="detail" namespace="/do/Api/Resource"><s:param name="resourceName" value="#resourceVar.resourceName" /></s:url>" >
                            <s:property value="#resourceVar.resourceName" />
                            </a>
                        </td>
                        <td>
                            <s:property value="#resourceVar.description" />
                        </td>
                        <td class="monospace">
                            <s:property value="#resourceVar.source" />/<s:property value="#resourceVar.sectionCode" />
                        </td>
                        
                        <td class="icon">
                            <s:if test="#resourceVar.getMethod != null" >
                                <s:if test="!#resourceVar.getMethod.active" >OFF</s:if>
                                <s:elseif test="#resourceVar.getMethod.requiredPermission != null" >LOCK</s:elseif>
                                <s:elseif test="#resourceVar.getMethod.requiredAuth" >AUTH</s:elseif>
                                <s:else>FREE</s:else>
                                <s:if test="#resourceVar.getMethod.canSpawnOthers"><a href="<s:url action="newService" namespace="/do/Api/Service"><s:param name="apiMethodName" value="#resourceVar.resourceName" /></s:url>" title="<s:text name="note.api.apiMethodList.createServiceFromMethod" />: <s:property value="#resourceVar.resourceName" />"><img src="<wp:resourceURL />administration/common/img/icons/22x22/api-service-new.png" alt="<s:text name="label.new" />" /></a></s:if>
                            </s:if><s:else>-</s:else>
                        </td>
                        <td class="icon">
                            <s:if test="#resourceVar.postMethod != null" >
                                <s:if test="!#resourceVar.postMethod.active" >OFF</s:if>
                                <s:elseif test="#resourceVar.postMethod.requiredPermission != null" >LOCK</s:elseif>
                                <s:elseif test="#resourceVar.postMethod.requiredAuth" >AUTH</s:elseif>
                                <s:else>FREE</s:else>
                            </s:if><s:else>-</s:else>
                        </td>
                        <td class="icon">
                            <s:if test="#resourceVar.putMethod != null" >
                                <s:if test="!#resourceVar.putMethod.active" >OFF</s:if>
                                <s:elseif test="#resourceVar.putMethod.requiredPermission != null" >LOCK</s:elseif>
                                <s:elseif test="#resourceVar.putMethod.requiredAuth" >AUTH</s:elseif>
                                <s:else>FREE</s:else>
                            </s:if><s:else>-</s:else>
                        </td>
                        <td class="icon">
                            <s:if test="#resourceVar.deleteMethod != null" >
                                <s:if test="!#resourceVar.deleteMethod.active" >OFF</s:if>
                                <s:elseif test="#resourceVar.deleteMethod.requiredPermission != null" >LOCK</s:elseif>
                                <s:elseif test="#resourceVar.deleteMethod.requiredAuth" >AUTH</s:elseif>
                                <s:else>FREE</s:else>
                            </s:if><s:else>-</s:else>
                        </td>
                        
                        <!--
                        <td class="monospace">
                            <wpsf:checkbox useTabindexAutoIncrement="true" id="%{#methodItemVar.key + '_active'}" name="%{#methodItemVar.key + '_active'}" value="%{#methodVar.active}" />
                            <label for="<s:property value="%{#methodItemVar.key + '_active'}" />"><s:if test="#methodVar.active"><s:text name="label.yes" /></s:if><s:else><s:text name="label.no" /></s:else></label>
                        </td>
                        <td class="icon">
                            <s:if test="#methodVar.canSpawnOthers"><a href="<s:url action="newService" namespace="/do/Api/Service"><s:param name="apiMethodName" value="#methodItemVar.key" /></s:url>" title="<s:text name="note.api.apiMethodList.createServiceFromMethod" />: <s:property value="#methodItemVar.key" />"><img src="<wp:resourceURL />administration/common/img/icons/22x22/api-service-new.png" alt="<s:text name="label.new" />" /></a></s:if>
                            <s:else>&nbsp;</s:else>
                            </td>
                        </tr>
                        -->
                        
                    <tr>
                    
                </s:iterator>
            </s:iterator>
        </table>
    </s:if>
    <s:else>
        <p><s:text name="note.api.noResources" /></p>
    </s:else>
</div>