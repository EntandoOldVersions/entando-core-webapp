<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set name="currentResource" value="#attribute.resources[#lang.code]"></s:set>
<s:set name="defaultResource" value="#attribute.resource"></s:set>

<span class="sr-only"><s:text name="note.imageContent" /></span>
<s:if test="#lang.default">
<%-- Lingua di DEFAULT --%>
	<s:if test="#currentResource != null">
	<div class="panel">
		<%-- Lingua di default - Risorsa VALORIZZATA --%>
		<%-- IMMAGINE E LINK + TESTO + PULSANTE RIMUOVI --%>
		<%-- IMMAGINE E LINK --%>
		<s:if test="!(#attributeTracer.monoListElement) || ((#attributeTracer.monoListElement) && (#attributeTracer.compositeElement))">
			<%-- PULSANTE DI RIMOZIONE RISORSA --%>
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/removeResourceSubmit.jsp">
				<s:param name="resourceTypeCode">Image</s:param>
			</s:include>
		</s:if>
		<div class="row">
			<div class="col-4 col-lg-2 col-sm-3">
			<a href="<s:property value="#defaultResource.getImagePath('0')" />" title="<s:text name="label.img.original" />">
			<img class="alignTop" src="<s:property value="#defaultResource.getImagePath('1')"/>" alt="<s:property value="#defaultResource.descr"/>" />
			</a>
			</div>
			<%-- CAMPO DI TESTO --%>
			<div class="col-8 col-lg-10 col-sm-9 form-horizontal margin-base-top">	
			  	<div class="form-group">
				<label class="col-2 col-lg-2 control-label" for="<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />">
				<abbr title="<s:text name="label.img.text.long" />"><s:text name="label.img.text.short" /></abbr>:</label>
				<div class="col-10 col-lg-10">
					<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/textAttribute.jsp" />
				</div>
				</div>
			</div>
		</div>
	</div>
	</s:if>
	<s:else>
		<%-- Lingua di default - Risorsa NON VALORIZZATA --%>
		
		<%-- PULSANTE DI RICERCA RISORSA --%>
		<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/chooseResourceSubmit.jsp">
			<s:param name="resourceTypeCode">Image</s:param>
		</s:include>
		
	</s:else>
</s:if>
<s:else>
<%-- Lingua NON di DEFAULT --%>
	<s:if test="#defaultResource == null">
		<%-- Risorsa lingua di DEFAULT NON VALORIZZATA --%>
		<s:text name="note.editContent.doThisInTheDefaultLanguage" />.
	</s:if>
	<s:else>
	<div class="panel">
		<div class="row">
		<%-- Risorsa lingua di DEFAULT VALORIZZATA --%>
		<s:if test="#currentResource == null">
			<%-- Risorsa lingua corrente NON VALORIZZATA --%>
			<%-- IMMAGINE DI DEFAULT + PULSANTE SCEGLI RISORSA --%> 
			
			<%-- IMMAGINE DI DEFAULT --%>
			<div class="col-lg-2 col-sm-2">
			<a href="<s:property value="#defaultResource.getImagePath('0')" />" title="<s:text name="label.img.original" />">
			<img class="alignTop" src="<s:property value="#defaultResource.getImagePath('1')"/>" alt="<s:property value="#defaultResource.descr"/>" />
			</a>
			</div>
			<%-- PULSANTE DI RICERCA RISORSA --%>
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/chooseResourceSubmit.jsp">
				<s:param name="resourceTypeCode">Image</s:param>
			</s:include>
		</s:if>
		<s:else>
			<%-- IMMAGINE LINGUA CORRENTE CON LINK + PULSANTE RIMUOVI --%>
			
			<%-- PULSANTE DI RIMOZIONE RISORSA --%>
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/removeResourceSubmit.jsp">
				<s:param name="resourceTypeCode">Image</s:param>
			</s:include>			
			
			<%-- IMMAGINE LINGUA CORRENTE CON LINK  --%> 
			<div class="col-lg-2 col-sm-2">
			<a href="<s:property value="#currentResource.getImagePath('0')" />" title="<s:text name="label.img.original" />">
			<img class="alignTop" src="<s:property value="#currentResource.getImagePath('1')"/>" alt="<s:property value="#currentResource.descr"/>" />
			</a>
			</div>
			
			<%-- PULSANTE DI RICERCA RISORSA --%>
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/include/chooseResourceSubmit.jsp">
				<s:param name="resourceTypeCode">Image</s:param>
			</s:include>
		</s:else>
		<%-- CAMPO DI TESTO --%>
		<%-- CAMPO DI TESTO - MODULARIZZARE --%>
		<span class="imageAttribute-text">
		<label class="basic-mint-label" for="<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />"><abbr title="testo per ciccio">testo</abbr>:</label>		
		<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/textAttribute.jsp" />
		</span>
	</div>
	</div>
	</s:else>
</s:else>
