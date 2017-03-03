<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/12/16
 * Time: 16:17
 */
class Web_Raiders_Search{

        static function handle($type){
            switch($type){
                case "article":
                    Tpl_Smarty::assign("nav",'article');
                    self::showRaiderList();
                    break;
                case "company":
                    Tpl_Smarty::assign("nav",'company');
                    self::showCompanyList();
                case "doc":
                    Tpl_Smarty::assign("nav",'paper');
                    self::showDocumentsList();
                    break;
                default:
                    Func_Header::to('',Core::$urls['root']);
            }

        }

        static function  showRaiderList(){
            $preuri = '/article-keyword';  //拿到Uri前缀
            $uri = str_replace($preuri, '', Func_Url::str_urldecode(Core::$urls['uri']));     //去除前缀，避免匹配到Action数字
            $uri_arr = explode('?', $uri);      //标签显示过滤掉Uri中的面积 ?size_range=200
            $uri_arr = explode('/', $uri_arr[0]);
            $_REQUEST['keyword'] =Func_String::utf8($uri_arr[1]);
            Web_Raiders_Search_New::display('Web_Static::search/search_alist_1.0.tpl');
            die();
        }
        static function  showDocumentsList(){
            $preuri = '/doc-keyword';  //拿到Uri前缀
            $uri = str_replace($preuri, '', Func_Url::str_urldecode(Core::$urls['uri']));     //去除前缀，避免匹配到Action数字
            $uri_arr = explode('?', $uri);      //标签显示过滤掉Uri中的面积 ?size_range=200
            $uri_arr = explode('/', $uri_arr[0]);
            $_REQUEST['keyword'] =Func_String::utf8($uri_arr[1]);
            $_REQUEST['category_id'] =12;
            Web_Raiders_Search_New::display('Web_Static::search/search_list_doc.tpl');
            die();
        }

        static function showCompanyList(){
            $preuri = '/company-keyword';  //拿到Uri前缀
            $uri = str_replace($preuri, '', Func_Url::str_urldecode(Core::$urls['uri']));     //去除前缀，避免匹配到Action数字
            $uri_arr = explode('?', $uri);      //标签显示过滤掉Uri中的面积 ?size_range=200
            $uri_arr = explode('/', $uri_arr[0]);
            $_REQUEST['keyword'] =Func_String::utf8($uri_arr[1]);
            Web_Company_Search_New::display('Web_Static::search/search_clist_1.0.tpl');
            die();
        }



}