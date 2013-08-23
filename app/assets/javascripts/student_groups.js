

$(document).ready(function () {

    //  add student field
	$(function() {
	    $('#add_student').click(function() {
	        addStudent();
	    });
	});
	
	function addStudent()
	{
	    $('#students_form_table').append('<tr><td id="student_name" class="field form_field"><input id="student_group_students_attributes__name" name="student_group[students_attributes][][name]" placeholder="Student name" size="30" type="text" /></td><td id="student_gender" class="field dropdown"><select id="student_group_students_attributes__gender" name="student_group[students_attributes][][gender]"><option value="">select a gender</option><option value="Female">Female</option><option value="Male">Male</option><option value="Transgender">Transgender</option></select></td></tr>');
	}
	
	// remove student field
	$(function() {
	    $('#remove_student').click(function() {
	        removeStudent();
	    });
	});
	
	function removeStudent() 
	{
	    $('#students_form_table tr:last').remove();
	    count--;
	}

    // fadeout flash messages
	$('.flash').not('.login_error').fadeIn(function() {
	    setTimeout(function() {
	        $('.flash').fadeOut();
	    }, '2000');
	});
		
 });