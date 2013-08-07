<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<s:include value="/WEB-INF/apsadmin/jsp/common/layouts/assets-common.jsp" />
<script type="text/javascript">
<!--//--><![CDATA[//><!--
//for tabs
window.addEvent('domready', function(){

	var permission = document.getElement("#requiredPermission");
	var group = document.getElement("#requiredGroup");
	var registered =  document.getElement("#requiredAuth");
	Array.each([permission, group], function(item, index) {
		item.addEvent("change", function(ev) {
			var value = ev.target.get("value");
			if (value != "") {
				registered.set("checked", "checked");
				registered.set("checked", true);
			}
		});
	});

	registered.addEvent("change", function(ev) {
		if (!ev.target.get("checked")) {
			permission.set("value", "");
			group.set("value", "");
		}
	});


});
//--><!]]>
</script>
