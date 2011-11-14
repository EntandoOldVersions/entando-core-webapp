<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<s:include value="linkAttributeConfigIntro.jsp" />

<h3><s:text name="title.configureLinkAttribute" />&#32;(<s:text name="title.step2of2" />)</h3>

<s:include value="linkAttributeConfigReminder.jsp"/>

<p class="margin-more-bottom"><s:text name="note.chooseContentToLink" /></p>

<s:form action="search" >
<s:if test="hasFieldErrors()">
	<div class="message message_error">
	<h4><s:text name="message.title.FieldErrors" /></h4>
		<ul>
			<s:iterator value="fieldErrors">
				<s:iterator value="value">
		            <li><s:property escape="false" /></li>
				</s:iterator>
			</s:iterator>
		</ul>
	</div>
</s:if>

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
		<wpsf:select useTabindexAutoIncrement="true" name="contentType" id="contentType" list="contentTypes" listKey="code" listValue="descr" headerKey="" headerValue="%{getText('label.all')}" cssClass="text" />
	</p>
	
	<p>
		<label for="state" class="basic-mint-label"><s:text name="label.state"/>:</label>
		<wpsf:select useTabindexAutoIncrement="true" name="state" id="state" list="avalaibleStatus" headerKey="" headerValue="%{getText('label.all')}" cssClass="text" listKey="key" listValue="%{getText(value)}" />
	</p>
</div>
</fieldset>

<p><wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.search')}" cssClass="button" /></p>

<div class="subsection-light">
<wpsa:subset source="contents" count="10" objectName="groupContent" advanced="true" offset="5">
<s:set name="group" value="#groupContent" />

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

<p class="noscreen">
	<wpsf:hidden name="lastGroupBy" />
	<wpsf:hidden name="lastOrder" />
</p>
<s:if test="%{getContents().size() > 0}">
<table class="generic" summary="<s:text name="note.content.linkAttribute.summary" />">
<caption><span><s:text name="title.contentList" /></span></caption>
<tr>
	<th><a href="
	<s:url action="changeOrder">
		<s:param name="text">
			<s:property value="#request.text"/>
		</s:param>
		<s:param name="contentIdToken">
			<s:property value="#request.contentIdToken"/>
		</s:param>		
		<s:param name="contentType">
			<s:property value="#request.contentType"/>
		</s:param>
		<s:param name="state">
			<s:property value="#request.state"/>
		</s:param>
		<s:param name="pagerItem">
			<s:property value="#groupContent.currItem"/>
		</s:param>
		<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
		<s:param name="lastOrder"><s:property value="lastOrder"/></s:param>
		<s:param name="groupBy">descr</s:param>
	</s:url>
"><s:text name="label.description" /></a></th>
	<th><a href="
	<s:url action="changeOrder">
		<s:param name="text">
			<s:property value="#request.text"/>
		</s:param>
		<s:param name="contentIdToken">
			<s:property value="#request.contentIdToken"/>
		</s:param>
		<s:param name="contentType">
			<s:property value="#request.contentType"/>
		</s:param>
		<s:param name="state">
			<s:property value="#request.state"/>
		</s:param>
		<s:param name="pagerItem">
			<s:property value="#groupContent.currItem"/>
		</s:param>
		<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
		<s:param name="lastOrder"><s:property value="lastOrder"/></s:param>
		<s:param name="groupBy">code</s:param>
	</s:url>
"><s:text name="label.code" /></a></th>
	<th><s:text name="label.group" /></th>
	<th><a href="
	<s:url action="changeOrder">
		<s:param name="text">
			<s:property value="#request.text"/>
		</s:param>
		<s:param name="contentIdToken">
			<s:property value="#request.contentIdToken"/>
		</s:param>
		<s:param name="contentType">
			<s:property value="#request.contentType"/>
		</s:param>
		<s:param name="state">
			<s:property value="#request.state"/>
		</s:param>
		<s:param name="pagerItem">
			<s:property value="#groupContent.currItem"/>
		</s:param>
		<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
		<s:param name="lastOrder"><s:property value="lastOrder"/></s:param>
		<s:param name="groupBy">created</s:param>
	</s:url>
"><s:text name="label.creationDate" /></a></th>
	<th><a href="
	<s:url action="changeOrder">
		<s:param name="text">
			<s:property value="#request.text"/>
		</s:param>
		<s:param name="contentIdToken">
			<s:property value="#request.contentIdToken"/>
		</s:param>
		<s:param name="contentType">
			<s:property value="#request.contentType"/>
		</s:param>
		<s:param name="state">
			<s:property value="#request.state"/>
		</s:param>
		<s:param name="pagerItem">
			<s:property value="#groupContent.currItem"/>
		</s:param>
		<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
		<s:param name="lastOrder"><s:property value="lastOrder"/></s:param>
		<s:param name="groupBy">lastModified</s:param>
	</s:url>
"><s:text name="label.lastEdit" /></a></th>
</tr>
<s:iterator id="contentId">
<s:set name="content" value="%{getContentVo(#contentId)}"></s:set>
<tr>
<td><input type="radio" name="contentId" id="contentId_<s:property value="#content.id"/>" value="<s:property value="#content.id"/>" />
<label for="contentId_<s:property value="#content.id"/>"><s:property value="#content.descr" /></label></td>
<td><span class="monospace"><s:property value="#content.id" /></span></td>
<td><s:property value="groupsMap[#content.mainGroupCode].descr" /></td>
<td><s:date name="#content.create" format="dd/MM/yyyy HH:mm" /></td>
<td><s:date name="#content.modify" format="dd/MM/yyyy HH:mm" /></td>
</tr>
</s:iterator>
</table>
</s:if>
<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

</wpsa:subset>

<p>
	<wpsf:checkbox useTabindexAutoIncrement="true" name="contentOnPageType" id="contentOnPageType"/><label for="contentOnPageType"><s:text name="note.makeContentOnPageLink"></s:text></label>
</p>

<p class="centerText">
	<wpsf:submit useTabindexAutoIncrement="true" action="joinContentLink" value="%{getText('label.confirm')}" cssClass="button" />
</p>
</div>
</s:form>

</div>