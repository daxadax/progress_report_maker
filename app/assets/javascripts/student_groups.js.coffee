# A proper JavaScript template library would be better
# but this bit of regex mangling will do for now.
# name = ($ "#ss_name").addClass "form_field"
# gender = ($ "#ss_gender").addClass "dropdown"

# http://stackoverflow.com/questions/17405760/adapting-coffeescript-for-a-rails-application?noredirect=1#comment25325428_17405760

# emptyRow = (row_i) ->
#     # $('#empty_row').html().replace(/\{row_i\}/g, row_i)
#     """
#         <tr>
#             <td><input type="text" id="ss_name"></td>
# 		    <td><input type="select" id="ss_gender"></td>
#         </tr>
#     """
# 
# refresh = (need_rows) ->
#     $tbody = $('.student_input_form tbody')
#     current_rows = $tbody.find('tr').length
#     
#     if(current_rows < need_rows)
#         $tbody.append(emptyRow(i)) for i in [current_rows ... need_rows]
#     else if(current_rows > need_rows)
#         $tbody.find("tr:gt(#{need_rows - current_rows - 1})").remove()
#  
# $(document).ready ->
#     $("#nos").change ->
#         refresh(parseInt($(@).val(), 10))