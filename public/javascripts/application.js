$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});

jQuery.ajaxSetup({
	'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

$(function() {
  LeaguesEditInit();

  $('.datePicker').datepicker({ dateFormat: 'dd MM yy'});
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


function flash_notice(msg){
	//alert("Notice: "+msg);
	//$('#content').prepend('<div id="flash_notice">'+<%= @notice %>+'</div>')
	  //$('#flash_notice').fadeOut('slow');
}
function flash_error(msg){
	alert("Error: "+msg);
}

/**********************************************************************
*********            admin leagues
***********************************************************************/

$(function() {
  $('#admin_leagues .league').hover(
    function () {
      $(this).find('a').show();
    }, 
    function () {
      $(this).find('a').hide();
    }
  );
});