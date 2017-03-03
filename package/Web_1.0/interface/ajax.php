<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/6/18
 * Time: 15:48
 */
switch (Core::$urls['action']) {
    case 'comment':
        Web_Ajax::handleComment();
        break;
    case 'reply':
        Web_Ajax::handleReply();
        break;
    case 'dianzan':
        Web_Ajax::handleDianzan();
        break;
    case 'jianzan':
        Web_Ajax::handleJianzan();
        break;
    default:
        Func_Header::notFound();
}