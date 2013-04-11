<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<s:if test="#attribute.failedHourString == null">
<s:set name="hourAttributeValue" value="#attribute.getFormattedDate('HH')"></s:set>
</s:if>
<s:else>
<s:set name="hourAttributeValue" value="#attribute.failedHourString"></s:set>
</s:else>
<%-- hour HH --%>
<wpsf:select id="%{#attributeTracer.getFormFieldName(#attribute) + '_hour'}" 
		name="%{#attributeTracer.getFormFieldName(#attribute) + '_hour'}" value="%{#hourAttributeValue}" 
		list='#{"00":"00","01":"01","02":"02", "03":"03","04":"04","05":"05","06":"06","07":"07","08":"08","09":"09","10":"10",
				 "11":"11","12":"12", "13":"13","14":"14","15":"15","16":"16","17":"17","18":"18","19":"19","20":"20",
				 "21":"21","22":"22","23":"23"}' cssClass="text" />
<%-- minute mm --%>
<s:set var="range059" value="#{'00':'00','01':'01','02':'02','03':'03','04':'04','05':'05','06':'06','07':'07','08':'08','09':'09',
'10':'10','11':'11','12':'12','13':'13','14':'14','15':'15','16':'16','17':'17','18':'18','19':'19',
'20':'20','21':'21','22':'22','23':'23','24':'24','25':'25','26':'26','27':'27','28':'28','29':'29',
'30':'30','31':'31','32':'32','33':'33','34':'34','35':'35','36':'36','37':'37','38':'38','39':'39',
'40':'40','41':'41','42':'42','43':'43','44':'44','45':'45','46':'46','47':'47','48':'48','49':'49',
'50':'50','51':'51','52':'52','53':'53','54':'54','55':'55','56':'56','57':'57','58':'58','59':'59'}" />
<s:if test="#attribute.failedMinuteString == null">
<s:set name="minuteAttributeValue" value="#attribute.getFormattedDate('mm')"></s:set>
</s:if>
<s:else>
<s:set name="minuteAttributeValue" value="#attribute.failedMinuteString"></s:set>
</s:else>
<wpsf:select id="%{#attributeTracer.getFormFieldName(#attribute) + '_minute'}" 
		name="%{#attributeTracer.getFormFieldName(#attribute) + '_minute'}" value="%{#minuteAttributeValue}" 
		list='#range059' cssClass="text" />
<%-- second ss --%>
<s:if test="#attribute.failedSecondString == null">
<s:set name="secondAttributeValue" value="#attribute.getFormattedDate('ss')"></s:set>
</s:if>
<s:else>
<s:set name="secondAttributeValue" value="#attribute.failedSecondString"></s:set>
</s:else>
<wpsf:select id="%{#attributeTracer.getFormFieldName(#attribute) + '_second'}" 
		name="%{#attributeTracer.getFormFieldName(#attribute) + '_second'}" value="%{#secondAttributeValue}" 
		list='#range059' cssClass="text" />
