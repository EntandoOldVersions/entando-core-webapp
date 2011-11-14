<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${group.size > group.max}">
	<p class="paginazione">
		<c:if test="${'1' != group.currItem}">
			<c:if test="${group.advanced}">
				<%-- TORNA ALL'INIZIO --%>
				<a href="<wp:url paramRepeat="true" ><wp:parameter name="${group.paramItemName}" >1</wp:parameter></wp:url>">|&lt;</a>
				<%-- salta indietro dell'offset --%>
				<c:if test="${1 != group.beginItemAnchor}">
					<a href="<wp:url paramRepeat="true" ><wp:parameter name="${group.paramItemName}" ><c:out value="${group.currItem - group.offset}" /></wp:parameter></wp:url>">&laquo;</a>
				</c:if>
			</c:if>
			<a href="<wp:url paramRepeat="true" ><wp:parameter name="${group.paramItemName}" ><c:out value="${group.prevItem}"/></wp:parameter></wp:url>"><wp:i18n key="PREV" /></a>
		</c:if>
		<c:forEach var="item" items="${group.items}" begin="${group.beginItemAnchor-1}" end="${group.endItemAnchor-1}">
			<c:choose>
			<c:when test="${item == group.currItem}">&#32;[<c:out value="${item}"/>]&#32;</c:when>
			<c:otherwise>&#32;<a href="<wp:url paramRepeat="true" ><wp:parameter name="${group.paramItemName}" ><c:out value="${item}"/></wp:parameter></wp:url>"><c:out value="${item}"/></a>&#32;</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${group.maxItem != group.currItem}">
			<a href="<wp:url paramRepeat="true" ><wp:parameter name="${group.paramItemName}" ><c:out value="${group.nextItem}"/></wp:parameter></wp:url>"><wp:i18n key="NEXT" /></a>
			<c:if test="${group.advanced}">
				<%-- salta avanti dell'offset --%>
				<c:if test="${group.maxItem != group.endItemAnchor}">
					<a href="<wp:url paramRepeat="true" ><wp:parameter name="${group.paramItemName}" ><c:out value="${group.currItem + group.offset}" /></wp:parameter></wp:url>">&raquo;</a>
				</c:if>
				<%-- VAI ALLA FINE --%>
				<a href="<wp:url paramRepeat="true" ><wp:parameter name="${group.paramItemName}" ><c:out value="${group.maxItem}" /></wp:parameter></wp:url>">&gt;|</a>
			</c:if>
		</c:if>
	</p>
</c:if>