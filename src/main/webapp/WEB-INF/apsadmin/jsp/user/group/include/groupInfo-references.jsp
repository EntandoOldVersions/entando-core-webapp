<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<s:form>
<p class="sr-only">
	<wpsf:hidden name="name" />
</p>
<div class="subsection-light">
<h3><s:text name="title.group.referencedPages" /></h3>

<s:if test="null != references['PageManagerUtilizers']">
<wpsa:subset source="references['PageManagerUtilizers']" count="10" objectName="pageReferences" advanced="true" offset="5" pagerId="pageManagerReferences">
<s:set name="group" value="#pageReferences" />

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

<table class="generic" id="pageListTable" summary="<s:text name="note.group.referencedPages.summary" />">
<caption><span><s:text name="title.pageList" /></span></caption>
	<tr>
		<th><s:text name="label.page" /></th>
	</tr>
	<s:iterator var="currentPageVar" >
		<s:set var="canEditCurrentPage" value="%{false}" />
		<c:set var="currentPageGroup"><s:property value="#currentPageVar.group" escape="false"/></c:set>
		<wp:ifauthorized groupName="${currentPageGroup}" permission="managePages"><s:set var="canEditCurrentPage" value="%{true}" /></wp:ifauthorized>
		<tr>
			<td>
				<s:property value="%{#currentPageVar.getFullTitle(currentLang.code)}" />
				<s:if test="#canEditCurrentPage">
					<a href="<s:url namespace="/do/Page" action="viewTree"><s:param name="selectedNode" value="#currentPageVar.code" /></s:url>"><img src="<wp:resourceURL />administration/common/img/icons/node-leaf.png" alt="<s:text name="note.goToSomewhere" />: <s:property value="%{#currentPageVar.getFullTitle(currentLang.code)}" />" title="<s:text name="note.goToSomewhere" />: <s:property value="%{#currentPageVar.getFullTitle(currentLang.code)}" />" /></a>
					<a href="<s:url namespace="/do/Page" action="configure"><s:param name="pageCode" value="#currentPageVar.code" /></s:url>"><img src="<wp:resourceURL />administration/common/img/icons/page-configure.png" alt="<s:text name="title.configPage" />: <s:property value="%{#currentPageVar.getFullTitle(currentLang.code)}" />" title="<s:text name="title.configPage" />: <s:property value="%{#currentPageVar.getFullTitle(currentLang.code)}" />" /></a>
				</s:if>
				<s:else></s:else>
			</td>
		</tr>
	</s:iterator>
</table>

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

</wpsa:subset>
</s:if>
<s:else>
<p><s:text name="note.group.referencedPages.empty" /></p>
</s:else>
</div>

<div class="subsection-light">
<h3><s:text name="title.group.referencedUsers" /></h3>
<s:if test="null != references['UserManagerUtilizers']">
<wpsa:subset source="references['UserManagerUtilizers']" count="10" objectName="userReferences" advanced="true" offset="5" pagerId="userManagerReferences">
<s:set name="group" value="#userReferences" />

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

<wp:ifauthorized permission="superuser" var="canEditUser" />
<table class="generic" id="userListTable" summary="<s:text name="note.group.referencedUsers.summary" />">
<caption><span><s:text name="title.userList" /></span></caption>
	<tr>
		<th><s:text name="label.username" /></th>
		<th><s:text name="label.date.registration" /></th>
		<th><s:text name="label.date.lastLogin" /></th>
		<th><s:text name="label.date.lastPasswordChange" /></th>
		<th class="icon"><abbr title="<s:text name="label.state" />">S</abbr></th>	
		<c:if test="${canEditUser == 'true'}">
		<th class="icon"><abbr title="<s:text name="label.authorizations" />">A</abbr></th>	
		</c:if>
	</tr>
	<s:iterator var="currentUserVar" >
		<s:if test="!#currentUserVar.japsUser">
			<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-notjAPSUser.png</s:set>
			<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.notEntandoUser" /></s:set>
		</s:if>
		<s:elseif test="#currentUserVar.disabled">
			<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-notActive.png</s:set>
			<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.notActive" /></s:set>	
		</s:elseif>
		<s:elseif test="!#currentUserVar.accountNotExpired">
			<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-expiredAccount.png</s:set>
			<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.expiredAccount" /></s:set>	
		</s:elseif>
		<s:elseif test="!#currentUserVar.credentialsNotExpired">
			<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-expiredPassword.png</s:set>
			<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.expiredPassword" /></s:set>	
		</s:elseif>
		<s:elseif test="!#currentUserVar.disabled">
			<s:set name="statusIconImagePath" id="statusIconImagePath"><wp:resourceURL/>administration/common/img/icons/user-status-active.png</s:set>
			<s:set name="statusIconText" id="statusIconText"><s:text name="note.userStatus.active" /></s:set>
		</s:elseif>
		<tr>
			<td>
				<c:if test="${canEditUser == 'true'}">
					<a href="<s:url namespace="/do/User/" action="edit"><s:param name="username" value="#currentUserVar.username"/></s:url>" title="<s:text name="label.edit" />: <s:property value="#currentUserVar.username" />" ><s:property value="#currentUserVar" /></a>
				</c:if>
				<c:if test="${canEditUser == 'false'}"><s:property value="#currentUserVar" /></c:if>
			</td>
			<td class="centerText monospace">
				<s:if test="#currentUserVar.japsUser">
					<s:date name="#currentUserVar.creationDate" format="dd/MM/yyyy" />
				</s:if>
				<s:else><abbr title="<s:text name="label.none" />">&ndash;</abbr></s:else>
			</td>
			<td class="centerText monospace">
				<s:if test="#currentUserVar.japsUser && #currentUserVar.lastAccess != null">
					<s:date name="#currentUserVar.lastAccess" format="dd/MM/yyyy" />
				</s:if>
				<s:else><abbr title="<s:text name="label.none" />">&ndash;</abbr></s:else>
			</td>
			<td class="centerText monospace">
				<s:if test="#currentUserVar.japsUser && #currentUserVar.lastPasswordChange != null">
					<s:date name="#currentUserVar.lastPasswordChange" format="dd/MM/yyyy" />
				</s:if>
				<s:else><abbr title="<s:text name="label.none" />">&ndash;</abbr></s:else>
			</td>
			<td class="icon"><img src="<s:property value="#statusIconImagePath" />" alt="<s:property value="#statusIconText" />" title="<s:property value="#statusIconText" />" /></td>
			<c:if test="${canEditUser == 'true'}">
			<td class="icon">
				<a href="<s:url namespace="/do/User/Auth" action="edit"><s:param name="username" value="#currentUserVar.username"/></s:url>" title="<s:text name="note.configureAuthorizationsFor" />: <s:property value="#currentUserVar.username" />"><img src="<wp:resourceURL />administration/common/img/icons/authorizations.png" alt="<s:text name="note.configureAuthorizationsFor" />: <s:property value="#currentUserVar.username" />" /></a>
			</td>
			</c:if>
		</tr>
	</s:iterator>
</table>

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

</wpsa:subset>
</s:if>
<s:else>
<p><s:text name="note.group.referencedUsers.empty" /></p>
</s:else>
</div>

<div class="subsection-light">
<h3><s:text name="title.group.referencedWidgetTypes" /></h3>

<s:if test="null != references['ShowletTypeManagerUtilizers']">
<wpsa:subset source="references['ShowletTypeManagerUtilizers']" count="10" objectName="showletTypeReferences" advanced="true" offset="5" pagerId="showletTypeReferences">
<s:set name="group" value="#showletTypeReferences" />

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

<table class="generic" id="showletTypeListTable" summary="<s:text name="note.group.referencedWidgetTypes.summary" />">
<caption><span><s:text name="title.showletTypeList" /></span></caption>
	<tr>
		<th><s:text name="label.code" /></th>
		<th><s:text name="label.title" /></th>
	</tr>
	<s:iterator var="currentShowletTypeVar" >
	<tr>
		<td>
			<s:property value="#currentShowletTypeVar.code" />
		</td>
		<td>
			<s:property value="getTitle(#currentShowletTypeVar.code, #currentShowletTypeVar.titles)" />
		</td>
	</tr>
	</s:iterator>
</table>

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

</wpsa:subset>
</s:if>
<s:else>
<p><s:text name="note.group.referencedWidgetTypes.empty" /></p>
</s:else>
</div>

<wpsa:hookPoint key="core.groupReferences" objectName="hookPointElements_core_groupReferences">
<s:iterator value="#hookPointElements_core_groupReferences" var="hookPointElement">
	<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
</s:iterator>
</wpsa:hookPoint>
</s:form>
