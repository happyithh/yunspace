<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/28
 * Time: 16:21
 */
//if (!empty(Core::$urls['action'])) {
//    Q(Core::$urls['action'],Core::$urls);
//    //Core::$urls['action'] = Page_Site_Global::$space_id;
//}
$request = Func_Input::filter(array(
    'keyword' => 'string',
    'searchtype' => 'string',
), $_REQUEST);
//if(isset($request['searchtype']) && trim($request['keyword'])){
if(isset($request['searchtype']) ){
    switch($request['searchtype']){
        case 'space':
            Data_Mysql_Table_Search_Logm::searchLog($request['keyword'],"space");
            Func_Header::location('../space/?keyword='.$request['keyword']);
            break;
        case 'service':
            Data_Mysql_Table_Search_Logm::searchLog($request['keyword'],"service");
            Func_Header::location('../service/?keyword='.$request['keyword']);
            break;
        case 'vendor':
            Data_Mysql_Table_Search_Logm::searchLog($request['keyword'],"vendor");
            Func_Header::location('../vendor/?keyword='.$request['keyword']);
            break;
       default:
           Data_Mysql_Table_Search_Logm::searchLog($request['keyword'],"set_list");
            Func_Header::location('../set_list/?keyword='.$request['keyword']);
            break;
    }
    die();
}
$list = Data_Mysql_Table_Search_Logm::hotSearchList();
Tpl_Smarty::assign("list",$list);
Tpl_Smarty::display('Web_Mobile_Static::v1.0/search.tpl');