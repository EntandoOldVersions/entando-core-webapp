<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<div class="panel panel-default">
	<div class="panel-body">
		<div class="form-group">
			<label for="attributeTypeCode" class="control-label"><s:text name="label.type" /></label>
			<div class="input-group">
			<s:select id="attributeTypeCode" list="attributeTypes" name="attributeTypeCode" 
				listKey="type" listValue="type" cssClass="form-control" />
				<span class="input-group-btn">
					<s:submit type="button" action="addAttribute" cssClass="btn btn-default" value="%{getText('label.add')}"/>
				</span>
			</div>
		</div>
	</div>
</div>
