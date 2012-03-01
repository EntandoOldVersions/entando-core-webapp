<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<s:set var="apiResourceVar" value="apiResource" />
<s:set var="GETMethodVar" value="#apiResourceVar.getMethod" />
<s:set var="POSTMethodVar" value="#apiResourceVar.postMethod" />
<s:set var="PUTMethodVar" value="#apiResourceVar.putMethod" />
<s:set var="DELETEMethodVar" value="#apiResourceVar.deleteMethod" />
<h1>
	<s:text name="title.apiResourceManagement" />
	<%-- anchor print --%>
	<a href="<s:url action="list" />" title="<s:text name="label.list" />">
		<img src="<wp:resourceURL/>administration/common/img/icons/32x32/general-list.png" alt="<s:text name="label.list" />" />
	</a>
</h1>
<div id="main">

	<h2><s:text name="title.apiResourceEdit" /></h2>

	<s:if test="hasActionMessages()">
		<div class="message message_confirm">
		<h3><s:text name="messages.confirm" /><h3>
		<ul>
			<s:iterator value="actionMessages">
				<li><s:property escape="false" /></li>
			</s:iterator>
		</ul>
		</div>
	</s:if>

	<p>
		<s:text name="note.workingOn" />: <em><s:property value="#apiResourceVar.resourceName" />&#32;(<s:property value="#apiResourceVar.source" /><s:if test="%{#apiResourceVar.pluginCode != null && #apiResourceVar.pluginCode.length() > 0}">&#32;/&#32;<s:property value="#apiResourceVar.pluginCode" /></s:if>)</em>
	</p>

	<ul class="menu horizontal tab-toggle-bar">
		<li>
			<a href="#general" id="info_tab_quickmenu" class="tab-toggle">
				<s:text name="label.general" />
			</a>
		</li>
		<li>
			<a href="#get_tab" id="get_tab_quickmenu" class="tab-toggle">
				GET
			</a>
		</li>
		<li>
			<a href="#post_tab" id="post_tab_quickmenu" class="tab-toggle">
				POST
			</a>
		</li>
		<li>
			<a href="#put_tab" id="put_tab_quickmenu" class="tab-toggle">
				PUT
			</a>
		</li>
		<li>
			<a href="#delete_tab" id="delete_tab_quickmenu" class="tab-toggle">
				DELETE
			</a>
		</li>
	</ul>

	<div class="tab-container">
		<div id="general" class="tab">
			<dl class="table-display">
				<dt>
					<s:text name="label.api.resource.name" />
				</dt>
					<dd><s:property value="#apiResourceVar.resourceName" /></dd>
				<dt>
					<s:text name="label.api.resource.description" />
				</dt>
					<dd><s:property value="#apiResourceVar.description" /></dd>
				<dt>
					<s:text name="label.api.resource.source" />
				</dt>
					<dd><s:property value="#apiResourceVar.source" /></dd>
				<dt>
					<s:text name="label.api.resource.plugin" />
				</dt>
					<dd><s:property value="#apiResourceVar.pluginCode" /><s:if test="#apiResourceVar.pluginCode == null||#apiResourceVar.pluginCode.length == 0"><abbr title="none">&ndash;</abbr></s:if></dd>
				<dt>
					<s:text name="label.api.resource.uri" />
				</dt>
					<dd><wp:info key="systemParam" paramName="applicationBaseURL" />api/rs/<wp:info key="defaultLang" />/<s:property value="#apiResourceVar.resourceName" /></dd>
				<dt>
					<s:text name="label.api.resource.extensions" />
				</dt>
					<dd>
						<s:text name="note.extensions.xml" />
						<br />
						<s:text name="note.extensions.json" />
					</dd>
			</dl>
			<div class="subsection margin-more-top">
				<s:form namespace="/do/Api/Resource" action="updateAllMethodStatus">
					<fieldset>
						<legend><s:text name="label.api.options.for.all" /></legend>
						<p>
							<wpsf:hidden name="resourceName" value="%{#apiResourceVar.resourceName}" />
							<wpsf:checkbox name="active" value="true" id="all_active" cssClass="radiocheck" />
							<label for="all_active">
								<s:text name="label.active" />
							</label>
						</p>
						<p>
							<label for="all_auth" class="basic-mint-label"><s:text name="label.api.authorization" />:</label>
							<s:select name="methodAuthority" list="methodAuthorityOptions" listKey="key" listValue="value" id="all_auth"  />
						</p>
						<p class="centerText">
							<wpsf:submit action="updateAllMethodStatus" useTabindexAutoIncrement="true" value="%{getText('label.update')}" cssClass="button" />
							&#32;
							<wpsf:submit action="resetAllMethodStatus" useTabindexAutoIncrement="true" value="%{getText('label.reset.default')}" cssClass="button" />
						</p>
					</fieldset>
				</s:form>
			</div>

		</div>

<%-- GET --%>
		<div id="GET_tab" class="tab">
			<s:set name="methodVar" value="#GETMethodVar" />
			<s:include value="/WEB-INF/apsadmin/jsp/api/include/resource-method-detail.jsp" />
		</div>
<%-- POST --%>
		<div id="POST_tab" class="tab">
			<s:set name="methodVar" value="#POSTMethodVar" />
			<s:include value="/WEB-INF/apsadmin/jsp/api/include/resource-method-detail.jsp" />
		</div>
<%-- PUT --%>
		<div id="PUT_tab" class="tab">
			<s:set name="methodVar" value="#PUTMethodVar" />
			<s:include value="/WEB-INF/apsadmin/jsp/api/include/resource-method-detail.jsp" />
		</div>
<%-- DELETE --%>
		<div id="DELETE_tab" class="tab">
			<s:set name="methodVar" value="#DELETEMethodVar" />
			<s:include value="/WEB-INF/apsadmin/jsp/api/include/resource-method-detail.jsp" />
		</div>
	</div>
</div>

