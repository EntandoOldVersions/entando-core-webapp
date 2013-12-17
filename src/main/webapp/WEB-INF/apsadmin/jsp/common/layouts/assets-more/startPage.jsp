<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<s:include value="/WEB-INF/apsadmin/jsp/common/layouts/assets-common.jsp" />
<script>
	Entando = Entando || {};
	Entando.backoffice = Entando.backoffice || {};
	Entando.backoffice.stream = {};
	Entando.backoffice.stream.list = {};
	Entando.backoffice.stream.list.updateUrl = '/portalexample/streams-list-item-ajax.jsp';
	Entando.backoffice.stream.list.loadMoreUrl = '/portalexample/streams-list-item-ajax.jsp';

	Entando.backoffice.stream.comments = {};
	Entando.backoffice.stream.comments.addUrl = '/portalexample/stream-add-comment-ajax.jsp';;
	Entando.backoffice.stream.comments.deleteUrl = '/portalexample/stream-add-comment-ajax.jsp';;
</script>
<script>
	jQuery(function(){
		$('#activity-stream [data-toggle="tooltip"]').tooltip({trigger: 'hover'});
	})
</script>
<script src="<wp:resourceURL />administration/js/entando-stream.js"></script>