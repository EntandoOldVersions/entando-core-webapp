var jAPSShortCuts = new Class({
	Implements: [Events, Options],
	options: {
		ajaxSwapActionUrl: null,
		configureActionUrl: null,
		draggables: ".maxiButton",
		droppables: ".maxiButton",
		handler: "img.move",
		container: null,
		css: {
			dragWhileDraggin: "dragged",
			dropOver: "dropping",
			clone: "dragClone",
			dragLoading: "dragLoading",
			dropLoading: "dropLoading",
			divMessage: "message message_error",
			divMessageContainer: "jAPSShortCutsMessages"
		},
		cloneOffsets: {
			"top": -19 ,
			"left": -140
		},
		ajaxSwapActionUrl: null,
		params: {
			start: "positionTarget",
			end: "positionDest"
		},
		prefixId: "shortCut_",
		labels: {
			"messageTitle": "Errors",
			"genericError": "Generic Error: cannot send your request.",
			"timeoutError": "Timeout: the server is not responding.",
			"configure": "Configure",
			"clearPosition": "Clear Position "
		},
		iconShortcutClear: null
	},
	initialize: function(options) {
		this.setOptions(options);
		this._setupRequest();
		this._setupDraggable();
	},
	_setupRequest: function() {
		//debugger;
		this.swapRequest = {
			isRunning: function() {
				return false;
			}
		};
	},
	
	doSwap: function(drag,drop) {
		if (this.swapRequest.isRunning()) {
			//console.log("wait! there's another request!");
		}
		else {
			this.start = drag;
			this.end = drop;
			var startValue = drag.get("id").split(this.options.prefixId)[1];
			var endValue = drop.get("id").split(this.options.prefixId)[1];
			var mythis = this;
			var sr = new Request.JSON({
				"url":  this.options.ajaxSwapActionUrl,
				"secure": true,
				"link": "ignore",
				"noCache": true,
				"method": "get",
				onRequest: function() {
					//status = false;
					this.doLoad(this.start,this.end);
				}.pass(null,mythis),
				onComplete: function(res) {
					this.removeLoad(this.start,this.end);
				}.pass(null,mythis),
				onSuccess: function(response, responseText){
					//console.log("ajax success... checking result...",response.result);
					if (response.result==true) {
						this.applySwap(this.start,this.end,response);
						this.removeMessages();
					}
					else {
						this.revertSwap(this.start,this.end,response);
						this.handleMessages(response.messages);
					}
				}.pass(null,mythis),
				onFailure: function(xhr) {
					this.revertSwap(this.start,this.end);
					this.handleMessages([this.options.labels.genericError]);
				}.pass(null,mythis),
				onException: function(headerName, value){
					this.revertSwap(this.start,this.end);
					this.handleMessages([this.options.labels.genericError]);
				}.pass(null,mythis),
				onTimeout: function(xhr) {
					this.revertSwap(this.start,this.end);
					this.handleMessages([this.options.labels.timeoutError]);
				}.pass(null,mythis)
			});
			this.swapRequest = sr;
			var requestObjectParams = {};
			requestObjectParams[this.options.params.start] = startValue;
			requestObjectParams[this.options.params.end] = endValue;
			this.swapRequest.get(requestObjectParams);
			//console.log("make request for swap",drag,drop);
		}
	},
	doLoad: function(drag,drop) {
		//console.log("loading",drag,drop);
		if (drag) {
			drag = Array.from(drag);
			Array.each(drag, function(item){
				item.addClass(this.options.css.dragLoading);
			}.bind(this));
		}
		if (drop) {
			drop = Array.from(drop);
			Array.each(drop, function(item){
				item.addClass(this.options.css.dropLoading);
			}.bind(this));
		}
	},
	removeLoad: function(drag,drop) {
		//console.log("removeLoading",drag,drop);
		if (drag) {
			drag = Array.from(drag);
			Array.each(drag, function(item){
				item.removeClass(this.options.css.dragLoading);
			}.bind(this));
		}
		if (drop) {
			drop = Array.from(drop);
			Array.each(drop, function(item){
				item.removeClass(this.options.css.dropLoading);
			}.bind(this));
		}
	},
	applySwap: function(drag,drop,params) {
		var startId = params.positionTarget;
		var endId = params.positionDest;
		drag.set("id",null);
		drop.set("id",this.options.prefixId+startId);
		drag.set("id",this.options.prefixId+endId);
		this.fireEvent("completeSwap",[drag,drop]);
	},
	revertSwap: function(drag,drop) {
		//console.log("reverting swap", drag,drop,params);
		var newPosition = drag.getPosition(this.container);
		var oldPosition = drop.getPosition(this.container);
		drop.removeClass(this.options.css.dropOver);
        drag.setPosition(oldPosition);
        drop.setPosition(newPosition);
		var dragBeforePlaceHolder = new Element("span",{text: ""}).inject(drag,"before");
		var dropBeforePlaceHolder = new Element("span",{text: ""}).inject(drop,"before");
		drag.inject(dropBeforePlaceHolder,"after");
		drop.inject(dragBeforePlaceHolder,"after");
		dragBeforePlaceHolder.destroy();
		dropBeforePlaceHolder.destroy();
		//this.doSwap(drag,drop);
	},
	handleMessages: function(messages) {
		var messageContainer = this.container.getPrevious("."+this.options.css.divMessageContainer); 
		if (null != messageContainer) {
			messageContainer.destroy();
		}
		messageContainer = new Element("div", {
			"class": this.options.css.divMessageContainer
		}).inject(this.container,"before");
		
		var errorContainer = new Element("div",{"class": this.options.css.divMessage}).inject(messageContainer);
		new Element("h2",{text: this.options.labels.messageTitle}).inject(errorContainer);
		var ul = new Element("ul").inject(errorContainer);
		Array.each(messages,function(item){
			new Element("li", {
				html: item
			}).inject(ul);			
		}.bind(this));
	},
	removeMessages: function() {
		var messageContainer = this.container.getPrevious("."+this.options.css.divMessageContainer); 
		if (null != messageContainer) {
			messageContainer.destroy();
		}
	},
	_setupDraggable: function() {
		this.draggable = document.getElements(this.options.draggables);
		this.droppable = document.getElements(this.options.droppables);
		
	//////////////////if
			if (this.draggable.length > 0) {
				//debugger;
				this.container = new Element("div",{
					styles : {
						"position": "relative",
						"height": "398px",
						"width": "100%",
						"overflow": "hidden"
					}
				}).inject(this.draggable[0],"before").adopt(this.draggable);
				
				
			    var mythis = this;
				Array.each(this.draggable, function(item,i){
					var pos = item.getPosition(this.container);            
				    item.setStyles({
				        "top": pos.y,
				        "left": pos.x
				    });
				}.bind(this));
			    
				Array.each(this.draggable,function(item,i){
					var d = item;
				//for (var i = 0;i<this.draggable.length;i++) {
				    //var d = this.draggable[i];
				    var handler = d.getElement(this.options.handler);
				    handler.addEvent("click",function(ev){ev.preventDefault();});
				    //var drops = this.drops.erase(d); 
				   var dragManager =  d.makeDraggable({
						css: this.options.css,
						cloneOffsets: this.options.cloneOffsets,
						snap: 1,
						swapRequest: this.swapRequest,
						preventDefault: true,
				        handle: handler,
				        droppables: document.getElements(this.options.droppables).erase(d),
				        style: false,
				        onBeforeStart: function(drag) {
								////console.log("this",this);
					            this.oldPosition = drag.getPosition(this.container);
								////console.log("bs",this.options.myContainer);
								
								if (undefined == this.dragClone) {
									var dragDimensions = drag.getDimensions();
									this.dragClone = new Element("div",{
										"class": this.options.css.clone,
										"styles": {
											"position": "absolute",
											"z-index": "1",
											"width": dragDimensions.x,
											"height": dragDimensions.y,
											"display": "none",
											"visibility": "hidden"
										},
										"html" : "&#32;"
									});
								}
								this.dragClone.setStyles({
									"top": drag.getPosition().y,
									"left": drag.getPosition().x
								});
								this.dragClone.inject(this.container,"after");
				        }.bind(mythis),
				        onStart: function(drag) {
							if (this.swapRequest.isRunning()) {
								drag.retrieve("dragManager").stop(drag);
							}
							else {
								drag.addClass(this.options.css.dragWhileDraggin);
							}
				        }.bind(mythis),
						onDrag: function(drag,ev) {
							////console.log(ev.page.x,ev.page.y,ev);
							this.dragClone.setStyles({
								"top": (ev.page.y)+this.options.cloneOffsets.top,
								"left": (ev.page.x)+this.options.cloneOffsets.left,
								"display": "block",
								"visibility": "visible"
							});
						}.bind(mythis),
				        onEnter: function(drag,drop) {
							drop.addClass(this.options.css.dropOver);
				        }.bind(mythis),
				        onLeave: function(drag,drop) {
				            if (drop != null) {
								drop.removeClass(this.options.css.dropOver);
							}
				        }.bind(mythis),
				        onDrop: function(drag,drop) {
				            if (null != drop) {
				                var newPosition = drop.getPosition(this.container);
								////console.log("drop",this.options.myContainer);
								drop.removeClass(this.options.css.dropOver);
				                drag.setPosition(newPosition);
				                drop.setPosition(this.oldPosition);
								var dragBeforePlaceHolder = new Element("span",{text: ""}).inject(drag,"before");
								var dropBeforePlaceHolder = new Element("span",{text: ""}).inject(drop,"before");
								drag.inject(dropBeforePlaceHolder,"after");
								drop.inject(dragBeforePlaceHolder,"after");
								dragBeforePlaceHolder.destroy();
								dropBeforePlaceHolder.destroy();
								this.doSwap(drag,drop);
				            }
				            else {
				                drag.setPosition(this.oldPosition);
				            }
				            
				        }.bind(mythis),
				        onComplete: function(drag) {
							this.dragClone.dispose();
							this.oldPosition = null;
							drag.removeClass(this.options.css.dragWhileDraggin);
				        }.bind(mythis),
						onCancel: function(drag) {
							this.dragClone.dispose(); 
						}.bind(mythis)
				    });
					d.store("dragManager",dragManager);
				//}
				}.bind(mythis));
			
			}
	//////////////////end
	},
	updateShortcut: function(shortcut, newJSONshortcut) {
		if (shortcut!==undefined && newJSONshortcut!==undefined) {
			var dt = shortcut.getElement("dt");
				dt.setProperty("class","");
				dt.addClass(newJSONshortcut.menuSectionCode); 
				dt.addClass("name");
			var a = dt.getElement("a.shortcut-link");
			if (a==null) {
				a = new Element("a", {"class": "shortcut-link"});
				a.inject(dt,"bottom");
				a.adopt([dt.getElement(".up"),dt.getElement(".down")]);
			}
				a.set("href",newJSONshortcut.href);
				a.set("title",newJSONshortcut.menuSection.description);
				a.getElement(".up").set("text",newJSONshortcut.menuSection.description);
				a.getElement(".down").set("text",newJSONshortcut.shortDescr);
			var dd = shortcut.getElement("dd");
				dd.getElement("p").set("text",newJSONshortcut.longDescr);
			
			if (dt.getElement("a.shortcut-configure")==null) {
				var arr = document.getElements("dl"+this.options.draggables);
				var id = new Number(dt.getParent("dl").get("id").substring(this.options.prefixId.length)).valueOf();
				var sconfigure = new Element("a", {
					"class": "shortcut-configure", 
					"href": this.options.configureActionUrl.replace("POSitionTOKen",id),
					"title": this.options.labels.clearPosition+""+id
				});
				var simg = new Element("img", {
					src: this.options.iconShortcutClear
				});
				sconfigure.inject(dt.getElement(".shortcut-toolbar"),"top");
				simg.inject(sconfigure);
			}
			
		}
	}
});