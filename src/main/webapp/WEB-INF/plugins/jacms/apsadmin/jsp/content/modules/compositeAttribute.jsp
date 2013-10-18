<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<s:set var="masterCompositeAttributeTracer" value="#attributeTracer" />
<s:set var="masterCompositeAttribute" value="#attribute" />
<ul class="list-group">
	<s:iterator value="#attribute.attributes" var="attribute">
		<s:set var="parentAttribute" value="#masterCompositeAttribute" />
		<s:set var="attributeTracer" value="#masterCompositeAttributeTracer.getCompositeTracer(#masterCompositeAttribute)"></s:set>

		<s:set var="nullValueVar" />
		<s:property value="%{#attributeTracer.setLang(#nullValueVar)}" />

		<s:set var="masterAttributeFieldErrorsVar" value="#attributeFieldErrorsVar" />
		<s:set var="masterAttributeHasFieldErrorVar" value="#attributeHasFieldErrorVar" />
		<s:set var="masterAontrolGroupErrorClassVar" value="#controlGroupErrorClassVar" />
		<s:set var="masterAnputErrorClassVar" value="#inputErrorClassVar" />
		<s:set var="masterAttributeFieldNameErrorsVar" value="#attributeFieldNameErrorsVar" />
		<s:set var="masterAttributeHasFieldNameErrorVar" value="#attributeHasFieldNameErrorVar" />
		<s:set var="masterAttributeFieldNameErrorsVarV2" value="#attributeFieldNameErrorsVarV2" />
		<s:set var="masterAttributeHasFieldNameErrorVarV2" value="#attributeHasFieldNameErrorVarV2" />
		<s:set var="masterAttributeHasErrorVar" value="#attributeHasErrorVar" />

		<s:set var="attributeFieldErrorsVar" value="%{fieldErrors[#attribute.name]}" />
		<s:set var="attributeHasFieldErrorVar" value="#attributeFieldErrorsVar != null && !#attributeFieldErrorsVar.isEmpty()" />
		<s:set var="attributeFieldNameErrorsVar" value="%{fieldErrors[#attributeTracer.getFormFieldName(#attribute)]}" />
		<s:set var="attributeHasFieldNameErrorVar" value="#attributeFieldNameErrorsVar != null && !#attributeFieldNameErrorsVar.isEmpty()" />
		<s:set var="attributeFieldNameErrorsVarV2" value="%{fieldErrors[#attribute.name+':'+#attribute.name]}" />
		<s:set var="attributeHasFieldNameErrorVarV2" value="#attributeFieldNameErrorsVarV2 != null && !#attributeFieldNameErrorsVarV2.isEmpty()" />
		<s:set var="attributeHasErrorVar" value="%{#attributeHasFieldErrorVar||#attributeHasFieldNameErrorVar||#attributeHasFieldNameErrorVarV2}" />

		<s:set var="controlGroupErrorClassVar" value="''" />
		<s:set var="inputErrorClassVar" value="''" />
		<s:if test="#attributeHasErrorVar">
			<s:set var="controlGroupErrorClassVar" value="' panel-danger'" />
			<s:set var="inputErrorClassVar" value="' input-with-feedback'" />
		</s:if>

		<s:property value="%{#attributeTracer.setLang(#lang)}" />

		<li class="list-group-item<s:property value="#controlGroupErrorClassVar" />">
			<s:if test="null != #attribute.description"><s:set var="compositeElementLabelVar" value="#attribute.description" /></s:if>
			<s:else><s:set var="compositeElementLabelVar" value="#attribute.name" /></s:else>

			<s:if test="#attribute.type == 'Image' || #attribute.type == 'CheckBox' || #attribute.type == 'Boolean' || #attribute.type == 'ThreeState'">
				<label class="display-block">
					<s:property value="#compositeElementLabelVar" />
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" />
				</label>
			</s:if>
			<s:else>
				<label class="display-block" for="<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />">
					<s:property value="#compositeElementLabelVar"/>
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" />
				</label>
			</s:else>

			<s:if test="#attribute.type == 'Boolean'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/booleanAttribute.jsp" />
			</s:if>
			<s:elseif test="#attribute.type == 'CheckBox'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/checkBoxAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Date'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/dateAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Enumerator'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/enumeratorAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Hypertext'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/hypertextAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Longtext'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/longtextAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Monotext'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/monotextAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Number'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/numberAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Text'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/textAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'ThreeState'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/threeStateAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Timestamp'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/timestampAttribute.jsp" />
			</s:elseif>

			<%-- jacms attribute types --%>
				<s:elseif test="#attribute.type == 'Image'">
					<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/imageAttribute.jsp" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'Attach'">
					<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/attachAttribute.jsp" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'Link'">
					<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/linkAttribute.jsp" />
				</s:elseif>

			<wpsa:hookPoint key="jacms.entryContent.attributeExtra" objectName="hookPointElements_jacms_entryContent_attributeExtra">
			<s:iterator value="#hookPointElements_jacms_entryContent_attributeExtra" var="hookPointElement">
				<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
			</s:iterator>
			</wpsa:hookPoint>

			<s:if test="#attributeHasErrorVar">
				<p class="text-danger margin-none padding-none padding-small-top">
				<s:iterator value="#attributeFieldErrorsVar"><s:property /><br /></s:iterator>
				<s:iterator value="#attributeFieldNameErrorsVar"><s:property /><br /></s:iterator>
				<s:iterator value="#attributeFieldNameErrorsVarV2"><s:property /><br /></s:iterator>
			</s:if>

			<s:set var="attributeFieldErrorsVar" value="#masterAttributeFieldErrorsVar" />
			<s:set var="attributeHasFieldErrorVar" value="#masterAttributeHasFieldErrorVar" />
			<s:set var="controlGroupErrorClassVar" value="#masterAontrolGroupErrorClassVar" />
			<s:set var="inputErrorClassVar" value="#masterAnputErrorClassVar" />
			<s:set var="attributeFieldNameErrorsVar" value="#masterAttributeFieldNameErrorsVar" />
			<s:set var="attributeHasFieldNameErrorVar" value="#masterAttributeHasFieldNameErrorVar" />
			<s:set var="attributeFieldNameErrorsVarV2" value="#masterAttributeFieldNameErrorsVarV2" />
			<s:set var="attributeHasFieldNameErrorVarV2" value="#masterAttributeHasFieldNameErrorVarV2" />
			<s:set var="attributeHasErrorVar" value="#masterAttributeHasErrorVar" />

		</li>
	</s:iterator>
</ul>
<s:set var="attributeTracer" value="#masterCompositeAttributeTracer" />
<s:set var="attribute" value="#masterCompositeAttribute" />
<s:set var="parentAttribute" value=""></s:set>
