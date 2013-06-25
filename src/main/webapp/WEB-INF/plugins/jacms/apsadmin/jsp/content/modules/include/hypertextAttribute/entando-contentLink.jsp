<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<div id="divContentLink" class="tab">
	<s:form action="entandoInternalLink" cssClass="searchForm">
		<p  class="margin-bit-bottom"><s:text name="note.chooseContentToLink" />.</p>

		<p class="noscreen">
			<wpsf:hidden name="lastGroupBy" />
			<wpsf:hidden name="lastOrder" />
			<wpsf:hidden name="activeTab" value="2" />
			<wpsf:hidden name="internalActionName" value="entandoSearch" />
			<wpsf:hidden name="contentOnSessionMarker" />
		</p>

		<p>
			<label for="text" class="basic-mint-label label-search"><s:text name="label.search.by"/>&#32;<s:text name="label.description"/>:</label>
			<wpsf:textfield useTabindexAutoIncrement="true" name="text" id="text" cssClass="text" />
		</p>

		<fieldset><legend class="accordion_toggler"><s:text name="title.searchFilters" /></legend>
			<div class="accordion_element">

				<p>
					<label for="contentIdToken" class="basic-mint-label"><s:text name="label.code"/>:</label>
					<wpsf:textfield useTabindexAutoIncrement="true" name="contentIdToken" id="contentIdToken" cssClass="text" />
				</p>

				<p>
					<label for="contentType" class="basic-mint-label"><s:text name="label.type"/>:</label>
					<wpsf:select useTabindexAutoIncrement="true" name="contentType" id="contentType"
						list="contentTypes" listKey="code" listValue="descr"
						headerKey="" headerValue="%{getText('label.all')}" cssClass="text"></wpsf:select>
				</p>
			</div>
		</fieldset>
		<p>
			<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.search')}" cssClass="button" />
		</p>
	</s:form>

	<s:form action="entandoInternalLink" >
		<p class="noscreen">
			<wpsf:hidden name="text" />
			<wpsf:hidden name="contentType" />
			<wpsf:hidden name="state" />
			<wpsf:hidden name="categoryCode" />
			<wpsf:hidden name="viewTypeDescr" />
			<wpsf:hidden name="viewGroup" />
			<wpsf:hidden name="viewCode" />
			<wpsf:hidden name="viewStatus" />
			<wpsf:hidden name="viewCreationDate" />
			<wpsf:hidden name="lastGroupBy" />
			<wpsf:hidden name="lastOrder" />
			<wpsf:hidden name="contentIdToken" />
			<wpsf:hidden name="activeTab" value="2" />
			<wpsf:hidden name="internalActionName" value="entandoSearch" />
			<wpsf:hidden name="contentOnSessionMarker" />
		</p>

		<wpsa:subset source="contents" count="10" objectName="groupContent" advanced="true" offset="5">
			<s:set name="group" value="#groupContent" />

			<div class="pager">
				<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
				<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
			</div>

			<s:if test="%{getContents().size() > 0}">
				<table class="generic" id="contentListTable" summary="<s:text name="note.content.fck_entandolink.summary" />">
				<caption><span><s:text name="title.contentList" /></span></caption>
				<tr>
					<th><a href="<s:url action="entandoInternalLink" includeParams="all" >
						<s:param name="activeTab">2</s:param>
						<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
						<s:param name="lastOrder"><s:property value="lastOrder"/></s:param>
						<s:param name="groupBy">descr</s:param>
						<s:param name="internalActionName">entandoChangeOrder</s:param>
					</s:url>#divContentLink"><s:text name="label.description" /></a></th>

					<th><a href="<s:url action="entandoInternalLink" includeParams="all" >
						<s:param name="activeTab">2</s:param>
						<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
						<s:param name="lastOrder"><s:property value="lastOrder"/></s:param>
						<s:param name="groupBy">code</s:param>
						<s:param name="internalActionName">entandoChangeOrder</s:param>
					</s:url>#divContentLink"><s:text name="label.code" /></a></th>

					<th><s:text name="label.creationDate" /></th>
					<th><s:text name="label.lastEdit" /></th>
				</tr>
				<s:iterator id="contentId">
				<s:set name="content" value="%{getContentVo(#contentId)}"></s:set>
				<tr>
				<td><input type="radio" name="contentId" id="contentId_<s:property value="#content.id"/>" value="<s:property value="#content.id"/>" />
				<label for="contentId_<s:property value="#content.id"/>"><s:property value="#content.descr" /></label></td>
				<td><s:property value="#content.id"/></td><%-- AGGIUNTO DA MATTEO--%>
				<td class="centerText"><span class="monospace"><s:date name="#content.create" format="dd/MM/yyyy HH:mm" /></span></td>
				<td class="icon"><span class="monospace"><s:date name="#content.modify" format="dd/MM/yyyy HH:mm" /></span></td>
				</tr>
				</s:iterator>
				</table>
			</s:if>

			<div class="pager">
				<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
			</div>

		</wpsa:subset>
		<p><input id="button_contentLink" name="button_contentLink" type="submit" value="<s:text name="label.confirm" />" class="button" /></p>

	</s:form>
</div>