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

function flash_notice(msg){
	alert("Notice: "+msg);
	//$('#content').prepend('<div id="flash_notice">'+<%= @notice %>+'</div>')
	  //$('#flash_notice').fadeOut('slow');
}
function flash_error(msg){
	alert("Error: "+msg);
}