<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>


{
    "action": "1",
    "errors": [],
    "position": 3,

    "shortcut": {
        "actionName": "list",
        "description": "CNT Model List",
        "descriptionKey": "jacms.shortcut.contentModel.list.shortDesc",
        "id": "jacms.contentModel.list",
        "longDescription": "\n\t\t\t\tManage ContentModels: you can edit or delete the ContentModels.\n\t\t\t",
        "longDescriptionKey": "jacms.shortcut.contentModel.list.longDesc",
        "menuSection": {
            "description": "C.M.S",
            "descriptionKey": "jacms.menuSection.shortDesc",
            "id": "cms",
            "longDescription": "Content Management System",
            "longDescriptionKey": "jacms.menuSection.longDesc"
        },
        "menuSectionCode": "cms",
        "namespace": "/do/jacms/ContentModel",
        "parameters": null,
        "requiredPermission": "superuser",
        "source": "jacms"
    }
 
}