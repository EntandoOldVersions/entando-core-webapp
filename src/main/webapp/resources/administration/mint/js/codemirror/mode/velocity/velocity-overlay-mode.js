/*
---
description: 
	-Velocity sintax Overlay for codemirror 2
authors:
	- Andrea Dessì <a.dessi@agiletec.it>
requires:
	- codemirror2 
	- overlay library
	- xml mode
changelog:
	- 23 mag 2011: fixed velocity inline code when a comma is found
...
*/
CodeMirror.defineMode("velocity", function(config, parserConfig) {
  var velocityOverlay = {
    //some status variable helpers
	state_velocity: {
		prevChar: null,
		velocity: false
	},
	//constants, no need to write them many times
	VELOCITY_CSS_STATUES: {
		"defaultStatus": " velocity ", // this.VELOCITY_CSS_STATUES.defaultStatus //not used
		"open" : " velocity-block-open ", // this.VELOCITY_CSS_STATUES.open
		"close" : " velocity-block-close ", // this.VELOCITY_CSS_STATUES.close
		"inline" : " velocity-inline " // this.VELOCITY_CSS_STATUES.inline
	},
	token: function(stream, state) {
		//instatiate the return value... 
		var returnValue = null;
		//get the current char
		var ch = stream.next();
		//start mathing some velocity code
		if (ch=="#") {
			//matching #end in the next 3 chars...
				if (stream.string.substring(stream.pos,stream.pos+3)=="end") {
					var match = stream.pos+3;
					while (stream.pos<match) { //move 3 chars forward 
						stream.next();
					}
					this.state_velocity.velocity = false;
					returnValue = this.VELOCITY_CSS_STATUES.close; //say we're closing a velocity block (so next chars they will know)
				}
			//matching #else in the next 4 chars (never should match #elseif, watchout!)
				else if (stream.string.substring(stream.pos,stream.pos+4)=="else" && !(stream.string.substring(stream.pos,stream.pos+6)=="elseif")) {
					var match = stream.pos+4;
					while (stream.pos<match) { //move 4 chars forward
						stream.next();
					}
					this.state_velocity.velocity = true;
					returnValue = this.VELOCITY_CSS_STATUES.open;//say we're opening a velocity block (so next chars they will know)
				}
			//matching others...
				else {
					//matching an ending "#block )" 
					var match = stream.string.search(/[^\(]\)/g);
					if (match>-1) {//find what's matching
						match = /[^\(]\)/g;
						var lastIndexOfClosedPar = stream.string.lastIndexOf(")")+1;
						var numberOfParentesisOpen = 0; //how many opened parentesis...
						var numberOfParentesisClose = 0;//how many closed parentesis...
						var prev = "";
						if (prev=="(") { numberOfParentesisOpen=numberOfParentesisOpen+1; }
						else if (prev==")") { numberOfParentesisClose=numberOfParentesisClose+1; }
						var curr = ch;
						var next = stream.peek();
						//var stringToTest = prev+curr+next;
						//until we have found "match chars" (example " ) ") and it's not finished the line and the number of opened parentesis is less than closed parentesis: go on...
						while (!stream.eol() && (stream.pos <= lastIndexOfClosedPar) && (numberOfParentesisOpen==0 || numberOfParentesisClose<numberOfParentesisOpen)) {
							prev = curr;
							if (prev=="(") { numberOfParentesisOpen=numberOfParentesisOpen+1; }
							else if (prev==")") { numberOfParentesisClose=numberOfParentesisClose+1; }
							curr = stream.next();
							next = stream.peek();
						}
						//say we've found an open block and its closing part. change stream status
						this.state_velocity.velocity = false;
						returnValue = this.VELOCITY_CSS_STATUES.open;
					}
				}
				return returnValue;//return what's found
		}
		//if it's not a "#" char
		else {
			//and the current char is not inside a discovered velocity block
			if (this.state_velocity.velocity == false) {
				//check if it's a velocity variable starting with dollar sign $
					if (/[\$]/.test(ch)) {
						stream.eatWhile(/[\d\w_,]/); //move forward until there's a number or a digit or an underscore
						this.state_velocity.velocity = true;
						returnValue = this.VELOCITY_CSS_STATUES.inline;//say we're starting an inline velocity
					}
			}
			//if it's already velocity code... we have to discover if it's ending...
			else if (this.state_velocity.velocity == true) {
				//check if it's an ending variable like: ...........)
				if (ch==")") {
					returnValue = this.VELOCITY_CSS_STATUES.inline;
					this.state_velocity.velocity = false;
				}
				else if (/[\w\d_\.\(\"\/\\',]/.test(ch)) {
					returnValue = this.VELOCITY_CSS_STATUES.inline;
					this.state_velocity.velocity = true
				}
				//if it's a fullstop check it's before a ")" char
				else if (ch!="." && this.state_velocity.velocity.prevChar==")") {
					this.state_velocity.velocity = false;
				}
				//else: we're not handling velocity code
				else {
					this.state_velocity.velocity = false;
				}
			} 
		}
		//save the used char as previous and go on...
		this.state_velocity.prevChar = ch;
		//return the style matched
		return returnValue;
    }
  };
  return CodeMirror.overlayParser(CodeMirror.getMode(config, parserConfig.backdrop || "text/html"), velocityOverlay);
});