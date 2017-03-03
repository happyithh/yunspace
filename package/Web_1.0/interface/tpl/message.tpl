<!DOCTYPE html>
<html>
<head>
    {include "inc/html_head.tpl"}
    <style>

        .media-left img {
            width: 64px;
            height: 64px;
        }

        .media_buyer {
            width: 800px;
            float: left;
        }

        .media_seller {
            width: 800px;
            float: right;
        }

        .media-body t {
            color: #999;
            display: block;
        }

        .load {
            width: 20px;
            margin: auto;
            padding-bottom: 20px;
        }

        .btn-cont a {
            color: #fff;
        }

        .btn-cont a:hover {
            color: #fff;
        }

        .btn-primary1 {
            color: #fff;
            background-color: #24252f;
        }

        .scroller {
            padding: 0px;
            margin: 0px;
            padding-right: 12px;
            overflow: hidden;
        }

        .chats {
            margin: 0;
            padding: 0;
            margin-top: -15px;
            margin-right: 10px;
        }

        .chats li {
            list-style: none;
            padding: 5px 0;
            margin: 10px auto;
            font-size: 12px;
        }

        .chats li img.avatar {
            height: 45px;
            width: 45px;
            -webkit-border-radius: 50% !important;
            -moz-border-radius: 50% !important;
            border-radius: 50% !important;
        }

        .chats li.in img.avatar {
            float: left;
            margin-right: 10px;
        }

        .img-responsive {
            display: block;
            max-width: 100%;
        }

        .chats li .message {
            display: block;
            padding: 5px;
            position: relative;
        }

        .chats li.in .message {
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            text-align: left;
            border: 1px solid #ddd;
            margin-left: 65px;
            background: #fafafa
        }

        .chats li.in .message .arrow {
            display: block;
            position: absolute;
            top: 5px;
            left: -8px;
            width: 0;
            height: 0;

            border-top: 8px solid transparent;
            border-bottom: 8px solid transparent;
            border-right: 8px solid #ddd;
        }

        .chats li.out .message .arrow {
            display: block;
            position: absolute;
            top: 5px;
            right: -8px;
            border-top: 8px solid transparent;
            border-bottom: 8px solid transparent;
            border-left: 8px solid #ddd;
        }

        .chats li.out .message {
            border: 1px solid #ddd;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            margin-right: 65px;
            text-align: right;
        }

        .chats li .name {
            color: #00c3c3; /*更改过*/
            font-size: 13px;
            font-weight: 400;
        }

        .chats li .datetime {
            color: #333;
            font-size: 13px;
            font-weight: 400;
        }

        .chats li.out img.avatar {
            float: right;
            margin-left: 10px;
        }

        .chats li .message .body {
            display: block;
        }

        .chat-form {
            margin-top: 15px;
            padding: 10px;
            background-color: #f2fcfc; /*更改过*/
            overflow: hidden;
            clear: both;
        }

        .chat-form .input-cont {
            margin-right: 40px;
        }

        .chat-form .input-cont .form-control {
            width: 100% !important;
            margin-bottom: 0px;
        }

        .chat-form .input-cont input {
            border: 1px solid #ddd;
            width: 100% !important;
            margin-top: 0;
        }

        .chat-form .input-cont input {
            background-color: #fff !important;
        }

        .chat-form .input-cont input:focus {
            border: 1px solid #4b8df9 !important;
        }

        .chat-form .btn-cont {
            margin-top: -42px;
            position: relative;
            float: right;
            width: 44px;
        }

        .chat-form .btn-cont .arrow {
            position: absolute;
            top: 17px;
            right: 43px;
            border-top: 8px solid transparent;
            border-bottom: 8px solid transparent;
            border-right: 8px solid #24252f; /*更改过*/
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

        .chat-form .btn-cont:hover .arrow {
            border-right-color: #00c3c3; /*更改过*/
        }

        .chat-form .btn-cont:hover .btn {
            background-color: #00c3c3; /*更改过*/
        }

        .chat-form .btn-cont .btn {
            border-radius: 0px 4px 4px 0px;
            margin-top: 8px;
        }

        [class^="fa-"],
        [class*=" fa-"] {
            display: inline-block;
            margin-top: 1px;
            font-size: 14px;
            *margin-right: .3em;
            line-height: 14px;
        }

        [class^="fa-"],
        [class^="glyphicon-"],
        [class^="icon-"],
        [class*=" fa-"],
        [class*=" glyphicon-"],
        [class*=" icon-"] {
            display: inline-block;
            margin-top: 1px;
            font-size: 14px;
            *margin-right: .3em;
            line-height: 14px;
            -webkit-font-smoothing: antialiased;
        }

    </style>
</head>
<body>
{include "inc/header_nav.tpl"}
<div class="content">
    <div class="wbs">
        <div class="booking_step  wrap">
            <ul class="clearfix">
                <li>
                    <span>1</span>

                    <p>预定下单</p>
                </li>
                <li>
                    <span>2</span>

                    <p>订单审核</p>
                </li>
                <li class="active">
                    <span>3</span>

                    <p>交易签约</p>
                </li>
                <li>
                    <span>4</span>

                    <p>订单支付</p>
                </li>
                <li>
                    <span>5</span>

                    <p>订单结算</p>
                </li>
            </ul>
        </div>
    </div>
    <div class="wrap clearfix">
        <div class="allt border1">
            <div style="position: relative; overflow:hidden; width: auto; height: 435px;" class="slimScrollDiv">
                <div class="scroller" style=" overflow-y:scroll; width: auto; height: 435px;" data-always-visible="1"
                     data-rail-visible1="1">
                    <div class="load"><img src="img/loading.gif"></div>
                    <ul class="chats">
                        <li class="in"><img class="avatar img-responsive" alt="" src="img/avatar3.jpg">

                            <div class="message"><span class="arrow"></span>
                                <a href="index.html#" class="name">Bob Nilson</a>
                                <span class="datetime">at Jul 25, 2012 11:09 </span>
                                <span class="body">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. </span>
                            </div>
                        </li>
                        <li class="out"><img class="avatar img-responsive" alt="" src="img/avatar1.jpg">

                            <div class="message"><span class="arrow"></span>
                                <a href="index.html#" class="name">Lisa Wong</a>
                                <span class="datetime">at Jul 25, 2012 11:09 </span>
                                <span class="body">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. </span>
                            </div>
                        </li>
                        <li class="in"><img class="avatar img-responsive" alt="" src="img/avatar3.jpg">

                            <div class="message"><span class="arrow"></span>
                                <a href="index.html#" class="name">Bob Nilson</a>
                                <span class="datetime">at Jul 25, 2012 11:09 </span>
                                <span class="body">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. </span>
                            </div>
                        </li>
                        <li class="out"><img class="avatar img-responsive" alt="" src="img/avatar1.jpg">

                            <div class="message"><span class="arrow"></span>
                                <a href="index.html#" class="name">Richard Doe</a>
                                <span class="datetime">at Jul 25, 2012 11:09 </span>
                                <span class="body">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. </span>
                            </div>
                        </li>
                        <li class="in"><img class="avatar img-responsive" alt="" src="img/avatar3.jpg">

                            <div class="message"><span class="arrow"></span>
                                <a href="index.html#" class="name">Richard Doe</a>
                                <span class="datetime">at Jul 25, 2012 11:09 </span>
                                <span class="body">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. </span>
                            </div>
                        </li>
                        <li class="out"><img class="avatar img-responsive" alt="" src="img/avatar1.jpg">

                            <div class="message"><span class="arrow"></span>
                                <a href="index.html#" class="name">Bob Nilson</a>
                                <span class="datetime">at Jul 25, 2012 11:09 </span>
                                <span class="body">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. </span>
                            </div>
                        </li>
                        <li class="in"><img class="avatar img-responsive" alt="" src="img/avatar3.jpg">

                            <div class="message"><span class="arrow"></span>
                                <a href="index.html#" class="name">Richard Doe</a>
                                <span class="datetime">at Jul 25, 2012 11:09 </span>
                                <span class="body">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. </span>
                            </div>
                        </li>
                        <li class="out"><img class="avatar img-responsive" alt="" src="img/avatar1.jpg">

                            <div class="message"><span class="arrow"></span>
                                <a href="index.html#" class="name">Bob Nilson</a>
                                <span class="datetime">at Jul 25, 2012 11:09 </span>
                                <span class="body">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. sed diam nonummy nibh euismod tincidunt ut laoreet. </span>
                            </div>
                        </li>
                        <li class="in"><img class="avatar img-responsive" alt="" src="img/avatar3.jpg">

                            <div class="message"><span class="arrow"></span>
                                <a href="index.html#" class="name">Richard Doe</a>
                                <span class="datetime">at Jul 25, 2012 11:09 </span>
                                <span class="body">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. </span>
                            </div>
                        </li>
                        <li class="out"><img class="avatar img-responsive" alt="" src="img/avatar1.jpg">

                            <div class="message"><span class="arrow"></span>
                                <a href="index.html#" class="name">Bob Nilson</a>
                                <span class="datetime">at Jul 25, 2012 11:09 </span>
                                <span class="body">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. sed diam nonummy nibh euismod tincidunt ut laoreet. </span>
                            </div>
                        </li>
                    </ul>
                </div>
                <div style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; background: none repeat scroll 0% 0% rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px;"
                     class="slimScrollRail">
                </div>
            </div>
            <div class="chat-form">
                <div class="input-cont">
                    <input class="form-control" placeholder="Type a message here..." type="text">
                </div>
                <div class="btn-cont">
									<span class="arrow">
									</span>
                    <a href="index.html" class="btn btn-primary1 icn-only"><i class="fa fa-check"></i></a>
                </div>
            </div>


        </div>
    </div>
</div>
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>