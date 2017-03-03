<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/6/5
 * Time: 10:22
 */
if (Core::$urls['action'] == 'sale') {
    Wechat_Oauth_Sale::handle();

} else {
    Wechat_Oauth::handle();

}