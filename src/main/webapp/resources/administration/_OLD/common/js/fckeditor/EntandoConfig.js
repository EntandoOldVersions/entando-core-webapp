FCKConfig.Plugins.Add( 'japslink', 'en,it' );

FCKConfig.DocType = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">' ;
FCKConfig.ForcePasteAsPlainText	= true ;
//default toolbar - very few buttons
FCKConfig.ToolbarSets["Entando-default"] = [
	['Bold','Italic','-','OrderedList','UnorderedList','-','Table','-','Source']
];
//bit more complex - with japslink plugin, suitable for content editing
FCKConfig.ToolbarSets["Entando"] = [
	['Bold','Italic','-','OrderedList','UnorderedList','-','japslink','Unlink','-','Table','-','Source']
];