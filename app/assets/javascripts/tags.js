var tagReplace = {
    init: function(){
        //Replace "#tags" with new updated tags html on tag create
        $("#new_tag").on("ajax:success", function(e, data, status, xhr){
            $("#tags").html(data);
            tagReplace.init();
            $("#tag").val("");
        });

        //Replace "#tags" with new updated tags html on comment delete
        $("#tags a[data-remote]").on("ajax:success", function(e, data, status, xhr){
            $("#tags").html(data);
            tagReplace.init();
        });

        //Add autocomplete to tags field
        $("#tag").autocomplete({
            source: $("#tag").data("autocomplete-source")
        });

        //Submit form on enter
        $("#tag").on("keypress", function(e){
            if (e.which == 13){
                $("#new_tag").submit();
            }
        });

        $("#tag #ui-id-1").on("keypress", function(e){
            if (e.which == 13){
                $("#new_tag").submit();
            }
        });
    }
};

//Initalize
$(document).on('ready page:load', function () {
    tagReplace.init()
});