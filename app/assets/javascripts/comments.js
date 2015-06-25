var commentReplace = {
  init: function(){
      //Replace "#comments" with new updated comments html on comment create
      $("#new_comment").on("ajax:success", function(e, data, status, xhr){
          $("#comments").html(data);
          commentReplace.init();
          $("#comment_comment").val("");
      });

      //Replace "#comments" with new updated comments html on comment delete
      $("#comments a[data-remote]").on("ajax:success", function(e, data, status, xhr){
          $("#comments").html(data);
          commentReplace.init();
      });
  }
};

//Initalize
$(document).on('ready page:load', function () {
    commentReplace.init()
});