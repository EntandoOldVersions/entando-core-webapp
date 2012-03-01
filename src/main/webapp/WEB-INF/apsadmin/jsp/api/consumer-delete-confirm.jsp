<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<h1><s:text name="title.apiProviderManagement" /></h1>

<div id="main">
    <h2><s:text name="title.api.provider.trash" /></h2>
    <s:form action="delete">
        <p class="noscreen"><wpsf:hidden name="serviceKey" /></p>
        
        <p>
            <s:text name="note.api.provider.trash" />&#32;<em class="important"><s:property value="providerKey" /></em>?
            <wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.remove')}" cssClass="button" />
        </p>
        
        <p><s:text name="note.api.provider.trash.goBack" />&#32;<a href="<s:url action="list" namespace="/do/Api/Provider" />" ><s:text name="menu.apisAdmin.providers" /></a></p>
        
    </s:form>
</div>