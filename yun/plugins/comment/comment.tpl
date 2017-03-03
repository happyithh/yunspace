<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="{$_root}yun/plugins/comment/css/comment.css"/>
    <link rel="stylesheet" href="{$_root}yun/plugins/comment/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="{$_root}yun/plugins/comment/css/ionicons.min.css"/>
    <link rel="stylesheet" href="css/v1.0/global.css"/>
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <script src="{$_root}yun/plugins/comment/js/comment.js"></script>
    <script src="{$_root}yun/plugins/yunspace.js"></script>
    <title></title>
</head>
<body  yun-src="{$_root}yun/plugins/comment/">
<div class="container">
    <div class="clearfix">
        <a href="javascript:;" yun="js/comment.js::wow@click" class="js-wow">
            <span class="glyphicon glyphicon-thumbs-up wow-1"></span>
        </a>
        <p class="wow-num-1">10</p>
    </div>
    <div class="comment-back">
        <div class="comment-back-input">
            <input type="text" class="comment-back-input-content""/>
        </div>
        <a href="javascript:;" yun="js/comment.js::comment@click" class="call-back-submit">评论</a>
    </div>
    <div class="comment">
        <ul class="comment-list">
            {*<li>*}
                {*<div class="comment-slide">*}
                    {*<div class="comment-img">*}
                        {*<img src="img/chat.v1.0/lufei.jpg" alt=""/>*}
                    {*</div>*}
                {*</div>*}
                {*<div class="comment-body">*}
                    {*<div class="comment-head clearfix" >*}
                        {*<div class="comment-person">*}
                            {*泡泡水流*}
                        {*</div>*}
                        {*<div class="comment-time">*}
                            {*2015-07-03*}
                        {*</div>*}
                    {*</div>*}

                    {*<div class="comment-content">*}
                        {*<p>人的染色体有23对。有一天，教生物的老头慢悠悠地问：“染色体多少对啊，同学们。”角落里某二货大声答道：“64对啊！”老头淡定而严肃地点点头：“嗯，现在告诉我，你来地球的目的是什么？”</p>*}
                    {*</div>*}
                    {*<div class="comment-chat">*}
                        {*<a href="javascript:;"  yun="js/comment.js::wowComment@click">*}
                            {*<span class="glyphicon glyphicon-thumbs-up wow-2"></span>*}
                            {*<p class="wow-num-2">10</p>*}
                        {*</a>*}
                        {*<a href="javascript:;">*}
                            {*<span class="glyphicon glyphicon-edit wow-2"></span>*}
                            {*<p class="call">回复</p>*}
                        {*</a>*}
                    {*</div>*}
                    {*<div class="comment-back">*}
                        {*<div class="comment-back-input">*}
                            {*<input type="text" class="comment-back-input-content""/>*}
                        {*</div>*}
                        {*<div class="call-submit clearfix">*}
                             {*<a href="javascript:;" class="call-back-submit js-call1" data-username="泡泡水流">回复</a>*}
                        {*</div>*}
                    {*</div>*}

                    {*<div class="call-back clearfix">*}
                        {*<div class="comment-slide">*}
                            {*<div class="comment-img">*}
                                {*<img src="img/chat.v1.0/lufei.jpg" alt=""/>*}
                            {*</div>*}

                        {*</div>*}
                        {*<div class="comment-body">*}
                            {*<div class="comment-head clearfix" >*}
                                {*<div class="comment-person">*}
                                    {*angular*}
                                {*</div>*}
                                {*<div class="comment-time">*}
                                    {*2015-07-03*}
                                {*</div>*}
                            {*</div>*}

                            {*<div class="comment-content">*}
                                {*<p>人的染色体有23对。有一天，教生物的老头慢悠悠地问：“染色体多少对啊，同学们。”角落里某二货大声答道：“64对啊！”老头淡定而严肃地点点头：“嗯，现在告诉我，你来地球的目的是什么？”</p>*}
                            {*</div>*}
                            {*<div class="comment-chat">*}
                                {*<a href="javascript:;"  yun="js/comment.js::wowComment@click">*}
                                    {*<span class="glyphicon glyphicon-thumbs-up wow-2"></span>*}
                                    {*<p class="wow-num-2">10</p>*}
                                {*</a>*}
                                {*<a href="javascript:;">*}
                                    {*<span class="glyphicon glyphicon-edit wow-2"></span>*}
                                    {*<p class="call">回复</p>*}
                                {*</a>*}
                            {*</div>*}
                            {*<div class="comment-back">*}
                                {*<div class="comment-back-input">*}
                                    {*<input type="text" class="comment-back-input-content""/>*}
                                {*</div>*}
                                {*<div class="call-submit">*}
                                    {*<a href="javascript:;"  class="call-back-submit js-call-2" data-username="angular">回复</a>*}
                                {*</div>*}
                            {*</div>*}
                        {*</div>*}

                    {*</div>*}


                {*</div>*}
            {*</li>*}

        </ul>
    </div>
</div>
{*{static "core/yunspace.js"}*}
</body>
</html>