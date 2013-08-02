// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
// 
//  
// http://stackoverflow.com/questions/15130587/jquery-add-or-remove-table-row-based-on-inputs

var row_i = 0;

function emptyRow() {
    row_i++;
    this.obj = $("<tr></tr>");
    this.obj.append('<td id="student_name" class="field form_field"><input id="student_group_students_attributes__name" name="student_group[students_attributes][][name]" placeholder="Student name" size="30" type="text" /></td>');
    this.obj.append('<td id="student_gender" class="field dropdown"><select id="student_group_students_attributes__gender" name="student_group[students_attributes][][gender]"><option value="">select a gender</option><option value="Female">Female</option><option value="Male">Male</option><option value="Transgender">Transgender</option></select></td>');
    this.obj.append('<td id="remove_link"><input id="student_group_students_attributes___destroy" name="student_group[students_attributes][][_destroy]" type="hidden" /><a href="#" class="remove_fields dynamic">remove student</a></td>')
}

function refresh(new_count) {
    //how many students we have drawn ?
    console.log("New count= " + new_count);
    // alert(new_count);
    if (new_count > 0) {
        $('#students_form_table').show();
    } 
    else {
        $('#students_form_table').hide();
    }
    var old_count = parseInt($('tbody').children().length);
    console.log("Old count= " + old_count);
    //the difference, we need to add or remove ?
    var rows_difference = parseInt(new_count) - old_count;
    console.log("Rows diff= " + rows_difference);
    //if we have rows to add
    if (rows_difference > 0) {
        for (var i = 0; i < rows_difference; i++)
        $('tbody').append((new emptyRow()).obj);
    } else if (rows_difference < 0) //we need to remove rows ..
    {
        var index_start = old_count + rows_difference + 1;
        console.log("Index start= " + index_start);
        $('tr:gt(' + index_start + ')').remove();
        row_i += rows_difference;
    }
}

$(document).ready(function () {
    //hide table by default
    $('#students_form_table').hide();
    
    //function to change the number of rows for student input
    //based on the number of students selected  
    $('#nos').change(function () {
        var opt=$('#nos option:selected');
        refresh(opt.text());
    })
   
    //fadeout flash messages
    $('.flash').fadeIn(function() {
	    setTimeout(function() {
	        $('.flash').fadeOut();
	    }, '2000');
	});
	
 });
