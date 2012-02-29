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
		<h3><s:text name="messages.confirm" /><<h3>
		<ul>
			<s:iterator value="actionMessages">
				<li><s:property escape="false" /></li>
			</s:iterator>
		</ul>
		</div>
	</s:if>

	<p>
		<s:text name="note.workingOn" />: <em><s:property value="#apiResourceVar.resourceName" />&#32;(<s:property value="#apiResourceVar.source" />&#32;/&#32;<s:property value="#apiResourceVar.pluginCode" />)</em>

	</em>


	<ul class="menu horizontal tab-toggle-bar">
		<li>
			<a href="#info" id="info_tab_quickmenu" class="tab-toggle">
				<abbr title="<s:text name="title.contentInfo" />"><s:text name="label.general" /></abbr>
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
		<div id="info" class="tab">
			<dl class="table-display">
				<dt>
					Name
				</dt>
					<dd><s:property value="#apiResourceVar.resourceName" /></dd>
				<dt>
					Description
				</dt>
					<dd><s:property value="#apiResourceVar.description" /></dd>
				<dt>
					Source
				</dt>
					<dd><s:property value="#apiResourceVar.source" /></dd>
				<dt>
					Plugin
				</dt>
					<dd><s:property value="#apiResourceVar.pluginCode" /><s:if test="#apiResourceVar.pluginCode == null||#apiResourceVar.pluginCode.length == 0"><abbr title="none">&ndash;</abbr></s:if></dd>
				<dt>
					Resoure URI
				</dt>
					<dd><wp:info key="systemParam" paramName="applicationBaseURL" />api/rs/<wp:info key="defaultLang" />/<s:property value="#apiResourceVar.resourceName" /></dd>
				<dt>
					Extension
				</dt>
					<dd>
						".xml" for xml response format (default)
						<br />
						".json" for json response format
					</dd>
			</dl>
			<div class="subsection margin-more-top">
				<s:form namespace="/do/Api/Resource" action="updateAllMethodStatus">
					<fieldset>
						<legend>All Methods Options</legend>
						<p>
							<wpsf:hidden name="resourceName" value="%{#apiResourceVar.resourceName}" />
							<wpsf:checkbox name="active" value="true" id="all_active" cssClass="radiocheck" />
							<label for="all_active" class="">
								Active
							</label>
						</p>
						<p>
							<label for="all_auth" class="basic-mint-label">Authorization:</label>
							<s:select name="methodAuthority" list="methodAuthorityOptions" listKey="key" listValue="value" id="all_auth" />
						</p>
						<p class="centerText">
							<wpsf:submit action="updateAllMethodStatus" useTabindexAutoIncrement="true" value="%{getText('Update')}" cssClass="button" />
							&#32;
							<wpsf:submit action="resetAllMethodStatus" useTabindexAutoIncrement="true" value="%{getText('Reset to Default')}" cssClass="button" />
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

