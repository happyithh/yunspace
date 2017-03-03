<style>
    .fc-scroller{
        height:auto!important;
    }
    .fc-day{
        z-index:8888;
    }
    .fc-day-number{

    }

</style>
<div class="s_left_c mt0" style="border-bottom: none;">
    <div class="container">
        <div class='bpdate'>
            <span class="titp">开始时间 :</span>
            <input type="hidden" name="data[is_schedule]" value="1">
            <div class="form-group che">
                {if $start_time}
                    <input type='text' class="form-control" readonly value="{date('Y-m-d',$start_time)}"/>
                {else}
                    <div class='input-group date' id='datetimepicker1'>
                        <input type='text'  id='datetimepicker_input1' class="form-control" placeholder="请选择" name="data[start_date]"/>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                            </span>
                    </div>
                {/if}
            </div>
        </div>
        <div class='bpdate'>
            <span class="titp">结束时间 :</span>

            <div class="form-group che">
                {if $start_time}
                    <input type='text' class="form-control" readonly value="{date('Y-m-d',$end_time)}"/>
                {else}
                    <div class='input-group date' id='datetimepicker2'>
                        <input type='text' class="form-control" id='datetimepicker_input2' placeholder="请选择" name="data[end_date]"/>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                            </span>
                    </div>
                {/if}
            </div>
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
                aspectRatio : 1,
                height: 500,
                contentHeight: 300,
                editable: true,
                timezone:true,
                eventLimit: true, // allow "more" link when too many events
                dayNamesShort:[
                    '日','一','二','三','四','五','六'
                ],
                events:'{$_root}json_product_schedule/?product_id={$info['id']}',
                monthNamesShort :[
                    '一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'

                ] ,
                monthNames :[
                    '一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'
                ],
                dayClick: function(date, jsEvent, view) {
                    if($("#datetimepicker_input1").val()!=''&&$("#datetimepicker_input2").val()!=''){
                        $("#datetimepicker_input1").val('');
                        $("#datetimepicker_input2").val('');
                    }
                    if($("#datetimepicker_input1").val()==''){
                        var date_time1= date.format();
                        $("#datetimepicker_input1").val(date_time1);
                        $('.fc-day').css('background','#ffffff');
                        $(this).css('background','#ebf8fb');
                    }else{
                        var date_time2= date.format();
                        $("#datetimepicker_input2").val(date_time2);
                        $('.fc-day').css('background','#ffffff');
                        var date1=$("#datetimepicker_input1").val();
                        date1 = date1.replace(/-/g,'/');
                        var time1 = new Date(date1);
                        var times1 = time1.getTime();
                        var date2=$("#datetimepicker_input2").val();
                        date2 = date2.replace(/-/g,'/');
                        var time2 = new Date(date2);
                        var times2 = time2.getTime();
                        if(times1>times2){
//                            alert('结束时间必须大于开始时间');
                            $("#datetimepicker_input1").val(date_time2);
                            $("#datetimepicker_input2").val('');
                        }else{
                            $('#showDate').fullCalendar( 'select', $("#datetimepicker_input1").val(), $("#datetimepicker_input2").val())
                        }
                    }
                    $(this).css('background-color', '#ebf8fb');
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

            $('#datetimepicker1').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: 'zh-cn'
            });

            $('#datetimepicker2').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: 'zh-cn'
            });
            $('#datetimepicker_input1').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: 'zh-cn'
            });
            $('#datetimepicker_input2').datetimepicker({
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
</div>