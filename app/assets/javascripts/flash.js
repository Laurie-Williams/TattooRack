var flash = {
    init: function(){
        setTimeout(flash.fadeFlash , 1000);
    },

    fadeFlash: function(){
        $("#flash").fadeOut("slow", function(){
            $(this).remove;
        })

    }
};
//Initalize
$(document).on('ready page:load', function () {
    flash.init();
});