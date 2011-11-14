<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="operationButtonDisabled" value="false" />
<p class="noscreen"><s:text name="note.monolist.intro" /></p>

<s:if test="#attribute.attributes.size() != 0">
<ul>
</s:if>
<s:set name="masterListAttributeTracer" value="#attributeTracer" />
<s:set name="masterListAttribute" value="#attribute" />
<s:iterator value="#attribute.attributes" id="attribute" status="elementStatus">
<s:set name="attributeTracer" value="#masterListAttributeTracer.getMonoListElementTracer(#elementStatus.index)"></s:set>

<s:set name="elementIndex" value="#elementStatus.index" />

	<s:if test="#attribute.type == 'Composite'">
<li>	
		<span class="important" title="<s:text name="label.compositeAttribute.element" />"><s:property value="#elementStatus.index + 1" /></span>
		<s:if test="!#lang.default">
			<s:set var="operationButtonDisabled" value="true" />
		</s:if>
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/listAttributes/allList_operationModule.jsp" />
	</s:if>
	<s:else>
<li>	
		<label for="<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />"><s:property value="#elementStatus.index + 1" /></label>
		<s:if test="!#lang.default">
			<s:set var="operationButtonDisabled" value="true" />
		</s:if>
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/listAttributes/allList_operationModule.jsp" />
	</s:else>	 
	
	<s:if test="#attribute.type == 'Monotext'">
		<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/monotextAttribute.jsp" />
	</s:if>
	<s:elseif test="#attribute.type == 'Text'">
		<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/textAttribute.jsp" />
	</s:elseif>
	<s:elseif test="#attribute.type == 'Longtext'">
		<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/longtextAttribute.jsp" />
	</s:elseif>
	<s:elseif test="#attribute.type == 'Date'">
		<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/dateAttribute.jsp" />
	</s:elseif>
	<s:elseif test="#attribute.type == 'Number'">
		<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/numberAttribute.jsp" />
	</s:elseif>
	<s:elseif test="#attribute.type == 'Hypertext'">
		<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/hypertextAttribute.jsp" />
	</s:elseif>
	<s:elseif test="#attribute.type == 'Enumerator'">
		<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/enumeratorAttribute.jsp" />
	</s:elseif>
	<s:elseif test="#attribute.type == 'Image'">
		<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/imageAttribute.jsp" />
	</s:elseif>
	<s:elseif test="#attribute.type == 'Attach'">
		<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/attachAttribute.jsp" />
	</s:elseif>
	<s:elseif test="#attribute.type == 'Link'">
		<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/linkAttribute.jsp" />
	</s:elseif>
	<s:elseif test="#attribute.type == 'Composite'">
		<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/compositeAttribute.jsp" />
	</s:elseif>
	<s:elseif test="#attribute.type == 'Boolean'">
		<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/booleanAttribute.jsp" />
	</s:elseif>
	<s:elseif test="#attribute.type == 'ThreeState'">
		<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/threeStateAttribute.jsp" />
	</s:elseif>
	<s:elseif test="#attribute.type == 'CheckBox'">
		<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/checkBoxAttribute.jsp" />
	</s:elseif>
</li>
</s:iterator>

<s:set name="attributeTracer" value="#masterListAttributeTracer" />
<s:set name="attribute" value="#masterListAttribute" />
<s:set name="elementIndex" value="" />
<s:if test="#attribute.attributes.size() != 0">
</ul>
</s:if>

<s:if test="#lang.default">
<p class="button-align"><s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/listAttributes/allList_addElementButton.jsp" /></p>
</s:if>