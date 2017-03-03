{if $is_new_msg['is_notice']==0}
    <div style="position: absolute;top: 0;left: 0;right: 0;height: 30px;background: rgba(0,0,0,0.5);text-align: center;color: #FFF;line-height: 30px;">
        有一条新公告
    </div>
{/if}
<!--底部导航-->
<div class="grab-menu">
    <a class="fl alink {if Core::$urls['action']=='' || Core::$urls['action']=='ready'} current{/if}"
       href="{$_home}grab_order/ready">
        <span class="icon1 icon-grabmenu"></span>

        <p>抢单</p>
    </a>
    <a class="fl alink {if Core::$urls['action']=='create'} current{/if}" href="{$_home}grab_order/create">
        <span class="icon2 icon-grabmenu"></span>

        <p>新建</p>
    </a>
    <a class="fl alink {if Core::$urls['action']=='credit'} current{/if}" href="{$_home}grab_order/credit">
        <span class="icon3 icon-grabmenu"></span>

        <p>积分</p>
    </a>
    <a class="fr alink {if Core::$urls['action']=='notice'} current{/if}" href="{$_home}grab_order/notice">
        <span class="icon4 icon-grabmenu"></span>

        <p>公告</p>
    </a>
</div>
<!--刷新按钮-->
<div class="reload js-reload" onclick="window.location.reload()"></div>
<!--回到顶部按钮-->
<div class="upward js-upward"></div>
<!--置顶公告-->
{*<div class="top-notice">1条新的公告</div>*}