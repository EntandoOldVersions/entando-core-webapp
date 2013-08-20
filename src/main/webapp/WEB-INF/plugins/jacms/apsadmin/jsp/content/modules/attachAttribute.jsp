<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<s:set name="currentResource" value="#attribute.resources[#lang.code]"></s:set>
<s:set name="defaultResource" value="#attribute.resource"></s:set>

<span class="sr-only"><s:text name="note.attachContent" /></span>

<s:if test="#lang.default">
<%--Default lang --%>
	<s:if test="#currentResource != null">
		<s:if test="!(#attributeTracer.monoListElement) || ((#attributeTracer.monoListElement) && (#attributeTracer.compositeElement))">
			<div class="panel panel-default margin-small-top">
			<%-- PULSANTE DI RIMOZIONE RISORSA --%>
			<div class="panel-heading text-right">
				<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/removeResourceSubmit.jsp">
					<s:param name="resourceTypeCode">Attach</s:param>
				</s:include>
			</div>
		</s:if>
		<div class="row panel-body">
			<div class="col-xs-12 col-sm-3 col-lg-2 text-center">
				<a class="noborder" href="<s:property value="#defaultResource.attachPath" />" title="<s:text name="label.download" />:&#32;<s:property value="#defaultResource.descr"/>">
					<span class="icon icon-file-text icon-4x icon-large" ></span>
				</a>
			</div>
			<div class="col-xs-12 col-sm-9 col-lg-10 form-horizontal margin-large-top">
			  	<div class="form-group">
					<label class="col-xs-2 control-label text-right" for="<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />">
					<s:text name="label.text" /></label>
					<div class="col-xs-10">
						<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/textAttribute.jsp" />
					</div>
				</div>
			</div>
		</div>
		<s:if test="!(#attributeTracer.monoListElement) || ((#attributeTracer.monoListElement) && (#attributeTracer.compositeElement))">
			</div>
		</s:if>
	</s:if>
	<s:else>
		<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/chooseResourceSubmit.jsp">
			<s:param name="resourceTypeCode">Attach</s:param>
			<s:param name="iconImagePath"><wp:resourceURL/>administration/common/img/icons/22x22/attachment.png</s:param>
		</s:include>
	</s:else>
</s:if>
<s:else>
<%-- Not-default lang --%>
	<s:if test="#defaultResource == null">
		<s:text name="note.editContent.doThisInTheDefaultLanguage" />.
	</s:if>
	<s:else>
		<s:if test="#currentResource == null">
			<a class="noborder" href="<s:property value="#defaultResource.attachPath" />">
				<s:property value="#defaultResource.descr"/>
			</a>
			
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/chooseResourceSubmit.jsp">
				<s:param name="resourceTypeCode">Attach</s:param>
			</s:include>
			
		</s:if>
		<s:else>
			<a class="noborder" href="<s:property value="#currentResource.attachPath" />">
				<s:property value="#defaultResource.descr"/>
			</a> 
			
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/chooseResourceSubmit.jsp">
				<s:param name="resourceTypeCode">Attach</s:param>
			</s:include>
			
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/removeResourceSubmit.jsp">
				<s:param name="resourceTypeCode">Attach</s:param>
			</s:include>
			
		</s:else>
		<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/textAttribute.jsp" />
	</s:else>
</s:else>
