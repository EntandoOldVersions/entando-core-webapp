<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<s:include value="/WEB-INF/apsadmin/jsp/common/template/defaultExtraResources.jsp" />
<s:include value="/WEB-INF/apsadmin/jsp/common/template/extraresources/inc/snippet-calendar.jsp" />

<s:set var="categoryTreeStyleVar" ><wp:info key="systemParam" paramName="treeStyle_category" /></s:set>

<script type="text/javascript">
<!--//--><![CDATA[//><!--

<s:if test="#categoryTreeStyleVar == 'classic'">
//per categorie
window.addEvent('domready', function(){
	var catTree  = new Wood({
		menuToggler: "subTreeToggler",
		rootId: "categoryTree",
		openClass: "node_open",
		closedClass: "node_closed",
		showTools: "true",
		expandAllLabel: "<s:text name="label.expandAll" />",
		collapseAllLabel: "<s:text name="label.collapseAll" />",
		type: "tree",
		<s:if test="%{categoryCode != null && !(categoryCode.equalsIgnoreCase(''))}">
		startIndex: "fagianonode_<s:property value="categoryCode" />",
		</s:if>
		toolTextIntro: "<s:text name="label.introExpandAll" />",
		toolexpandAllLabelTitle: "<s:text name="label.expandAllTitle" />",
		toolcollapseLabelTitle: "<s:text name="label.collapseAllTitle" />"			
	});
});
</s:if>

<s:if test="#myClient == 'advanced'">
	
	var TableToolbar = new Class({
		Implements: [Events, Options],
		options: { 
			"duration": 1500,
			"size": {
				x: 16,
				y: 16
			},
			rowInputSelector: "[name=contentIds]",
			otherButtonsContainerSelector: "p.buttons",
			injectPosition: "after",
			css: {
				toolbarClass: "contentListToolbar",
				reset: "reset",
				highlight: "highlight",
				current: "current"
			}
			//onOpen: function(tr) { console.log("open",tr); },
			//onClose: function(tr) { console.log("closed",tr); }
		},
		initialize: function(tableid, options) {
			if (document.id(tableid) != null) {
				this.toolbar =  null;
				this.anchor =  null;
				this.actions =  null; 
				this.stack = [];
				this.setOptions(options);
				this._setTable(tableid);
			}
		},
		_setupSingleActions: function(actions) {
			for (var i = 0; i < actions.length; i++) {
				var item = actions[i];
				item.getElement("img").setProperty("width", this.options.size.x);
				item.getElement("img").setProperty("height", this.options.size.y);
				item.addClass("noborder");
			}
		},
		updateToolbarActions: function(actions) {
			var oldText = this.singleActionContainer.getFirst("span").clone();
			this.singleActionContainer.empty();
			oldText.inject(this.singleActionContainer);
			for (var i = 0;i<actions.length;i++) {
				actions[i].inject(this.singleActionContainer);
			}
		},
		makeToolbar: function(anchor) {
			///settaggio parametri
				if (this.table.getElement(anchor) && anchor != this.toolbar) {
					
					//get the current checkbox
						var checkbox = anchor.getElement(this.options.rowInputSelector);
					//change its status
						if (checkbox.getProperty("checked")) { checkbox.removeProperty("checked"); }
						else { checkbox.setProperty("checked",true); }
					
					//retrieve current contentId
						var contentId = checkbox.get("value");
					
					//animation set	
						anchor.set('morph', { duration: 'short' });
						this.toolbar.getElement("td").set('tween', {duration: "short"});
					
					//remove the old one marker
						var oldCurrent = this.table.getElement("."+this.options.css.current);
						if (null != oldCurrent){
							this.table.getElement("."+this.options.css.current).removeClass(this.options.css.current);
						}
					
					/** do **/
					//if it's true
						if (checkbox.getProperty("checked")) {
							//add the anchor to the stack
								this.stack.include(anchor);
							//change css properties
								anchor.removeClass(this.options.css.reset);
								anchor.addClass(this.options.css.highlight);
								anchor.addClass(this.options.css.current);
						}
					//if it's false
						else {
							//remove the anchor from the stack
								this.stack.erase(anchor);
							//change css properties
								anchor.removeClass(this.options.css.highlight);
								anchor.addClass(this.options.css.reset);
						}
					//evaluate the modified stack.
						//if it's NOT empty 
						if (this.stack.length > 0) {
							//put the toolbar after the last item
								var lastAnchor = this.stack.getLast();
							//update actions for the current anchor
								var actions = lastAnchor.retrieve("actions");
								var isFirstUse = lastAnchor.retrieve("actionsFirstUse");
								if (isFirstUse) {
									this._setupSingleActions(actions);
									lastAnchor.store("actionsFirstUse",false);
								}
								this.updateToolbarActions(actions);
							//inject the toolbar
								this.toolbar.inject(lastAnchor, this.options.injectPosition);
							//add the "current" marker
								lastAnchor.addClass(this.options.css.current); 

							//then show it	
								this.toolbar.getElement("td").fade('in');
							//fire the open event
								this.fireEvent("open",anchor);
						}
						//if it's empty
						else {
							//close it
								this.toolbar.getElement("td").fade('out');
								this.toolbar.dispose();
							//fire the close event
							this.fireEvent("close",anchor);
						}
					//final setting
						this.anchor = anchor;
				}
		},
		_setTable: function(tableid) {
			this.table = document.id(tableid);
			if (null != this.table) {
				this.table.getElements("input[type=checkbox]").setStyles({
					'position': 'absolute',
					'left': '-9999px'
				});
				this.table.getElements("label").setStyles({
					display: "block"
					//sarebbe bello... che la label sia "block" alta come la riga della tabella.
				});
			
				//get all the rows
					var rows = this.table.getElements("tr");
				
				//if any...
					if (rows.length>0) {
					//remove the action header
						rows[0].getElements("th")[0].dispose();
					
					//discover what's the colspan
						var tds = rows[1].getElements("td");
						var colspan = (tds.length-1);

					//prepare the toolbar
						this._setupToolbar(colspan);
						
					//for each row: store the contentId, remove the unnecessary cell, add the events
						for (var i = 1;i<rows.length;i++) {
							var tr = rows[i];
							var td = tr.getElement("td");
							//retieve the actions
								var rowAction = [];
								td.getChildren().each(function(item){
									rowAction.include(item.clone());
								});
							//store in the row
								tr.store("actions",rowAction);
								tr.store("actionsFirstUse",true);
								td.destroy();
						}
						this.table.addEvents({
							"click:relay(tr)": function(ev) {
								this.makeToolbar(ev.target.getParent("tr"));
							}.bind(this)
						});
					}
			}
		},
		_setupToolbar: function(colspan,actions) {
			//new row element
				this.toolbar = new Element("tr",{
					"class": this.options.css.toolbarClass
				});
			
			//toolbar cell	
				var toolbartd = new Element("td",{
					colspan: colspan,
					styles: {
						"opacity": 0
					}
				}).inject(this.toolbar);
				
				this.singleActionContainer = new Element("div",{
					"class": "singleActions"
				}).inject(toolbartd);
			 
			 	new Element("span",{text: "<s:text name="note.actions.itemList.thisOnly" />"}).inject(this.singleActionContainer);
			 	//new Element("br").inject(this.singleActionContainer);
			 	
			 	
			 	
			//setting actions to the class
				/*
				this.actions = actions;
				this.actions.each(function(item){ item.inject(this.singleActionContainer); });
				*/
				
			//retrieving other actions buttons...
				var otherButtons = document.getElement(this.options.otherButtonsContainerSelector).getChildren();
				if (null != otherButtons) {
					document.getElement(this.options.otherButtonsContainerSelector).getParent().dispose();
					
					var toolbardivOther = new Element("div",{
						"class": "multipleActions"
					}).inject(toolbartd);
					
					new Element("span",{text: "<s:text name="note.actions.itemList.selection" />"}).inject(toolbardivOther);
			 		//new Element("br").inject(toolbardivOther);
					
					otherButtons.each(function(item){
						var clone = item.clone(); 
						clone.inject(toolbardivOther);
						clone.setProperty("width", this.options.size.x);
						clone.setProperty("height", this.options.size.y);
						clone.setStyles({
							width: this.options.size.x+"px",
							height: this.options.size.y+"px" 
						});
					}.bind(this));
				}
		}
	});

	window.addEvent("domready", function(){
		new TableToolbar("contentListTable",{
			"duration": 1500,
			"size": {
				x: 16,
				y: 16
			},
			rowInputSelector: "[name=contentIds]",
			otherButtonsContainerSelector: "p.buttons",
			css: {
				toolbarClass: "contentListToolbar",
				reset: "reset",
				highlight: "highlight"
			} 
			//onOpen: function(tr) { console.log("open",tr); },
			//onClose: function(tr) { console.log("closed",tr); }
		});
	});
</s:if>

<s:if test="null != actionCode">
window.addEvent("load",function(){
		var scroll = new Fx.Scroll(window, {duration: 125});
		scroll.toElement('content_list-<s:property value="actionCode" />');
});
</s:if>

	//--><!]]>
	</script>