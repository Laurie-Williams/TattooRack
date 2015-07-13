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
        $notifications_button.on("click", function(e){
            if ($notifications_panel.css('display') == 'none') {
                notifications.getNotifications();
            } else {
                $notifications_button.text("Notifications (0)");
                $notifications_panel.slideUp();
            }
            e.preventDefault();
        })
    },
    getNotifications: function(){
        $.ajax({
            async: true,
            type: 'GET',
            url: "/notifications",
            success: function(data){
                var $notifications_panel = $("#notifications_panel");
                $notifications_panel.html(data);
                $notifications_panel.slideDown();
            }
        });
    },
    getNotificationsCount: function(){
        $.ajax({
            async: true,
            type: 'GET',
            url: "/notifications/count",
            success: function(data){
                var $notifications_button = $("#notifications_button");
                $notifications_button.text("Notifications" + " (" + data + ")");
            }
        });
    }
};
        //Initalize
$(document).on('ready page:load', function () {
    notifications.init();
});