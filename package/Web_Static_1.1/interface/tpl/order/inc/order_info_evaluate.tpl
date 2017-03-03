{if $orderinfo['is_buyer']}
    <!--评价状态-->
    <div class="reviews-state" id="js-evaluate-show">
        {if $orderinfo['evaluate']}
            <div class="reviews-state-tit">
                <h2 class="fl">评价状态</h2>
                <h3 class="fr magenta">已评价</h3>
            </div>
            <div class="reviews-cmpld">
                <dl class="clearfix">
                    <dt>评价时间：</dt>
                    <dd>{date('Y-m-d H:i:s',$orderinfo['evaluate']['create_time'])}</dd>
                </dl>
                <dl class="clearfix">
                    <dt>质量效果：</dt>
                    <dd>{$orderinfo['evaluate']['quality']}分</dd>
                </dl>
                <dl class="clearfix">
                    <dt>服务态度：</dt>
                    <dd>{$orderinfo['evaluate']['service']}分</dd>
                </dl>
                <dl class="clearfix">
                    <dt>响应速度：</dt>
                    <dd>{$orderinfo['evaluate']['speed']}分</dd>
                </dl>
                <dl class="reviews-remarks clearfix">
                    <dt>评价备注：</dt>
                    <dd class="dd-eval">{$orderinfo['evaluate']['demo']}</dd>
                </dl>
            </div><!--reviews-cmpld-end-->
        {else}
            <div class="reviews-state-tit">
                <h2 class="fl">评价状态</h2>
                <h3 class="fr magenta">待评价</h3>
            </div>
            <dl class="clearfix">
                <dt>质量效果</dt>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['quality'] ==5} checked {/if} name="quality" value="5"> 5分</label></dd>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['quality'] ==4} checked {/if} name="quality" value="4"> 4分</label></dd>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['quality'] ==3} checked {/if} name="quality" value="3"> 3分</label></dd>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['quality'] ==2} checked {/if} name="quality" value="2"> 2分</label></dd>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['quality'] ==1} checked {/if} name="quality" value="1"> 1分</label></dd>
            </dl>
            <dl class="clearfix">
                <dt>服务态度</dt>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['service'] ==5} checked {/if} name="service" value="5"> 5分</label></dd>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['service'] ==4} checked {/if} name="service" value="4"> 4分</label></dd>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['service'] ==3} checked {/if} name="service" value="3"> 3分</label></dd>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['service'] ==2} checked {/if} name="service" value="2"> 2分</label></dd>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['service'] ==1} checked {/if} name="service" value="1"> 1分</label></dd>
            </dl>
            <dl class="clearfix">
                <dt>响应速度</dt>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['speed'] ==5} checked {/if} name="speed" value="5"> 5分</label></dd>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['speed'] ==4} checked {/if} name="speed" value="4"> 4分</label></dd>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['speed'] ==3} checked {/if} name="speed" value="3"> 3分</label></dd>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['speed'] ==2} checked {/if} name="speed" value="2"> 2分</label></dd>
                <dd><label><input type="radio" {if $orderinfo['evaluate']['speed'] ==1} checked {/if} name="speed" value="1"> 1分</label></dd>
            </dl>
            <dl class="reviews-remarks clearfix">
                <dt style="width: 80px;">评价备注：</dt>
                <dd>
                    <textarea name="demo">{$orderinfo['evaluate']['demo']}</textarea>
                    <input type="button" class="fr reviews-submit bg-green evaluate_submit" value="提交评价">
                </dd>
            </dl>
        {/if}
    </div>
{else}
    <div class="reviews-state">
        {*评价完成的状态*}
        {if $orderinfo['evaluate']}
            <div class="reviews-state-tit">
                <h2 class="fl">评价状态</h2>
                <h3 class="fr magenta">已评价</h3>
            </div>
            <div class="reviews-cmpld">
                <dl class="clearfix">
                    <dt>评价时间：</dt>
                    <dd>{date('Y-m-d H:i:s',$orderinfo['evaluate']['create_time'])}</dd>
                </dl>
                <dl class="clearfix">
                    <dt>质量效果：</dt>
                    <dd>{$orderinfo['evaluate']['quality']}分</dd>
                </dl>
                <dl class="clearfix">
                    <dt>服务态度：</dt>
                    <dd>{$orderinfo['evaluate']['service']}分</dd>
                </dl>
                <dl class="clearfix">
                    <dt>响应速度：</dt>
                    <dd>{$orderinfo['evaluate']['speed']}分</dd>
                </dl>
                <dl class="reviews-remarks clearfix">
                    <dt>评价备注：</dt>
                    <dd  class="dd-eval">{$orderinfo['evaluate']['demo']}</dd>
                </dl>
            </div>
        {else}
            <div class="reviews-state-tit">
                <h2 class="fl">评价状态</h2>
                <h3 class="fr magenta">待评价</h3>
            </div>
            <div class="reviews-cmpld">
                <dl class="clearfix">
                    <dd>等待采购方评价...</dd>
                </dl><!--reviews-cmpld-end-->
            </div>
        {/if}
    </div>
{/if}