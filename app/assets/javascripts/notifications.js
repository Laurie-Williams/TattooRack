var notifications = {
    init: function(){
        var $notifications_panel = $("#notifications_panel");

        $notifications_panel.hide();
        notifications.setClickCallback();
        notifications.getNotificationsCount();
        setInterval(notifications.getNotificationsCount, 3*60*1000);

    },
    setClickCallback: function(){
        var $notifications_panel = $("#notifications_panel");
        var $notifications_button = $("#notifications_button");
        var $notifications_count = $("#notifications-count");
        $notifications_button.on("click", function(e){
            if ($notifications_panel.css('display') == 'none') {
                notifications.getNotifications();
            } else {
                $notifications_count.text("");
                $notifications_panel.slideUp("fast");
            }
            e.preventDefault();
        })
    },
    getNotifications: function(){
        var $notifications_button = $("#notifications_button");
        if ($notifications_button.is(":visible")) {
            $.ajax({
                async: true,
                type: 'GET',
                url: "/notifications",
                success: function(data){
                    var $notifications_panel = $("#notifications_panel");
                    $notifications_panel.html(data);
                    $notifications_panel.slideDown("fast");
                }
            });
        }

    },
    getNotificationsCount: function(){
        $.ajax({
            async: true,
            type: 'GET',
            url: "/notifications/count",
            success: function(data){
                var $notifications_count = $("#notifications-count");
                if (data == "0") {
                    $notifications_count.text("");
                } else {
                    $notifications_count.text(data);
                }
            }
        });
    }
};
        //Initalize
$(document).on('ready page:load', function () {
    notifications.init();
});