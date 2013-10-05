<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="viewTree" namespace="/do/Page" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.pageManagement" />">
			<s:text name="title.pageManagement" /></a>&#32;/&#32;
		<a href="
						<s:url action="configure" namespace="/do/Page">
							<s:param name="pageCode"><s:property value="currentPage.code"/></s:param>
						</s:url>
			 " title="<s:text name="note.goToSomewhere" />: <s:text name="title.configPage" />"><s:text name="title.configPage" /></a>&#32;/&#32;
		<s:text name="name.showlet" />
	</span>
</h1>

<div id="main">

<s:set var="breadcrumbs_pivotPageCode" value="pageCode" />
<s:include value="/WEB-INF/apsadmin/jsp/portal/include/pageInfo_breadcrumbs.jsp" />

<s:action namespace="/do/Page" name="printPageDetails" executeResult="true" ignoreContextParams="true"><s:param name="selectedNode" value="pageCode"></s:param></s:action>
<s:include value="/WEB-INF/apsadmin/jsp/portal/include/frameInfo.jsp" />

<s:set var="showletType" value="%{getShowletType(widgetTypeCode)}"></s:set>
<h3 class="margin-more-top margin-more-bottom"><s:text name="name.widget" />:&#32;<s:property value="%{getTitle(#showletType.code, #showletType.titles)}" /></h3>

<s:form action="searchContents" >

<p class="noscreen">
	<wpsf:hidden name="pageCode" />
	<wpsf:hidden name="frame" />
	<wpsf:hidden name="widgetTypeCode" />
	<wpsf:hidden name="modelId" />
</p>

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
	
<p><label for="text" class="basic-mint-label label-search"><s:text name="label.search.by"/>&#32;<s:text name="label.description"/>:</label>
<wpsf:textfield useTabindexAutoIncrement="true" name="text" id="text" cssClass="text" /></p>

<fieldset><legend class="accordion_toggler"><s:text name="title.searchFilters" /></legend>
<div class="accordion_element">
<p>
	<label for="contentIdToken"><s:text name="label.code"/>:</label><br />
	<wpsf:textfield useTabindexAutoIncrement="true" name="contentIdToken" id="contentIdToken" cssClass="text" />
</p>

<p>
	<label for="contentType"><s:text name="label.type"/>:</label><br />
	<wpsf:select useTabindexAutoIncrement="true" name="contentType" id="contentType" 
		list="contentTypes" listKey="code" listValue="descr" 
		headerKey="" headerValue="%{getText('label.all')}" cssClass="text"></wpsf:select>
</p>

<p>
	<label for="state"><s:text name="label.state"/>:</label><br />
	<wpsf:select useTabindexAutoIncrement="true" name="state" id="state" list="avalaibleStatus" 
		headerKey="" headerValue="%{getText('label.all')}" cssClass="text" listKey="key" listValue="%{getText(value)}" />
</p>
</div>
</fieldset>
<p><wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.search')}" cssClass="button" /></p>

<s:form action="searchContents" cssClass="form-horizontal">

<div class="panel panel-default">
	<div class="panel-heading">
		<s:include value="/WEB-INF/apsadmin/jsp/portal/include/frameInfo.jsp" />
	</div>

	<div class="panel-body">

<table class="generic" summary="<s:text name="note.page.contentViewer.summary" />">
<caption><span><s:text name="title.contentList" /></span></caption>
<tr>
	<th><a href="
	<s:url action="changeContentListOrder">
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
		<s:param name="pageCode">
			<s:property value="#request.pageCode"/>
		</s:param>
		<s:param name="frame">
			<s:property value="#request.frame"/>
		</s:param>
		<s:param name="modelId">
			<s:property value="#request.modelId"/>
		</s:param>
		<s:param name="widgetTypeCode"><s:property value="widgetTypeCode" /></s:param>
		<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
		<s:param name="lastOrder"><s:property value="lastOrder"/></s:param>
		<s:param name="groupBy">descr</s:param>
	</s:url>
"><s:text name="label.description" /></a></th>
	<th><a href="
	<s:url action="changeContentListOrder">
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
		<s:param name="pageCode">
			<s:property value="#request.pageCode"/>
		</s:param>
		<s:param name="frame">
			<s:property value="#request.frame"/>
		</s:param>
		<s:param name="modelId">
			<s:property value="#request.modelId"/>
		</s:param>
		<s:param name="widgetTypeCode"><s:property value="widgetTypeCode" /></s:param>
		<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
		<s:param name="lastOrder"><s:property value="lastOrder"/></s:param>
		<s:param name="groupBy">code</s:param>
	</s:url>
"><s:text name="label.code" /></a></th>
	<th><s:text name="label.group" /></th>
	<th><a href="
	<s:url action="changeContentListOrder">
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
		<s:param name="pageCode">
			<s:property value="#request.pageCode"/>
		</s:param>
		<s:param name="frame">
			<s:property value="#request.frame"/>
		</s:param>
		<s:param name="modelId">
			<s:property value="#request.modelId"/>
		</s:param>
		<s:param name="widgetTypeCode"><s:property value="widgetTypeCode" /></s:param>
		<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
		<s:param name="lastOrder"><s:property value="lastOrder"/></s:param>
		<s:param name="groupBy">created</s:param>
	</s:url>
"><s:text name="label.creationDate" /></a></th>
	<th><a href="
	<s:url action="changeContentListOrder">
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
		<s:param name="pageCode">
			<s:property value="#request.pageCode"/>
		</s:param>
		<s:param name="frame">
			<s:property value="#request.frame"/>
		</s:param>
		<s:param name="modelId">
			<s:property value="#request.modelId"/>
		</s:param>
		<s:param name="widgetTypeCode"><s:property value="widgetTypeCode" /></s:param>
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
<td><s:property value="%{getGroup(#content.mainGroupCode).descr}" /></td>
<td><s:date name="#content.create" format="dd/MM/yyyy HH:mm" /></td>
<td><s:date name="#content.modify" format="dd/MM/yyyy HH:mm" /></td>
</tr>
</s:iterator>
</table>

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

		<h3 class="h5 margin-small-top margin-large-bottom">
			<label class="sr-only"><s:text name="name.showlet" /></label>
			<span class="icon icon-puzzle-piece" title="<s:text name="name.showlet" />"></span>&#32;
			<s:property value="%{getTitle(#showletType.code, #showletType.titles)}" />
		</h3>


			<p class="sr-only">
				<s:hidden name="pageCode" />
				<s:hidden name="frame" />
				<s:hidden name="showletTypeCode" />
				<s:hidden name="modelId" />
			</p>

			<s:if test="hasFieldErrors()">
			<div class="alert alert-danger alert-dismissable">
				<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
				<h4 class="margin-none"><s:text name="message.title.FieldErrors" /></h4>
				<ul class="margin-base-vertical">
				<s:iterator value="fieldErrors">
					<s:iterator value="value">
					<li><s:property escape="false" /></li>
					</s:iterator>
				</s:iterator>
				</ul>
			</div>
			</s:if>

			<div class="form-group">

				<label for="text" class="sr-only"><s:text name="label.search.by"/>&#32;<s:text name="label.description"/></label>
				<div class="input-group col-sm-12">
					<span class="input-group-addon">
						<span class="icon icon-file-text-alt icon-large"></span>
					</span>
					<s:textfield name="text" id="text" cssClass="form-control input-lg" placeholder="%{getText('label.search.topic')}" title="%{getText('label.search.by')} %{getText('label.description')}" />
					<div class="input-group-btn">
						<s:submit type="button" cssClass="btn btn-primary btn-lg">
							<span class="icon icon-search" title="<s:text name="label.search" />"></span>
						</s:submit>
					</div>
				</div>
				<p class="help-block text-right">
					<button type="button" data-toggle="collapse" data-target="#search-advanced"  class="btn btn-link">
						<s:text name="title.searchFilters" />&#32;<span class="icon-chevron-down"></span>
					</button>
				</p>

			</div>

			<div id="search-advanced" class="collapse">

				<div class="form-group">
					<label for="contentType" class="control-label col-sm-2 text-right">
						<s:text name="label.type" />
					</label>
					<div class="col-sm-5">
						<s:select name="contentType" id="contentType"	list="contentTypes" listKey="code" listValue="descr" headerKey="" headerValue="%{getText('label.all')}" cssClass="form-control" />
					</div>
				</div>

				<div class="form-group">
					<label for="contentIdToken" class="control-label col-sm-2 text-right">
						<s:text name="label.code" />
					</label>
					<div class="col-sm-5">
						<s:textfield name="contentIdToken" id="contentIdToken" cssClass="form-control" />
					</div>
				</div>

				<div class="form-group">
					<label for="state" class="control-label col-sm-2 text-right"><s:text name="label.state" /></label>
					<div class="col-sm-5">
						<s:select name="state" id="state" list="avalaibleStatus" headerKey="" headerValue="%{getText('label.all')}" cssClass="form-control" listKey="key" listValue="%{getText(value)}" />
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-5 col-sm-offset-2">
						<s:submit type="button" cssClass="btn btn-primary">
							<span class="icon icon-search"></span>&#32;<s:text name="label.search" />
						</s:submit>
					</div>
				</div>

			</div><!--// search-advanced -->

			<hr />

			<wpsa:subset source="contents" count="10" objectName="groupContent" advanced="true" offset="5">
			<s:set name="group" value="#groupContent" />

			<div class="text-center">
				<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
				<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
			</div>

			<p class="sr-only">
				<s:hidden name="lastGroupBy" />
				<s:hidden name="lastOrder" />
			</p>

			<div class="table-responsive">
				<table class="table table-bordered">
				<tr>
					<th><a href="
					<s:url action="changeContentListOrder">
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
						<s:param name="pageCode">
							<s:property value="#request.pageCode"/>
						</s:param>
						<s:param name="frame">
							<s:property value="#request.frame"/>
						</s:param>
						<s:param name="modelId">
							<s:property value="#request.modelId"/>
						</s:param>
						<s:param name="showletTypeCode"><s:property value="showletTypeCode" /></s:param>
						<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
						<s:param name="lastOrder"><s:property value="lastOrder"/></s:param>
						<s:param name="groupBy">descr</s:param>
					</s:url>
				"><s:text name="label.description" /></a></th>
					<th><a href="
					<s:url action="changeContentListOrder">
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
						<s:param name="pageCode">
							<s:property value="#request.pageCode"/>
						</s:param>
						<s:param name="frame">
							<s:property value="#request.frame"/>
						</s:param>
						<s:param name="modelId">
							<s:property value="#request.modelId"/>
						</s:param>
						<s:param name="showletTypeCode"><s:property value="showletTypeCode" /></s:param>
						<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
						<s:param name="lastOrder"><s:property value="lastOrder"/></s:param>
						<s:param name="groupBy">code</s:param>
					</s:url>
				"><s:text name="label.code" /></a></th>
					<th><s:text name="label.group" /></th>
					<th class="text-center"><a href="
					<s:url action="changeContentListOrder">
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
						<s:param name="pageCode">
							<s:property value="#request.pageCode"/>
						</s:param>
						<s:param name="frame">
							<s:property value="#request.frame"/>
						</s:param>
						<s:param name="modelId">
							<s:property value="#request.modelId"/>
						</s:param>
						<s:param name="showletTypeCode"><s:property value="showletTypeCode" /></s:param>
						<s:param name="lastGroupBy"><s:property value="lastGroupBy"/></s:param>
						<s:param name="lastOrder"><s:property value="lastOrder"/></s:param>
						<s:param name="groupBy">created</s:param>
					</s:url>
				"><s:text name="label.creationDate" /></a></th>
					<th class="text-center"><a href="
					<s:url action="changeContentListOrder">
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
						<s:param name="pageCode">
							<s:property value="#request.pageCode"/>
						</s:param>
						<s:param name="frame">
							<s:property value="#request.frame"/>
						</s:param>
						<s:param name="modelId">
							<s:property value="#request.modelId"/>
						</s:param>
						<s:param name="showletTypeCode"><s:property value="showletTypeCode" /></s:param>
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
				<td><code><s:property value="#content.id" /></code></td>
				<td><s:property value="%{getGroup(#content.mainGroupCode).descr}" /></td>
				<td class="text-center text-nowrap">
					<code><s:date name="#content.create" format="dd/MM/yyyy HH:mm" /></code>
				</td>
				<td class="text-center text-nowrap">
					<code><s:date name="#content.modify" format="dd/MM/yyyy HH:mm" /></code>
				</td>
				</tr>
				</s:iterator>
				</table>
			</div>

			<div class="text-center">
				<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
			</div>

			</wpsa:subset>

	</div>

</div>
<div class="form-group">
	<div class="col-xs-12 col-sm-4 col-md-3 margin-small-vertical">
			<s:submit action="joinContent" value="%{getText('label.confirm')}" cssClass="btn btn-primary btn-block" />
	</div>
</div>
</s:form>

</div>
