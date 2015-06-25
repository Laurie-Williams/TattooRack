var voteCountReplace = {
    init: function(){
        //Replace "#comments" with new updated comments html on comment create
        $("#likes a[data-remote]").on("ajax:success", function(e, data, status, xhr){
            $("#likes").html(data);
            voteCountReplace.init();
        });

        //Replace "#comments" with new updated comments html on comment delete
        $("#likes a[data-remote]").on("ajax:success", function(e, data, status, xhr){
            $("#likes").html(data);
            voteCountReplace.init();
        });
    }
};

//Initalize
$(document).on('ready page:load', function () {
    voteCountReplace.init()
});