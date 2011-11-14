<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="startLangCode"><wp:info key="startLang"></wp:info></c:set>
<jsp:forward page="/${startLangCode}/homepage.page"/>