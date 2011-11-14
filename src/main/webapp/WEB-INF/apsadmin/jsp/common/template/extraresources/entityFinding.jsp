<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<s:include value="/WEB-INF/apsadmin/jsp/common/template/defaultExtraResources.jsp" />

<!-- for Date Attribute filters -->
<script type="text/javascript" src="<wp:resourceURL />administration/js/calendar_wiz.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="<wp:resourceURL />administration/css/calendar.css" />
<!--[if gte IE 7]>
	<link rel="stylesheet" type="text/css" media="screen" href="<wp:resourceURL />administration/css/calendar_ie.css" />
<![endif]-->
	
<script type="text/javascript">
<!--//--><![CDATA[//><!--

//start Date Attribute filters Block
<s:set var="searcheableAttributes" value="searcheableAttributes" ></s:set>
<s:if test="null != #searcheableAttributes && #searcheableAttributes.size() > 0">
<s:iterator var="attribute" value="#searcheableAttributes">
<s:set var="currentFieldId">entityFinding_<s:property value="#attribute.name" /></s:set> 

<s:if test="#attribute.type == 'Date'">
	
	window.addEvent('domready', function() { myCal_<s:property value="#currentFieldId" />_dateStartFieldName = new Calendar({ <s:property value="#currentFieldId" />_dateStartFieldName: 'd/m/Y' }, { 
		navigation: 1, 
		months: ['<s:text name="calendar.month.gen" />','<s:text name="calendar.month.feb" />','<s:text name="calendar.month.mar" />','<s:text name="calendar.month.apr" />','<s:text name="calendar.month.may" />','<s:text name="calendar.month.jun" />','<s:text name="calendar.month.jul" />','<s:text name="calendar.month.aug" />','<s:text name="calendar.month.sep" />','<s:text name="calendar.month.oct" />','<s:text name="calendar.month.nov" />','<s:text name="calendar.month.dec" />'],
		days: ['<s:text name="calendar.week.sun" />','<s:text name="calendar.week.mon" />','<s:text name="calendar.week.tue" />','<s:text name="calendar.week.wen" />','<s:text name="calendar.week.thu" />','<s:text name="calendar.week.fri" />','<s:text name="calendar.week.sat" />'],
		calendarTitle: "<s:text name="calendar.button.title" />",
		prevText: "<s:text name="calendar.label.prevText" />",
		nextText: "<s:text name="calendar.label.nextText" />",
		introText: "<s:text name="calendar.label.introText" />"
	});});
	
	window.addEvent('domready', function() { myCal_<s:property value="#currentFieldId" />_dateEndFieldName = new Calendar({ <s:property value="#currentFieldId" />_dateEndFieldName: 'd/m/Y' }, { 
			navigation: 1, 
			months: ['<s:text name="calendar.month.gen" />','<s:text name="calendar.month.feb" />','<s:text name="calendar.month.mar" />','<s:text name="calendar.month.apr" />','<s:text name="calendar.month.may" />','<s:text name="calendar.month.jun" />','<s:text name="calendar.month.jul" />','<s:text name="calendar.month.aug" />','<s:text name="calendar.month.sep" />','<s:text name="calendar.month.oct" />','<s:text name="calendar.month.nov" />','<s:text name="calendar.month.dec" />'],
			days: ['<s:text name="calendar.week.sun" />','<s:text name="calendar.week.mon" />','<s:text name="calendar.week.tue" />','<s:text name="calendar.week.wen" />','<s:text name="calendar.week.thu" />','<s:text name="calendar.week.fri" />','<s:text name="calendar.week.sat" />'],
			calendarTitle: "<s:text name="calendar.button.title" />",
			prevText: "<s:text name="calendar.label.prevText" />",
			nextText: "<s:text name="calendar.label.nextText" />",
			introText: "<s:text name="calendar.label.introText" />"
		});});
	
</s:if>

</s:iterator>

</s:if>
//end Date Attribute filters Block

//--><!]]></script>