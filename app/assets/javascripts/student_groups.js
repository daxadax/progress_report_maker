// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
// 
//  
// http://stackoverflow.com/questions/15130587/jquery-add-or-remove-table-row-based-on-inputs

// var row_i = 0;
// 
// function emptyRow() {
//     row_i++;
//     this.obj = $("<tr></tr>");
//     // this.obj.append('<td><input type="text" size="5" value="' + row_i + '"/></td>');
//     this.obj.append('<td><input type="text"' + row_i + '"id="ss_name' + row_i + '""/></td>');
//     this.obj.append('<td><input type="SELECT"' + row_i + '" id="ss_gender' + row_i + '""/></td>');
// }
// 
// function refresh(new_count) {
//     //how many students we have drawn ?
//     console.log("New count= " + new_count);
//     // alert(new_count);
//     if (new_count > 0) {
//         $('#nos_header').show();
//     } else {
//         $('#nos_header').hide();
//     }
//     var old_count = parseInt($('tbody').children().length);
//     console.log("Old count= " + old_count);
//     //the difference, we need to add or remove ?
//     var rows_difference = parseInt(new_count) - old_count;
//     console.log("Rows diff= " + rows_difference);
//     //if we have rows to add
//     if (rows_difference > 0) {
//         for (var i = 0; i < rows_difference; i++)
//         $('tbody').append((new emptyRow()).obj);
//     } else if (rows_difference < 0) //we need to remove rows ..
//     {
//         var index_start = old_count + rows_difference + 1;
//         console.log("Index start= " + index_start);
//         $('tr:gt(' + index_start + ')').remove();
//         row_i += rows_difference;
//     }
// }
// 
// $(document).ready(function () {
//     //hide table by default
//     $('#nos_header').hide ();
//   
//     $('#nos').change(function () {
//         var opt=$('#nos option:selected');
//           //alert(opt.text());
//         refresh(opt.text());
//     })
// });