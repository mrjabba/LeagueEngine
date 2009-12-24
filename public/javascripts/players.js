$(document).ready(function() {
  PlayersBind();
});

function PlayersBind(){
	$('table.left_menu tr').unbind('hover');
	$('table.left_menu tr').hover(
		function(){
			$(this).find('div.row_left_options').show();
		},
		function(){
			$(this).find('div.row_left_options').hide();
		}
	);

	$('.row_left_options .merge').unbind('click');	
	$('.row_left_options .merge').click(function(){
	   var form = $(this).parents('form').serialize();
		 if(form == ""){
			form = {dummy: "form"}
		 }
	   //$.post($(this).attr('href'), form.serialize(), null, "script"); 
		 $.post($(this).attr('href'), form, null, "script"); 
	   return false;
	});

// $('.row_left_options .merge').click(function(){
//   merge('t17', '333', '157');
//   return false;
// });
}