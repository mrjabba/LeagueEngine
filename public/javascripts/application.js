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
*********    common
***********************************************************************/
$(function() {
  $('.x_show_confirm').live('click', function(){
    $(this).parent().toggle();
    $(this).parent().next().toggle();
  });

  $('.x_del_cancel').live('click', function(){
    $(this).parent().toggle();
    $(this).parent().prev().toggle();
    return false;
  });
});

/**********************************************************************
*********            admin leagues
***********************************************************************/

$(function() {
  $('#admin_leagues .league').live('hover',
    function () {
      $(this).find('a').show();
    }, 
    function () {
      $(this).find('a').hide();
    }
  );

  $('.league_form .x_add_team').live('click', function(){
    $(this).prev().append(blank_team);
  });

  $('.league_form .x_del_team').live('click', function(){
    $(this).parents('.team').remove();
    return false;
  });
});

/**********************************************************************
*********            account new
***********************************************************************/

$(function() {
  $('#sport select').change(function(){
    if ($(this).find("option:selected").text() == '-Not in this list'){
      $('.other_sport').show();
    }else{
      $('.other_sport').hide();
    }
  });
});
