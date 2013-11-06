// modifed from http://stackoverflow.com/a/6520723/2128691

var count = 1;

//  add goal field
$(function() {
    $('#add_goal').click(function() {
        addGoal();
    });
});

function addGoal()
{
    $('#goal_form').append('<div class="goal_field fields"><input id="goals_" name="goals[]" placeholder="Students should..." type="text" /></div>');
    count++;
}

// remove goal field
$(function() {
    $('#remove_goal').click(function() {
        removeGoal();
    });
});

function removeGoal() 
{
    $('#goal_form div:last').remove();
    count--;
}

// hide help div
$(function() {
    $('#show_goal_help').click(function() {
        $('#help').slideToggle();
    });
});

