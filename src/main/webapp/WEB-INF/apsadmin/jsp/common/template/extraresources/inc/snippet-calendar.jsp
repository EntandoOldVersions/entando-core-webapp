<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<s:if test='#myClient == "normal"'>	
	<link href="<wp:resourceURL />administration/basic/css/calendar.css" rel="stylesheet"  />
	<!--[if IE 7]>
		<link href="<wp:resourceURL />administration/basic/css/calendar_ie7.css" rel="stylesheet"  /> 
	<![endif]-->
	<!--[if IE 8]>
		<link href="<wp:resourceURL />administration/basic/css/calendar_ie8.css" rel="stylesheet"  /> 
	<![endif]-->
</s:if>
<s:elseif test='#myClient == "advanced"'>
	<link href="<wp:resourceURL />administration/mint/css/calendar.css" rel="stylesheet"  />
</s:elseif>

<script type="text/javascript" src="<wp:resourceURL />administration/common/js/calendar_wiz.js"></script>
<script type="text/javascript">
<!--//--><![CDATA[//><!--
	window.addEvent("domready", function() { 
		var calendars = document.getElements("input[id$=_cal]");
		if (calendars != null) {
			var calendarOpts = {
				navigation: 1, 
				months: ["<s:text name="calendar.month.gen" />","<s:text name="calendar.month.feb" />","<s:text name="calendar.month.mar" />","<s:text name="calendar.month.apr" />","<s:text name="calendar.month.may" />","<s:text name="calendar.month.jun" />","<s:text name="calendar.month.jul" />","<s:text name="calendar.month.aug" />","<s:text name="calendar.month.sep" />","<s:text name="calendar.month.oct" />","<s:text name="calendar.month.nov" />","<s:text name="calendar.month.dec" />"],
				days: ["<s:text name="calendar.week.sun" />","<s:text name="calendar.week.mon" />","<s:text name="calendar.week.tue" />","<s:text name="calendar.week.wen" />","<s:text name="calendar.week.thu" />","<s:text name="calendar.week.fri" />","<s:text name="calendar.week.sat" />"],
				prevText: "<s:text name="calendar.label.prevText" />",	//Mese precedente 
				nextText: "<s:text name="calendar.label.nextText" />",	//Mese successivo
				introText: "<s:text name="calendar.label.introText" />"	//Benvenuto nel calendario
			};
			for (var i = 0;i<calendars.length;i++) {
				var istanceSetup = {};
				istanceSetup[calendars[i].get("id")] = "d/m/Y";
				new Calendar(istanceSetup, calendarOpts);
			}
		}
	});
//--><!]]>
</script>