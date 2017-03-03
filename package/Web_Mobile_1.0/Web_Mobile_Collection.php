<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/20
 * Time: 14:01
 */
class Web_Mobile_Collection
{

    static function  handle()
    {
        $type = !empty($_REQUEST['type']) ? $_REQUEST['type'] : "space";
        self::getCollectionList($type);
        switch($type){
            case "space" :
                $typeurl = "service_info";
                break;
            case "set" :
                $typeurl = "set_info";
                break;
            case "vendor" :
                $typeurl = "vendor_info";
                break;
            case "event" :
                $typeurl = "event_info";
                break;
            default:
                break;
        }
        Tpl_Smarty::assign('type_url',$typeurl);
        Tpl_Smarty::assign('type',$type);
        Tpl_Smarty::display('Web_Mobile_Static::chat.v1.0/chat_collect.tpl');
    }

    static function getCollectionList($type){
        $result = Api_Collection_GetList::getCollectionList(array('type'=>$type));
        if($result && $result['data']){
            Tpl_Smarty::assign("list",$result['data']);
        }
    }
}