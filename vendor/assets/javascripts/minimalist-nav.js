// JavaScript Document
// UTF-8
(function ($) {
    'use strict';

    $.fn.pulldown = function (option) {
        var elm = this,
            options,
            delaySpeed = 75;

        // オプション
        options = $.extend({
            slideSpeed: 75
        }, option);

        elm.find('ul li').hover(function () {
            // ホバー時
            $('>ul', $(this))
                .stop(true, false)
                .slideDown(options.slideSpeed);
        }, function (){
            // ホバーが外れた時
            $('>ul', $(this))
                .delay(delaySpeed)
                .slideUp(options.slideSpeed);
        });

        return this;
    }

})(jQuery);