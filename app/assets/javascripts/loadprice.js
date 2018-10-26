$(document).ready(function() { 
	var at,pt,ar,ai;
  at = $("a.tascode");
 if(at[0]){
 	 ap = at.attr("href");
 	 ar = "https://tradenaira.com/pages/liveprice/"+ap;
 	 ai = '<iframe src="'+ar+'" frameborder="0" scrolling="no" height="100px" width="100%"></iframe>';
 	 at.replaceWith(ai);
 }
})