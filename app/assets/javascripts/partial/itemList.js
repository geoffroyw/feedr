var showAction = function(_this) {
    _this.find('.actions').removeClass('hide');
};

var hideAction = function(_this) {
    _this.find('.actions').addClass('hide')
};

var mark_as_read = function(_this, feed_id, item_id) {
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
};




$(document).ready(function() {
    $(document).on('mouseenter','.js-display-action',function(){
        showAction($(this))
    });

    $(document).on('mouseleave','.js-display-action',function(){
        hideAction($(this))
    });

    $(document).on('click', '.js-remove-unread-state', function() {
        $(this).parents('.feed').removeClass('unread');
        $(this).removeClass('js-remove-unread-state');
    });

    $(document).on('click', '.js-show-content', function(event) {
        event.preventDefault();

        if ($(this).attr('data-action') == 'show') {


            var feed_id = $(this).attr('data-feed');
            var item_id = $(this).attr('data-item');

            if($(this).parents('.feed').hasClass('unread')) {
                mark_as_read($(this),feed_id, item_id);

            }


            var fetched = $(this).attr('data-item-fetched');
            if(!fetched) {
                var _this = $(this);
                $.ajax({
                    url: "/feeds/" + feed_id + "/items/" + item_id,
                    method: "get",
                    success: function (data) {
                        _this.parents('.row').siblings('.content').html(data);
                        _this.parents('.row').siblings('.content').removeClass('hide');
                        _this.attr('data-item-fetched', true);
                    }
                });
            } else {
                $(this).parents('.row').siblings('.content').removeClass('hide');
            }



            $(this).children('.glyphicon').removeClass('glyphicon-plus');
            $(this).children('.glyphicon').addClass('glyphicon-minus');

            $(this).attr('data-action', 'hide')
        } else {
            $(this).parents('.row').siblings('.content').addClass('hide');

            $(this).children('.glyphicon').addClass('glyphicon-plus');
            $(this).children('.glyphicon').removeClass('glyphicon-minus');

            $(this).attr('data-action', 'show')

        }

    });
    
    $(document).on('click', '.js-mark-read', function(event) {
        event.preventDefault();

        if ($(this).parents('.feed').hasClass('unread')) {
            var feed_id = $(this).attr('data-feed');
            var item_id = $(this).attr('data-item');
            mark_as_read($(this), feed_id, item_id);
        }
    });


});