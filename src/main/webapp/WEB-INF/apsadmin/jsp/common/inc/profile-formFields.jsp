<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set name="lang" value="defaultLang" />

<%-- START CICLO ATTRIBUTI --%> 
<s:iterator value="userProfile.attributeList" var="attribute">
	<div class="contentAttributeBox contentAttribute-<s:property value="#attribute.type" />" id="<s:property value="%{'contentedit_'+#lang.code+'_'+#attribute.name}" />">
	<%-- INIZIALIZZAZIONE TRACCIATORE --%>
	<wpsa:tracerFactory var="attributeTracer" lang="%{#lang.code}" />

	<s:if test="#attribute.active"><s:set var="attributeActiveMarker" value="'modules'" /></s:if>
	<s:else><s:set var="attributeActiveMarker" value="'view'" /></s:else>
	
	<s:if test="null != #attribute.description"><s:set var="attributeLabelVar" value="#attribute.description" /></s:if>
	<s:else><s:set var="attributeLabelVar" value="#attribute.name" /></s:else>
	
	<s:if test="#attribute.type == 'List' || #attribute.type == 'Monolist'">
	<p class="important">
		<s:property value="#attributeLabelVar" /><s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" /><span class="monospace">&#32;(<s:text name="label.list" />)</span>:
	</p>
	</s:if>
	<s:elseif test="#attribute.type == 'Image' || #attribute.type == 'CheckBox' || #attribute.type == 'Boolean' || #attribute.type == 'ThreeState' || #attribute.type == 'Composite'">
	<p>
		<span class="important"><s:property value="#attributeLabelVar" /><s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" />:</span>
	</s:elseif>
	<s:else>
	<p>
		<label for="<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />" class="basic-mint-label"><s:property value="#attribute.name" /><s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" />:</label>
	</s:else>

	<s:if test="#attribute.type == 'Monotext'">
	<!-- ############# ATTRIBUTE Monotext ############# -->
	<s:include value="%{'/WEB-INF/apsadmin/jsp/entity/' + #attributeActiveMarker + '/monotextAttribute.jsp'}" />
	</p>
	</s:if>

	<s:elseif test="#attribute.type == 'Text'">
	<!-- ############# ATTRIBUTE Text ############# -->
	<s:include value="%{'/WEB-INF/apsadmin/jsp/entity/' + #attributeActiveMarker + '/textAttribute.jsp'}" />
	</p>
	</s:elseif>

	<s:elseif test="#attribute.type == 'Longtext'">
	<!-- ############# ATTRIBUTE Longtext ############# -->
	<s:include value="%{'/WEB-INF/apsadmin/jsp/entity/' + #attributeActiveMarker + '/longtextAttribute.jsp'}" />
	</p>
	</s:elseif>

	<s:elseif test="#attribute.type == 'Hypertext'">
	<!-- ############# ATTRIBUTE Hypertext ############# -->
	<s:include value="%{'/WEB-INF/apsadmin/jsp/entity/' + #attributeActiveMarker + '/hypertextAttribute.jsp'}" />
	</p>
	</s:elseif>

	<s:elseif test="#attribute.type == 'CheckBox'">
	<!-- ############# ATTRIBUTE CheckBox ############# -->
	<s:include value="%{'/WEB-INF/apsadmin/jsp/entity/' + #attributeActiveMarker + '/checkBoxAttribute.jsp'}" />
	</p>
	</s:elseif>

	<s:elseif test="#attribute.type == 'Boolean'">
	<!-- ############# ATTRIBUTE Boolean ############# -->
	<s:include value="%{'/WEB-INF/apsadmin/jsp/entity/' + #attributeActiveMarker + '/booleanAttribute.jsp'}" />
	</p>
	</s:elseif>

	<s:elseif test="#attribute.type == 'ThreeState'">
	<!-- ############# ATTRIBUTE ThreeState ############# -->
	<s:include value="%{'/WEB-INF/apsadmin/jsp/entity/' + #attributeActiveMarker + '/threeStateAttribute.jsp'}" />
	</p>
	</s:elseif>

	<s:elseif test="#attribute.type == 'Number'">
	<!-- ############# ATTRIBUTE Number ############# -->
	<s:include value="%{'/WEB-INF/apsadmin/jsp/entity/' + #attributeActiveMarker + '/numberAttribute.jsp'}" />
	</p>
	</s:elseif>

	<s:elseif test="#attribute.type == 'Date'">
	<!-- ############# ATTRIBUTE Date ############# -->
	<s:include value="%{'/WEB-INF/apsadmin/jsp/entity/' + #attributeActiveMarker + '/dateAttribute.jsp'}" />
	</p>
	</s:elseif>

	<s:elseif test="#attribute.type == 'Enumerator'">
	<!-- ############# ATTRIBUTE TESTO Enumerator ############# -->
	<s:include value="%{'/WEB-INF/apsadmin/jsp/entity/' + #attributeActiveMarker + '/enumeratorAttribute.jsp'}" />
	</p>
	</s:elseif>

	<s:elseif test="#attribute.type == 'Monolist'">
	<!-- ############# ATTRIBUTE Monolist ############# -->
	<s:include value="%{'/WEB-INF/apsadmin/jsp/entity/' + #attributeActiveMarker + '/monolistAttribute.jsp'}" />
	</s:elseif>

	<s:elseif test="#attribute.type == 'List'">
	<!-- ############# ATTRIBUTE List ############# -->
	<s:include value="%{'/WEB-INF/apsadmin/jsp/entity/' + #attributeActiveMarker + '/listAttribute.jsp'}" />
	</s:elseif>

	<s:elseif test="#attribute.type == 'Composite'">
	<!-- ############# ATTRIBUTE Composite ############# -->
	<s:include value="%{'/WEB-INF/apsadmin/jsp/entity/' + #attributeActiveMarker + '/compositeAttribute.jsp'}" />
	</p>
	</s:elseif>

	</div>
</s:iterator>
<%-- END CICLO ATTRIBUTI --%>
</fieldset>