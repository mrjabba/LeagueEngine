$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});

jQuery.ajaxSetup({
	'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

$(document).ready(function() {
  LeaguesEditInit();
  GameInit();
  PlayerInit();
});

function LeaguesEditInit()
{
  $('#LeaguesAddTeam').click(function(){
    $('#LeaguesAddTeamForm').toggle();
    return false;
  });
  
  $('.LeagueTeamDestroy').click(function(){
    var team_id = $(this).attr('id');
    $.post('/teams/destroy/'+team_id, {authenticity_token: AUTH_TOKEN});
    $(this).parents('tr').remove();
    return false;
  });
}

function GameInit () {	
  $('.teamSelect').change(function(){
		var tagid = $(this).attr("id");
		if (tagid == "game_team1_id")
			tagid = "team1";
		if (tagid == "game_team2_id")
	  	tagid = "team2";
	  //alert("tagid="+tagid);
	  var teamid = $(this).val();
	  //alert("teamid="+teamid);
	  $.post("/games/replace_team", {teamid: teamid, team: tagid}, null, "script"); 
	 	//$("#team1").html("ok the replace works");
	}); 
	
	$('table.teamlist input').change(function(){
	  $('table.teamlist')
	  $(this).parents('table').find('input').each('')
	});
}

function PlayerInit() {
	$('table.left_menu tr').hover(
		function(){
			$(this).find('div.row_left_options').show();
		},
		function(){
			$(this).find('div.row_left_options').hide();
		}
	);
	
	$('.row_left_options .merge').click(function(){
   var form = $(this).parents('form');
   var player_id = $(this).attr('id')
   $.post($(this).attr('href'), form.serialize(), 
	   function(data_back){
		   if(data_back == 'completed'){
			 	 $('input[checked:checked]').each(function(){
				   if(this.attr('value') == player_id){
					   this.parents('tr').remove();
					 }
				 });
			 }
	 }); 
   return false;
	});
}