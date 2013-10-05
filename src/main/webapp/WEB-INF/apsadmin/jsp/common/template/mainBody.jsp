<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<wpsa:activityStream var="activityStreamVar" />

<s:if test="null != #activityStreamVar && #activityStreamVar.size() != 0">
	<s:iterator value="#activityStreamVar" var="actionLogRecordIdVar">
		<wpsa:actionLogRecord key="%{#actionLogRecordIdVar}" var="actionLogRecordVar" />
		<c:set var="usernameVar"><s:property value="#actionLogRecordVar.username" /></c:set>
		<s:set var="fullnameVar"><wp:userProfileAttribute username="${usernameVar}" attributeRoleName="userprofile:fullname" /></s:set>
		<s:set var="emailAttributeVar"><wp:userProfileAttribute username="${usernameVar}" attributeRoleName="userprofile:email" /></s:set>
		<s:if test="null != #fullnameVar && #fullnameVar.length() > 0"><s:property value="#fullnameVar" /></s:if>
		<s:else><s:property value="#actionLogRecordVar.username" /></s:else>
		
		<%--
		&nbsp;&dash;&nbsp;x<s:property value="#emailAttributeVar" />x&nbsp;
		--%>
		
		&nbsp;&dash;&nbsp;
		
		<s:set var="activityStreamInfoVar" value="#actionLogRecordVar.activityStreamInfo" />
		
		<wpsa:activityTitle actionName="%{#actionLogRecordVar.actionName}" namespace="%{#actionLogRecordVar.namespace}" actionType="%{#activityStreamInfoVar.actionType}" />
		
		<%--
		<s:text name="%{#actionLogRecordVar.namespace + '_' + #actionLogRecordVar.actionName + '_' + #activityStreamInfoVar.actionType}" />
		--%>
		<c:set var="authGroupNameVar"><s:property value="#activityStreamInfoVar.linkAuthGroup" /></c:set>
		<c:set var="authPermissionNameVar"><s:property value="#activityStreamInfoVar.linkAuthPermission" /></c:set>
		<wp:ifauthorized groupName="${authGroupNameVar}" permission="${authPermissionNameVar}" var="isAuthorizedVar" />
		
		&nbsp;:&nbsp;
		
		<s:set var="linkTitleVar" value="%{getTitle('view/edit', #activityStreamInfoVar.objectTitles)}" />
		<c:choose>
			<c:when test="${isAuthorizedVar}">
				<s:url action="%{#activityStreamInfoVar.linkActionName}" 
					   namespace="%{#activityStreamInfoVar.linkNamespace}" var="actionUrlVar">
					<wpsa:paramMap map="#activityStreamInfoVar.linkParameters" />
				</s:url>
				<a href="<s:property value="#actionUrlVar" />"><s:property value="#linkTitleVar" /></a>
			</c:when>
			<c:otherwise>
				<s:property value="#linkTitleVar" />
			</c:otherwise>
		</c:choose>
		<br />
		<s:date name="#actionLogRecordVar.actionDate" format="EEEE dd-MMMM-yyyy HH:mm" />
		<br />
		---------------------------------------
		<br />
	</s:iterator> 
</s:if>
<s:else>
	NO ONE ACTIVITY
</s:else>
