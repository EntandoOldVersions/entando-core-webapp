<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cache_buster"  value="${param.fagianoCache}" />
<c:choose>
	<c:when test="${cache_buster == null}"><c:set var="cache_buster"  value="fa" /></c:when>  
	<c:otherwise><c:set var="cache_buster">${fn:substring(cache_buster, 1, -1)}${fn:substring(cache_buster, 0, 1)}</c:set></c:otherwise> 
</c:choose>

<div id="main">

<s:include value="/WEB-INF/apsadmin/jsp/entity/include/entity-type-list.jsp" />

<div class="alert alert-success">
	<h3 class="margin-none" id="fagiano_startReloadIndexes"><s:text name="title.entityAdmin.entityTypes.indexes" /></h3>
		<s:text name="note.entityAdmin.entityTypes.indexes.intro" />
		<s:if test="getSearcherManagerStatus() == 1">
				<s:text name="label.indexes.status.wip" />&#32;
				<span class="icon icon-spinner"></span>
		</s:if>
		<s:elseif test="getSearcherManagerStatus() == 2">
		<a href="
			<s:url namespace="/do/jacms/Entity" action="reloadContentsIndex" anchor="fagiano_startReloadIndexes">
				<s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param>
				<s:param name="fagianoCache"><c:out value="${cache_buster}" /></s:param>
			</s:url>
			"><s:text name="label.indexes.status.ko" /></a>
		</s:elseif>
		<s:elseif test="getSearcherManagerStatus() == 0">
		<span class="label label-success"><s:text name="label.indexes.status.ok" /></span>
		</s:elseif>
</div>
</div>