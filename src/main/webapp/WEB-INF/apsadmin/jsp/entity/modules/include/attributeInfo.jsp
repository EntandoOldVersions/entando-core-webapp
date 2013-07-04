<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<s:set var="validationRules" value="#attribute.validationRules" />
<s:set var="hasValidationRulesVar" value="%{#validationRules != null && #validationRules.ognlValidationRule != null&& #validationRules.ognlValidationRule.expression != null}" />
<s:if test="#attribute.required || #attribute.searcheable || #attribute.indexingType != 'NONE' || (#attribute.textAttribute && (#attribute.minLength != -1 || #attribute.maxLength != -1)) || (#hasValidationRulesVar) ">
	<span class="monospace js_noscreen">&#32;[</span><span class="attribute-meta-tip monospace">
	<s:if test="#attribute.required"><abbr title="<s:text name="Entity.attribute.flag.mandatory.full"/>"><s:text name="Entity.attribute.flag.mandatory.short"/></abbr><span class="attribute-meta-tip-info"></span> </s:if>
	<s:if test="#attribute.searcheable"><abbr title="<s:text name="Entity.attribute.flag.searcheable.full"/>"><s:text name="Entity.attribute.flag.searcheable.short"/></abbr><span class="attribute-meta-tip-info"></span> </s:if>
	<s:if test="#attribute.indexingType != 'NONE'"><abbr title="<s:text name="Entity.attribute.flag.indexed.full"/>"><s:text name="Entity.attribute.flag.indexed.short"/></abbr><span class="attribute-meta-tip-info"></span> </s:if>
	<s:if test="#attribute.textAttribute">
		<s:if test="#attribute.minLength != -1">&#32;<abbr title="<s:text name="Entity.attribute.flag.minLength.full" />" ><s:text name="Entity.attribute.flag.minLength.short" /></abbr>:<span class="attribute-meta-tip-info"><s:property value="#attribute.minLength" /></span> </s:if>
		<s:if test="#attribute.maxLength != -1">&#32;<abbr title="<s:text name="Entity.attribute.flag.maxLength.full" />" ><s:text name="Entity.attribute.flag.maxLength.short" /></abbr>:<span class="attribute-meta-tip-info"><s:property value="#attribute.maxLength" /></span> </s:if>
	</s:if>
	
	<s:if test="#hasValidationRulesVar">
		<abbr title="<s:if test="#validationRules.ognlValidationRule.helpMessageKey != null"><s:set var="labelKey" value="#validationRules.ognlValidationRule.helpMessageKey" scope="page" /><s:set var="langCode" value="currentLang.code" scope="page" /><wp:i18n key="${labelKey}" lang="${langCode}" /></s:if><s:else><s:property value="#validationRules.ognlValidationRule.helpMessage" /></s:else>"><s:text name="Entity.attribute.flag.help.short"/></abbr>
		<span class="attribute-meta-tip-info"></span>
	</s:if>
	</span><span class="monospace js_noscreen">]</span></s:if> 

<a id="label" href="#" class="btn btn-default" data-toggle="popover" data-placement="bottom" data-content="Vivamus sagittis lacus vel augue laoreet rutrum faucibus." title="" data-original-title="Popover on bottom">Popover on bottom</a>
