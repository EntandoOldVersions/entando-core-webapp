<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set var="targetNS" value="%{'/do/Role'}" />
<h1><s:text name="title.roleManagement" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

<div id="main">

<s:if test="getStrutsAction() == 1">
	<h2 class="margin-more-bottom"><s:text name="title.roleManagement.roleNew" /></h2>
</s:if>
<s:if test="getStrutsAction() == 2">
	<h2 class="margin-more-bottom"><s:text name="title.roleManagement.roleEdit" /></h2>	
</s:if>

<s:form action="save" >
	<s:if test="hasFieldErrors()">
<div class="message message_error">	
<h3><s:text name="message.title.FieldErrors" /></h3>
		<ul>
			<s:iterator value="fieldErrors">
				<s:iterator value="value">
		            <li><s:property escape="false" /></li>
				</s:iterator>
			</s:iterator>
		</ul>
</div>
	</s:if>
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
	
<p class="sr-only">
	<wpsf:hidden name="strutsAction" />
</p>

<s:if test="getStrutsAction() == 2">
<p class="sr-only">
	<wpsf:hidden name="name" />
</p>
</s:if>

<fieldset><legend><s:text name="label.info" /></legend>
<p>
	<label for="name" class="basic-mint-label"><s:text name="name" />:</label>
	<wpsf:textfield useTabindexAutoIncrement="true" name="name" id="name" disabled="%{getStrutsAction() == 2}" cssClass="text" />
</p>

<p>
	<label for="description" class="basic-mint-label"><s:text name="description" />:</label>
	<wpsf:textfield useTabindexAutoIncrement="true" name="description" id="description" cssClass="text" />
</p>	
</fieldset>	
	<%-- Per WILLY - Genera una serie di checkbox e labels associate.
		vedere link http://struts.apache.org/2.x/docs/checkboxlist.html
	 --%>
<fieldset><legend><s:text name="name.permissions" /></legend>
	<p><s:text name="note.permissions.intro" />:</p>
	<s:checkboxlist name="permissionNames" list="systemPermissions" listKey="name" listValue="description" cssClass="noBullet radiocheck" />
</fieldset>
<p class="centerText">
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" />
</p>
	
</s:form>

</div>