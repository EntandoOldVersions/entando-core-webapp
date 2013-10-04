<%@ taglib prefix="s" uri="/struts-tags" %>
<p class="sr-only"><s:text name="note.monolist.intro" /></p>
<s:if test="#attribute.attributes.size() != 0">
<ul class="media-list">
</s:if>
<s:set var="masterListAttributeTracer" value="#attributeTracer" />
<s:set var="masterListAttribute" value="#attribute" />
<s:iterator value="#attribute.attributes" var="attribute" status="elementStatus">
	<s:set var="attributeTracer" value="#masterListAttributeTracer.getMonoListElementTracer(#elementStatus.index)" />
	<s:set var="elementIndex" value="#elementStatus.index" />
	<li class="media">
		 <span class="pull-left">
			<span class="media-object">
				<span class="h3 text-info margin-small-right padding-small-vertical">
					<span class="label label-primary"><s:property value="#elementStatus.count" /></span>
					<s:if test="#attribute.type == 'Composite'">
						<span class="sr-only"><s:text name="label.compositeAttribute.element" />:</span>
					</s:if>
				</span>
			</span>
    </span>
		<div class="media-body">
			<s:if test="#attribute.type == 'Monotext'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/view/monotextAttribute.jsp" />
			</s:if>
			<s:elseif test="#attribute.type == 'Text'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/view/textAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Longtext'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/view/longtextAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Date'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/view/dateAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Timestamp'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/view/timestampAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Number'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/view/numberAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Hypertext'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/view/hypertextAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Enumerator'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/view/enumeratorAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Image'">
				<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/view/imageAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Attach'">
				<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/view/attachAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Link'">
				<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/view/linkAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Composite'">
				<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/view/compositeAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'Boolean'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/view/booleanAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'ThreeState'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/view/threeStateAttribute.jsp" />
			</s:elseif>
			<s:elseif test="#attribute.type == 'CheckBox'">
				<s:include value="/WEB-INF/apsadmin/jsp/entity/view/checkBoxAttribute.jsp" />
			</s:elseif>
		</div>
	</li>
</s:iterator>
<s:set var="attributeTracer" value="#masterListAttributeTracer" />
<s:set var="attribute" value="#masterListAttribute" />
<s:set var="elementIndex" value="" />
<s:if test="#attribute.attributes.size() != 0">
</ul>
</s:if>
<s:else><p><s:text name="label.none" /></p></s:else>