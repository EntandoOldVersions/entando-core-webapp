<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<div id="main" role="main">
	<h1><s:text name="title.activityStream" /></h1>
	<s:set var="currentUsernameVar"><c:out value="${sessionScope.currentUser.username}" /></s:set>
	<wpsa:activityStream var="activityStreamListVar" />
	<s:if test="null != #activityStreamListVar && #activityStreamListVar.size() != 0">
		<div id="stream-updates-alert" class="alert alert-info hide cursor-pointer margin-small-bottom">Show New Updates (<span class="n">0</span>)</div>
		<ul class="list-unstyled" id="activity-stream">
			<s:include value="/WEB-INF/apsadmin/jsp/common/activity-stream/inc/stream.jsp" />
			<%--
			<li class="media row">
				<div class="media-body col-xs-12 col-sm-10 col-lg-11 col-sm-offset-2 col-lg-offset-1 activity-stream-event event-last">
				</div>
			</li>
			--%>
		</ul>
		<button class="btn btn-default" data-entando="load-more-button" data-loading-text="Loading...">Load More</button>
	</s:if>
	<s:else>
		NO ONE ACTIVITY
	</s:else>
</div>