
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
            $(this).parents('.row').siblings('.content').removeClass('hide')

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