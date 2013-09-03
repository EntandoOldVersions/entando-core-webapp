<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url namespace="/do/BaseAdmin" action="settings" />"><s:text name="menu.configure" /></a> 
		/ 
		<s:text name="title.languageAdmin.labels" />
	</span>
</h1>
<div class="row">
	<div class="hidden-xs hidden-sm col-md-3 col-lg-3 ">
			<s:include value="/WEB-INF/apsadmin/jsp/admin/inc/settings-nav-menu.jsp">
				<s:param name="activeItem" value="%{'localeStrings'}" />
			</s:include>
	</div>
	<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
		<s:form action="search" cssClass="form-horizontal">
			<s:if test="hasActionErrors()">
				<div class="alert alert-warning alert-dismissable fade in">
					<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
					<h2 class="h4 margin-none"><s:text name="message.title.ActionErrors" /></h2>
					<ul class="margin-base-top">
						<s:iterator value="actionErrors">
							<li><s:property escape="false" /></li>
						</s:iterator>
					</ul>
				</div>
			</s:if>
			<div class="form-group">
				<div class="input-group col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<a href="<s:url namespace="/do/LocaleString" action="new" />" class="btn btn-default"><s:text name="title.languageAdmin.labels" /></a>					
				</div>
			</div>
			<div class="form-group">
				<div class="input-group col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<span class="input-group-addon">
							<span class="icon icon-file-text-alt icon-large"></span>
						</span>
						<s:textfield name="text" id="text" cssClass="form-control input-lg" title="%{getText('label.search.by') +' '+ getText('label.text')}" placeholder="%{getText('label.search.by') +' '+ getText('label.text')}" />
						<div class="input-group-btn">
							<button type="submit" id="search_%{#searchActionName}" name="action:search?actionCode=search" value="Submit" class="btn btn-primary btn-lg">
								<span class="icon icon-search" title="Search"></span>
							</button>
						</div>
				</div>
				<p class="help-block text-right">
					<button type="button" data-toggle="collapse" data-target="#search-advanced"  class="btn btn-link">
						<s:text name="title.searchFilters" />&#32;<span class="icon-chevron-down"></span>
					</button>
				</p>
			</div>
			<div id="search-advanced" class="collapse">
					<div class="form-group col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<label class="control-label col-lg-3 col-md-3" for="searchOption"><s:text name="label.type"/></label>
						<div class="col-md-9 col-lg-9">
							<select name="searchOption" id="searchOption" class="form-control">
								<option <s:if test="searchOption=='all'">selected="selected"</s:if> value="all"><s:text name="label.all" /></option>
								<option <s:if test="searchOption=='labelkey'">selected="selected"</s:if> value="labelkey"><s:text name="label.key" /></option>
								<s:iterator value="systemLangs">
									<option <s:if test="searchOption==code">selected="selected"</s:if> value="<s:property value="code" />"><s:property value="descr" /></option>
								</s:iterator>
							</select>	
						</div>
					</div>
					<div class="form-group col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="col-xs-offset-1 col-xs-12 col-sm-offset-12 col-sm-12 col-md-offset-3 col-lg-offset-3  col-md-9 col-lg-9">
							<s:submit type="button" value="%{getText('label.search')}" cssClass="btn btn-default" />
						</div>
					</div>
			</div>
			<hr />
			<s:set name="currentLocaleStrings" value="localeStrings"/>
			<wpsa:subset source="currentLocaleStrings" count="10" objectName="groupContent" advanced="true" offset="5">
				<s:set name="group" value="#groupContent" />
				<div  class="text-center">
					<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
					<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
				</div>
				<p class="sr-only">
					<wpsf:hidden name="lastGroupBy" />
					<wpsf:hidden name="lastOrder" />
				</p>
				<s:if test="%{#currentLocaleStrings.size > 0}" >
					<p class="sr-only"><s:text name="title.generalSettings.locale.installedLabels" /></p>
					<div class="dl-list">
						<s:iterator var="key">
							<dl class="dl-horizontal dl-striped panel padding-base-top padding-base-bottom">
								<s:set name="currentLabel" value="labels[#key]" />
								<dt class="hidden-sm"><s:text name="label.code" /></dt>
									<dd><s:property value="#key" /></dd>
									<s:iterator value="systemLangs" var="lang">
										<dt><abbr title="<s:property value="#lang.descr" />"><s:property value="#lang.descr" /></abbr></dt>
											<dd>
												<s:if test="%{#currentLabel[#lang.code]==null || #currentLabel[#lang.code].length()==0}">
													<abbr title="empty">&ndash;</abbr>
												</s:if>
												<s:else>
													<s:property value="#currentLabel[#lang.code]" />
												</s:else>
											</dd>
									</s:iterator>
								<dt class="sr-only"><s:text name="label.actions" /></dt>
									<dd class="margin-small-top">
										<a class="btn btn-default btn-small"href="<s:url action="edit" namespace="/do/LocaleString" />?key=<s:property value="#key" />"title="<s:text name="label.edit" />: <s:property value="#key" />"> <span class="icon icon-edit">&#32;Edit</span></a> 
										<a class="btn btn-default btn-small"href="<s:url action="delete" namespace="/do/LocaleString"><s:param name="key" value="#key" /></s:url>"title="<s:text name="label.remove" />: <s:property value="#key" />"> <span class="icon icon-remove-circle">&#32;<s:text name="label.remove" /></a> 
									</dd>
							</dl>
						</s:iterator>
					</div>
				</s:if>
				<div  class="text-center">
					<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
				</div>
			</wpsa:subset>
		</s:form>
	</div>
</div>
<%--
<hr />

<h1><s:text name="title.languageAdmin" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

<div id="main">

<h2 class="margin-more-bottom"><s:text name="title.languageAdmin.labels" /></h2>

<s:form action="search" cssClass="form-horizontal">
	<s:if test="hasActionErrors()">
		<div class="message message_error">
			<h3><s:text name="message.title.ActionErrors" /></h3>	
			<ul>
				<s:iterator value="actionErrors">
					<li><s:property escape="false" /></li>
				</s:iterator>
			</ul>
		</div>
	</s:if>


	
	<fieldset>
		<legend class="accordion_toggler"><s:text name="title.searchFilters" /></legend>
		<div class="accordion_element">
		<p>
			<label for="searchOption" class="basic-mint-label"><s:text name="label.type"/>:</label>
			<select name="searchOption" id="searchOption" class="text">
				<option <s:if test="searchOption=='all'">selected="selected"</s:if> value="all"><s:text name="label.all" /></option>
				<option <s:if test="searchOption=='labelkey'">selected="selected"</s:if> value="labelkey"><s:text name="label.key" /></option>
				
				<s:iterator value="systemLangs">
					<option <s:if test="searchOption==code">selected="selected"</s:if> value="<s:property value="code" />"><s:property value="descr" /></option>
				</s:iterator>
				
			</select>
		</p>
		</div>
	</fieldset>
	<p>
		<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.search')}" cssClass="button" />
	</p>

<div class="subsection-light">

<s:set name="currentLocaleStrings" value="localeStrings"/>
<wpsa:subset source="currentLocaleStrings" count="10" objectName="groupContent" advanced="true" offset="5">
	<s:set name="group" value="#groupContent" />
	<div class="pager">
		<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
		<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
	</div>
	<p class="sr-only">
		<wpsf:hidden name="lastGroupBy" />
		<wpsf:hidden name="lastOrder" />
	</p>

<s:if test="%{#currentLocaleStrings.size > 0}" >
	<table class="generic" summary="<s:text name="note.generalSettings.locale.summary" />">
	<caption><span><s:text name="title.generalSettings.locale.installedLabels" /></span></caption>
		<tr>
			<th><s:text name="label.code" /></th>
			<s:iterator value="systemLangs" id="lang">
				<th><s:property value="#lang.descr" /></th>
			</s:iterator>
			<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>	
		</tr>
	
		<s:iterator id="key">
			<s:set name="currentLabel" value="labels[#key]" />
			<tr>
				<td>
					<a href="<s:url action="edit" namespace="/do/LocaleString" />?key=<s:property value="#key" />" title="<s:text name="label.edit" />: <s:property value="#key" />">
						<s:property value="#key" />
					</a>
				</td>
			<s:iterator value="systemLangs" id="lang">
				<td><s:property value="#currentLabel[#lang.code]" /></td>
			</s:iterator>
				<td class="icon"><a href="<s:url action="delete" namespace="/do/LocaleString"><s:param name="key" value="#key" /></s:url>" title="<s:text name="label.remove" />: <s:property value="#key" />"><img src="<wp:resourceURL />administration/common/img/icons/delete.png" alt="<s:text name="label.alt.clear" />" /></a></td>			
			</tr>
		</s:iterator>
	</table>
</s:if>
	<div class="pager">
		<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
	</div>
</wpsa:subset>
</div>

</s:form>

</div>
--%>	