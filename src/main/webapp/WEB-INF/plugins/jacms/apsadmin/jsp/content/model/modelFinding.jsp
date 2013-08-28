<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<h1 class="panel panel-default title-page"><span class="panel-body display-block"><s:text name="title.generalSettings.contentModels" /></span></h1>

<a href="<s:url action="new" namespace="/do/jacms/ContentModel"/>">NEW TODO</a>

<div id="main">

<s:form action="search" >

<p><label for="contentType" class="basic-mint-label label-search"><s:text name="label.search.by"/>&#32;<s:text name="label.type"/>:</label>
<wpsf:select useTabindexAutoIncrement="true" name="contentType" id="contentType" 
	list="smallContentTypes" listKey="code" listValue="descr" 
	headerKey="" headerValue="%{getText('label.all')}" cssClass="text"></wpsf:select>
</p>

<p><wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.search')}" cssClass="button" /></p>

</s:form>

<div class="subsection-light">

<s:form action="search">

<p class="sr-only"><wpsf:hidden name="contentType" /></p>

	<s:if test="%{contentModels.size > 0}" >
	
		<wpsa:subset source="contentModels" count="10" objectName="groupContentModel" advanced="true" offset="5">
		<s:set name="group" value="#groupContentModel" />
		
		<div class="pager">
			<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
			<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
		</div>
			
		<table class="generic" summary="<s:text name="note.generalSettings.contentModels.summary" />">
		<caption><span><s:text name="title.generalSettings.contentModels.installedModels" /></span></caption>
			
			<tr>
				<th><s:text name="contentModel.id" /></th>
				<th><s:text name="contentModel.type" /></th>
				<th><s:text name="label.description" /></th>
				<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>
			</tr>
			
			<s:iterator id="model">
				<tr>
						<td class="rightText monospace"><s:property value="#model.id" /></td>
						<td><s:property value="%{getSmallContentType(#model.contentType).descr}" /></td>  
						<td>
							<a href="<s:url action="edit" namespace="/do/jacms/ContentModel" />?modelId=<s:property value="#model.id" />" title="<s:text name="label.edit" />: <s:property value="#model.description" />">
								<s:property value="#model.description" />
							</a> 
						</td>
						<td class="icon">
							<a href="<s:url action="trash" namespace="/do/jacms/ContentModel" />?modelId=<s:property value="#model.id" />" title="<s:text name="label.remove" />: <s:property value="#model.description" />">
								<img src="<wp:resourceURL />administration/common/img/icons/delete.png" alt="<s:text name="label.alt.clear" />" />
							</a> 
						</td>
				</tr>
			</s:iterator>
		</table>
	<div class="pager">
		<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
	</div>
	</wpsa:subset>
	</s:if>
	<s:else>
		<p><s:text name="contentModel.noModels" /></p> 
	</s:else>
</s:form>

</div>
</div>