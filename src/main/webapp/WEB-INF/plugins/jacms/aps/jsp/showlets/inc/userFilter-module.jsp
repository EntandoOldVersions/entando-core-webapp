<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${null != userFilterOptionsVar && !empty userFilterOptionsVar}">

<c:set var="hasUserFilterError" value="${false}" />
<c:forEach var="userFilterOptionVar" items="${userFilterOptionsVar}">
<c:if test="${null != userFilterOptionVar.formFieldErrors && !empty userFilterOptionVar.formFieldErrors}"><c:set var="hasUserFilterError" value="${true}" /></c:if>
</c:forEach>

<c:if test="${hasUserFilterError}">
	<h3><wp:i18n key="ERRORS" /></h3>
	<ul>
		<c:forEach var="userFilterOptionVar" items="${userFilterOptionsVar}">
			<c:if test="${null != userFilterOptionVar.formFieldErrors}">
			<c:forEach var="formFieldError" items="${userFilterOptionVar.formFieldErrors}">
			<li>
			<wp:i18n key="jacms_LIST_VIEWER_FIELD" />&#32;<em><c:out value="${formFieldError.value.attributeName}" /></em><c:if test="${formFieldError.value.rangeFieldType != null}">:&#32;<em><wp:i18n key="${formFieldError.value.rangeFieldType}" /></em></c:if>&#32;<wp:i18n key="${formFieldError.value.errorKey}" />
			</li>
			</c:forEach>
			</c:if>
		</c:forEach>
	</ul>
</c:if>
<c:set var="hasUserFilterError" value="${false}" />

<%-- search form with user filters --%>
<form action="<wp:url />" method="post">
	<c:forEach var="userFilterOptionVar" items="${userFilterOptionsVar}">
		<c:set var="userFilterOptionVar" value="${userFilterOptionVar}" scope="request" />
		<c:choose>
			<c:when test="${!userFilterOptionVar.attributeFilter && (userFilterOptionVar.key == 'fulltext' || userFilterOptionVar.key == 'category')}">
				<c:import url="/WEB-INF/plugins/jacms/aps/jsp/showlets/inc/userFilter-module-${userFilterOptionVar.key}.jsp" />
			</c:when>
			<c:when test="${userFilterOptionVar.attributeFilter}">
				<c:choose>
					<c:when test="${userFilterOptionVar.attribute.type == 'Monotext' || userFilterOptionVar.attribute.type == 'Text' || userFilterOptionVar.attribute.type == 'Longtext' || userFilterOptionVar.attribute.type == 'Hypertext'}">
						<c:import url="/WEB-INF/plugins/jacms/aps/jsp/showlets/inc/userFilter-module-entity-Text.jsp" />
					</c:when>
					<c:when test="${userFilterOptionVar.attribute.type == 'Enumerator' }">
						<c:import url="/WEB-INF/plugins/jacms/aps/jsp/showlets/inc/userFilter-module-entity-Enumerator.jsp" />
					</c:when>
					<c:when test="${userFilterOptionVar.attribute.type == 'Number'}">
						<c:import url="/WEB-INF/plugins/jacms/aps/jsp/showlets/inc/userFilter-module-entity-Number.jsp" />
					</c:when>
					<c:when test="${userFilterOptionVar.attribute.type == 'Date'}">
						<c:import url="/WEB-INF/plugins/jacms/aps/jsp/showlets/inc/userFilter-module-entity-Date.jsp" />
					</c:when>
					<c:when test="${userFilterOptionVar.attribute.type == 'Boolean' }">
						<c:import url="/WEB-INF/plugins/jacms/aps/jsp/showlets/inc/userFilter-module-entity-Boolean.jsp" />
					</c:when>
					<c:when test="${userFilterOptionVar.attribute.type == 'CheckBox'}">
						<c:import url="/WEB-INF/plugins/jacms/aps/jsp/showlets/inc/userFilter-module-entity-CheckBox.jsp" />
					</c:when>
					<c:when test="${userFilterOptionVar.attribute.type == 'ThreeState'}">
						<c:import url="/WEB-INF/plugins/jacms/aps/jsp/showlets/inc/userFilter-module-entity-ThreeState.jsp" />
					</c:when>
				</c:choose>
			</c:when>
		</c:choose>
	</c:forEach>
	<p>
		<input type="submit" value="<wp:i18n key="SEARCH" />" class="button" />
	</p>
</form>
</c:if>