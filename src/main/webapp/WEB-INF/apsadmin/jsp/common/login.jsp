<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<!DOCTYPE html>

<html lang="en">
<head>

	<title>Entando - Sign in</title>

	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<link rel="stylesheet" href="<wp:resourceURL />administration/bootstrap/css/bootstrap.min.css" media="screen" />

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="<wp:resourceURL />administration/js/html5shiv.js"></script>
		<script src="<wp:resourceURL />administration/js/respond.min.js"></script>
	<![endif]-->

	<script src="<wp:resourceURL />administration/js/jquery-1.9.1.min.js"></script>
	<script>
		$(function(){
			document.getElementById('username').focus();
		});
	</script>

</head>
<body>

<div class="container">

	<div class="row">
		<div class="col-sm-6 col-offset-3">

			<h1 class="margin-base-top padding-small-top margin-small-bottom text-center">LOGO</h1>

			<s:form action="doLogin" cssClass="padding-base-vertical">

			<s:if test="hasActionErrors()">
			<div class="alert alert-danger">
				<button type="button" class="close" data-dismiss="alert">&times;</button>

				<s:if test="hasActionErrors()">
				<h2><s:text name="message.title.ActionErrors" /></h2>
				<ul class="list-unstyled">
					<s:iterator value="actionErrors">
					<li><s:property /></li>
					</s:iterator>
				</ul>
				</s:if>
			</div>
			</s:if>

	 		<s:if test="#session.currentUser != null && #session.currentUser.username != 'guest'">

				<h2 class="text-center margin-base-bottom"><s:text name="note.userbar.welcome"/>&#32;<s:property value="#session.currentUser" />!</h2>

				<s:if test="!#session.currentUser.credentialsNotExpired">

					<div class="alert alert-warning alert-block">
						<strong><s:text name="note.login.expiredPassword.intro" /></strong><br />
						<div class="text-center margin-base-top">
							<a href="<s:url action="editPassword" />" class="btn btn-large btn-warning">
								<s:text name="note.login.expiredPassword.outro" />
							</a>
						</div>
					</div>

				</s:if>

			<s:else>
			<wp:ifauthorized permission="enterBackend" var="checkEnterBackend" />

			<c:choose>
				<c:when test="${checkEnterBackend}">

				<div class="alert alert-info alert-block">
					<strong><s:text name="note.login.yetLogged" /></strong><br />
					<div class="text-center margin-base-top">
						<div class="btn-group btn-group-justified">
							<a href="<s:url action="main" />" class="btn btn-primary">
								<s:text name="note.goToMain" />
							</a>
							<a href="<s:url action="logout" namespace="/do" />" class="btn btn-danger">
								<s:text name="menu.exit"/>
							</a>
						</div>
					</div>
				</div>
				</c:when>
				<c:otherwise>

				<div class="alert alert-danger alert-block">
					<strong><s:text name="note.login.notAllowed" /></strong><br />
					<div class="text-center margin-base-top">
						<a href="<s:url action="logout" namespace="/do" />" class="btn btn-large btn-danger">
							<s:text name="menu.exit"/>
						</a>
					</div>
				</div>

				</c:otherwise>
			</c:choose>

			</s:else>

			</div>
			</s:if>

			<s:else>

				<s:set var="usernameFieldErrorsVar" value="%{fieldErrors['username']}" />
				<s:set var="usernameHasFieldErrorVar" value="#usernameFieldErrorsVar != null && !#usernameFieldErrorsVar.isEmpty()" />
				<s:set var="controlGroupErrorClassVar" value="''" />

				<s:if test="#usernameHasFieldErrorVar">
					<s:set var="controlGroupErrorClassVar" value="' has-error'" />
				</s:if>

				<div class="margin-base-vertical form-group<s:property value="controlGroupErrorClassVar" />">
					<label for="username" class="sr-only"><s:text name="label.username" /></label>
					<div class="input-group">
						<div class="input-group-addon"><span class="icon icon-user"></span></div>
						<s:textfield name="username" id="username" cssClass="form-control input-large" placeholder="%{getText('label.username')}" />
					</div>
					<s:if test="#usernameHasFieldErrorVar">
						<p class="text-danger padding-small-vertical"><s:iterator value="#usernameFieldErrorsVar"><s:property /> </s:iterator></p>
					</s:if>
				</div>

				<s:set var="passwordFieldErrorsVar" value="%{fieldErrors['password']}" />
				<s:set var="passwordHasFieldErrorVar" value="#passwordFieldErrorsVar != null && !#passwordFieldErrorsVar.isEmpty()" />
				<s:set var="controlGroupErrorClassVar" value="''" />

				<s:if test="#passwordHasFieldErrorVar">
					<s:set var="controlGroupErrorClassVar" value="' has-error'" />
				</s:if>

				<div class="margin-base-vertical form-group<s:property value="controlGroupErrorClassVar" />">
					<label for="password" class="sr-only"><s:text name="label.password" /></label>
					<div class="input-group">
						<div class="input-group-addon"><span class="icon icon-lock"></span></div>
						<s:password name="password" id="password" cssClass="form-control input-large" placeholder="%{getText('label.password')}" />
					</div>
					<s:if test="#passwordHasFieldErrorVar">
						<p class="text-danger padding-small-vertical"><s:iterator value="#passwordFieldErrorsVar"><s:property /> </s:iterator></p>
					</s:if>
				</div>

				<div class="text-center margin-base-vertical">
					<div class="btn-group" data-toggle="buttons">
						<label class="btn btn-default active">
							<input type="radio" name="request_locale" value="en" checked="checked" /> English
						</label>
						<label class="btn btn-default">
							<input type="radio" name="request_locale" value="it" /> Italiano
						</label>
					</div>
				</div>

				<div class="row">
					<p class="padding-base-top col-sm-8 col-offset-2">
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