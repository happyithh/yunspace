<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-10-16
 * Time: 上午10:01
 */
switch (Core::$urls['action']) {
    case "public_list":
        OA_Public_Number_Management::handle();
        break;
    case 'wechat_article':
        OA_WeChat_Article_List::handle();
        break;
    case 'wechat_author':
        OA_WeChat_Article_Author_List::handle();
        break;
    case 'article_log':
        OA_WeChat_Article_Log::handle();
        break;
    default:
        Func_Header::notFound();
        break;
}