// $.getScript("/static/components/codemirror/keymap/vim.js", function() {
//     if (! IPython.Cell) return;
//     IPython.Cell.options_default.cm_config.keyMap = "vim";
// });

// require(["nbextensions/vim"], function (vim_extension) {
//     vim_extension.load_extension();
// });

$([IPython.events]).on('notebook_loaded.Notebook', function(){
	$('div#header').hide()
	$('div#maintoolbar').hide()
	IPython.layout_manager.do_resize();
})
