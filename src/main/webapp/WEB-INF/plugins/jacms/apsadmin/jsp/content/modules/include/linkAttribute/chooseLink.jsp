<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/linkAttribute/linkAttributeConfigIntro.jsp" />
<h3 class="margin-more-bottom"><s:text name="title.configureLinkAttribute" />&#32;(<s:text name="title.step1of2" />)</h3>
<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/linkAttribute/linkAttributeConfigReminder.jsp"/>

<s:form action="configLink">
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
<fieldset><legend><s:text name="title.chooseLinkType" /></legend>
<ul class="noBullet radiocheck">
<s:iterator id="typeId" value="linkDestinations">
	<s:if test="#typeId != 4">
		
		<s:if test="#typeId == 1">
			<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/22x22/link-url.png</s:set>
			<s:set name="linkDestination" value="%{getText('note.URLLinkTo')}" />
		</s:if>
		
		<s:if test="#typeId == 2">
			<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/22x22/link-page.png</s:set>
			<s:set name="linkDestination" value="%{getText('note.pageLinkTo')}" />
		</s:if>
		
		<s:if test="#typeId == 3">
			<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/22x22/link-content.png</s:set>
			<s:set name="linkDestination" value="%{getText('note.contentLinkTo')}" />
		</s:if>
		
		<li><input type="radio" <s:if test="#typeId == symbolicLink.destType">checked="checked"</s:if> name="linkType" id="linkType_<s:property value="#typeId"/>" value="<s:property value="#typeId"/>" /><label for="linkType_<s:property value="#typeId"/>"><img src="<s:property value="iconImagePath" />" alt=" " /> <s:property value="linkDestination" /></label></li>
		
	</s:if>	
</s:iterator>
</ul>

<p class="centerText"><wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.continue')}" title="%{getText('label.continue')}" cssClass="button" /></p>

</fieldset>
</s:form>
<%--
<p><a href="<s:url action="backToEntryContent" />" ><s:text name="label.backTo.Content" /></a></p>
 --%>
 
</div>