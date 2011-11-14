<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib prefix="jacms" uri="/jacms-apsadmin-core" %>

<s:set var="targetNS" value="%{'/do/jacms/ContentModel'}" />
<h1><s:text name="title.generalSettings.contentModels" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

<div id="main">
<s:if test="strutsAction == 1">
	<h2 class="margin-bit-bottom"><s:text name="title.generalSettings.contentModels.new" /></h2>
</s:if>
<s:if test="strutsAction == 2">
	<h2 class="margin-bit-bottom"><s:text name="title.generalSettings.contentModels.edit" /></h2>
</s:if>                 

<s:form action="save" namespace="/do/jacms/ContentModel" >
	
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
	<wpsf:hidden name="strutsAction" />
	<s:if test="strutsAction == 2">
		<wpsf:hidden name="modelId" />  
	</s:if>
</p>
	
<fieldset class="margin-more-top"><legend><s:text name="label.info" /></legend>
	<p><s:text name="note.contentModel.assist.intro" /></p>
	<p>
		<label for="newModel_id" class="basic-mint-label"><s:text name="contentModel.id" />:</label> 
		<wpsf:textfield useTabindexAutoIncrement="true" name="modelId" id="newModel_id" disabled="%{strutsAction == 2}" cssClass="text" />  
	</p>
	<p>
		<label for="newModel_contentType" class="basic-mint-label"><s:text name="contentModel.type" />:</label>
		<wpsf:select useTabindexAutoIncrement="true" id="newModel_contentType" list="smallContentTypes" name="contentType" 
			listKey="code" listValue="descr" cssClass="text" />
			<wpsf:submit useTabindexAutoIncrement="true" action="lockContentType" value="%{getText('label.set')}" cssClass="button" />
	</p> 
	<p>
		<label for="newModel_description" class="basic-mint-label"><s:text name="label.description" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" name="description" id="newModel_description" cssClass="text" />
	</p>
	<p>
		<label for="newModel_contentShape" class="basic-mint-label alignTop"><s:text name="contentModel.label.shape" />:</label>
		<wpsf:textarea useTabindexAutoIncrement="true"  name="contentShape" id="newModel_contentShape" cols="60" rows="10" cssClass="text" />
		<span class="help-window">
			<s:if test="strutsAction == 2 || (strutsAction == 1 && null != contentType)">(<s:text name="note.contentModel.help" />)&#32;</s:if>
			<s:text name="note.contentModel.contentAssist" />:&#32;<em class="important"><s:text name="label.on" /></em>.&#32;
				<s:if test="strutsAction == 2 || (strutsAction == 1 && null != contentType)">[<s:text name="note.contentModel.attributeHelp" />:&#32;<em class="important"><s:text name="label.on" /></em>]</s:if>
				<s:else>[<s:text name="note.contentModel.attributeHelp" />:&#32;<em class="important"><s:text name="label.off" /></em>]</s:else>
		</span>
	</p>
	<p>
		<label for="newModel_stylesheet" class="basic-mint-label"><s:text name="contentModel.label.stylesheet" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" name="stylesheet" id="newModel_stylesheet" cssClass="text" />
	</p>
</fieldset>
<p class="centerText">
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" />
</p>
<s:if test="#myClient == 'advanced'">
<p class="centerText"><s:text name="label.or" />&#32;<a href="#jacms-content-model-detail-shortcut" id="jacms-content-model-detail-shortcut"><s:text name="note.contentModel.detailsdownload" /></a></p>
</s:if>	

</s:form>
</div>