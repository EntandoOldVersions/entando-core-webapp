<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<c:set var="loremText">Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 

Ut enim ad minim veniam, quis 
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 

Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit 
anim id est laborum.</c:set>
<c:set var="random"><%= java.lang.Math.round(java.lang.Math.random() * 6) %></c:set>
<c:set var="param_date" value="${!(empty param.lastStreamTimestamp) ? param.lastStreamTimestamp : '2013-01-05 10:09:08 0765' }" />
<c:set var="random" value="${0}" />
<c:if test="${random%2 > 0 || true}">
	<c:forEach begin="0" end="${random}" varStatus="s">
		<fmt:parseDate value="${param_date}" pattern="yyyy-MM-dd HH:mm:ss SSSS" var="startDate" type="both" />
		<c:set var="testDate" value="${startDate}" />
		<c:set var="testDate_time"><jsp:getProperty name="testDate" property="time" /></c:set>
		<c:set var="testDate_time" value="${testDate_time + ((1000 * 60 * 60 * 25) * (random+1-s.index))}" />
		<jsp:setProperty name="testDate" property="time" value="${testDate_time}" />
		<fmt:formatDate value="${testDate}" pattern="yyyy-MM-dd HH:mm:ss|SSSS" var="fmt" />
		<li class="media row padding-large-bottom" 
			data-entando-timestamp="<c:out value="${fmt}" />" 
			data-entando-timestamp-comment="<c:out value="${fmt}" />">
			<div class="col-xs-12 col-sm-2 col-lg-1 margin-small-bottom activity-stream-picture">
				<img alt=" " src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=admin" width="56" height="56" class="img-circle media-object">
			</div>
			<div class="media-body col-xs-12 col-sm-10 col-lg-11 activity-stream-event event-first">
				<div class="popover right display-block" data-entando="ajax-update">
					<div class="arrow"></div>
					<div class="popover-content">
						<a href="/portalexample/do/userprofile/view.action?username=admin" title="label.viewProfile: admin">NAme&amp;</a>
						 ·
						created a new page <c:out value="${s.count}" />:
						<a href="/portalexample/do/Page/edit.action?selectedNode=errorpage">System Error</a>
						<p class="margin-small-vertical">
							<time 
								datetime="<c:out value="${fmt}" />" 
								title="<c:out value="${fmt}" />" 
								class="text-info">
									<c:out value="${fmt}" />
							</time>
							·
							<c:set var="randomLike"><%= java.lang.Math.round(java.lang.Math.random() * 99) %></c:set>
							<c:out value="${randomLike}" />&#32;like(s)
							·
							<a href="/portalexample/do/ActivityStream/unlikeActivity.action?recordId=3" data-toggle="tooltip" data-placement="bottom" 
							data-original-title="<c:forEach begin="1" end="${randomLike}" varStatus="likeStatus">Name<c:out value="${likeStatus.count}" />&#32;</c:forEach>likes this">Unlike</a>
						</p>
					</div>
				</div>
				<div class="padding-base-left" style="margin-left: 20px"  data-entando="ajax-update">
					<h4 class="sr-only">Comments</h4>
					<c:set var="randomComment"><%= java.lang.Math.round(java.lang.Math.random() * 7) %></c:set>
					<c:forEach begin="0" end="${randomComment}" varStatus="commentStatus">
						<div class="media">
							<a class="pull-left" href="/portalexample/do/userprofile/view.action?username=username-<c:out value="${commentStatus.count}" />" title="label.viewProfile: display name <c:out value="${commentStatus.count}" />">
								<img class="img-circle media-object" src="http://lorempixel.com/32/32/?gravatarSize=56&amp;username=username-<c:out value="${commentStatus.count}" />" style="width: 32px; height: 32px">
							</a>
							<div class="media-body">
								<h5 class="media-heading">
									<a href="/portalexample/do/userprofile/view.action?username=username-<c:out value="${commentStatus.count}" />" title="label.viewProfile: display name <c:out value="${commentStatus.count}" />">display name <c:out value="${commentStatus.count}" /></a>,&#32;
									<time datetime="2013-12-13 16:19" title="2013-12-13 16:19" class="text-info">
										in an instant
									</time>
								</h5>
								<c:set var="loremRandom1"><%= java.lang.Math.round(java.lang.Math.random() * 440) %></c:set>
								<c:set var="loremRandom2" value="${440-loremRandom1}" />
								<c:if test="${loremRandom2 < loremRandom1}">
									<c:set var="tmp" value="${loremRandom2}" />
									<c:set var="loremRandom2" value="${loremRandom1}" />
									<c:set var="loremRandom1" value="${tmp}" />
								</c:if>
								<% pageContext.setAttribute("carriageReturn", "\r"); %> 
								<% pageContext.setAttribute("newLine", "\n"); %> 
								<c:set var="STRING_TO_ESCAPE"><c:out value="${fn:substring(loremText, loremRandom1, loremRandom2)}" /></c:set>
								<c:set var="ESCAPED_STRING" value="${fn:replace(fn:replace(STRING_TO_ESCAPE,carriageReturn,' '),newLine,'<br />')}" />
								<c:set var="ESCAPED_STRING" value="${fn:replace(ESCAPED_STRING,'<br /><br />','<br />')}" />
								<c:out value="${ESCAPED_STRING}" escapeXml="false" />
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="padding-base-left margin-small-top" style="margin-left: 20px">
					<div class="media insert-comment hide">
						<span class="pull-left">
							<img class="img-circle media-object" src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=admin" style="width: 32px; height: 32px">
						</span>
						<div class="media-body">
							<form action="#">
								<textarea class="col-xs-12 col-sm-12 col-md-12 col-lg-12" cols="30" rows="3" placeholder="insert comment..." name="comment"></textarea>
								<button name="" class="margin-small-top pull-right btn btn-sm btn-default"><span class="icon fa fa-comment"></span> Submit</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</li>
		<c:remove var="testDate" />
		<c:remove var="startDate" />
		<c:remove var="testDate_time" />
	</c:forEach>
</c:if>
<%-- 2013-09-27 10:58:38|0000 --%>
<jsp:useBean id="testDate2" class="java.util.Date" scope="page" />
<jsp:setProperty name="testDate2" property="year" value="113"/>
<jsp:setProperty name="testDate2" property="month" value="8"/>
<jsp:setProperty name="testDate2" property="date" value="27"/>
<jsp:setProperty name="testDate2" property="hours" value="10"/>
<jsp:setProperty name="testDate2" property="minutes" value="58"/>
<jsp:setProperty name="testDate2" property="seconds" value="38"/>
<li class="media row padding-large-bottom" data-entando-timestamp="<fmt:formatDate value="${testDate2}" pattern="yyyy-MM-dd HH:mm:ss" />|0000">
	<div class="col-xs-12 col-sm-2 col-lg-1 margin-small-bottom activity-stream-picture">
		<img alt=" " src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=admin" width="56" height="56" class="img-circle media-object">
	</div>
	<div class="media-body col-xs-12 col-sm-10 col-lg-11 activity-stream-event event-first">
		<div class="popover right display-block" data-entando="ajax-update">
			<div class="arrow"></div>
			<div class="popover-content">
			<a href="/portalexample/do/userprofile/view.action?username=admin" title="label.viewProfile: admin">NAme&amp;</a>
			 ·
			created a new page:
			<a href="/portalexample/do/Page/edit.action?selectedNode=errorpage">System Error</a>
				<p class="margin-small-vertical">
					<time datetime="<fmt:formatDate value="${testDate2}" pattern="yyyy-MM-dd HH:mm" />" title="<fmt:formatDate value="${testDate2}" pattern="yyyy-MM-dd HH:mm:ss" />" class="text-info">
						<fmt:formatDate value="${testDate2}" pattern="yyyy-MM-dd HH:mm:ss" />|0000 | <c:out value="${random}" />
					</time>
					 ·
					<c:set var="randomLike"><%= java.lang.Math.round(java.lang.Math.random() * 99) %></c:set>
					<c:out value="${randomLike}" />&#32;like(s)
					·
					<a href="/portalexample/do/ActivityStream/unlikeActivity.action?recordId=3" 
					data-toggle="tooltip" 
					data-placement="bottom data-original-title="data-original-title="<c:forEach begin="1" end="${randomLike}" varStatus="likeStatus">Name<c:out value="${likeStatus.count}" />&#32;</c:forEach>likes this">Unlike</a>
				</p>
			</div>
		</div>
		<div class="padding-base-left" style="margin-left: 20px" data-entando="ajax-update">
			<h4 class="sr-only">Comments</h4>
			<c:set var="random"><%= java.lang.Math.round(java.lang.Math.random() * 7) %></c:set>
			<c:forEach begin="0" end="${random}" varStatus="commentStatus">
				<div class="media">
					<a class="pull-left" href="/portalexample/do/userprofile/view.action?username=username-<c:out value="${commentStatus.count}" />" title="label.viewProfile: display name <c:out value="${commentStatus.count}" />">
						<img class="img-circle media-object stream-img-small" src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=username-<c:out value="${commentStatus.count}" />" />
					</a>
					<div class="media-body">
						<h5 class="media-heading">
							<a href="/portalexample/do/userprofile/view.action?username=username-<c:out value="${commentStatus.count}" />" title="label.viewProfile: display name <c:out value="${commentStatus.count}" />">display name <c:out value="${commentStatus.count}" /></a>,&#32;
								<time datetime="2013-12-13 16:19" title="2013-12-13 16:19" class="text-info">in an instant</time>
						</h5>
						<c:set var="loremRandom1"><%= java.lang.Math.round(java.lang.Math.random() * 440) %></c:set>
						<c:set var="loremRandom2" value="${440-loremRandom1}" />
						<c:if test="${loremRandom2 < loremRandom1}">
							<c:set var="tmp" value="${loremRandom2}" />
							<c:set var="loremRandom2" value="${loremRandom1}" />
							<c:set var="loremRandom1" value="${tmp}" />
						</c:if>
						<% pageContext.setAttribute("carriageReturn", "\r"); %> 
						<% pageContext.setAttribute("newLine", "\n"); %> 
						<c:set var="STRING_TO_ESCAPE"><c:out value="${fn:substring(loremText, loremRandom1, loremRandom2)}" /></c:set>
						<c:set var="ESCAPED_STRING" value="${fn:replace(fn:replace(STRING_TO_ESCAPE,carriageReturn,' '),newLine,'<br />')}" />
						<c:set var="ESCAPED_STRING" value="${fn:replace(ESCAPED_STRING,'<br /><br />','<br />')}" />
						<c:out value="${ESCAPED_STRING}" escapeXml="false" />
					</div>
				</div>
			</c:forEach>
		</div>
		<div class="padding-base-left margin-small-top" style="margin-left: 20px">
			<div class="media insert-comment hide">
				<span class="pull-left">
					<img class="img-circle media-object stream-img-small" src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=admin" />
				</span>
				<div class="media-body">
					<form action="#">
						<textarea class="col-xs-12 col-sm-12 col-md-12 col-lg-12" cols="30" rows="3" placeholder="insert comment..." name="comment"></textarea>
						<button name="" class="margin-small-top pull-right btn btn-sm btn-default"><span class="icon fa fa-comment"></span> Submit</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</li>
