<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-10-16
 * Time: 上午10:01
 */
switch (Core::$urls['action']) {
    case "baike_112":
        OA_Baike_List::handle(112);
        break;
    case "baike_200":
        OA_Baike_List::handle(200);
        break;
    case "baike_300":
        OA_Baike_List::handle(300);
        break;
    case "baike_400":
        OA_Baike_List::handle(400);
        break;
    case "my_baike":
        OA_My_Baike_List::handle();
        break;
    case "article":
        OA_Raiders_Info::handle(1);
        break;
    case "old_article":
        OA_Raiders_Info::handle(12);
        break;
    case "contribute":
        die("Coming Soon ......");
        break;
    default:
        Func_Header::notFound();
        break;
}