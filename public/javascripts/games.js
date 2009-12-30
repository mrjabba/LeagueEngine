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
	  $.post("/games/replace_team", {teamid: teamid, team: tagid}, null, "script"); 
	 	//$("#team1").html("ok the replace works");
	}); 
}