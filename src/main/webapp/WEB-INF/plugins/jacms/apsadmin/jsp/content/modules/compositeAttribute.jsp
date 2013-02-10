<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>

<div class="compositeAttribute">
<s:set name="masterCompositeAttributeTracer" value="#attributeTracer" />
<s:set name="masterCompositeAttribute" value="#attribute" />
<s:iterator value="#attribute.attributes" id="attribute">
<div class="compositeAttribute-element">
<s:set name="attributeTracer" value="#masterCompositeAttributeTracer.getCompositeTracer(#masterCompositeAttribute)"></s:set>
<s:set name="parentAttribute" value="#masterCompositeAttribute"></s:set>

<s:if test="#attribute.type == 'Image' || #attribute.type == 'CheckBox' || #attribute.type == 'Boolean' || #attribute.type == 'ThreeState'">
	<span class="important"><s:property value="#attribute.name" /><s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" />:</span>

</s:if>
<s:else>
	<label for="<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />" class="basic-mint-label"><s:property value="#attribute.name"/><s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" />:</label>
</s:else>
		
		<s:if test="#attribute.type == 'Text'">
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/textAttribute.jsp" />
		</s:if>
		<s:elseif test="#attribute.type == 'Monotext'">
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/monotextAttribute.jsp" />
		</s:elseif>
		<s:elseif test="#attribute.type == 'Hypertext'">
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/hypertextAttribute.jsp" />
		</s:elseif>
		<s:elseif test="#attribute.type == 'Longtext'">
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/longtextAttribute.jsp" />
		</s:elseif>
		<s:elseif test="#attribute.type == 'Enumerator'">
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/enumeratorAttribute.jsp" />
		</s:elseif>
		<s:elseif test="#attribute.type == 'Number'">
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/numberAttribute.jsp" />
		</s:elseif>
		<s:elseif test="#attribute.type == 'Date'">
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/dateAttribute.jsp" />
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
		
</div>		
</s:iterator>
<s:set name="attributeTracer" value="#masterCompositeAttributeTracer" />
<s:set name="attribute" value="#masterCompositeAttribute" />
<s:set name="parentAttribute" value=""></s:set>
</div>