<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${group.size > group.max}">
	<div class="pagination pagination-centered">
		<ul>
		<c:if test="${'1' != group.currItem}">
			<c:if test="${group.advanced}">
				<%-- TORNA ALL'INIZIO --%>
				<li><a href="<wp:url paramRepeat="true" ><wp:parameter name="${group.paramItemName}" >1</wp:parameter></wp:url>">|&lt;</a></li>
				<%-- salta indietro dell'offset --%>
				<c:if test="${1 != group.beginItemAnchor}">
					<li><a href="<wp:url paramRepeat="true" ><wp:parameter name="${group.paramItemName}" ><c:out value="${group.currItem - group.offset}" /></wp:parameter></wp:url>">&laquo;</a></li>
				</c:if>
			</c:if>
			<li><a href="<wp:url paramRepeat="true" ><wp:parameter name="${group.paramItemName}" ><c:out value="${group.prevItem}"/></wp:parameter></wp:url>"><wp:i18n key="PREV" /></a></li>
		</c:if>
		<c:forEach var="item" items="${group.items}" begin="${group.beginItemAnchor-1}" end="${group.endItemAnchor-1}">
			<c:choose>
			<c:when test="${item == group.currItem}"><li class="active"><a href="#"><c:out value="${item}"/></a></li></c:when>
			<c:otherwise><li><a href="<wp:url paramRepeat="true" ><wp:parameter name="${group.paramItemName}" ><c:out value="${item}"/></wp:parameter></wp:url>"><c:out value="${item}"/></a></li></c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${group.maxItem != group.currItem}">
			<li><a href="<wp:url paramRepeat="true" ><wp:parameter name="${group.paramItemName}" ><c:out value="${group.nextItem}"/></wp:parameter></wp:url>"><wp:i18n key="NEXT" /></a></li>
			<c:if test="${group.advanced}">
				<%-- salta avanti dell'offset --%>
				<c:if test="${group.maxItem != group.endItemAnchor}">
					<li><a href="<wp:url paramRepeat="true" ><wp:parameter name="${group.paramItemName}" ><c:out value="${group.currItem + group.offset}" /></wp:parameter></wp:url>">&raquo;</a></li>
				</c:if>
				<%-- VAI ALLA FINE --%>
				<li><a href="<wp:url paramRepeat="true" ><wp:parameter name="${group.paramItemName}" ><c:out value="${group.maxItem}" /></wp:parameter></wp:url>">&gt;|</a></li>
			</c:if>
		</c:if>
		</ul>
	</div>
</c:if>