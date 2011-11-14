<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/aps-core" prefix="wp" %>

<s:set var="targetNS" value="%{'/do/User'}" />
<h1><s:text name="title.userManagement" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

<div id="main">

<h2><s:text name="title.userManagement.userAuthorizations" /></h2>

<p class="margin-more-bottom">
	<s:text name="note.userAuthorizations.intro" />&#32;<strong><s:property value="userAuthsFormBean.username"/></strong>, <s:text name="note.userAuthorizations.youCan" />&#32;<a href="#groups"><s:text name="note.userAuthorizations.configureGroups" /></a>&#32;<s:text name="label.or" />&#32;<a href="#roles"><s:text name="note.userAuthorizations.configureRoles" /></a>.
</p>

<s:set name="addIcon" id="addIcon"><wp:resourceURL/>administration/common/img/icons/list-add.png</s:set>
<s:set name="removeIcon" id="removeIcon"><wp:resourceURL/>administration/common/img/icons/list-remove.png</s:set>
	
<s:form action="save">
<p class="noscreen">
	<wpsf:hidden name="username" value="%{getUserAuthsFormBean().getUsername()}"/>
</p>

<fieldset id="groups"><legend><s:text name="note.userAuthorizations.chooseGroup" /></legend>
<p class="important"><s:text name="note.userAuthorizations.groupList" />:</p>
<s:if test="%{getUserAuthsFormBean().getGroups().size() > 0}">
	<ul>
	<s:iterator id="group" value="userAuthsFormBean.groups">
		<li>
			<wpsa:actionParam action="removeGroup" var="actionName" >
				<wpsa:actionSubParam name="groupName" value="%{#group.name}" />
			</wpsa:actionParam>
			<wpsf:submit useTabindexAutoIncrement="true" action="%{#actionName}" type="image" src="%{#removeIcon}" value="%{getText('label.remove')}" title="%{getText('label.remove')}" />: <s:property value="descr" /> 
		</li>
	</s:iterator>
	</ul>
</s:if>
<p>
	<label for="groupName" class="basic-mint-label"><s:text name="label.group" />:</label>
	<wpsf:select useTabindexAutoIncrement="true" name="groupName" id="groupName" list="groups" listKey="name" listValue="descr" cssClass="text" />
	<wpsf:submit useTabindexAutoIncrement="true" action="addGroup" type="image" src="%{#addIcon}" value="%{getText('label.add')}" title="%{getText('label.add')}" />
</p>
</fieldset>

<fieldset id="roles"><legend><s:text name="note.userAuthorizations.chooseRole" /></legend>
<p class="important"><s:text name="note.userAuthorizations.roleList" />:</p>
<s:if test="%{getUserAuthsFormBean().getRoles().size() > 0}">
	<ul>
	<s:iterator id="role" value="userAuthsFormBean.roles">
		<li>
			<wpsa:actionParam action="removeRole" var="actionName" >
				<wpsa:actionSubParam name="roleName" value="%{#role.name}" />
			</wpsa:actionParam>
			<wpsf:submit useTabindexAutoIncrement="true" action="%{#actionName}" type="image" src="%{#removeIcon}" value="%{getText('label.remove')}" title="%{getText('label.remove')}" />: <s:property value="description" /> 
		</li>
	</s:iterator>
	</ul>
</s:if>
<p>
	<label for="roleName" class="basic-mint-label"><s:text name="name.role" />:</label>
	<wpsf:select useTabindexAutoIncrement="true" name="roleName" id="roleName" list="roles" listKey="name" listValue="description" cssClass="text" />
	<wpsf:submit useTabindexAutoIncrement="true" action="addRole" type="image" src="%{#addIcon}" value="%{getText('label.add')}" title="%{getText('label.add')}" />
</p>
</fieldset>

<p class="centerText">	
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" />
</p>	
</s:form>

</div>