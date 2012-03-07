CKEDITOR.editorConfig = function(config) {
	//config.language = 'fr';
	config.extraPlugins = 'entandolink';
	//config.uiColor = '#AADC6E';
	config.toolbar = [['Bold', 'Italic', '-', 'NumberedList','BulletedList', '-', 'entandolink', 'Unlink', '-', 'Undo','Redo', '-', 'Table', '-', 'Source']];
	config.height = 250;
};