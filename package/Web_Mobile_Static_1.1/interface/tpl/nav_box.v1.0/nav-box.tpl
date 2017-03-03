<ul>
    <li>
        <a href="{$_home}">
            <img src="img/nav_box.v1.0/s1.png"/>

            <p>首页</p>
        </a>
    </li>
    <li>
        <a href="{$_home}space/">
            <img src="img/nav_box.v1.0/s2.png"/>

            <p>空间场地</p>
        </a>
    </li>
    <li>
        <a href="{$_home}service/">
            <img src="img/nav_box.v1.0/s3.png"/>

            <p>配套服务</p>
        </a>
    </li>
    {*临时注释*}
    {*<li>*}
        {*<a href="javascript:;">*}
            {*<img src="img/nav_box.v1.0/s4.png"/>*}

            {*<p>活动案例</p>*}
        {*</a>*}
    {*</li>*}
    <li>
        <a href="{$_home}set_list/">
            <img src="img/nav_box.v1.0/s5.png"/>

            <p>超值套餐</p>
        </a>
    </li>
    {if $__user['id']}
    <li>
        <a href="{$_root}user_center/user_admin/order">
            <img src="img/nav_box.v1.0/s9.png"/>

            <p>交易管理</p>
        </a>
    </li>
    <li>
        <a href="{$_root}user_center/">
            <img src="img/nav_box.v1.0/s8.png"/>

            <p>用户中心</p>
        </a>
    </li>
    {else}
    <li>
            <a href="{$_home}user_center/">
                <img src="img/nav_box.v1.0/s8.png"/>

                <p>登录/注册</p>
            </a>
    </li>
    {/if}


</ul>