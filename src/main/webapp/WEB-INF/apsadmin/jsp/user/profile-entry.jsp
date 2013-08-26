<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1><s:text name="userprofile.menu.profileAdmin" /></h1>

<div id="main">
	<h2><s:text name="userprofile.title.changeUserProfile" /></h2>
	<p class="margin-more-bottom"><s:text name="userprofile.note.current" />:&#32;<em class="important">
		<a href="<s:url action="edit" namespace="/do/User"><s:param name="username" value="%{userProfile.username}" /></s:url>">
			<s:property value="userProfile.username" />
		</a>
	</em></p>
	<s:form>
		<s:if test="hasFieldErrors()">
			<div class="message message_error">
				<h3><s:text name="message.title.FieldErrors" /></h3>
					<ul>
						<s:iterator value="fieldErrors">
							<s:iterator value="value">
								<li><s:property escape="false" /></li>
							</s:iterator>
						</s:iterator>
					</ul>
			</div>
		</s:if>
		<fieldset>
		<legend><span><s:text name="label.info" /></span></legend>
		<s:set name="lang" value="defaultLang" />
		<%--
		<div class="contentAttributeBox contentAttribute-Checkbox">
			<p>
				<s:set name="checkedValue" value="%{userProfile.publicProfile != null && userProfile.publicProfile == true}" />
				<wpsf:checkbox useTabindexAutoIncrement="true" id="userprofile_isPublic" name="publicProfile" value="#checkedValue" cssClass="radiocheck" />
				<label for="userprofile_isPublic"><s:text name="userprofile.title.myPublicPorfile" /></label>
			</p>
		</div>
		--%>
		<%-- START CICLO ATTRIBUTI --%>
		<s:iterator value="userProfile.attributeList" id="attribute">
			<div class="contentAttributeBox contentAttribute-<s:property value="#attribute.type" />" id="<s:property value="%{'contentedit_'+#lang.code+'_'+#attribute.name}" />">
			<%-- INIZIALIZZAZIONE TRACCIATORE --%>
			<wpsa:tracerFactory var="attributeTracer" lang="%{#lang.code}" />

			<s:if test="#attribute.type == 'List' || #attribute.type == 'Monolist'">
			<p class="important">
				<s:property value="#attribute.name" /><s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" /><span class="monospace">&#32;(<s:text name="label.list" />)</span>:
			</p>
			</s:if>
			<s:elseif test="#attribute.type == 'Image' || #attribute.type == 'CheckBox' || #attribute.type == 'Boolean' || #attribute.type == 'ThreeState' || #attribute.type == 'Composite'">
			<p>
				<span class="important"><s:property value="#attribute.name" /><s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" />:</span>

			</s:elseif>
			<s:else>
			<p>
				<label for="<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />" class="basic-mint-label"><s:property value="#attribute.name" /><s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/attributeInfo.jsp" />:</label>
			</s:else>

			<s:if test="#attribute.type == 'Monotext'">
			<!-- ############# ATTRIBUTO TESTO MONOLINGUA ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/monotextAttribute.jsp" />
			</p>
			</s:if>

			<s:elseif test="#attribute.type == 'Text'">
			<!-- ############# ATTRIBUTO TESTO SEMPLICE MULTILINGUA ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/textAttribute.jsp" />
			</p>
			</s:elseif>

			<s:elseif test="#attribute.type == 'Longtext'">
			<!-- ############# ATTRIBUTO TESTOLUNGO ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/longtextAttribute.jsp" />
			</p>
			</s:elseif>

			<s:elseif test="#attribute.type == 'Hypertext'">
			<!-- ############# ATTRIBUTO HYPERTEXT ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/hypertextAttribute.jsp" />
			</p>
			</s:elseif>

			<s:elseif test="#attribute.type == 'Image'">
			<!-- ############# ATTRIBUTO Image ############# -->
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/imageAttribute.jsp" />
			</p>
			</s:elseif>

			<s:elseif test="#attribute.type == 'Attach'">
			<!-- ############# ATTRIBUTO Attach ############# -->
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/attachAttribute.jsp" />
			</p>
			</s:elseif>

			<s:elseif test="#attribute.type == 'CheckBox'">
			<!-- ############# ATTRIBUTO CheckBox ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/checkBoxAttribute.jsp" />
			</p>
			</s:elseif>

			<s:elseif test="#attribute.type == 'Boolean'">
			<!-- ############# ATTRIBUTO Boolean ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/booleanAttribute.jsp" />
			</p>
			</s:elseif>

			<s:elseif test="#attribute.type == 'ThreeState'">
			<!-- ############# ATTRIBUTO ThreeState ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/threeStateAttribute.jsp" />
			</p>
			</s:elseif>

			<s:elseif test="#attribute.type == 'Number'">
			<!-- ############# ATTRIBUTO Number ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/numberAttribute.jsp" />
			</p>
			</s:elseif>

			<s:elseif test="#attribute.type == 'Date'">
			<!-- ############# ATTRIBUTO Date ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/dateAttribute.jsp" />
			</p>
			</s:elseif>

			<s:elseif test="#attribute.type == 'Link'">
			<!-- ############# ATTRIBUTO Link ############# -->
			<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/modules/linkAttribute.jsp" />
			</p>
			</s:elseif>

			<s:elseif test="#attribute.type == 'Enumerator'">
			<!-- ############# ATTRIBUTO TESTO Enumerator ############# -->
			<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/enumeratorAttribute.jsp" />
			</p>
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
			</p>
			</s:elseif>


			</div>
		</s:iterator>
		<%-- END CICLO ATTRIBUTI --%>
		</fieldset>

		<p class="centerText">
			<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" action="save" />
		</p>

	</s:form>
</div>