<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>

<div class="row margin-large-vertical">
	<div class="input-group col-12 col-sm-3 margin-small-vertical">
		<label for="status" class="noscreen"><s:text name="label.state" /></label>
		<s:select name="status" id="status" list="avalaibleStatus" value="%{content.status}" listKey="key" listValue="%{getText(value)}" cssClass="form-control" />
		<span class="input-group-btn">
			<s:submit action="save" type="button" cssClass="btn btn-default" title="%{getText('note.button.saveContent')}">
				<span class="icon icon-save"></span>
			</s:submit>
		</span>
	</div>

<wp:ifauthorized permission="validateContents">
	<div class="col-12 col-sm-4 margin-small-vertical">
		<s:submit action="saveAndApprove" type="button" cssClass="btn btn-success btn-block" title="%{getText('note.button.saveAndApprove')}" >
			<span class="icon icon-ok"></span>&#32;
			<s:text name="label.saveAndApprove" />
		</s:submit>
	</div>
	<div class="col-12 col-sm-4 margin-small-vertical">
		<s:submit action="saveAndContinue" type="button" cssClass="btn btn-success btn-block" title="%{getText('note.button.saveAndContinue')}" >
			<span class="icon icon-ok"></span>&#32;
			<s:text name="label.saveAndContinue" />
		</s:submit>
	</div>
	<s:if test="content.onLine">
		<div class="col-12 col-sm-4 margin-small-vertical">
			<s:submit action="suspend" type="button" cssClass="btn btn-warning btn-block" title="%{getText('note.button.suspend')}">
				<span class="icon icon-pause"></span>&#32;
				<s:text name="label.suspend" />
			</s:submit>
		</div>
	</s:if>
</wp:ifauthorized>
</div>
