
//Initalize
$(document).on('ready page:load', function () {
    // Submit search form on Enter
    $("#q").on("keypress", function(e){
        if(e.which == 13) {
            $("#search_form").submit();
        }
    });
});