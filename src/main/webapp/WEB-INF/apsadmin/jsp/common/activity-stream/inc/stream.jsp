<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%-- reading the list from mainBody.jsp with: <wpsa:activityStream var="activityStreamListVar" /> --%>
<s:set var="ajax" value="%{#parameters.ajax}" /><%-- fill this with something... --%>
<c:set var="ajax" value="${param.ajax eq 'true'}" />
<s:set var="ajax" value="#attr.ajax" />
<s:if test="#ajax">
	<%-- ajax eh? so set the #activityStreamListVar variable accordingly --%>
	<s:set var="activityStreamListVar" value="%{getActionRecordIds()}" />
</s:if>
<s:else>
	<%-- use the #activityStreamListVar from mainBody.jsp --%>
</s:else>
<c:set var="browserUsername" value="${session.currentUser.username}" />
<s:set var="currentUsernameVar" value="#attr.browserUsername" />
<wp:userProfileAttribute username="${browserUsername}" attributeRoleName="userprofile:fullname" var="browserUserFullnameVar" />
<wp:userProfileAttribute username="${browserUsername}" attributeRoleName="userprofile:email" var="browserUserEmailAttributeVar" />
<wp:ifauthorized permission="superuser" var="browserIsSuperUser" />
<s:iterator value="#activityStreamListVar" var="actionLogRecordIdVar" status="currentEvent">
	<wpsa:actionLogRecord key="%{#actionLogRecordIdVar}" var="actionLogRecordVar" />
	<s:set var="usernameVar" value="#actionLogRecordVar.username" scope="page" />
	<wp:userProfileAttribute username="${usernameVar}" attributeRoleName="userprofile:fullname" var="fullnameVar" />
	<wp:userProfileAttribute username="${usernameVar}" attributeRoleName="userprofile:email" var="emailAttributeVar" />
	<s:set var="fullnameVar" value="#attr.fullnameVar" />
	<s:set var="emailAttributeVar" value="#attr.emailAttributeVar" />
	<li
		class="media row padding-large-bottom" 
		data-entando-timestamp="<s:date name="#actionLogRecordVar.actionDate" format="yyyy-MM-dd HH:mm:ss|SSS" />"
		data-entando-timestamp-comment="<s:date name="#actionLogRecordVar.actionDate" format="yyyy-MM-dd HH:mm:ss|SSS" />"
	>
		<div class="col-xs-12 col-sm-2 col-lg-1 margin-small-bottom activity-stream-picture">
			<img alt=" " src="<s:url action="avatarStream" namespace="/do/user/avatar">
							<s:param name="gravatarSize">56</s:param>
							<s:param name="username" value="#actionLogRecordVar.username" />
						</s:url>" width="56" height="56" class="img-circle media-object" />
		</div>
		<div class="media-body col-xs-12 col-sm-10 col-lg-11 activity-stream-event <s:if test="#currentEvent.first && !#ajax">event-first</s:if>">
			<s:set var="activityStreamInfoVar" value="#actionLogRecordVar.activityStreamInfo" />
			<s:set var="authGroupNameVar" value="#activityStreamInfoVar.linkAuthGroup" scope="page" />
			<s:set var="authPermissionNameVar" value="#activityStreamInfoVar.linkAuthPermission" scope="page" />
			<wp:ifauthorized groupName="${authGroupNameVar}" permission="${authPermissionNameVar}" var="isAuthorizedVar" />
			<div class="popover right display-block" data-entando="ajax-update">
				<div class="arrow"></div>
				<div class="popover-content">
					<c:choose>
						<c:when test="${isAuthorizedVar}">
							<a
								href="<s:url action="view" namespace="/do/userprofile"><s:param name="username" value="#actionLogRecordVar.username"/></s:url>"
								title="<s:text name="label.viewProfile" />: <s:property value="#actionLogRecordVar.username" />">
									<s:if test="null != #fullnameVar && #fullnameVar.length() > 0">
										<s:property value="#fullnameVar" />
									</s:if>
									<s:else>
										<s:property value="#actionLogRecordVar.username" />
									</s:else>
							</a>
						</c:when>
						<c:otherwise>
							<s:if test="null != #fullnameVar && #fullnameVar.length() > 0">
								<s:property value="#fullnameVar" />
							</s:if>
							<s:else>
								<s:property value="#actionLogRecordVar.username" />
							</s:else>
						</c:otherwise>
					</c:choose>
					&#32;&middot;&#32;
					<wpsa:activityTitle actionName="%{#actionLogRecordVar.actionName}" namespace="%{#actionLogRecordVar.namespace}" actionType="%{#activityStreamInfoVar.actionType}" />:&#32;
					<s:set var="linkTitleVar" value="%{getTitle('view/edit', #activityStreamInfoVar.objectTitles)}" />
					<c:choose>
						<c:when test="${isAuthorizedVar}">
							<s:url
								action="%{#activityStreamInfoVar.linkActionName}"
								namespace="%{#activityStreamInfoVar.linkNamespace}"
								var="actionUrlVar">
									<wpsa:paramMap map="#activityStreamInfoVar.linkParameters" />
							</s:url>
							<a href="<s:property value="#actionUrlVar" escape="false" />"><s:property value="#linkTitleVar" /></a>
						</c:when>
						<c:otherwise>
							<s:property value="#linkTitleVar" />
						</c:otherwise>
					</c:choose>
					<wpsa:activityStreamLikeRecords recordId="%{#actionLogRecordIdVar}" var="activityStreamLikeRecordsVar" />
					<%-- like / dislike --%>
						<s:set value="%{#activityStreamLikeRecordsVar.containsUser(#currentUsernameVar)}" var="likeRecordsContainsUserVar" />
						<p class="margin-small-vertical">
							<time datetime="<s:date name="#actionLogRecordVar.actionDate" format="yyyy-MM-dd HH:mm" />" title="<s:date name="#actionLogRecordVar.actionDate" format="yyyy-MM-dd HH:mm" />" class="text-info">
								<s:date name="#actionLogRecordVar.actionDate" nice="true" />
							</time>
							<s:if test="#activityStreamLikeRecordsVar.size() > 0">
								&#32;&middot;&#32;
								<span
									data-toggle="tooltip"
									data-placement="bottom"
									data-original-title="<s:iterator value="#activityStreamLikeRecordsVar" var="activityStreamLikeRecordVar"><s:property value="#activityStreamLikeRecordVar.displayName" />&#32;
										</s:iterator><s:text name="label.like.likesthis" />">
									<s:property value="#activityStreamLikeRecordsVar.size()" />
									&#32;
									<s:text name="label.like.number" />
								</span>
							</s:if>
							&#32;&middot;&#32;
							<s:if test="%{#likeRecordsContainsUserVar}" >
								<a
									href="<s:url namespace="/do/ActivityStream" action="unlikeActivity">
										<s:param name="recordId" value="%{#actionLogRecordIdVar}" />
										</s:url>">
										<s:text name="label.like.unlike" />
								</a>
							</s:if>
							<s:else>
								<a
									href="<s:url namespace="/do/ActivityStream" action="likeActivity">
										<s:param name="recordId" value="%{#actionLogRecordIdVar}" /></s:url>">
										<s:text name="label.like.like" />
								</a>
							</s:else>
						</p>
				</div>
			</div>
			<%-- comments --%>
				<div class="padding-base-left" style="margin-left: 20px" data-entando="ajax-update">
					<h4 class="sr-only">Comments</h4>
					<c:forEach begin="0" end="4" varStatus="commentStatus">
						<jsp:useBean id="testDate" class="java.util.Date" />
						<s:set var="comment" value="#{
						 'username': 'username-'+#attr.commentStatus.count,
						 'displayName': 'display name '+#attr.commentStatus.count,
						 'text': 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmodtempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
						 'date': #attr.testDate
						}" />
						<div class="media" data-entando-comment="<%= java.lang.Math.round(java.lang.Math.random() * 9999999) %><%= java.lang.Math.round(java.lang.Math.random() * 7) %><%= java.lang.Math.round(java.lang.Math.random() * 7) %><%= java.lang.Math.round(java.lang.Math.random() * 7) %><%= java.lang.Math.round(java.lang.Math.random() * 7) %><%= java.lang.Math.round(java.lang.Math.random() * 7) %><%= java.lang.Math.round(java.lang.Math.random() * 7) %><%= java.lang.Math.round(java.lang.Math.random() * 7) %><%= java.lang.Math.round(java.lang.Math.random() * 7) %><%= java.lang.Math.round(java.lang.Math.random() * 7) %>">
							<a
								class="pull-left"
								href="<s:url action="view" namespace="/do/userprofile"><s:param name="username" value="#comment.username"/></s:url>"
								title="<s:text name="label.viewProfile" />:&#32;<s:property value="#comment.displayName" />"
								>
								<img
									class="img-circle media-object stream-img-small"
									src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&username=<s:property value="#comment.username" />" />
							</a>
							<div class="media-body">
								<h5 class="media-heading">
									<a
										href="<s:url action="view" namespace="/do/userprofile"><s:param name="username" value="#comment.username"/></s:url>"
										title="<s:text name="label.viewProfile" />:&#32;<s:property value="#comment.displayName" />">
										<s:property value="#comment.displayName" /></a>
									,&#32;<time datetime="<s:date name="#comment.date" format="yyyy-MM-dd HH:mm" />" title="<s:date name="#comment.date" format="yyyy-MM-dd HH:mm" />" class="text-info">
										<s:date name="%{#comment.date}" nice="true" />
									</time>
									<s:if test="#comment.username == #attr.browserUsername || #attr.browserIsSuperUser">
										<a href="#remove" data-entando="remove-comment-ajax" class="pull-right">
											<span class="icon fa fa-icon fa-times-circle-o"></span>
											&nbsp;Delete
										</a>
									</s:if>
								</h5>
								<s:property value="#comment.text" />
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="padding-base-left margin-small-top" style="margin-left: 20px">
					<div class="insert-comment media <s:if test="#ajax"> hide </s:if>">
						<span
							class="pull-left"
							>
							<img
								class="img-circle media-object stream-img-small"
								src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&username=<s:property value="#attr.browserUsername" />" />
						</span>
						<div class="media-body">
							<form action="#">
								<textarea
									role="textbox"
									aria-multiline="true"
									class="col-xs-12 col-sm-12 col-md-12 col-lg-12" cols="30" rows="2" placeholder="insert comment..." name="comment"></textarea>
								<button name="" class="margin-small-top pull-right btn btn-sm btn-default"><span class="icon fa fa-comment"></span>&#32;Submit</button>
							</form>
						</div>
					</div>
				</div>
		</div>
	</li>
</s:iterator>