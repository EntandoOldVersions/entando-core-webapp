<%@ taglib prefix="s" uri="/struts-tags" %>

<s:form action="search" cssClass="form-horizontal">

	<div class="form-group">
		<label for="pageCodeToken" class="sr-only"><s:text name="label.search.by"/>&#32;<s:text name="name.pageCode"/></label>
		<div class="input-group col-sm-12">
			<span class="input-group-addon">
				<span class="icon icon-file-text-alt icon-large"></span>
			</span>
			<s:textfield name="pageCodeToken" id="pageCodeToken" value="%{pageCodeToken}" cssClass="form-control input-lg" placeholder="%{getText('label.pageCode')}" />
			<div class="input-group-btn">
				<s:submit type="button" cssClass="btn btn-primary btn-lg">
					<span class="icon icon-search" title="<s:text name="label.search" />"></span>
				</s:submit>
			</div>
		</div>
	</div>

</s:form>

