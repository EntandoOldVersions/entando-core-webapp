<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<c:set var="random"><%= java.lang.Math.round(java.lang.Math.random() * 3) %></c:set>
<c:if test="${random%2 > 0}">
	<c:forEach begin="0" end="${random}" varStatus="s">
		<jsp:useBean id="testDate" class="java.util.Date" scope="page" />
		<li class="media row padding-large-vertical" data-entando-timestamp="<fmt:formatDate value="${testDate}" pattern="yyyy-MM-dd HH:mm:ss|SSSS" />">
		<c:remove var="testDate" scope="page" />
			<div class="col-xs-12 col-sm-2 col-lg-1 margin-small-bottom activity-stream-picture">
				<img alt=" " src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=admin" width="56" height="56" class="img-circle media-object">
			</div>
			<div class="media-body col-xs-12 col-sm-10 col-lg-11 activity-stream-event event-first">

				<div class="popover right display-block">
					<div class="arrow"></div>
					<div class="popover-content">

								<a href="/portalexample/do/userprofile/view.action?username=admin" title="label.viewProfile: admin">
										NAme&amp;
								</a>

						 ·
						created a new page <c:out value="${s.count}" />:

								<a href="/portalexample/do/Page/edit.action?selectedNode=errorpage">System Error</a>

							<p class="margin-small-vertical">
								<time datetime="2013-09-27 11:00" title="2013-09-27 11:00" class="text-info">
									76 days, 2 hours ago
								</time>

									 ·
									1

									like(s)
								 ·

									<a href="/portalexample/do/ActivityStream/unlikeActivity.action?recordId=3" data-toggle="tooltip" data-placement="right" data-original-title="NAme&amp; likes this">
											Unlike
									</a>

							</p>
					</div>
				</div>

				<div class="padding-base-left" style="margin-left: 20px">
					<h4 class="sr-only">Comments</h4>

						<div class="media">
							<a class="pull-left" href="/portalexample/do/userprofile/view.action?username=username-1" title="label.viewProfile: display name 1">
								<img class="img-circle media-object" src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=username-1" style="width: 32px; height: 32px">
							</a>
							<div class="media-body">
								<h5 class="media-heading">
									<a href="/portalexample/do/userprofile/view.action?username=username-1" title="label.viewProfile: display name 1">
										display name 1</a>
									, in an instant
								</h5>
								Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmodtempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.
							</div>
						</div>

						<div class="media">
							<a class="pull-left" href="/portalexample/do/userprofile/view.action?username=username-2" title="label.viewProfile: display name 2">
								<img class="img-circle media-object" src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=username-2" style="width: 32px; height: 32px">
							</a>
							<div class="media-body">
								<h5 class="media-heading">
									<a href="/portalexample/do/userprofile/view.action?username=username-2" title="label.viewProfile: display name 2">
										display name 2</a>
									, an instant ago
								</h5>
								Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmodtempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.
							</div>
						</div>

						<div class="media">
							<a class="pull-left" href="/portalexample/do/userprofile/view.action?username=username-3" title="label.viewProfile: display name 3">
								<img class="img-circle media-object" src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=username-3" style="width: 32px; height: 32px">
							</a>
							<div class="media-body">
								<h5 class="media-heading">
									<a href="/portalexample/do/userprofile/view.action?username=username-3" title="label.viewProfile: display name 3">
										display name 3</a>
									, an instant ago
								</h5>
								Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmodtempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.
							</div>
						</div>

						<div class="media">
							<a class="pull-left" href="/portalexample/do/userprofile/view.action?username=username-4" title="label.viewProfile: display name 4">
								<img class="img-circle media-object" src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=username-4" style="width: 32px; height: 32px">
							</a>
							<div class="media-body">
								<h5 class="media-heading">
									<a href="/portalexample/do/userprofile/view.action?username=username-4" title="label.viewProfile: display name 4">
										display name 4</a>
									, an instant ago
								</h5>
								Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmodtempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.
							</div>
						</div>

						<div class="media">
							<a class="pull-left" href="/portalexample/do/userprofile/view.action?username=username-5" title="label.viewProfile: display name 5">
								<img class="img-circle media-object" src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=username-5" style="width: 32px; height: 32px">
							</a>
							<div class="media-body">
								<h5 class="media-heading">
									<a href="/portalexample/do/userprofile/view.action?username=username-5" title="label.viewProfile: display name 5">
										display name 5</a>
									, an instant ago
								</h5>
								Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmodtempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.
							</div>
						</div>
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
	</c:forEach>
</c:if>
<li class="media row padding-large-vertical" data-entando-timestamp="2013-12-12 12:25:03|0238">
		<div class="col-xs-12 col-sm-2 col-lg-1 margin-small-bottom activity-stream-picture">
			<img alt=" " src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=admin" width="56" height="56" class="img-circle media-object">
		</div>
		<div class="media-body col-xs-12 col-sm-10 col-lg-11 activity-stream-event event-first">

			<div class="popover right display-block">
				<div class="arrow"></div>
				<div class="popover-content">

							<a href="/portalexample/do/userprofile/view.action?username=admin" title="label.viewProfile: admin">
									NAme&amp;
							</a>

					 ·
					created a new page:

							<a href="/portalexample/do/Page/edit.action?selectedNode=errorpage">System Error</a>

						<p class="margin-small-vertical">
							<time datetime="2013-09-27 11:00" title="2013-09-27 11:00" class="text-info">
								<jsp:useBean id="testDate2" class="java.util.Date" scope="page" />
								<fmt:formatDate value="${testDate2}" pattern="yyyy-MM-dd HH:mm:ss|SSSS" /> | <c:out value="${random}" />
							</time>

								 ·
								1

								like(s)
							 ·

								<a href="/portalexample/do/ActivityStream/unlikeActivity.action?recordId=3" data-toggle="tooltip" data-placement="right" data-original-title="NAme&amp; likes this">
										Unlike
								</a>

						</p>
				</div>
			</div>

			<div class="padding-base-left" style="margin-left: 20px">
				<h4 class="sr-only">Comments</h4>

					<div class="media">
						<a class="pull-left" href="/portalexample/do/userprofile/view.action?username=username-1" title="label.viewProfile: display name 1">
							<img class="img-circle media-object" src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=username-1" style="width: 32px; height: 32px">
						</a>
						<div class="media-body">
							<h5 class="media-heading">
								<a href="/portalexample/do/userprofile/view.action?username=username-1" title="label.viewProfile: display name 1">
									display name 1</a>
								, in an instant
							</h5>
							Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmodtempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.
						</div>
					</div>

					<div class="media">
						<a class="pull-left" href="/portalexample/do/userprofile/view.action?username=username-2" title="label.viewProfile: display name 2">
							<img class="img-circle media-object" src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=username-2" style="width: 32px; height: 32px">
						</a>
						<div class="media-body">
							<h5 class="media-heading">
								<a href="/portalexample/do/userprofile/view.action?username=username-2" title="label.viewProfile: display name 2">
									display name 2</a>
								, an instant ago
							</h5>
							Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmodtempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.
						</div>
					</div>

					<div class="media">
						<a class="pull-left" href="/portalexample/do/userprofile/view.action?username=username-3" title="label.viewProfile: display name 3">
							<img class="img-circle media-object" src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=username-3" style="width: 32px; height: 32px">
						</a>
						<div class="media-body">
							<h5 class="media-heading">
								<a href="/portalexample/do/userprofile/view.action?username=username-3" title="label.viewProfile: display name 3">
									display name 3</a>
								, an instant ago
							</h5>
							Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmodtempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.
						</div>
					</div>

					<div class="media">
						<a class="pull-left" href="/portalexample/do/userprofile/view.action?username=username-4" title="label.viewProfile: display name 4">
							<img class="img-circle media-object" src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=username-4" style="width: 32px; height: 32px">
						</a>
						<div class="media-body">
							<h5 class="media-heading">
								<a href="/portalexample/do/userprofile/view.action?username=username-4" title="label.viewProfile: display name 4">
									display name 4</a>
								, an instant ago
							</h5>
							Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmodtempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.
						</div>
					</div>

					<div class="media">
						<a class="pull-left" href="/portalexample/do/userprofile/view.action?username=username-5" title="label.viewProfile: display name 5">
							<img class="img-circle media-object" src="/portalexample/do/user/avatar/avatarStream.action?gravatarSize=56&amp;username=username-5" style="width: 32px; height: 32px">
						</a>
						<div class="media-body">
							<h5 class="media-heading">
								<a href="/portalexample/do/userprofile/view.action?username=username-5" title="label.viewProfile: display name 5">
									display name 5</a>
								, an instant ago
							</h5>
							Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmodtempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodoconsequat. Duis aute irure dolor in reprehenderit in voluptate velit essecillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat nonproident, sunt in culpa qui officia deserunt mollit anim id est laborum.
						</div>
					</div>
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