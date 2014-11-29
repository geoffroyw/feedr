/**
 * Created by geoffroy on 29/11/14.
 */

function updateUnreadCount() {

    $.ajax({
        url: "/feeds/unread_item_count",
        method: "get",
        dataType: "json",
        success: function(data) {
            if(data.success) {
                $.each($.parseJSON(data.values), function(i, e) {
                    $('*[data-badge-for="'+e.id+'"]').html(e.count);
                    console.log($('.badge, *[data-feed="'+e.id+'"'))
                })
            }
        }
    })
}


$(document).ready(function() {
    setInterval(updateUnreadCount,30000);

})