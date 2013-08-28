<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" namespace="/do/Group"></s:url>" 
		title="<s:text name="note.goToSomewhere" />: <s:text name="title.groupManagement" />">
		<s:text name="title.groupManagement" />
		</a>
		&#32;/&#32;
		<s:if test="getStrutsAction() == 1">
			<s:text name="title.groupManagement.groupNew" />
		</s:if>
		<s:if test="getStrutsAction() == 2">
			<s:text name="title.groupManagement.groupEdit" />
		</s:if>
	</span>
</h1>

<div id="main">

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
	
<p class="centerText">
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" />
</p>
	
</s:form>

</div>