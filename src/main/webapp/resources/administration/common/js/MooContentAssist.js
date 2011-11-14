/*
---

description: A content assist for textares of your webpage.

license: GNU General Public License, version 2.

authors:
- Andrea Dessì <nkjoep@gmail.com>

requires:
 core/1.3:
  - all
 more/1.3:  
  - all (sorry I should investigate about which More classes are needed.) 

provides: [MooContentAssist]

...
*/
/*
Changelog:
14 Mar 2011 v0.80.3 - namespace parser, fixed "charAt()" problem with IE7
08 Mar 2011 v0.80.2 - namespace parser, now with allowed chars (or strings) in the namespace
08 Mar 2011 v0.80.1 - configurable items container inside the main box
06 Mar 2011 v0.80 - MooTools 1.3, several bugfixing, internal API rewritten.
01 Jul 2010 v0.70.4 - converter from xml to words object, fixed bug on foundlist, fixed bug on assist window position
27 Jun 2010 v0.70 - theme changer, new demo with theme toggler
11 Jun 2010 v0.70 - configurable number of item shown in the box
10 Jun 2010 v0.70 - scrollable result box, scrollable result box shows always the current item in the middle
04 Jun 2010 v0.68 - few standard methods for positioning, css rules methods
24 May 2010 v0.68 - fixed textarea scroll when inserting keywords, fixed assistWindow position
23 May 2010 v0.66 - first dot fixed, occurence text highlight fixed, animation now is a parameter
22 May 2010 v0.64 - ie7 fixes
21 May 2010 v0.63 - added events "click" and "over" to the shown items, when showing assistWindow first item is already selected, added "." trigger
21 May 2010 v0.60 - added styles for items, window positioning 
20 May 2010 v0.55 - fixed textarea events
16 May 2010 v0.25 - fixed words data structure
15 May 2010 v0.15 - added completed text, events and keys
13 May 2010 v0.0  - hello word	
*/
/* JSHint globals
globals Events: false, Options: false, MooTools: false, Class: false, Element: false, typeOf: false, instanceOf: false, Fx: false, Slick: false, Type: false, Chain: false, Elements: false, Document: false, Event: false, Window: false, Browser: false , Request: false, Keyboard: false */

/**
 * @author Andrea Dessì <nkjoep@gmail.com>
 * @fileoverview A content assist for textares of your webpage. {@link https://github.com/NKjoep/MooContentAssist}
 * @version 0.80.3
 * 
 * */
/**
Construct a new MooContentAssist object.
@class {MooContentAssist} This is the basic MooContentAssist class. It adds a content/code assist functionality to your textareas.
@constructor
@param {Object} options
@param {HtmlElement} options.source The html element of an input or textarea.
@param {Integer} [options.frameSize=3] How many items show in the window at same size.
@param {Integer} [options.animationDuration=75] How long the show/hide animation in milliseconds
@param {Object} options.vocabulary The JSON obj representing the vocabulary
@param {Boolean} [options.vocabularyDiscoverer=true] Toggle the automatic words discoverer on/off
@param {String} [options.vocabularyUrl] The url for ajax calls. It's optional.
@param {String} [options.vocabularyUrlParam="ns"] The name of the querystring variable passed to the options.vocabularyUrl in ajax calls
@param {String} [options.vocabularyUrlMethod="get"] Supported: get, post. Used for ajax calls.
@param {Object} [options.windowPadding={x: 0, y: 2}] The margin of the assist window. It's an object with x,y keys.
@param {String} [options.itemType="li"] The tag used for generating itemsContainer
@param {String} [options.itemsContainer="ul"] The tag used for generating the items container
@param {String} [options.matchedTextItemType="span"] The tag used for the matched text
@param {Boolean} [options.aggressiveAssist="true"] Toggle aggressiveAssist mode on/offset
@param {String[]} [options.namespaceAllowed=["()", "$"]] Define which strings can be contained in namespaces item.
@param {Object} [options.css]
@param {String} [options.css.item="item"] The css class for the single item
@param {String} [options.css.itemsContainer="itemsContainer"] The css for the items container
@param {String} [options.css.itemSelected="itemSelected"] The css class added to the item when it's selected
@param {String} [options.css.messageItem="message"]
@param {String} [options.css.matchedText="matched"]
@param {Object} [options.labels]
@param {String} [options.labels.nothingFound="Nothing was found."]
@param {String} [options.labels.ajaxError="Error while retrieving data."]
@param {Function} [options.vocabularyManager_GetVocabulary]
@param {Function} [options.vocabularyManager_Extract]
@param {Function} [options.vocabularyManager_Render]
@return {MooContentAssist} A MooContentAssist
* 
*/
var MooContentAssist = new Class({
	version: "MooContentAssist v0.80.3",
	Implements: [Events, Options],
	options: {
		source: null,
		frameSize: 3,
		animationDuration: 75,
		vocabulary: null,
		vocabularyDiscoverer: true,
		vocabularyUrl: null,
		vocabularyUrlParam: "ns",
		vocabularyUrlMethod: "get",
		windowPadding: {x: 0, y: 2},
		itemType: "li",
		itemsContainerType: "ul",
		matchedTextItemType: "span",
		aggressiveAssist: true,
		namespaceAllowed: ["()", "$"],
		css : {
			item: "item",
			itemsContainer: "itemsContainer",
			itemSelected: "itemSelected",
			messageItem: "message",
			matchedText: "matched"
		},
		labels: {
			nothingFound: "Nothing was found.",
			ajaxError: "Error while retrieving data."
		},
		vocabularyManager_Render: function(obj) {
			var ns = this.getNameSpace().getLast();
			var rendered = new Element(this.options.itemType,{"class": this.options.css.item});
			rendered.store("value",obj);
			if (ns!="/") {
				new Element(this.options.matchedTextItemType,{text: obj.substring(0,ns.length), "class": this.options.css.matchedText}).inject(rendered);
				obj=obj.substring(ns.length);
			}
			rendered.appendText(obj);						
			return rendered; 
		},
		vocabularyManager_Extract: function(namespace,vocabulary) {
			if (namespace[0] === "") { 
				namespace=Array.clone(namespace);
				namespace.shift(); 
			}
			var vocabularyFound = [];
			var found = null;
			var searchKey = null;
			if (namespace.length === 1){
				found = vocabulary; 
				if (namespace[0] != "/") {
					searchKey = namespace[0];
						searchKey = searchKey.replace(/\*/g,"\\\*");
						searchKey = searchKey.replace(/\./g,"\\\.");
						searchKey = searchKey.replace(/\?/g,"\\\?");
						searchKey = searchKey.replace(/\[/g,"\\\[");
						searchKey = searchKey.replace(/\]/g,"\\\]");
						searchKey = searchKey.replace(/\(/g,"\\\(");
						searchKey = searchKey.replace(/\)/g,"\\\)");
						searchKey = searchKey.replace(/\{/g,"\\\{");
						searchKey = searchKey.replace(/\}/g,"\\\}");
						searchKey = searchKey.replace(/\^/g,"\\\^");
						searchKey = searchKey.replace(/\$/g,"\\\$");
				}
			}
			else if (namespace.length > 1) {
				if (namespace[namespace.length-1] != "/") {
					searchKey = namespace[namespace.length-1];
						searchKey = searchKey.replace(/\|/g,"\\\|");
						searchKey = searchKey.replace(/\*/g,"\\\*");
						searchKey = searchKey.replace(/\./g,"\\\.");
						searchKey = searchKey.replace(/\?/g,"\\\?");
						searchKey = searchKey.replace(/\[/g,"\\\[");
						searchKey = searchKey.replace(/\]/g,"\\\]");
						searchKey = searchKey.replace(/\(/g,"\\\(");
						searchKey = searchKey.replace(/\)/g,"\\\)");
						searchKey = searchKey.replace(/\{/g,"\\\{");
						searchKey = searchKey.replace(/\}/g,"\\\}");
						searchKey = searchKey.replace(/\^/g,"\\\^");
						searchKey = searchKey.replace(/\$/g,"\\\$");
				}
				namespace=Array.clone(namespace);
				namespace.pop();
				var tempFound = vocabulary;
				for (var i=0;i<namespace.length;i++) {
					try {
						tempFound = tempFound[namespace[i]];
					}
					catch (e) {
						tempFound = null;
					}
				}
				found = tempFound;
			}
			if (null !== found) {
				if(typeOf(found)=="object") {
					Object.each(found,function(value,key){
						if (searchKey === null || key.test("^"+searchKey,"i")) {
							vocabularyFound.push(key);
						}
					});
				}
				else if(typeOf(found)=="array") {
					Array.each(found,function(item,index,object) {
						if(typeOf(item)=="string" || typeOf(item)=="number") {
							item = item.toString();
							if (item.length>0) {
								if (searchKey === null || item.test("^"+searchKey,"i")) {
									vocabularyFound.push(item.toString());
								}	
							}
						}
					});
				}
				vocabularyFound.sort();
			}
			return vocabularyFound;
		},
		vocabularyManager_GetVocabulary: function(namespace) {
			var currentNamespace = namespace;
			this._currentVocabulary = null;
			var extractedVocabulary = null;
			if (typeOf(this.options.vocabularyUrl)=="string") {
				var namespaceData = this.options.vocabularyUrlParam+"="+currentNamespace.join("."); 
				if (this.vocabularyRequest===undefined) {
					this.vocabularyRequest = new Request.JSON({
						secure: true,
						url: this.options.vocabularyUrl,
						method: this.options.vocabularyUrlMethod,
						//data: namespaceData,
						async: false,
						link: "cancel",
						onSuccess: function(obj) {
							this.currentVocabulary = obj;
						},
						onFailure: function(xhr) {
							var messageEl = this._createMessage(this.options.labels.ajaxError);
							this.setAssistWindowContent(messageEl);
						}.bind(this)
					});
				}
				else {
					this.vocabularyRequest.cancel();
				}
				this.vocabularyRequest.currentVocabulary = null;
				var reqObj = {};
				reqObj[this.options.vocabularyUrlParam] = currentNamespace;
				this.vocabularyRequest.send(namespaceData);
				extractedVocabulary = this.options.vocabularyManager_Extract.call(this,currentNamespace,this.vocabularyRequest.currentVocabulary);
			}
			else {
				extractedVocabulary = this.options.vocabularyManager_Extract.call(this,currentNamespace,this.options.vocabulary);
			}
			return extractedVocabulary;
		}
	},
	_checkFocus: function(target) {
		var t = target;
		var s = this.options.source;
		var assistWindow = this.getAssistWindow();
		var checkA = (assistWindow!==null) && (t == assistWindow || assistWindow.contains(t)); 
		var checkB = (t == s || s.contains(t));
		if (t==window) return false;
		else if (checkA || checkB) return true;
		else {
			return false;
		}
	},
	_createMessage: function(text) {
		var messageEl = new Element(this.options.itemType, {
			"class": this.options.css.messageItem,
			"text": text
		});
		return messageEl;
	},
	_discoverUserVocabulary: function(namespace) {
		var found = [];
		if (namespace.length==1) {
			namespace = namespace[0];
			var that = this;
		    found = this._discoverWords(this.getSourceValue());
			found = found.filter(function(item, index){
				var check = false;
				if (namespace == "/") {
					check = true;
				}
				else if (namespace==item) {
					check = false;
				}
				else if (item.substring(0,namespace.length).toLowerCase() == namespace.toLowerCase())  {
					check = true;
				}
				return check;
			});
			found.sort();
		}
		return found;
	},
	_discoverWords: function(str){
		str = str.replace(/\W/g," ").clean().split(" ").clean().unique();
		var tmp = [];
		str.each(function(item, index){
			if (item.length > 3) {
			tmp.push(item.clean());
			}
		});
		str = tmp;
		return str;
    },
	_eventManager: function() {
		this.addEvents({
			"start": function(mca) { this.start(); }.bind(this),
			"end": function(mca) { this.end(); }.bind(this)
		});
		var myKeyboardEvents = new Keyboard({
	        active: false,
	        events: {
	            "alt+space": function(ev){
					if (this.getAssistWindow()!==null) {
						//("already assisting!");
						ev.preventDefault();
					}
					else {
						//("start assist");
		                ev.preventDefault();
						this.fireEvent("start",this);
					}
	            }.bind(this),
	            "control+space": function(ev){
					//("already assisting!");
					if (this.getAssistWindow()!==null) {
						ev.preventDefault();
						this.fireEvent("start",this);
					}
					else {
		                //("start assist");
		                ev.preventDefault();
						this.fireEvent("start",this);
					}
				}.bind(this),
				"up": function(ev) {
					//("select item up");
					if (this.getAssistWindow()!==null) {
						ev.preventDefault();
						this.selectItemUp();
					}
				}.bind(this),
				"down": function(ev) {
					//("select item down");
					if (this.getAssistWindow()!==null) {
						ev.preventDefault();
						this.selectItemDown();
					}
				}.bind(this),
				"esc": function(ev) {
					//("close it!");
					if (this.getAssistWindow()!==null) {
						ev.preventDefault();
						this.fireEvent("end",this);
					}
				}.bind(this),
				"tab": function(ev) {
					//("close it!");
					if (this.getAssistWindow()!==null) {
						ev.preventDefault();
						this.fireEvent("end",this);
					}
				}.bind(this),
				"enter": function(ev) {
					//("use the item! and destroy it!");
					if(this.getAssistWindow()!==null && this.getItemSelected()!==null) {
						ev.preventDefault();
						this._useItemSelected();
						this.fireEvent("end",this);
					}
				}.bind(this),
				"keyup:delete": function(ev){ 
					if(this.getAssistWindow()!==null) {
						this.fireEvent("start",this); 
					}
				}.bind(this),
				"keyup:cancel": function(ev){ 
					if (this.getAssistWindow()!==null) {
						this.fireEvent("start",this); 
					}
				}.bind(this),
				"keyup:backspace": function(ev){ 
					if (this.getAssistWindow()!==null) {
						this.fireEvent("start",this);
					}
				}.bind(this),
				"keyup:space": function(ev){ 
					this.fireEvent("end",this);
				}.bind(this)
	        }
	    });
		var that = this;
		this.options.source.addEvents({
			"focus": function(ev) {
				this[1]._setSourceCaretPosition();
				this[0].activate();				
			}.bind([myKeyboardEvents,this]),
			"blur": function(ev) {
				this[0].deactivate();
				if (!this[1]._checkFocus(ev.target)) {
					this[1].fireEvent("end",this[1]);
				}
			}.bind([myKeyboardEvents,this]),
			"keyup": function(ev){
				this._setSourceCaretPosition();
				if (this.getAssistWindow()!==null||this.options.aggressiveAssist) {
					//removed control, for strange behaviour when selecting all with control+a
					if(!ev.control && ev.key.length == 1 && ev.key.test(/^\w$/)) {
						this.fireEvent("start",this);
					}
				}
			}.bind(this),
			"keypress": that._setSourceCaretPosition.bind(this),
			"keydown":  that._setSourceCaretPosition.bind(this)
		});
		this.options.source.set("autocomplete","off");
        this.options.source.setProperty("autocomplete","off");
		window.addEvent("click",function(ev) {
			if (!this._checkFocus(ev.target)) {
				this.fireEvent("end",this);
			}
		}.bind(this));
	},
	_mergeVocabulary: function(vocabulary, vocabularyToInclude) {
		var merged = vocabulary.combine(vocabularyToInclude).sort();
		return merged;
	},
	_namespaceParser: function(nameSpaceString,caretPosition) {
		if (nameSpaceString===undefined) { nameSpaceString=this.getSourceValue(); }
		if (typeOf(caretPosition)!="number") {
			caretPosition=this.getSourceCaretPosition();
		}
		var namespace = [];
		var allowed  = this.options.namespaceAllowed;
		/* parser start */
		var positionStart = 0;
		var i = 0;
		for (i=caretPosition-1;i>0;--i) {
			var character = nameSpaceString.charAt(i);
			var previousCharacter = nameSpaceString.charAt(i+1);
			if (character===undefined) {
				break;
			}
			if (character=="." && previousCharacter==".") {
				positionStart = i+1+1; 
				break; 
			}
			var cursorJump = 0;
			var endsWithAllowed = allowed.some(function(item) {
				if (item.length==1) {
					return character==item;
				}
				else if (nameSpaceString.substring(i-item.length+1,i+1)==item) {
					//cursorJump = item.length+1;
					cursorJump = item.length-1;
					return true;
				}
				else if (nameSpaceString.substring(i,i+item.length)==item) {
					return true;
				}
			});
			if (cursorJump>0) {
				i = i-cursorJump;
				character=nameSpaceString[i];
				previousCharacter=nameSpaceString.charAt(i+1);
				continue;
			}
			if ( character!="." && !(character.test(/^\w$/) || endsWithAllowed ) ) {
				positionStart = i+1;
				if (previousCharacter!==undefined) {
					var jumpPrevious = 0;
					if (previousCharacter==".") {
						//if theres a dot ".", just move forward of 1 position and exit the loop.
						jumpPrevious = 1;
						positionStart = i+1+jumpPrevious;
						break;
					}
					var previousCharacterEndsWithAllowed = allowed.some(function(item) {
						if (item.length==1) {
							if (previousCharacter==item) {
								jumpPrevious=1;
								return true;	
							}
						} 
						//forward seek
							else if (nameSpaceString.substring(i,i+item.length) == item ) {
								jumpPrevious=item.length;
								return true;
							}
						//back seek
							else if (nameSpaceString.substring(i-item.length+1,i+1) == item) {
								jumpPrevious= (-(item.length));
								return true;
							}
					});
					if (!previousCharacterEndsWithAllowed && !previousCharacter.test(/^\w$/)) { 
						//here only allowed
						positionStart = i+1+jumpPrevious;
					} 
				}
				break;
			}
		}
		if(positionStart>caretPosition) {
			positionStart=caretPosition;
		}
		nameSpaceString = nameSpaceString.substring(positionStart,caretPosition).trim();
		if (nameSpaceString.length>0) {
			namespace=nameSpaceString.split(".");
			if (namespace[namespace.length-1]==="") {
				namespace[namespace.length-1] = "/";
			}
		}
		else {
			namespace=["/"];
		}
		/* parser end */
		return namespace;	
	},
	_setItemSelected: function(item, executeScroll) {
		if (item!==null) {
			var oldItem = this.getItemSelected();
			if (oldItem!==null) { oldItem.removeClass(this.options.css.itemSelected); }
			item.addClass(this.options.css.itemSelected);
			this.fireEvent("selectItem",item);
			if (executeScroll !== false) {
				this.scrollToItem(item);
			}
		}
	},
	_setSourceCaretPosition: function() {
		this.options.source.store("MooContentAssist-CaretPosition",this.options.source.getCaretPosition());
	},
	_useItemSelected: function() {
		var text = this.getItemSelected();
		var w = this.getAssistWindow();
		if (text!==null && w!==null) {
			text = text.retrieve("value");
			var textarea = this.options.source;
			var scrollTop = textarea.scrollTop;
			var position = this.getSourceCaretPosition();
			var namespace = this.getNameSpace().getLast();
			var completedText=null;
			if (namespace=="/") {
				completedText=text;
			}
			else {
				completedText = text.substring(namespace.length,text.length);
			}
			var adjustCaseText = text.substring(0,text.length-completedText.length);
			var textbefore = textarea.get("value").substring(0, position);
			textbefore = textbefore.substring(0,textbefore.length-adjustCaseText.length)+adjustCaseText;
			var textafter = textarea.get("value").substring(position);
			textarea.set("value", textbefore + completedText + textafter);
			textarea.setCaretPosition(textbefore.length + completedText.length);
			textarea.scrollTop = scrollTop;
			this.fireEvent("useItem",text);
			this.fireEvent("end",this);
		}
	},
	createAssistWindow: function() {
		var w = new Element("div",{
			"class": "MooContentAssist"
		});
		this.options.source.store("MooContentAssist",w);
		var itemsEventsObj = {};
			itemsEventsObj['click:relay(.'+this.options.css.item+')'] = function(ev){ 
				ev.stopPropagation();
				ev.preventDefault();
				this._useItemSelected();
			}.bind(this);
			itemsEventsObj['mouseover:relay(.'+this.options.css.item+')'] = function(ev){ 
				ev.stopPropagation();
				ev.preventDefault();
				if (ev.target.get("tag")==this.options.itemType&&ev.target.hasClass(this.options.css.item)) {
					this._setItemSelected(ev.target,false);
				}
				else {
					var parent = ev.target.getParent(this.options.itemType+"."+this.options.css.item);
					if (parent!==null) {
						this._setItemSelected(parent,false);
					}
					
				}
			}.bind(this);
		w.addEvents(itemsEventsObj);
		var sourceEl = this.options.source;
		var sourceElPosition=sourceEl.getPosition(); 
		var sourceElSize = sourceEl.getDimensions();
		w.inject(this.options.source,"after");
		var top = sourceElPosition.y+sourceElSize.height+this.options.windowPadding.y;
		var left= sourceElPosition.x+this.options.windowPadding.x;
		w.setStyles({
			"overflow": "auto",
			"width": sourceElSize.width,
			"left": left,
			"top": top
		});
		if (this.options.itemsContainerType!==null) {
			new Element(this.options.itemsContainerType, {
				"class": this.options.css.itemsContainer
			}).inject(w,"bottom");
		}
		return w;
	},
	end: function() {
		var mca = this.getAssistWindow();
		if (mca !== null) {
			mca.destroy();
			this.options.source.store("MooContentAssist",null);
		}
	},
	getAssistWindow: function() {
		return this.options.source.retrieve("MooContentAssist");
	},
	getItemSelected: function() {
		var w = this.getAssistWindow();
		var item = null;
		if (w!==null) {
			item = w.getElement(this._prefixItemsSelector+this.options.css.itemSelected);
		}
		return item;
	},
	getNameSpace: function(string) { 
		var namespace = [];
		namespace = this._namespaceParser(string);
		return namespace;
	},
	getRenderedWord: function(word) {
		return this.options.vocabularyManager_Render.call(this,word);
	},
	getSourceCaretPosition: function() {
		var pos = this.options.source.retrieve("MooContentAssist-CaretPosition");
		if (pos === null) {
			pos = this.options.source.getCaretPosition();
		}
		return pos;
	},
	getSourceValue: function() { 
		return this.options.source.get("value"); 
	},
	getVocabulary: function(namespace) {
		var vocabulary =  null;
		var namespaceToString = namespace.toString();
		if (namespaceToString == this.oldNamespace) {
			vocabulary = this.oldVocabulary;
		}
		else {
			var vocabulary = this.options.vocabularyManager_GetVocabulary.call(this,namespace);
			this.oldVocabulary = vocabulary;
			this.oldNamespace = namespaceToString;
		}
		if (this.options.vocabularyDiscoverer) {
			var userVocabulary = this._discoverUserVocabulary(namespace);
			vocabulary = this._mergeVocabulary(vocabulary,userVocabulary);
		}
		return vocabulary;
	},
	hide: function() {
		if(this.getAssistWindow()!==null) this.getAssistWindow().dissolve();
		this.fireEvent("hide");
	},
	initialize: function(opt) {
		this.setOptions(opt);
		if (opt.itemsContainerType===null) {
			this.options.itemsContainerType = null;
			this._prefixItemsSelector=".";
		}
		else {
			this._prefixItemsSelector="."+this.options.css.itemsContainer+" .";
		}
		this.options.source.store("MooContentAssist",null);
		this._eventManager();
		this.oldNamespace=false;
	},
	scrollToItem: function(item) {
		var w = this.getAssistWindow();
		if (w!==null && item!==null) {
			var animationScroller = w.retrieve("MooContentAssist-AnimationScroller");
			if (animationScroller === null) {
				animationScroller = new Fx.Scroll(w,{
		            duration: this.options.animationDuration,
					offset: {"x": 0, "y": w.getStyle('padding-top').toInt()*-1}
				});
				w.store("MooContentAssist-AnimationScroller",animationScroller);
			}
			//item height
		    var i = item.getComputedSize({"styles": ["margin","padding","border"]}).totalHeight;
		    //box height
		    var f = (w.getComputedSize({"styles": ["padding"]}).totalHeight/i).toInt();
		    //children
		    var children = w.getElements(this._prefixItemsSelector+this.options.css.item);
		    //current item
		    var c = children.indexOf(item);
		    //index
		    var indexToScrollTo = ((c/f).toInt()) * f; 
			//calculate the current "frame"
			if (c > (f/2).toInt()) {
				indexToScrollTo = c - (f/2).toInt(); 
			}
			//scroll to item at that index
			if(w.getElement(children[indexToScrollTo])!==null) {
				try {
					animationScroller.toElement(children[indexToScrollTo]);
				} catch(e) {
					//sometimes IE fires errors...
					w.store("MooContentAssist-AnimationScroller",null);
				}
			}
		}
	},
	selectItemDown: function() {
		var currentItem = this.getItemSelected();
		var prevItem = null;
		if (currentItem!==null) {
			prevItem = currentItem.getNext();
		}
		else {
			prevItem = this.getAssistWindow().getFirst(this._prefixItemsSelector+this.options.css.item);
		}
		if (prevItem!==null) { 
			this._setItemSelected(prevItem); 
		}
		else { 
			this._setItemSelected(this.getAssistWindow().getFirst(this._prefixItemsSelector+this.options.css.item)); 
		}	
	},
	selectItemUp: function() {
		var currentItem = this.getItemSelected();
		var prevItem = null;
		if (currentItem!==null) {
			prevItem = currentItem.getPrevious();
		}
		else {
			prevItem = this.getAssistWindow().getLast(this._prefixItemsSelector+this.options.css.item);
		}
		if (prevItem!==null) { 
			this._setItemSelected(prevItem); 
		}
		else { 
			this._setItemSelected(this.getAssistWindow().getLast(this._prefixItemsSelector+this.options.css.item));
		}
	},
	setAggressiveAssist: function(aggressiveStatus) {
		if (typeOf(aggressiveStatus)=="boolean"){
			this.options.aggressiveAssist=aggressiveStatus;
		}
	},
	setAssistWindowContent: function(vocabulary) {
		var w = this.getAssistWindow();
		if (w!==null) {
			vocabulary = Array.from(vocabulary);
			var injectBindElement = this.options.itemsContainerType===null? w : w.getElement("."+this.options.css.itemsContainer);
			var inject = function(word) {
				word.inject(this);
			}.bind(injectBindElement);
			for (var i=0;i<vocabulary.length;i++) {
				var currentWord = vocabulary[i];
				inject(currentWord);
			}
			this.setFrameSize();
			this.selectItemDown();
		}
	},
	setFrameSize: function(size) {
		if(typeOf(size) != "number") { size = this.options.frameSize; }
		var selector = this._prefixItemsSelector+this.options.css.item;
		var w = this.getAssistWindow();
		var children = w.getElements(selector);
		var childrenLength = children.length > 0 ? children.length : 1;
		if (childrenLength<size) { size = childrenLength;}
		var exampleItem = w.getElement(selector);
		if (exampleItem===null) {
			exampleItem = w.getElement(this._prefixItemsSelector+this.options.css.messageItem);
		}
		w.setStyle("height",(exampleItem.getComputedSize({
			"styles": ["padding","margin","border"]
		}).totalHeight * size) + "px");
	},
	show: function() {
		if(this.getAssistWindow()!==null) this.getAssistWindow().reveal();
		this.getAssistWindow().setStyle("opacity",1);
		this.fireEvent("show");
	},
	start: function() {
		var mca = this.getAssistWindow();
		if (mca!==null) {
			this.end();
			this.createAssistWindow();
		}
		var value = this.getSourceValue();
		var namespace = this.getNameSpace(value);
		var vocabulary = this.getVocabulary(namespace);
		if (vocabulary.length > 0) {
			var renderedVocabulary = [];
			vocabulary.each(function(word) {
				renderedVocabulary.push(this.getRenderedWord(word));
			}.bind(this));
			if (mca === null) {
				mca = this.createAssistWindow();
			}
			this.setAssistWindowContent(renderedVocabulary);
		}
		else {
			if (!this.options.aggressiveAssist || (this.options.aggressiveAssist && namespace.length>1)) {
				var messageEl = this._createMessage(this.options.labels.nothingFound);
				if (mca === null) {
					mca = this.createAssistWindow();
				}
				this.setAssistWindowContent(messageEl);
			}
			else {
				this.end();
			}
		}
	}
});
