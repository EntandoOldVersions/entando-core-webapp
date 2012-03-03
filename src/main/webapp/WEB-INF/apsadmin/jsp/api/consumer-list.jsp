<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<s:set var="targetNS" value="%{'/do/Api/Consumer'}" />
<h1><s:text name="title.apiConsumerManagement" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>
<div id="main">
	<s:if test="hasActionMessages()">
		<div class="message message_confirm">
			<h2><s:text name="messages.confirm" /></h2>
			<ul>
				<s:iterator value="actionMessages">
					<li><s:property escape="false" /></li>
				</s:iterator>
			</ul>
		</div>
	</s:if>
	<s:if test="hasActionErrors()">
		<div class="message message_error">
			<h2><s:text name="message.title.ActionErrors" /></h2>
			<ul>
				<s:iterator value="actionErrors">
					<li><s:property escape="false" /></li>
				</s:iterator>
			</ul>
		</div>
	</s:if>

	<s:form action="search">
		<p>
			<label for="search_consumer_description" class="basic-mint-label  label-search"><s:text name="label.search.by"/>&#32;<s:text name="label.consumer.description"/>:</label>
			<wpsf:textfield useTabindexAutoIncrement="insertedDescription" name="insertedDescription" id="search_consumer_description" cssClass="text" />
		</p>
		<fieldset>
			<legend class="accordion_toggler"><s:text name="title.searchFilters" /></legend>
			<div class="accordion_element">
				<p>
					<label for="search_consumer_key" class="basic-mint-label"><s:text name="label.consumerKey"/>:</label>
					<wpsf:textfield useTabindexAutoIncrement="true" name="insertedKey" id="search_consumer_key" cssClass="text" />
				</p>
			</div>
		</fieldset>
		<p>
			<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.search')}" cssClass="button" />
		</p>
        </s:form>
                
	<s:form action="search">
		<wpsf:hidden name="insertedKey" />
                <wpsf:hidden name="insertedDescription" />
		<div class="subsection-light">
			<wpsa:subset source="searchResult" count="10" objectName="groupSearchResult" advanced="true" offset="5">
				<s:set name="group" value="#groupSearchResult" />
				<s:set name="tokenOccurrencesVar" value="tokenOccurrencesByConsumer" />
				<div class="pager">
					<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
					<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
				</div>

				<table class="generic" summary="<s:text name="note.consumerList.summary" />">
					<caption><span><s:text name="title.apiManagement.consumerList" /></span></caption>
					<tr>
						<th><s:text name="label.key" /></th>
						<th><s:text name="label.description" /></th>
						<th><s:text name="label.expirationDate" /></th>
						<th class="icon"><abbr title="<s:text name="label.tokens.full" />"><s:text name="label.tokens.short" /></abbr></th>
						<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>
					</tr>
					<s:iterator var="consumerKeyVar" status="status">
						<s:set var="consumerVar" value="%{getConsumer(#consumerKeyVar)}" />
						<tr>
							<td class="monospace"><a href="<s:url action="edit"><s:param name="consumerKey" value="#consumerKeyVar" /></s:url>" title="<s:text name="label.edit" />: <s:property value="#consumerKeyVar" />" ><s:property value="#consumerKeyVar" /></a></td>
							<td>
								<s:if test="%{#consumerVar.description.length()>200}">
									<s:property value="%{#consumerVar.description.substring(0,200)}" />&#133;
								</s:if>
								<s:else>
									<s:property value="#consumerVar.description" />
								</s:else>
							</td>
							<td class="centerText monospace">
								<s:if test="#consumerVar.expirationDate != null">
									<s:date name="#consumerVar.expirationDate" format="dd/MM/yyyy" />
								</s:if>
								<s:else><abbr title="<s:text name="label.none" />">&ndash;</abbr></s:else>
							</td>
							<td class="monospace icon">
								<s:property value="#tokenOccurrencesVar.class"/>
								<s:if test="null == #tokenOccurrencesVar[#consumerKeyVar]" >0</s:if>
								<s:else><s:property value="#tokenOccurrencesVar[#consumerKeyVar]" /></s:else>
							</td>
							<td class="icon"><a href="<s:url action="trash"><s:param name="consumerKey" value="#consumerKeyVar"/></s:url>" title="<s:text name="label.remove" />: <s:property value="#consumerKeyVar" />"><img src="<wp:resourceURL />administration/common/img/icons/delete.png" alt="<s:text name="label.alt.clear" />" /></a></td>
						</tr>
					</s:iterator>
				</table>

				<div class="pager">
					<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
				</div>
			</wpsa:subset>
		</div>
	</s:form>
</div>