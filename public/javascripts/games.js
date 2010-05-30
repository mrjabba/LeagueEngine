$(document).ready(function() {
  GamesBind();
});

function GamesBind () {	
  $('#team1 input[type=text]').autocomplete(team1);
  $('#team2 input[type=text]').autocomplete(team2);

  $('.teamSelect').unbind('change');
  $('.teamSelect').change(function(){
		var tagid = $(this).attr("id");
		if (tagid == "game_team1_id")
			tagid = "team1";
		if (tagid == "game_team2_id")
	  	tagid = "team2";
	  //alert("tagid="+tagid);
	  var teamid = $(this).val();
	  //alert("teamid="+teamid);
	  $('#'+tagid).html("Loading....");
	  $.post("/games/replace_team", {teamid: teamid, team: tagid}, null, "script"); 
	 	//$("#team1").html("ok the replace works");
	}); 
	
	//adds players to js array so I can use it for js validation
	// of player stats
	/*$('#team2 input[type=text]').leave(funciton(){
	  id = $(this).attr('id')
	  team, player_no = id.split('_')
	  name = $(this).value
	});*/
	
	//add player blank stat
	$('.add_player_stat').click(function(){
	  $('table.stat_list tbody').append(blank_player_stat);
    return false;
	});
}