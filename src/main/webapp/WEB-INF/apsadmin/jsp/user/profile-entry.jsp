<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url namespace="/do/BaseAdmin" action="settings" />"><s:text name="menu.configure" /></a>
		&#32;/&#32;
		<a href="<s:url namespace="do/User/" action="list" />">
		<s:text name="title.userManagement" /></a>
		&#32;/&#32;
		<s:text name="title.editUserProfile.currentUser" />
	</span>
</h1>
<div id="main">
	<s:form cssClass="form-horizontal">
		<div class="col-xs-12">
		<s:if test="hasFieldErrors()">
			<div class="alert alert-danger alert-dismissable fade in">
				<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
				<h2 class="h4 margin-none"><s:text name="message.title.FieldErrors" /></h2>
				<p class="margin-base-vertical"><s:text name="message.content.error" /></p>
			</div>
		</s:if>
		<div class="form-group">
			<label class="col-lg-2 control-label"><s:text name="label.username" /></label>
			<div class="col-lg-10">
      			<p class="form-control-static">
					<s:property value="userProfile.username" />
				</p>
			</div>
		</div>

		<s:set name="lang" value="defaultLang" />
		<%-- START CICLO ATTRIBUTI --%>
		<s:iterator value="userProfile.attributeList" id="attribute">
		<div class="form-group<s:property value="controlGroupErrorClassVar" />">
		<%-- INIZIALIZZAZIONE TRACCIATORE --%>
		<wpsa:tracerFactory var="attributeTracer" lang="%{#lang.code}" />

		<s:set var="attributeFieldErrorsVar" value="%{fieldErrors[#attributeTracer.getFormFieldName(#attribute)]}" />
		<s:set var="attributeHasFieldErrorVar" value="#attributeFieldErrorsVar != null && !#attributeFieldErrorsVar.isEmpty()" />
		<s:set var="controlGroupErrorClassVar" value="''" />
		<s:set var="inputErrorClassVar" value="''" />

		<s:if test="#attributeHasFieldErrorVar">
			<s:set var="controlGroupErrorClassVar" value="' has-error'" />
			<s:set var="inputErrorClassVar" value="' input-with-feedback'" />
		</s:if>

		<s:if test="#attribute.type == 'List' || #attribute.type == 'Monolist'">
			<p class="important">
				<s:property value="#attribute.name" /><s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" /><span class="monospace">&#32;(<s:text name="label.list" />)</span>:
			</p>
		</s:if>
		<s:elseif test="#attribute.type == 'Image' || #attribute.type == 'CheckBox' || #attribute.type == 'Boolean' || #attribute.type == 'ThreeState' || #attribute.type == 'Composite'">
			<span class="important"><s:property value="#attribute.name" /><s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" /></span>

		</s:elseif>
		<s:else>
			
			<label for="<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />" class="col-lg-2 control-label"><s:property value="#attribute.name" /><s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" /></label>
		</s:else>

			<s:if test="#attribute.type == 'Monotext'">
			<!-- ############# ATTRIBUTO TESTO MONOLINGUA ############# -->
			<div class="col-lg-10">
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/monotextAttribute.jsp" />
			</div>
			</s:if>

			<s:elseif test="#attribute.type == 'Text'">
			<!-- ############# ATTRIBUTO TESTO SEMPLICE MULTILINGUA ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/textAttribute.jsp" />
			
			</s:elseif>

			<s:elseif test="#attribute.type == 'Longtext'">
			<!-- ############# ATTRIBUTO TESTOLUNGO ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/longtextAttribute.jsp" />
			
			</s:elseif>

			<s:elseif test="#attribute.type == 'Hypertext'">
			<!-- ############# ATTRIBUTO HYPERTEXT ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/hypertextAttribute.jsp" />
			
			</s:elseif>

			<s:elseif test="#attribute.type == 'Image'">
			<!-- ############# ATTRIBUTO Image ############# -->
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/imageAttribute.jsp" />
			
			</s:elseif>

			<s:elseif test="#attribute.type == 'Attach'">
			<!-- ############# ATTRIBUTO Attach ############# -->
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/attachAttribute.jsp" />
			
			</s:elseif>

			<s:elseif test="#attribute.type == 'CheckBox'">
			<!-- ############# ATTRIBUTO CheckBox ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/checkBoxAttribute.jsp" />
			
			</s:elseif>

			<s:elseif test="#attribute.type == 'Boolean'">
			<!-- ############# ATTRIBUTO Boolean ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/booleanAttribute.jsp" />
			
			</s:elseif>

			<s:elseif test="#attribute.type == 'ThreeState'">
			<!-- ############# ATTRIBUTO ThreeState ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/threeStateAttribute.jsp" />
			
			</s:elseif>

			<s:elseif test="#attribute.type == 'Number'">
			<!-- ############# ATTRIBUTO Number ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/numberAttribute.jsp" />
			
			</s:elseif>

			<s:elseif test="#attribute.type == 'Date'">
			<!-- ############# ATTRIBUTO Date ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/dateAttribute.jsp" />
			
			</s:elseif>

			<s:elseif test="#attribute.type == 'Link'">
			<!-- ############# ATTRIBUTO Link ############# -->
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/linkAttribute.jsp" />
			
			</s:elseif>

			<s:elseif test="#attribute.type == 'Enumerator'">
			<!-- ############# ATTRIBUTO TESTO Enumerator ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/enumeratorAttribute.jsp" />
			
			</s:elseif>

			<s:elseif test="#attribute.type == 'Monolist'">
			<!-- ############# ATTRIBUTO Monolist ############# -->
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/monolistAttribute.jsp" />
			</s:elseif>

			<s:elseif test="#attribute.type == 'List'">
			<!-- ############# ATTRIBUTO List ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/listAttribute.jsp" />
			</s:elseif>

			<s:elseif test="#attribute.type == 'Composite'">
			<!-- ############# ATTRIBUTO Composite ############# -->
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/compositeAttribute.jsp" />
			
			</s:elseif>

		<s:if test="#attributeFieldErrorsVar">
		  <p class="text-danger padding-small-vertical">
		  	<s:iterator value="#attributeFieldErrorsVar"><s:property /> </s:iterator>
		  </p>
		</s:if>
		</div> <!-- form-group -->
		</s:iterator>
		<%-- END CICLO ATTRIBUTI --%>
		<div class="form-group">
		  <div class="col-xs-12 col-sm-4 col-md-3 margin-small-vertical">
		    <s:submit action="save" type="button" cssClass="btn btn-primary btn-block">
		      <span class="icon icon-save"></span>&#32;
		      <s:text name="label.save" />
		    </s:submit>
		  </div>
		</div>
	</div>
	</s:form>
</div>