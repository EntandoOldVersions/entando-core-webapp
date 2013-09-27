<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<s:set name="currentResource" value="#attribute.resources[#lang.code]"></s:set>
<s:set name="defaultResource" value="#attribute.resource"></s:set>

<span class="sr-only"><s:text name="note.imageContent" /></span>
<s:if test="#lang.default">
<%-- DEFAULT language --%>
	<s:if test="#currentResource != null">
	<%-- Default language - filled Attribute --%>

		<div class="panel panel-default margin-small-top">

			<s:if test="!(#attributeTracer.monoListElement) || ((#attributeTracer.monoListElement) && (#attributeTracer.compositeElement))">
				<div class="panel-heading text-right">
					<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/removeResourceSubmit.jsp">
						<s:param name="resourceTypeCode">Image</s:param>
					</s:include>
				</div>
			</s:if>

			<div class="row panel-body">
				<div class="col-xs-12 col-sm-3 col-lg-2 text-center">
					<a href="<s:property value="#defaultResource.getImagePath('0')" />" title="<s:text name="label.img.original" />">
						<img src="<s:property value="#defaultResource.getImagePath('1')"/>" alt="<s:property value="#defaultResource.descr"/>" style="height:90px;max-width:130px" />
					</a>
				</div>

				<div class="col-xs-12 col-sm-9 col-lg-10 form-horizontal margin-large-top">
				  <div class="form-group">
						<label class="col-xs-2 control-label text-right" for="<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />">
							<abbr title="<s:text name="label.img.text.long" />"><s:text name="label.img.text.short" /></abbr>
						</label>
						<div class="col-xs-10">
							<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/textAttribute.jsp" />
						</div>
					</div>
				</div>

			</div>

		</div>

	</s:if>
	<s:else>
		<%-- Default language - empty Attribute --%>

		<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/chooseResourceSubmit.jsp">
			<s:param name="resourceTypeCode">Image</s:param>
		</s:include>

	</s:else>
</s:if>
<s:else>
<%-- non-default language --%>
	<s:if test="#defaultResource == null">
		<%-- if default language still has empty Attribute --%>
		<span class="form-control-static text-info"><s:text name="note.editContent.doThisInTheDefaultLanguage" />.</span>
	</s:if>
	<s:else>
	<div class="panel panel-default">
		<div class="row">
		<%-- if default language has filled Attribute --%>
		<s:if test="#currentResource == null">
			<%-- this language: empty Attribute --%>
			<div class="col-sm-2 col-lg-2">
			<a href="<s:property value="#defaultResource.getImagePath('0')" />" title="<s:text name="label.img.original" />">
			<img src="<s:property value="#defaultResource.getImagePath('1')"/>" alt="<s:property value="#defaultResource.descr"/>" />
			</a>
			</div>
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/chooseResourceSubmit.jsp">
				<s:param name="resourceTypeCode">Image</s:param>
			</s:include>
		</s:if>
		<s:else>
		<%-- this language: filled Attribute --%>
			<div class="panel-heading">
				<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/removeResourceSubmit.jsp">
					<s:param name="resourceTypeCode">Image</s:param>
				</s:include>
			</div>

			<div class="col-sm-2 col-lg-2">
				<a href="<s:property value="#currentResource.getImagePath('0')" />" title="<s:text name="label.img.original" />">
					<img src="<s:property value="#currentResource.getImagePath('1')"/>" alt="<s:property value="#currentResource.descr"/>" />
				</a>
			</div>
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/chooseResourceSubmit.jsp">
				<s:param name="resourceTypeCode">Image</s:param>
			</s:include>
		</s:else>

		  <div class="form-group">
				<label class="col-xs-2 control-label text-right" for="<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />">
						<abbr title="<s:text name="label.img.text.long" />"><s:text name="label.img.text.short" /></abbr>
				</label>
				<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/textAttribute.jsp" />
			</div>

	</div>
	</div>
	</s:else>
</s:else>
