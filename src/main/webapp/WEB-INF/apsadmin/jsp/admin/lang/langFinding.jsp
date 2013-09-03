<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core"  %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url namespace="/do/BaseAdmin" action="settings" />"><s:text name="menu.configure" /></a> 
		&#32;/&#32;
		<s:text name="title.languageAdmin" /></span>
</h1>
<s:form action="add" cssClass="form-horizontal">
	<%-- <p><s:text name="title.languageAdmin.languages" /></p> --%>
	<s:if test="hasActionErrors()">
		<div class="alert alert-warning alert-dismissable fade in">
			<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
			<h2 class="h4 margin-none"><s:text name="message.title.ActionErrors" /></h2>
			<ul class="margin-base-vertical">
				<s:iterator value="actionErrors">
					<li><s:property escape="false" /></li>
				</s:iterator>
			</ul>
		</div>
	</s:if>
	<div class="form-group">
		<label class="control-label col-lg-3 col-md-3" for="langCode"><s:text name="name.chooseALanguage" /></label>
		<div class="col-md-9 col-lg-9">
			<select name="langCode" id="langCode" class="form-control">
				<s:iterator id="lang" value="assignableLangs">
				<option value="<s:property value="#lang.code"/>"><s:property value="#lang.code"/> &ndash; <s:property value="#lang.descr"/></option> 
				</s:iterator>
			</select>
		</div>
	</div>
	<div class="form-group">
		<div class="col-md-offset-3 col-lg-offset-3 col-md-9 col-lg-9">
			<s:submit type="button" cssClass="btn btn-primary" >
				<s:text name="label.add" />
			</s:submit> 	
		</div>
	</div>
	<table class="table table-hover" summary="<s:text name="note.generalSettings.lang.summary" />">
		<caption><span><s:text name="note.generalSettings.lang.definedLangs" /></span></caption>
		<tr>
			<th><s:text name="label.code" /></th>
			<th><s:text name="label.description" /></th>
			<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>	
		</tr>
		<s:iterator id="lang" value="langs">
		<tr>
			<td class="monospace">
				<s:if test="#lang.default">
				(<em><s:text name="label.default" /></em>)
				</s:if>	
				<s:property value="#lang.code" />
			</td>
			<td><s:property value="#lang.descr" /></td>
			
			<td class="icon">
				<a 
					href="<s:url action="remove"><s:param name="langCode" value="#lang.code"/></s:url>" 
					title="<s:text name="label.remove" />: <s:property value="#lang.descr" />">
					<span class="icon icon-remove-circle" /><span class="sr-only"><s:text name="label.alt.clear" /></span>
				</a>
			</td>	
		</tr>
		</s:iterator>
	</table>
</s:form>