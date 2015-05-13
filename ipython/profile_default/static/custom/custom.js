$([IPython.events]).on('notebook_loaded.Notebook', function(){
   // $('div#header').hide()
   $('div#maintoolbar').hide()
   IPython.layout_manager.do_resize();

   require(['/static/custom/hide_input.js'])
   require(['/static/custom/hide_input_all.js'])
   require(['/static/custom/shift-tab.js'])
   require(['/static/custom/comment-uncomment.js'])
})

// VIMCEPTION FOR THE WIN!
function load_vimception() {
   cell = IPython.notebook.insert_cell_at_index('code', 0);
   IPython.notebook.select(0);
   cell.set_text('%load_ext vimception\n%reload_ext vimception\n%vimception');
   if (!IPython.notebook.kernel) {
      $([IPython.events]).on('status_started.Kernel', function() {
         cell.execute();
         IPython.notebook.delete_cell();
      });
   } else {
      cell.execute();
      IPython.notebook.delete_cell();
   }
}

$([IPython.events]).on('notebook_loaded.Notebook', function(){
   $('#help_menu').prepend([
         '<li id="vimception" title="load up vimception cell">',
         '<a href="#" title="vimception" onClick="load_vimception()">vimception</a></li>',
         '<li id="reflow" title="reflow markdown text">',
         '<a href="#" title="vimception" onClick="reflow_markdown()">reflow text</a></li>',
   ].join("\n"));

   // uncomment next line to *always* start in vimception
   // $('#vimception a').click();
});
