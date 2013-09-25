<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<s:include value="linkAttributeConfigIntro.jsp" />

<h3><s:text name="title.configureLinkAttribute" />&#32;(<s:text name="title.step2of2" />)</h3>

<s:include value="linkAttributeConfigReminder.jsp"/>

<p class="margin-more-bottom"><s:text name="note.chooseContentToLink" /></p>

<s:form action="search" cssClass="form-horizontal">
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

	<div class="form-group">
		<div class="input-group col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<label class="sr-only" for="text"><s:text name="label.search.by" />&#32;<s:text name="label.description" /></label>
			<span class="input-group-addon" title="<s:text name="label.search.by" />&#32;<s:text name="label.description" />">
				<span class="icon icon-file-text-alt icon-large"></span>
			</span>
			<wpsf:textfield name="text" id="text" cssClass="form-control input-lg" placeholder="%{getText('label.description')}" title="%{getText('label.search.by')+' '+getText('label.description')}" />
			<span class="input-group-btn">
				<s:submit type="button" title="%{getText('label.search')}" cssClass="btn btn-primary btn-lg">
					<span class="icon icon-search"></span>
					<span class="sr-only"><s:text name="label.search" /></span>
				</s:submit>
				<button type="button" class="btn btn-primary btn-lg dropdown-toggle" data-toggle="collapse" data-target="#search-advanced" title="<s:text name="title.searchFilters" />">
					<span class="sr-only"><s:text name="title.searchFilters" /></span>
					<span class="caret"></span>
				</button>
			</span>
		</div>
		<div class="input-group col-xs-12 col-sm-12 col-md-12 col-lg-12">
			<div id="search-advanced" class="collapse well collapse-input-group">
				<%-- code --%>
					<div class="form-group">
						<label class="control-label col-sm-2 text-right" for="contentIdToken"><s:text name="label.code"/></label>
						<div class="col-sm-5 input-group">
							<wpsf:textfield name="contentIdToken" id="contentIdToken" cssClass="form-control" />
						</div>
					</div>
				<%-- type --%>
					<div class="form-group">
						<label class="control-label col-sm-2 text-right" for="contentType"><s:text name="label.type"/></label>
						<div class="col-sm-5 input-group">
							<wpsf:select name="contentType" id="contentType" list="contentTypes" listKey="code" listValue="descr" headerKey="" headerValue="%{getText('label.all')}" cssClass="form-control" />
						</div>
					</div>
				<%-- status --%>
					<div class="form-group">
						<label class="control-label col-sm-2 text-right" for="state"><s:text name="label.state"/></label>
						<div class="col-sm-5 input-group">
							<wpsf:select name="state" id="state" list="avalaibleStatus" headerKey="" headerValue="%{getText('label.all')}" cssClass="form-control" listKey="key" listValue="%{getText(value)}" />
						</div>
					</div>
				<%-- search --%>
					<div class="form-group">
						<div class="col-sm-5 col-sm-offset-2">
							<s:submit type="button" cssClass="btn btn-primary">
								<span class="icon icon-search"></span>&#32;<s:text name="label.search" />
							</s:submit>
						</div>
					</div>
			</div>
		</div>
	</div>

<div class="subsection-light">
<wpsa:subset source="contents" count="10" objectName="groupContent" advanced="true" offset="5">
<s:set name="group" value="#groupContent" />

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

<p class="sr-only">
	<wpsf:hidden name="lastGroupBy" />
	<wpsf:hidden name="lastOrder" />
	<wpsf:hidden name="contentOnSessionMarker" />
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
		<s:param name="contentOnSessionMarker" value="contentOnSessionMarker" />
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
		<s:param name="contentOnSessionMarker" value="contentOnSessionMarker" />
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
		<s:param name="contentOnSessionMarker" value="contentOnSessionMarker" />
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
		<s:param name="contentOnSessionMarker" value="contentOnSessionMarker" />
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