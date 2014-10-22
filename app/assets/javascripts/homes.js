
$(document).ready(function() {

    var showAction = function(_this) {
        _this.find('.actions').removeClass('hide');
    }

    var hideAction = function(_this) {
        _this.find('.actions').addClass('hide')
    }

    $('.js-display-action').hover(function(){
        showAction($(this))
    }, function() {
        hideAction($(this))
    })

    $('.js-show-content').on('click', function(event) {
        event.preventDefault();

        if ($(this).attr('data-action') == 'show') {
            $(this).parents('.row').siblings('.content').removeClass('hide');

            var feed_id = $(this).attr('data-feed')
            var item_id = $(this).attr('data-item')

            if($(this).parents('.feed').hasClass('unread')) {
                var _this = $(this);
                $.ajax({
                    url: "/feeds/"+feed_id+"/items/"+item_id+"/read",
                    method: "post",
                    dataType: "json",
                    success: function(data) {
                        if(data.success) {
                            _this.parents('.feed').removeClass('unread')
                        }
                    }
                })

            }



            $(this).children('.glyphicon').removeClass('glyphicon-plus')
            $(this).children('.glyphicon').addClass('glyphicon-minus')

            $(this).attr('data-action', 'hide')
        } else {
            $(this).parents('.row').siblings('.content').addClass('hide')

            $(this).children('.glyphicon').addClass('glyphicon-plus')
            $(this).children('.glyphicon').removeClass('glyphicon-minus')

            $(this).attr('data-action', 'show')

        }

    })


})