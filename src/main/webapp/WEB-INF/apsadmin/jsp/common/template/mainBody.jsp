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
		<div id="stream-updates-alert" class="alert alert-info hide cursor-pointer margin-small-bottom"><s:text name="activity.stream.note.show.updates" /> (<span class="n">0</span>)</div>
		<ul class="list-unstyled padding-large-top" id="activity-stream">
			<s:include value="/WEB-INF/apsadmin/jsp/common/activity-stream/inc/stream.jsp" />
			<%--
			<li class="media row">
				<div class="media-body col-xs-12 col-sm-10 col-lg-11 col-sm-offset-2 col-lg-offset-1 activity-stream-event event-last">
				</div>
			</li>
			--%>
		</ul>
		<s:if test="#activityStreamListVar.size() != 10">
			<div class="row">
				<div class="col-xs-12 col-sm-2 col-md-2 col-lg-1 text-center">
					<button class="btn btn-default" data-entando="load-more-button" data-loading-text="<s:text name="activity.stream.note.loading" />&hellip;"><s:text name="activity.stream.note.loadMore" /></button>
				</div>
			</div>
		</s:if>
	</s:if>
	<s:else>
		<s:text name="activity.stream.note.no.activity" />
	</s:else>
</div>