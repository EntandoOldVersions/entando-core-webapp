var CodeMirrorManager = new Class({
	Implements: [Events, Options],
	options: {},
	initialize: function(editor,opt) {
		this.editor = editor;
		this.setOptions(opt);
		this.createEditor();
		this.vocabulary = this.options.vocabulary;
	},
	createEditor: function() {
		var cmMode = this.options.codemirrorMode!==undefined?this.options.codemirrorMode:"velocity";
		this.codeMirror = CodeMirror.fromTextArea(this.editor, {
			lineNumbers: true,
			mode: cmMode,
			onKeyEvent: this.manageEvent.bind(this)
		});
		return true;
	},
	manageEvent: function(codeMirror, event) {
		//console.log("raw", event,"wrapper",new Event(event));
		//console.log("key id",event.keyIdentifier);
		event = new Event(event);
		if (event.type == "keydown") {
			if(!this.isAssisting) {
				if (event.control && event.key == "space") {
					//console.log("managing event", event, codeMirror);
					event.preventDefault();
					this.startAssist();
				}
			}
			else if (this.isAssisting) {
				if (event.control && event.key == "space") {
					//console.log("managing event", event, codeMirror);
					event.preventDefault();
					this.endAssist();
					(function(){ this.startAssist(); }).delay(60,this);
				}
				else if (event.key == "up") {
					event.preventDefault();
					this.selectItemUp();
				}
				else if (event.key == "down") {
					event.preventDefault();
					this.selectItemDown();
				}
				else if (event.key == "esc") {
					event.preventDefault();
					this.endAssist();
					this.codeMirror.focus();
				}
				else if (event.key == "enter") {
					//console.log("triggered enterrrrrrrrrrr",event);
					event.preventDefault();
					this.codeMirror.focus();
					this.useSelectedItem();
					this.endAssist();
					return true;
				}
				else if(event.key.length==1 && /[a-zA-Z\d_\.\$#]/g.test(event.key) && event.code!=0) {
					//debugger;
					event.preventDefault();
					//console.log("keydown a letter: ",event.key,event);
					//console.log("raw cursor", this.codeMirror.getCursor());
					this.codeMirror.replaceRange(event.key, {line: this.cursor.line,ch: this.cursor.ch+1}, {line: this.cursor.line,ch: this.cursor.ch+1});
					this.codeMirror.setCursor({ch: this.cursor.ch+1, line: this.cursor.line});
					this.endAssist();
					(function(){ this.startAssist(); }).delay(60,this);
				}
				else if(event.key=="shift" || event.key=="control"){
					//console.log("keydown nothing",event.key,event);
				}
				else {
					//console.log("keydown ending",event.key,event);
					event.preventDefault();
					this.endAssist();
				}
			}
		}
		if (event.type == "keypress") {
			if(this.isAssisting) {
				if (event.key == "enter") {
					//console.log("keypress enter",event);
					event.preventDefault();
					return true;
				}
			}
		}
	},
	startAssist: function() {
		//console.log("startAssist");
		this.isAssisting = true;
		if (this.codeMirror.somethingSelected()) return;
		var cursor = this.codeMirror.getCursor(false);
		//console.log("cursor",cursor.ch);
		var textToComplete = this.codeMirror.getLine(cursor.line);
		cursor.end = textToComplete.length;
		this.cursor = cursor;
		searchNamespaceString = textToComplete.substring(0, cursor.ch);
		this.searchNamespaceString = searchNamespaceString;
		var namespace = this.UTILS().namespaceParser(searchNamespaceString, cursor.ch);
		this.namespace = namespace;
		var completions = this.UTILS().getVocabulary(namespace,this.codeMirror.getValue());
		this.dispatchCompletions(completions);
		return "startAssist";
	},
	dispatchCompletions: function(completions) {
		//console.log("dispatching",completions);
		if (completions.length==0) {
			this.isAssisting = false;
			this.endAssist();
		}
		else {
			this.insertCompletionItems(completions);
			
			if (completions.length>1) {
				var self = this;
				this.complete.getElement("select").addEvents({
					"click:relay(option)": function(ev){
						//console.log("clicking",ev.target);
						self.setSelectedItem(ev.target);
					},
					"dblclick:relay(option)": function(ev) {
						//console.log("dblclicking",ev.target);
						self.setSelectedItem(ev.target);
						self.useSelectedItem();
						self.endAssist();
					},
					"keydown": function(ev) {
						if (ev.key=="up") {}
						else if (ev.key=="down") {}						
						else if (ev.key=="enter") {
							//console.log("selcting from select",ev);
							ev.preventDefault();
							self.useSelectedItem();
							self.endAssist();
							self.codeMirror.focus();
						}
						else if (ev.key=="esc") {
							self.endAssist();
						}
						else {
							ev.preventDefault();
						}
					},
					"keydown:relay(option)": function(ev) {
						//console.log("keydown opt",ev.target);
					},
					"blur": function(ev) {
						self.endAssist();
					}
				});
			}
			else {
				this.useSelectedItem();
				this.endAssist();
			}
			
		}
	},
	insertCompletionItems: function(completions) {
		if (document.getElement(this.complete)!==null) {
			this.complete.empty();
			this.complete.destroy();
		}
		var complete = new Element("div", {"class": "completions"});
		this.complete = complete;
		var sel = new Element("select",{
			"multiple": false
		});		
		sel.inject(complete);
		this.codeMirror.sel = sel;
		for (var i = 0; i < completions.length; ++i) {
			var opt = new Element("option",{
				"text": completions[i],
				"value": completions[i]
			});
			if (i==0) {
				opt.set("selected","selected");
			}
			opt.inject(sel);
		}
		sel.set("size",Math.min(10, completions.length));
		var pos = this.codeMirror.cursorCoords();
		complete.setStyle("left",pos.x + "px");
		complete.setStyle("top",pos.yBot + "px");
		complete.inject(document.body);
		// Hack to hide the scrollbar.
		if (completions.length <= 10) {
			complete.setStyle("width", (sel.clientWidth - 1) + "px");
		}
		var done = false;
	},
	getCurrentSelectedItem: function() {
		var value = this.complete.getElement("select").get("value");
		var opts = this.complete.getElement("select").getElements("option");
		var found = false;
		var c = 0;
		if (value.length>0) {
			while(c<opts.length && found==false) {
				//console.log("|",value,"|",opts[c].get("text").trim(),"|",value==opts[c].get("text").trim());
				if (value == opts[c].get("text")) {
					found = opts[c];
				}
				c = c+1;
			}
		}
		else {
			//console.log("ERROR: value is empty: ",value);
		}
		if (found==false) {
			found = this.complete.getElement("select").getElement("option");
			//console.log("the found when erroring: ",found,found.value,found.get("text"));
			this.setSelectedItem(found);
		}
		//console.log(value,"found",found,opts.length)
		return found;
	},
	setSelectedItem: function(el) {
		this.complete.getElement("select").set("value",el.get("text"));
		el.set("selected","selected");
	},
	selectItemUp: function() {
		var currentItem = this.getCurrentSelectedItem();
		var prevItem = null;
		if (currentItem!==null) {
			prevItem = currentItem.getPrevious();
		}
		else {
			prevItem = this.complete.getElement("select").getLast("option");
		}
		if (prevItem!==null) { 
			this.setSelectedItem(prevItem); 
		}
		else { 
			this.setSelectedItem(this.complete.getElement("select").getLast("option")); 
		}
		//console.log("select item up",this.getCurrentSelectedItem());
	},
	selectItemDown: function() {
		var currentItem = this.getCurrentSelectedItem();
		var nextItem = null;
		if (currentItem!==null) {
			nextItem = currentItem.getNext();
		}
		else {
			nextItem = this.complete.getElement("select").getFirst("option");
		}
		if (nextItem!==null) {
			this.setSelectedItem(nextItem); 
		}
		else { 
			this.setSelectedItem(this.complete.getElement("select").getFirst("option")); 
		}
		//console.log("select item down",this.getCurrentSelectedItem());	
	},
	useSelectedItem: function() {
		var itemStringToInser = this.getCurrentSelectedItem().get("text");
		var itemSel = this.UTILS().useItemSelected(this.searchNamespaceString, itemStringToInser, this.cursor.ch, this.namespace);
		this.codeMirror.replaceRange(itemSel, {
			line: this.cursor.line,
			ch: 0
		}, {
			line: this.cursor.line,
			ch: this.cursor.ch
		});
		this.codeMirror.refresh();
	},
	endAssist: function() {
		//console.log("endAssist");
		if (this.complete!=null) {
			this.complete.empty();
			this.complete.destroy();
			this.complete = null;
		}
		(function(){ this.isAssisting = false; }).delay(50,this);
		return "endAssist";
	},
	UTILS: function() {
		var self = this;
		var getVocabulary = function(namespace,editor_full_text) {
			var currentNamespace = namespace;
			this._currentVocabulary = null;
			var extractedVocabulary = null;
			var vocabulary = this.vocabulary;
			var vocabularyManager_Extract = function (namespace, vocabulary) {
					if (namespace[0] === "") {
						namespace = Array.clone(namespace);
						namespace.shift();
					}
					var vocabularyFound = [];
					var found = null;
					var searchKey = null;
					if (namespace.length === 1) {
						found = vocabulary;
						if (namespace[0] != "/") {
							searchKey = namespace[0];
							searchKey = searchKey.replace(/\*/g, "\\\*");
							searchKey = searchKey.replace(/\./g, "\\\.");
							searchKey = searchKey.replace(/\?/g, "\\\?");
							searchKey = searchKey.replace(/\[/g, "\\\[");
							searchKey = searchKey.replace(/\]/g, "\\\]");
							searchKey = searchKey.replace(/\(/g, "\\\(");
							searchKey = searchKey.replace(/\)/g, "\\\)");
							searchKey = searchKey.replace(/\{/g, "\\\{");
							searchKey = searchKey.replace(/\}/g, "\\\}");
							searchKey = searchKey.replace(/\^/g, "\\\^");
							searchKey = searchKey.replace(/\$/g, "\\\$");
						}
					}
					else if (namespace.length > 1) {
						if (namespace[namespace.length - 1] != "/") {
							searchKey = namespace[namespace.length - 1];
							searchKey = searchKey.replace(/\|/g, "\\\|");
							searchKey = searchKey.replace(/\*/g, "\\\*");
							searchKey = searchKey.replace(/\./g, "\\\.");
							searchKey = searchKey.replace(/\?/g, "\\\?");
							searchKey = searchKey.replace(/\[/g, "\\\[");
							searchKey = searchKey.replace(/\]/g, "\\\]");
							searchKey = searchKey.replace(/\(/g, "\\\(");
							searchKey = searchKey.replace(/\)/g, "\\\)");
							searchKey = searchKey.replace(/\{/g, "\\\{");
							searchKey = searchKey.replace(/\}/g, "\\\}");
							searchKey = searchKey.replace(/\^/g, "\\\^");
							searchKey = searchKey.replace(/\$/g, "\\\$");
						}
						namespace = Array.clone(namespace);
						namespace.pop();
						var tempFound = vocabulary;
						for (var i = 0; i < namespace.length; i++) {
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
						if (typeOf(found) == "object") {
							Object.each(found, function (value, key) {
								if (searchKey === null || key.test("^" + searchKey, "i")) {
									vocabularyFound.push(key);
								}
							});
						}
						else if (typeOf(found) == "array") {
							Array.each(found, function (item, index, object) {
								if (typeOf(item) == "string" || typeOf(item) == "number") {
									item = item.toString();
									if (item.length > 0) {
										if (searchKey === null || item.test("^" + searchKey, "i")) {
											vocabularyFound.push(item.toString());
										}
									}
								}
							});
						}
						vocabularyFound.sort();
					}
					return vocabularyFound;
				};
			extractedVocabulary = vocabularyManager_Extract(namespace, vocabulary);
			var completions = extractedVocabulary;
			if (namespace.length == 1) {
				if (namespace[namespace.length - 1] == "/" || completions.length == 0) {
					var discoveredKeywords = this.UTILS().discoverWords(editor_full_text);
					for (var i = 0; i < discoveredKeywords.length; i++) {
						var currentDiscovered = discoveredKeywords[i];
						var isIn = false || (namespace[namespace.length - 1] == currentDiscovered);
						var x = 0;
						while (!isIn && x < completions.length) {
							if (currentDiscovered == completions[x]) {
								isIn = true;
							}
							x = x + 1;
						}
						if (!isIn) {
							if (namespace[namespace.length - 1] == "/") {
								completions.push(currentDiscovered);
							}
							else {
								var chk = namespace[namespace.length - 1];
								if (currentDiscovered.substring(0, chk.length) == chk) {
									completions.push(currentDiscovered);
								}
							}
						}
					}
				}
			}
			return extractedVocabulary;
		}.bind(self);
		
		var namespaceParser = function (nameSpaceString, caretPosition) {
			if (nameSpaceString === undefined) {
				nameSpaceString = "";
			}
			if (typeOf(caretPosition) != "number") {
				caretPosition = nameSpaceString.length;
			}
			var namespace = [];
			var allowed = ["()", "$", "#"]; /* parser start */
			var positionStart = 0;
			var i = 0;
			for (i = caretPosition - 1; i > 0; --i) {
				var character = nameSpaceString.charAt(i);
				var previousCharacter = nameSpaceString.charAt(i + 1);
				if (character === undefined) {
					break;
				}
				if (character == "." && previousCharacter == ".") {
					positionStart = i + 1 + 1;
					break;
				}
				var cursorJump = 0;
				var endsWithAllowed = allowed.some(function (item) {
					if (item.length == 1) {
						return character == item;
					}
					else if (nameSpaceString.substring(i - item.length + 1, i + 1) == item) {
						//cursorJump = item.length+1;
						cursorJump = item.length - 1;
						return true;
					}
					else if (nameSpaceString.substring(i, i + item.length) == item) {
						return true;
					}
				});
				if (cursorJump > 0) {
					i = i - cursorJump;
					character = nameSpaceString[i];
					previousCharacter = nameSpaceString.charAt(i + 1);
					continue;
				}
				if (character != "." && !(/^\w$/.test(character) || endsWithAllowed)) {
					positionStart = i + 1;
					if (previousCharacter !== undefined) {
						var jumpPrevious = 0;
						if (previousCharacter == ".") {
							//if theres a dot ".", just move forward of 1 position and exit the loop.
							jumpPrevious = 1;
							positionStart = i + 1 + jumpPrevious;
							break;
						}
						var previousCharacterEndsWithAllowed = allowed.some(function (item) {
							if (item.length == 1) {
								if (previousCharacter == item) {
									jumpPrevious = 1;
									return true;
								}
							}
							//forward seek
							else if (nameSpaceString.substring(i, i + item.length) == item) {
								jumpPrevious = item.length;
								return true;
							}
							//back seek
							else if (nameSpaceString.substring(i - item.length + 1, i + 1) == item) {
								jumpPrevious = (-(item.length));
								return true;
							}
						});
						if (!previousCharacterEndsWithAllowed && !/^\w$/.test(previousCharacter)) {
							//here only allowed
							positionStart = i + 1 + jumpPrevious;
						}
					}
					break;
				}
			}
			if (positionStart > caretPosition) {
				positionStart = caretPosition;
			}
			nameSpaceString = nameSpaceString.substring(positionStart, caretPosition).trim();
			if (nameSpaceString.length > 0) {
				namespace = nameSpaceString.split(".");
				if (namespace[namespace.length - 1] === "") {
					namespace[namespace.length - 1] = "/";
				}
			}
			else {
				namespace = ["/"];
			} /* parser end */
			return namespace;
			
		}.bind(self);
		var discoverWords = function(str) {
			var array = [];
			var utilSplit = function (arrayString, splitChar, reAppend) {
					var returnValue = [];
					for (var i = 0; i < arrayString.length; i++) {
						var current = arrayString[i].split(splitChar);
						for (var x = 0; x < current.length; x++) {
							if (current[x].length > 3) {
								returnValue.push(reAppend === true && x > 0 ? splitChar + current[x] : current[x]);
							}
						}
					}
					return returnValue;
				};
			str = str.replace(/[^\w\$\#\.]/g, " ");
			str = utilSplit([str], " ", false);
			str = utilSplit(str, "$", true);
			str = utilSplit(str, "#", true);
			array = str;
			array.sort();
			array = array.unique();
			return array;
		}.bind(self);
		var useItemSelected = function(textarea, text, position, namespace) {
			if (textarea !== undefined && text !== undefined && position !== undefined && namespace !== undefined) {
				namespace = namespace[namespace.length - 1];
				if (namespace == "/") {
					completedText = text;
				}
				else {
					completedText = text.substring(namespace.length, text.length);
				}
				var adjustCaseText = text.substring(0, text.length - completedText.length);
				var textbefore = textarea.substring(0, position);
				textbefore = textbefore.substring(0, textbefore.length - adjustCaseText.length) + adjustCaseText;
				var textafter = textarea.substring(position);
				textarea = textbefore + completedText + textafter;
				return textarea;
			}
			else {
				return "";
			}
		}.bind(self);
				
		return {
			getVocabulary: getVocabulary,
			namespaceParser: namespaceParser,
			discoverWords: discoverWords,
			useItemSelected: useItemSelected
		};
	}
});