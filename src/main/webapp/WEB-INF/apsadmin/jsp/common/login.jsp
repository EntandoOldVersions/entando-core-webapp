<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<!DOCTYPE html>

<html lang="en">
<head>

	<title>Entando - Sign in</title>

	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<link rel="stylesheet" href="<wp:resourceURL />administration/bootstrap/css/bootstrap.min.css" media="screen" />

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="<wp:resourceURL />administration/js/html5shiv.js"></script>
  <script src="<wp:resourceURL />administration/js/respond.min.js"></script>
<![endif]-->

</head>
<body>

<div class="container">

	<div class="row">
		<div class="col-lg-4 col-offset-4">

			<h1 class="margin-base-top padding-small-top margin-small-bottom text-center">LOGO</h1>

			<s:form action="doLogin">

			<s:if test="hasActionErrors()">
			<div class="alert alert-danger">
				<button type="button" class="close" data-dismiss="alert">&times;</button>

				<s:if test="hasActionErrors()">
				<h2 class="alert-heading"><s:text name="message.title.ActionErrors" /></h2>
				<ul class="list-unstyled">
					<s:iterator value="actionErrors">
					<li><s:property /></li>
					</s:iterator>
				</ul>
				</s:if>
			</div>
			</s:if>

	 		<s:if test="#session.currentUser != null && #session.currentUser.username != 'guest'">
			<div class="whiteBox">
			<p>
				<em><s:text name="note.userbar.welcome"/></em>,
				<strong> <s:property value="#session.currentUser" /></strong>!
			</p>

			<%--
			<s:if test="!#session.currentUser.accountNotExpired && #session.currentUser.username != 'admin'">
			<p>
				<s:text name="note.login.expiredAccount" />.
			</p>
			</s:if>
			--%>

			<s:if test="!#session.currentUser.credentialsNotExpired">
			<p>
				<s:text name="note.login.expiredPassword.intro" />&#32;<a href="<s:url action="editPassword" />" ><s:text name="note.login.expiredPassword.outro" /></a>.
			</p>
			</s:if>

			<s:else>
			<wp:ifauthorized permission="enterBackend" var="checkEnterBackend" />

			<c:choose>
				<c:when test="${checkEnterBackend}">
				<p>
					<s:text name="note.login.yetLogged" />,<br />
					<a href="<s:url action="main" />" ><s:text name="note.goToMain" /></a> | <a href="<s:url action="logout" namespace="/do" />" ><s:text name="menu.exit"/></a>
				</p>
				</c:when>
				<c:otherwise>
				<p>
					<s:text name="note.login.notAllowed" />, <a href="<s:url action="logout" namespace="/do" />" ><s:text name="menu.exit"/></a>
				</p>

				</c:otherwise>
			</c:choose>

			</s:else>

			</div>
			</s:if>

			<s:else>

			<div class="padding-base-vertical">

				<s:set var="usernameFieldErrorsVar" value="%{fieldErrors['username']}" />
				<s:set var="usernameHasFieldErrorVar" value="#usernameFieldErrorsVar != null && !#usernameFieldErrorsVar.isEmpty()" />
				<s:set var="controlGroupErrorClassVar" value="''" />
				<s:set var="inputErrorClassVar" value="''" />

				<s:if test="#usernameHasFieldErrorVar">
					<s:set var="controlGroupErrorClassVar" value="' has-error'" />
					<s:set var="inputErrorClassVar" value="' input-with-feedback'" />
				</s:if>

				<div class="margin-base-vertical control-group<s:property value="controlGroupErrorClassVar" />">
					<div class="controls">
						<label for="username" class="noscreen"><s:text name="label.username" /></label>
						<div class="input-group">
							<div class="input-group-addon"><span class="glyphicon glyphicon-user"></span></div>
							<s:textfield name="username" id="username" cssClass="%{'input-large' + #inputErrorClassVar}" placeholder="%{getText('label.username')}" />
						</div>
					</div>
					<s:if test="#usernameHasFieldErrorVar">
						<p class="text-danger padding-small-vertical"><s:iterator value="#usernameFieldErrorsVar"><s:property /> </s:iterator></p>
					</s:if>
				</div>

				<s:set var="passwordFieldErrorsVar" value="%{fieldErrors['password']}" />
				<s:set var="passwordHasFieldErrorVar" value="#passwordFieldErrorsVar != null && !#passwordFieldErrorsVar.isEmpty()" />
				<s:set var="controlGroupErrorClassVar" value="''" />
				<s:set var="inputErrorClassVar" value="''" />

				<s:if test="#passwordHasFieldErrorVar">
					<s:set var="controlGroupErrorClassVar" value="' has-error'" />
					<s:set var="inputErrorClassVar" value="' input-with-feedback'" />
				</s:if>

				<div class="margin-base-vertical control-group<s:property value="controlGroupErrorClassVar" />">
					<div class="controls">
						<label for="password" class="noscreen"><s:text name="label.password" /></label>
						<div class="input-group">
							<div class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></div>
							<s:password name="password" id="password" cssClass="%{'input-large' + #inputErrorClassVar}" placeholder="%{getText('label.password')}" />
						</div>
					</div>
					<s:if test="#passwordHasFieldErrorVar">
						<p class="text-danger padding-small-vertical"><s:iterator value="#passwordFieldErrorsVar"><s:property /> </s:iterator></p>
					</s:if>
				</div>

				<div class="text-center margin-base-vertical">
					<div class="btn-group" data-toggle="buttons-radio">
						<label class="btn btn-default active">
							<input type="radio" name="request_locale" value="en" checked="checked" /> English
						</label>
						<label class="btn btn-default">
							<input type="radio" name="request_locale" value="it" /> Italiano
						</label>
					</div>
				</div>

				<p class="padding-base-top">
						<s:submit cssClass="btn btn-success btn-large btn-block" name="backend_client_gui" value="advanced" />
				</p>

			</div>

			</s:else>
			</s:form>
		</div>
	</div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="<wp:resourceURL />administration/js/jquery-1.9.1.min.js"></script>
<script src="<wp:resourceURL />administration/bootstrap/js/bootstrap.js"></script>

</body>
</html>