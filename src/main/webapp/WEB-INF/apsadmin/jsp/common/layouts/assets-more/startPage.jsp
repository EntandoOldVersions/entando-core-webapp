<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<s:include value="/WEB-INF/apsadmin/jsp/common/layouts/assets-common.jsp" />
<script>
	Entando = Entando || {};
	Entando.backoffice = Entando.backoffice || {};
	Entando.backoffice.streamListUpdateAjaxUrl = '/portalexample/streams-list-item-ajax.jsp';
	Entando.backoffice.streamAddCommentAjaxUrl = '/portalexample/stream-add-comment-ajax.jsp';
	Entando.backoffice.streamLoadMoreAjaxUrl = '/portalexample/streams-list-load-more-ajax.jsp';
</script>
<script>
	jQuery(function(){
		$('#activity-stream [data-toggle="tooltip"]').tooltip({trigger: 'hover'});
	})
</script>
<script src="<wp:resourceURL />administration/js/entando-stream.js"></script>