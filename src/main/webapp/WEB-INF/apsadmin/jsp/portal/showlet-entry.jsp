<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<h1>
<s:if test="strutsAction == 2"><a href="<s:url action="viewShowlets" namespace="/do/Portal/WidgetType" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.showletManagement" />"><s:text name="title.showletManagement" /></a></s:if>
<s:else><s:text name="title.newShowletType" /></s:else>
</h1>
<div id="main">

<s:if test="strutsAction == 2">
<wpsa:widgetType key="%{showletTypeCode}" var="showletTypeVar" />
<h2><s:text name="title.showletManagement.edit" />:&#32;<s:property value="#showletTypeVar.titles[currentLang.code]" /></h2>
</s:if>
<s:else>
<h2><s:text name="title.newShowletType.from" />:&#32;
<s:if test="strutsAction == 1">
<wpsa:widgetType var="parentShowletTypeVar" key="%{parentShowletTypeCode}" />
<em><s:property value="%{getTitle(#parentShowletTypeVar.code, #parentShowletTypeVar.titles)}" /></em>
</s:if>
<s:elseif test="strutsAction == 3">
<em><s:property value="%{getTitle(showletToCopy.type.code, showletToCopy.type.titles)}" /></em>
</s:elseif>
</h2>
<s:if test="strutsAction == 3">
	<wpsa:page var="pageVar" key="%{pageCode}" />
	<p>
		<s:text name="note.showletType.page"/>:&#32;<em class="important"><s:property value="%{getTitle(#pageVar.code, #pageVar.titles)}" /></em>,&#32;<s:text name="note.showletType.position" />:&#32;<em class="important"><s:property value="framePos" /></em>
	</p>
</s:if>
</s:else>

<s:form action="save" namespace="/do/Portal/WidgetType" >

<wp:ifauthorized permission="superuser"><s:set var="isSuperuserVar" value="%{true}" /></wp:ifauthorized>

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
	<s:if test="strutsAction == 1">
	<wpsf:hidden name="parentShowletTypeCode" />
	</s:if>
	<s:elseif test="strutsAction == 2">
	<wpsf:hidden name="showletTypeCode" />
	</s:elseif>
	<s:elseif test="strutsAction == 3">
	<wpsf:hidden name="pageCode" />
	<wpsf:hidden name="framePos" />
	</s:elseif>
</p>

<fieldset class="margin-more-top"><legend><s:text name="label.info" /></legend>
	<s:if test="strutsAction != 2">
	<p>
		<label for="showletTypeCode" class="basic-mint-label"><s:text name="label.code" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" id="showletTypeCode" name="showletTypeCode" cssClass="text" />
	</p>
	</s:if>
	<p>
		<label for="showlet-title-en" class="basic-mint-label"><span class="monospace">(en)</span> <s:text name="label.title" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" id="showlet-title-en" name="englishTitle" cssClass="text" />
	</p>
	
	<p>
		<label for="showlet-title-it" class="basic-mint-label"><span class="monospace">(it)</span> <s:text name="label.title" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" id="showlet-title-it" name="italianTitle" cssClass="text" />
	</p>
	
	<p>
		<label for="showlet-maingroup" class="basic-mint-label"><s:text name="label.group" />:</label>
	<s:if test="#isSuperuserVar">
		<wpsf:select useTabindexAutoIncrement="true" name="mainGroup" id="showlet-maingroup" list="groups" listKey="name" listValue="descr" cssClass="text" />
	</s:if>
	<s:else>
		<s:property value="%{getGroup(mainGroup).descr}" />
	</s:else>
	</p>
	
	<s:if test="#showletTypeVar.logic && strutsAction == 2">
	<p>
		<em class="important"><s:text name="label.showletType.parentType" /></em>:<br />
		<s:property value="#showletTypeVar.parentType.titles[currentLang.code]" />
	</p>
	</s:if>
	
</fieldset>

<s:if test="strutsAction != 2 || #showletTypeVar.logic">
<fieldset><legend><s:text name="title.showletType.settings" /></legend>
	<s:if test="strutsAction == 1">
		<s:set var="parentShowletType" value="%{getShowletType(parentShowletTypeCode)}" />
		<s:iterator value="#parentShowletType.typeParameters" var="showletParam" >
			<p>
				<s:if test="#showletParam.descr != ''">
					<em><s:property value="#showletParam.descr" />:</em><br />
				</s:if>
				<label for="<s:property value="#showletParam.name" />" class="basic-mint-label"><s:property value="#showletParam.name" /></label>
				<wpsf:textfield useTabindexAutoIncrement="true" id="%{#showletParam.name}" name="%{#showletParam.name}" value="%{#request.parameters[#showletParam.name]}" cssClass="text" />
			</p>
		</s:iterator>
	</s:if>
	<s:elseif test="strutsAction == 2">
		<s:iterator value="#showletTypeVar.parentType.typeParameters" var="showletParam" >
		<p>
			<s:if test="#showletParam.descr != ''">
				<em><s:property value="#showletParam.descr" />:</em><br />
			</s:if>
			<s:if test="#isSuperuserVar && #showletTypeVar.userType">
			<label for="<s:property value="#showletParam.name" />" class="basic-mint-label"><s:property value="#showletParam.name" /></label>
			<wpsf:textfield useTabindexAutoIncrement="true" id="%{#showletParam.name}" name="%{#showletParam.name}" value="%{#showletTypeVar.config[#showletParam.name]}" cssClass="text" />
			</s:if>
			<s:else>
			<em class="important"><s:property value="#showletParam.name" /></em>:&#32;
			<s:property value="%{#showletTypeVar.config[#showletParam.name]}" />
			</s:else>
		</p>
		</s:iterator>
		<s:set var="isSuperuserVar" value="%{false}" />
	</s:elseif>
	<s:elseif test="strutsAction == 3">
		<s:iterator value="showletToCopy.type.typeParameters" var="showletParam" >
		<p>
			<s:if test="#showletParam.descr != ''">
				<em><s:property value="#showletParam.descr" />:</em><br />
			</s:if>
			<em class="important"><s:property value="#showletParam.name" /></em>:&#32;
			<s:property value="%{showletToCopy.config[#showletParam.name]}" />
		</p>
		</s:iterator>
	</s:elseif>
</fieldset>
</s:if>

<wpsa:hookPoint key="core.showletType.entry" objectName="hookPointElements_core_showlet_entry">
<s:iterator value="#hookPointElements_core_showlet_entry" var="hookPointElement">
	<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
</s:iterator>
</wpsa:hookPoint>

<p class="centerText"><wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" />
<s:if test="strutsAction == 3">
<wpsa:actionParam action="save" var="actionName" >
	<wpsa:actionSubParam name="replaceOnPage" value="true" />
</wpsa:actionParam>
<wpsf:submit useTabindexAutoIncrement="true" action="%{#actionName}" value="%{getText('label.save.replace')}" cssClass="button"/>
</s:if>
</p>

</s:form>
</div>