<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="#attribute.getAttributeList(#lang.code).size() != 0">
<ul class="list-group">
</s:if>
<s:set var="masterListAttributeTracer" value="#attributeTracer" />
<s:set var="masterListAttribute" value="#attribute" />
<s:iterator value="#attribute.getAttributeList(#lang.code)" var="attribute" status="elementStatus">
	<s:set var="attributeTracer" value="#masterListAttributeTracer.getListElementTracer(#lang, #elementStatus.index)" />
	<s:set var="elementIndex" value="#elementStatus.index" />

	<s:set var="masterAttributeFieldErrorsVar" value="#attributeFieldErrorsVar" />
	<s:set var="masterAttributeHasFieldErrorVar" value="#attributeHasFieldErrorVar" />
	<s:set var="masterAontrolGroupErrorClassVar" value="#controlGroupErrorClassVar" />
	<s:set var="masterAnputErrorClassVar" value="#inputErrorClassVar" />

	<s:set var="attributeFieldErrorsVar" value="%{fieldErrors[#attributeTracer.getFormFieldName(#attribute)]}" />
	<s:set var="attributeHasFieldErrorVar" value="#attributeFieldErrorsVar != null && !#attributeFieldErrorsVar.isEmpty()" />
	<s:set var="controlGroupErrorClassVar" value="''" />
	<s:set var="inputErrorClassVar" value="''" />
	<s:if test="#attributeHasFieldErrorVar">
		<s:set var="controlGroupErrorClassVar" value="' panel-danger'" />
		<s:set var="inputErrorClassVar" value="' input-with-feedback'" />
	</s:if>

	<li class="list-group-item">
		<div class="panel panel-default margin-none<s:property value="%{#controlGroupErrorClassVar}" />"><%-- panel panel-default --%>
			<div class="panel-heading"><%--panel heading --%>
				<label for="<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />" class=""><s:property value="#elementStatus.count" /></label>
				<div class="pull-right margin-small-bottom">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/listAttributes/allList_operationModule.jsp" />
				</div>
			</div><%--panel heading --%>
			<div class="clearfix"></div>
			<div class="panel-body">
				<s:if test="#attribute.type == 'CheckBox'">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/checkBoxAttribute.jsp" />
				</s:if>
				<s:elseif test="#attribute.type == 'Boolean'">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/booleanAttribute.jsp" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'Date'">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/dateAttribute.jsp" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'Enumerator'">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/enumeratorAttribute.jsp" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'Monotext'">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/monotextAttribute.jsp" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'Number'">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/numberAttribute.jsp" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'ThreeState'">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/threeStateAttribute.jsp" />
				</s:elseif>
				<s:elseif test="#attribute.type == 'Timestamp'">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/timestampAttribute.jsp" />
				</s:elseif>

				<s:if test="#attributeFieldErrorsVar">
					<p class="text-danger margin-none padding-none padding-small-top"><s:iterator value="#attributeFieldErrorsVar"><s:property /> </s:iterator></p>
				</s:if>

				<s:set var="attributeFieldErrorsVar" value="#masterAttributeFieldErrorsVar" />
				<s:set var="attributeHasFieldErrorVar" value="#masterAttributeHasFieldErrorVar" />
				<s:set var="controlGroupErrorClassVar" value="#masterAontrolGroupErrorClassVar" />
				<s:set var="inputErrorClassVar" value="#masterAnputErrorClassVar" />

			</div><%-- panel body --%>
		</div><%-- panel panel-default --%>
	</li>
	</s:iterator>

<s:set var="attributeTracer" value="#masterListAttributeTracer" />
<s:set var="attribute" value="#masterListAttribute" />
<s:set var="elementIndex" value="" />
<s:if test="#attribute.getAttributeList(#lang.code).size() != 0">
</ul>
</s:if>

<p class="button-align"><s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/listAttributes/allList_addElementButton.jsp" /></p>