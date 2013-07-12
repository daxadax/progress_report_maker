// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
// 
//  
// http://stackoverflow.com/questions/15130587/jquery-add-or-remove-table-row-based-on-inputs

var row_i = 0;
// var regex_for_id = /\dx[a-z\d]{14}/


// var myRe = /d(b+)d/g;
// var myArray = myRe.exec("cdbbdbsbz");
// console.log("The value of lastIndex is " + myRe.lastIndex);
// 
// var re = /(\w+)\s(\w+)/;
// var str = "John Smith";
// var newstr = str.replace(re, "$2, $1");
// console.log(newstr);


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
  
    $('#nos').change(function () {
        var opt=$('#nos option:selected');
          //alert(opt.text());
        refresh(opt.text());
    })


	// $(".layout")
	//   .on('ajax:beforeSend', ".progress_bar", function(){ 
	//     // get id of element to make visible
	//     var progress_bar_id = '#' + this.getAttribute('data-progress-bar');
	//     $(progress_bar_id).show();
	//   })
	
	
	//   <td id="student_name" class="field form_field">
	// <input id="student_group_students_attributes___Student:0x00000103de4be0__name" 
	// name="student_group[students_attributes][#&lt;Student:0x00000103de4be0&gt;][name]" 
	// placeholder="Student name" size="30" type="text" />
	// </td>
	
 });