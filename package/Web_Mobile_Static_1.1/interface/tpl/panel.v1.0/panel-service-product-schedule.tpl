<div class="relative" style="width:100%;height:100%;z-index:1">
    <div class="border">
        <div class="calendar">
            <div class="showDate" style="width:90%;margin:0 auto;">
            </div>
            <ul>
                <li class="statue">
                    <div class="color-choose" style="background: #999999"></div>
                    <p class="pre">已预订</p>
                </li>
                <li class="statue">
                    <div class="color-choose" style="background: #ffffff"></div>
                    <p class="pre">未预订</p>
                </li>
            </ul>
            <div class="clear"></div>
        </div>
    </div>
    <div class="covers absolute js-covers" style="left:0px;top:0px"></div>
    <div class="modal-schedule absolute js-modal-schedule">
        <div class="modal-body relative">
            <div class="modal-p">
                <p class="modal-p-title">档期查询:<span class="modal-p-title-span js-modal-p-title-span">
                        {if $page->productInfo['product_name']}
                            {$page->productInfo['product_name']}
                        {/if}
                        {if $page->info['set_name']}
                            {$page->info['set_name']}
                        {/if}
                    </span></p>
            </div>
            <div class="modal-p">
                <p class="modal-p-title">即将为您查询<span class="js-date"></span>的档期情况</p>
            </div>
            <div class="modal-p" style="height:40px;">
                <div class="modal-input">
                    <span class="icon ion-android-phone-portrait modal-icon-style"></span>
                    <input type="text" placeholder="请输入你的手机号码" class="js-service-phone"/>
                </div>
            </div>
            <div class="modal-p modal-p1">
                <p class="modal-p-title">请留下您的联系方式，我们将安排专业的活动顾问为您提供后续服务。</p>
            </div>
            <div class="modal-p">
                <a href="javascript:;" class="modal-submit js-modal-submit">提交</a>
            </div>
            <a href="javascript:;" class="close-schedule absolute js-close-schedule"><span
                        class="icon ion-close-round"></span></a>
        </div>
    </div>
    <div class="submit-success absolute js-submit-success">
        提交成功
    </div>
</div>
<script>

    $(function () {

        var showDate = $('.showDate').fullCalendar({
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
            //theme: true,
            eventLimit: true, // allow "more" link when too many events
            dayNamesShort: [
                '日', '一', '二', '三', '四', '五', '六'
            ],
            events: [
                    {foreach $data as $k=>$v}{
                    start: '{$v['service_date']}',
                    rendering: 'background',
                    color: '#999999'
                },
                {/foreach}
            ],
            monthNamesShort: [
                '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'

            ],
            monthNames: [
                '一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'
            ],
            dayClick: function (date, jsEvent, view) {
                var myDate=new Date();
                var currentDate=myDate.getTime()
                serviceDate=date.format();
                date = new Date(Date.parse(serviceDate.replace(/-/g, "/")));
                var stringDate = date.getTime();
                if(stringDate<=currentDate){
                    alert("预定时间必须在当天之后！！")
                }else{
                    $(".js-modal-schedule,.js-covers").show();
                    $(".js-date").html(serviceDate);
                }
            }
        });

        var serviceDate, color;
        $(".js-close-schedule").click(function () {
            $(".js-modal-schedule,.js-covers").hide();
        })
        $(".js-modal-submit").click(function (e) {

            var ask_type = '';
            var ask_id = '';
            //空间
            {if $page->productInfo['id']}
            ask_type = 2;
            ask_id ={$page->productInfo['id']};
            {/if}
            //套餐
            {if $page->info['set_name']}
            ask_type = 6;
            ask_id = {$page->id};
            {/if}

            var phone = $(".js-service-phone").val();
            $(".js-modal-schedule,.js-covers").hide();
            YunSpace.api('demand/create.jsonp',{
                ask_type: ask_type,
                ask_id: ask_id,
                username: '移动端',
                phone: phone,
                content: serviceDate,
                action:'consult'
            }, function (data) {
                $(".js-submit-success").html(data.msg);
                $(".js-submit-success").fadeIn().delay(1000).fadeOut("slow",function() {
                    if (data.status == 1) {
                        $(".js-service-phone").val('');
                        $(".close-panel").trigger('click');
                    }
                });
            });
        });
    })
</script>
