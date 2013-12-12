<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<div id="main" role="main">
	<h1><s:text name="title.activityStream" /></h1>
	<s:set var="currentUsernameVar"><c:out value="${sessionScope.currentUser.username}" /></s:set>
	<wpsa:activityStream var="activityStreamList" />
	<s:if test="null != #activityStreamList && #activityStreamList.size() != 0">
		<ul class="list-unstyled" id="activity-stream">
			<s:include value="/WEB-INF/apsadmin/jsp/common/activity-stream/inc/stream.jsp" />
			<li class="media row">
				<div class="media-body col-xs-12 col-sm-10 col-lg-11 col-sm-offset-2 col-lg-offset-1 activity-stream-event event-last">
				</div>
			</li>
		</ul>
	</s:if>
	<s:else>
		NO ONE ACTIVITY
	</s:else>
</div>


<script>
	jQuery(function(){
		$('#activity-stream [data-toggle="tooltip"]').tooltip({trigger: 'hover'});
	})
</script>