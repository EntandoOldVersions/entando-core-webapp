<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="viewTree" namespace="/do/Category" />" 
		title="<s:text name="note.goToSomewhere" />: <s:text name="title.categoryManagement" />">
		<s:text name="title.categoryManagement" />
		</a>
		&#32;/&#32;
		<s:if test="strutsAction == 1">
			<s:text name="title.newCategory" />
		</s:if>
		<s:elseif test="strutsAction == 2">
			<s:text name="title.editCategory" />
		</s:elseif>
	</span>
</h1>
<div id="main">
	<s:if test="strutsAction == 2"><s:set var="breadcrumbs_pivotCategoryCode" value="categoryCode" /></s:if>
	<s:else><s:set var="breadcrumbs_pivotCategoryCode" value="parentCategoryCode" /></s:else>
	<s:include value="/WEB-INF/apsadmin/jsp/category/include/categoryInfo_breadcrumbs.jsp" />

	<s:form action="save" cssClass="form-horizontal">
		<s:if test="hasFieldErrors()">
			<div class="alert alert-danger alert-dismissable fade in">
				<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
				<h2 class="h4 margin-none"><s:text name="message.title.FieldErrors" /></h2>
					<ul class="margin-base-top">
						<s:iterator value="fieldErrors">
							<s:iterator value="value">
								<li><s:property escape="false" /></li>
							</s:iterator>
						</s:iterator>
					</ul>
			</div>
		</s:if>

		<p class="sr-only">
			<wpsf:hidden name="strutsAction" />
			<s:if test="getStrutsAction() == 2"><wpsf:hidden name="categoryCode" /></s:if>
			<wpsf:hidden name="parentCategoryCode" />
		</p>

		<div class="form-group">
			<label class="control-label col-lg-3 col-md-3" for="categoryCode"><s:text name="name.categoryCode" /></label>
			<div class="col-md-9 col-lg-9">
				<s:textfield name="categoryCode" id="categoryCode" disabled="%{getStrutsAction() == 2}" cssClass="form-control" />
				<s:if test="getStrutsAction() != 2">
					<s:hidden name="selectedNode" value="%{parentCategoryCode}" />
				</s:if>
				<s:elseif test="getStrutsAction() == 2">
					<s:hidden name="selectedNode" value="%{categoryCode}" />
				</s:elseif>
			</div>
		</div>

		<s:iterator value="langs">
			<div class="form-group">
				<label class="control-label col-lg-3 col-md-3" for="lang<s:property value="code" />">
					<span class="label label-info">
						<s:property value="code" />
					</span>&#32;
					<s:text name="name.categoryTitle" />
				</label>
				<div class="col-md-9 col-lg-9">
					<s:textfield name="%{'lang'+code}" id="%{'lang'+code}" value="%{titles.get(code)}" cssClass="form-control" />
				</div>
			</div>
		</s:iterator>
		<div class="form-group">
			<div class="col-offset-md-3 col-offset-lg-3 col-md-9 col-lg-9">
				<s:submit type="button" cssClass="btn btn-primary">
					<s:tex name="label.save" />
				</s:submit>
			</div>
		</div>
	</s:form>
</div>