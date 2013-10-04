<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<s:set var="targetNS" value="%{'/do/LocaleString'}" />
<h1><s:text name="title.languageAdmin" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

<div id="main">

<h2 class="margin-more-bottom"><s:text name="title.languageAdmin.labels" /></h2>

<s:form action="search" >

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

		<p>
			<label for="text" class="basic-mint-label label-search"><s:text name="label.search.by"/>&#32;<s:text name="label.text"/>:</label>
			<wpsf:textfield useTabindexAutoIncrement="true" name="text" id="text" value="%{text}" cssClass="text" />
		</p>
	
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