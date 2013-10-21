<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<s:set var="operationButtonDisabled" value="false" />
<s:set var="masterListAttributeTracer" value="#attributeTracer" />
<s:set var="masterListAttribute" value="#attribute" />
<p class="sr-only"><s:text name="note.monolist.intro" /></p>
<s:if test="#attribute.attributes.size() != 0">
	<ul class="list-group">
</s:if>
<s:iterator value="#attribute.attributes" var="attribute" status="elementStatus">
	<s:set var="attributeTracer" value="#masterListAttributeTracer.getMonoListElementTracer(#elementStatus.index)" />
	<s:set var="elementIndex" value="#elementStatus.index" />


	<s:set var="MonoListAttributeFieldErrorsVar" value="%{fieldErrors[#attribute.name]}" />
	<s:set var="MonoListAttributeHasFieldErrorVar" value="#MonoListAttributeFieldErrorsVar != null && !#MonoListAttributeFieldErrorsVar.isEmpty()" />
	<s:set var="MonoListAttributeFieldNameErrorsVar" value="%{fieldErrors[#attributeTracer.getFormFieldName(#attribute)]}" />
	<s:set var="MonoListAttributeHasFieldNameErrorVar" value="#MonoListAttributeFieldNameErrorsVar != null && !#MonoListAttributeFieldNameErrorsVar.isEmpty()" />
	<s:set var="MonoListAttributeFieldNameErrorsVarV2" value="%{fieldErrors[#attribute.name+':'+#attribute.name]}" />
	<s:set var="MonoListAttributeHasFieldNameErrorVarV2" value="#MonoListAttributeFieldNameErrorsVarV2 != null && !#MonoListAttributeFieldNameErrorsVarV2.isEmpty()" />
	<s:set var="MonoListAttributeAttributeHasErrorVar" value="%{#MonoListAttributeHasFieldErrorVar||#MonoListAttributeHasFieldNameErrorVar||#MonoListAttributeHasFieldNameErrorVarV2}" />

	<s:set var="MonoListAttributeControlGroupErrorClassVar" value="''" />
	<s:set var="MonoListAttributeInputErrorClassVar" value="''" />
	<s:if test="#MonoListAttributeAttributeHasErrorVar">
		<s:set var="MonoListAttributeControlGroupErrorClassVar" value="' panel-danger'" />
		<s:set var="MonoListAttributeInputErrorClassVar" value="' input-with-feedback'" />
	</s:if>

	<li class="list-group-item">
		<div class="panel panel-default margin-none<s:property value="%{#MonoListAttributeControlGroupErrorClassVar}" />"><%-- panel panel-default --%>
			<div class="panel-heading">
			<%-- composite --%>
				<s:if test="#attribute.type == 'Composite'">
					<label title="<s:text name="label.compositeAttribute.element" />">
						<s:property value="#elementStatus.index + 1" />
					</label>
					<div class="pull-right margin-small-bottom">
						<s:if test="!#lang.default"><s:set var="operationButtonDisabled" value="true" /></s:if>
						<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/listAttributes/allList_operationModule.jsp" />
					</div>
				</s:if>
			<%-- others --%>
				<s:else>
					<label for="<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />" >
						<s:property value="#elementStatus.index + 1" />
					</label>
					<div class="pull-right">
						<s:if test="!#lang.default"><s:set var="operationButtonDisabled" value="true" /></s:if>
						<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/listAttributes/allList_operationModule.jsp" />
					</div>
				</s:else>
			</div>
			<div class="clearfix"></div>
			<div class="panel-body"><%-- row panel-body --%>
				<s:if test="#attribute.type == 'Boolean'">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/booleanAttribute.jsp" />
				</s:if>
				<s:elseif test="#attribute.type == 'Attach'">
					<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/attachAttribute.jsp" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'CheckBox'">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/checkBoxAttribute.jsp" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'Composite'">
					<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/compositeAttribute.jsp" />
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
				<s:elseif test="#attribute.type == 'Image'">
					<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/imageAttribute.jsp" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'Longtext'">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/longtextAttribute.jsp" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'Link'">
					<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/linkAttribute.jsp" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'Number'">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/numberAttribute.jsp" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'Monotext'">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/monotextAttribute.jsp" />
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
				<wpsa:hookPoint key="jacms.entryContent.attributeExtra" objectName="hookPointElements_jacms_entryContent_attributeExtra">
					<s:iterator value="#hookPointElements_jacms_entryContent_attributeExtra" var="hookPointElement">
						<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
					</s:iterator>
				</wpsa:hookPoint>

				<s:if test="#MonoListAttributeAttributeHasErrorVar">
					<p class="text-danger margin-none padding-none padding-small-top">
					<s:iterator value="#MonoListAttributeFieldErrorsVar"><s:property /><br /></s:iterator>
					<s:iterator value="#MonoListAttributeFieldNameErrorsVar"><s:property /><br /></s:iterator>
					<s:iterator value="#MonoListAttributeFieldNameErrorsVarV2"><s:property /><br /></s:iterator>
				</s:if>


			</div><%-- row panel-body --%>
		</div><%-- panel panel-default --%>
	</li>
</s:iterator>
<s:set var="attributeTracer" value="#masterListAttributeTracer" />
<s:set var="attribute" value="#masterListAttribute" />
<s:set var="elementIndex" value="" />
<s:if test="#attribute.attributes.size() != 0">
	</ul>
</s:if>
<s:if test="#lang.default">
	<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/listAttributes/allList_addElementButton.jsp" />
</s:if>