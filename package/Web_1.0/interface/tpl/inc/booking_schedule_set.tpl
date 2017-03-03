<style>
    .fc-scroller {
        height: auto !important;
    }

    .fc-day {
        z-index: 8888;
    }

    .fc-day-number {

    }

</style>
<div class='bpdate'>
    <span class="titp">活动时间 :</span>
    <input type="hidden" name="data[is_schedule]" value="1">

    <div class="form-group che">
        {if $start_time}
            <input type='text' class="form-control" readonly value="{date('Y-m-d',$start_time)}"/>
        {else}
            <div class='input-group date' class='datetimepicker1'>
                <input type='text' class="form-control datetimepicker1" placeholder="活动时间" name="data[start_date]"/>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                            </span>
            </div>
        {/if}
    </div>
</div>

<div class="showDate border1 showDate2">
    <div id="showDate" style="position:relative;">

    </div>
    <div class="datp clearfix">
        <div class="c1">
            <span></span>

            <p>无法预定</p>
        </div>
        {*<div class="c2">*}
        {*<span></span>*}

        {*<p>意向预定</p>*}
        {*</div>*}
        <div class="c3">
            <span></span>

            <p>可以预定</p>
        </div>
    </div>
</div>
<style>
    .fc-color {
        background-color: #000000;
        z-index: 999;
    }
</style>
<link rel="stylesheet" type="text/css" href="css/lightSlider.css">
<link href='css/fullcalendar.css' rel='stylesheet'/>
<link href='css/fullcalendar.print.css' rel='stylesheet' media='print'/>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/jquery.lazyload.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script src='js/fullcalendar.js'></script>
<script type="text/javascript">
    $(document).ready(function () {
        var date_time1;
        var date_time2;
        var showDate = $('#showDate').fullCalendar({
            header: {
                left: 'prev',
                center: 'title',
                right: 'next'
            },
            // start: '2015-02-01',
            // defaultDate: '2015-02-12',
            aspectRatio: 1,
            height: 500,
            contentHeight: 300,
            editable: true,
            timezone: true,
            eventLimit: true, // allow "more" link when too many events
            dayNamesShort: [
                '日', '一', '二', '三', '四', '五', '六'
            ],
            events: '{$_root}json_product_schedule/?product_id={$page->info['schedule_product_id']}',
            monthNamesShort: [
                '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'

            ],
            monthNames: [
                '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'
            ],
            dayClick: function (date, jsEvent, view) {

                {if !$page->info['attr_index']['节假日可选']}
                    if ($(this).hasClass('fc-sat') || $(this).hasClass('fc-sun')) {
                        alert('当前套餐节假日不可选！');
                        return false
                    }
                {/if}
                {if !$page->info['attr_index']['工作日可选']}
                    if ($(this).hasClass('fc-mon') || $(this).hasClass('fc-tue') || $(this).hasClass('fc-wed') || $(this).hasClass('fc-thu') ||$(this).hasClass('fc-fri')) {
                        alert('当前套餐工作日不可选！');
                        return false
                    }
                {/if}
                var date_time1 = date.format();
                $(".datetimepicker1").val(date_time1);
                $('.fc-day').css('background', '#ffffff');
                $(this).css({
                    background: '#FFBFD3'
                });
            }

            // views :{
            // 	month:{
            // 		start : ms,
            // 		end : me,
            // 		intervalStart : ms,

            // 	},
            // 	day:{
            // 		start : ms,
            // 		end : me,
            // 		intervalStart : ms,

            // 	}
            // }
        });
        var moment1 = moment('2015-02-02');
        var moment2 = moment('2015-09-09');
        $.fullCalendar.formatRange(moment1, moment2, 'MMMM D YYYY');

        $('.datetimepicker1').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
        $("#datetimepicker6").on("dp.change", function (e) {
            $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker7").on("dp.change", function (e) {
            $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
        });
    });

</script>