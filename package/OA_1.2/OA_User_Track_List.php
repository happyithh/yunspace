<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/1/14
 * Time: 14:27
 */
class OA_User_Track_List
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? "list" : $_REQUEST['action'];
        switch ($action) {
            case "track_list":
                self::handleUserTrackList();
                break;
            default:
                self::handleUserTrackList();
                break;
        }
    }
    static function handleUserTrackList(){
        $request = Func_Input::filter(
            array(
                'month'=>'string',
                'search'=>'array',
                'session_id'=>'string'
            ),$_REQUEST);
        if(!empty($request['month'])){
            $this_month  = "_".$request['month'];
        }else{
            $this_month  = "_".date("Ym");
        }
        $condition =array();
        if(!empty($request['search'])){
            $search = Func_Input::filter(array(
                'string'=>'string'
            ),$request['search']);
            if($search['string']){
                $condition['user_id'] =$search['string'];
            }
        }
        if(!empty($request['session_id'])){
            $condition['session_id'] =$request['session_id'];
        }
        $rs = Data_Mysql_Table_StaticLog::subTable($this_month)->page(0, 0, "*", $condition, 'order by create_time desc');
        Tpl_Smarty::assign('_data',$rs);
        Tpl_Smarty::display('OA_Static','user_track.v1.0/user_tack_list.tpl');
    }
}