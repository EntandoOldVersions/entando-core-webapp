/* XML Methods for MooTools */
/* Requires MooTools v1.2 */

var XML = {
	
	rootFromFile: function(file){
		var root = null;
		switch (Browser.Engine.name){
			case 'webkit':
				var xmlhttp = new XMLHttpRequest();
				xmlhttp.open('GET', file, false);
				xmlhttp.send(null);
				return xmlhttp.responseXML;
			case 'trident': root = new ActiveXObject('Microsoft.XMLDOM');
			default: root = root || document.implementation.createDocument('', '', null);
		}

		root.async = false;
		root.load(file);
		return root;
	},
	
	rootFromString: function(string){
		var root;

		if (Browser.Engine.trident){
			root = new ActiveXObject('Microsoft.XMLDOM');
			root.async = false;
			root.loadXML(string);
		} else {
			root = new DOMParser().parseFromString(string, 'text/xml');
		}

		return root;
	},
	
	rootToHashes: function(root){
		var hashes = [], children = root.childNodes;

		for (var i = 0, l = children.length; i < l; i++){
			var hash = XML.nodeToHash(children[i]);
			if (hash) hashes.push(hash);
		}

		return hashes;
	},
	
	nodeToHash: function(node){
		switch ($type(node)){

			case 'element':
				var attributes = node.attributes;
				var attributesLength = attributes.length;

				var attributesHash = {};

				for (var j = 0; j < attributesLength; j++){
					var attribute = attributes[j];
					if (attribute.nodeValue && attribute.nodeValue != 'inherit') attributesHash[attribute.nodeName] = attribute.nodeValue;
				}

				return {tag: node.nodeName.toLowerCase(), attributes: attributesHash, children: XML.rootToHashes(node)};

			case 'textnode': return {text: node.nodeValue};

			default: return null;
		}
	},
	
	hashesToTree: function(hash){
		var tree = [];
		for (var i = 0, l = hash.length; i < l; i++) tree.push(XML.hashToElement(hash[i]));
		return tree;
	},
	
	hashToElement: function(hash, tag){
		var element;
		if (hash.text) element = document.newTextNode(hash.text);
		else element = document.newElement(tag || hash.tag, hash.attributes).adopt(XML.hashesToTree(hash.children));
		return element;
	},
	
	hashToHTML: function(hash, level){
		var tabs = new Array(level || 0).join('\t');
		if (hash.text) return tabs + hash.text;
		var attributes = [''];
		for (var p in hash.attributes) attributes.push(p + '="' + hash.attributes[p] + '"');
		attributes = attributes.join(' ');
		var open = tabs + '<' + hash.tag + attributes + '>\n';
		var close = '\n' + tabs + '</' + hash.tag + '>';
		var children = XML.hashesToHTML(hash.children, level + 1);
		return open + children + close;
	},

	hashesToHTML: function(hashes, level){
		var html = [];
		for (var i = 0, l = hashes.length; i < l; i++) html.push(XML.hashToHTML(hashes[i], level));
		return html.join('\n');
	},
	
	transform: function(xml, xsl){
		xml = (typeof xml == 'string') ? XML.rootFromFile(xml) : xml;
		xsl = (typeof xsl == 'string') ? XML.rootFromFile(xsl) : xsl;
		
		var temp = document.newElement('div');
		
		if (Browser.Engine.trident){
			var html = xml.transformNode(xsl);
			temp.innerHTML = html;
		} else {
			var xslt = new XSLTProcessor();
			xslt.importStylesheet(xsl);
			var root = xslt.transformToFragment(xml, document);
			temp.appendChild(root);
		}
		
		var children = [];
		for (var i = 0, l = temp.childNodes.length; i < l; i++){
			var element = temp.childNodes[i], type = $type(element);
			if (type == 'element' || type == 'textnode') children.push(element);
		}
		return children;
	}
	
};
