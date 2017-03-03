<a href="javascript:void(0)" onclick="clearPosition(this)" data-id="{$demand_id}"
   class="btn btn-default btn-xs">重新分配</a>
{static "core/yunspace.js"}
<script>
    function clearPosition(e) {
        var demand_id = $(e).attr('data-id');
        YunSpace.api('grab/order/allot.jsonp', {
            demand_id: demand_id,
            action: 'clear'
        }, function (data) {
            top.alert(data.msg);
            window.location.reload();
        });
    }
</script>
