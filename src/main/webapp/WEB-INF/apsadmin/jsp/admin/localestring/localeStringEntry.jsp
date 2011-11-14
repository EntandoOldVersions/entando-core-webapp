<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<s:set var="targetNS" value="%{'/do/LocaleString'}" />
<h1><s:text name="title.languageAdmin" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

<div id="main">

<h2 class="margin-more-bottom"><a href="<s:url action="list" namespace="/do/LocaleString" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.languageAdmin.labels" />"><s:text name="title.languageAdmin.labels" /></a></h2>

<s:if test="getStrutsAction() == 1">
	<h3 class="margin-more-bottom"><s:text name="title.generalSettings.locale.new" /></h3>
</s:if>
<s:elseif test="getStrutsAction() == 2">
	<h3 class="margin-more-bottom"><s:text name="title.generalSettings.locale.edit" /></h3>
</s:elseif>
	
<s:form action="save" namespace="/do/LocaleString" >
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

	<p class="noscreen">
		<wpsf:hidden value="%{getStrutsAction()}" name="strutsAction"/>
	<s:if test="getStrutsAction() == 2">	
		<wpsf:hidden value="%{key}" name="key" />
	</s:if> 
	</p>

<fieldset><legend><s:text name="label.info" /></legend>
	<p>
		<label for="editLabel_key" class="basic-mint-label"><s:text name="label.code" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" value="%{key}" name="key" id="editLabel_key" disabled="%{getStrutsAction() == 2}" cssClass="text" />
	</p>	

	<s:iterator id="l" value="langs">
		<p>
			<label for="lang<s:property value="code"/>" class="basic-mint-label alignTop">
			   <span class="monospace">(<s:property value="code" />)</span>&#32;<s:text name="label.description" />:
			</label>
			<wpsf:textarea useTabindexAutoIncrement="true"  cols="50" rows="3" name="%{code}" id="%{'lang'+code}" value="%{labels[#l.code]}" cssClass="text" />
		</p> 
	</s:iterator>  
</fieldset>
	<p><wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" /></p>
</s:form>

</div> 