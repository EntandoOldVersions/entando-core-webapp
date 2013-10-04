<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>

<s:if test="#group.size > #group.max">

<ul class="pagination">
	<s:if test="null != #group.pagerId">
		<s:set var="pagerIdMarker" value="#group.pagerId" />
	</s:if>
	<s:else>
		<s:set var="pagerIdMarker">pagerItem</s:set>
	</s:else>

	<s:if test="#group.advanced">
	<li>
		<s:submit name="%{#pagerIdMarker + '_1'}" type="button" disabled="%{1 == #group.currItem}" title="%{getText('label.goToFirst')}">
			<span class="icon icon-step-backward"></span>
		</s:submit>
	</li>
	<li>
		<s:submit name="%{#pagerIdMarker + '_' + (#group.currItem - #group.offset) }" type="button" disabled="%{1 == #group.beginItemAnchor}" title="%{getText('label.jump') + ' ' + #group.offset + ' ' + getText('label.backward')}">
			<span class="icon icon-fast-backward"></span>
		</s:submit>
	</li>
	</s:if>

	<li>
		<s:submit name="%{#pagerIdMarker + '_' + #group.prevItem}" type="button" title="%{getText('label.prev.full')}" disabled="%{1 == #group.currItem}">
			<span class="icon icon-long-arrow-left"></span>
		</s:submit>
	</li>

	<s:subset source="#group.items" count="#group.endItemAnchor-#group.beginItemAnchor+1" start="#group.beginItemAnchor-1">
		<s:iterator id="item">
			<li>
				<s:submit name="%{#pagerIdMarker + '_' + #item}" type="button" disabled="%{#item == #group.currItem}">
					<s:property value="%{#item}" />
				</s:submit>
			</li>
		</s:iterator>
	</s:subset>

	<li>
		<s:submit name="%{#pagerIdMarker + '_' + #group.nextItem}" type="button" title="%{getText('label.next.full')}" disabled="%{#group.maxItem == #group.currItem}">
			<span class="icon icon-long-arrow-right"></span>
		</s:submit>
	</li>

	<s:if test="#group.advanced">
	<s:set name="jumpForwardStep" value="#group.currItem + #group.offset"></s:set>
	<li>
		<s:submit name="%{#pagerIdMarker + '_' + (#jumpForwardStep)}" type="button" disabled="%{#group.maxItem == #group.endItemAnchor}" title="%{getText('label.jump') + ' ' + #group.offset + ' ' + getText('label.forward')}">
			<span class="icon icon-fast-forward"></span>
		</s:submit>
	</li>
	<li>
		<s:submit name="%{#pagerIdMarker + '_' + #group.size}" type="button" disabled="%{#group.maxItem == #group.currItem}" title="%{getText('label.goToLast')}">
			<span class="icon icon-step-forward"></span>
		</s:submit>
	</li>
	</s:if>

	<s:set var="pagerIdMarker" value="null" />
</ul>

</s:if>