jQuery(function() {
    $( "#from" ).datepicker({
      dateFormat: 'yy-mm-dd',
      minDate: new Date(),
      changeMonth: true,
      showOtherMonths: true,
      dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      // nextText: "Next",
      // prevText: "Previous",
      onClose: function( selectedDate ) {
        $( "#to" ).datepicker( "option", "minDate", selectedDate );
      }
    });
    $( "#to" ).datepicker({
      dateFormat: 'yy-mm-dd',
      // defaultDate: "+1w",
      minDate: new Date("#from"),
      changeMonth: true,
      // numberOfMonths: 2,
      changeYear: true,
      yearRange: '-0:+5',
      dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      onClose: function( selectedDate ) {
        $( "#from" ).datepicker( "option", "maxDate", selectedDate );
      }
    });
  });