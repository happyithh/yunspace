<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 16-2-19
 * Time: 下午3:26
 */
class OA_Track_Referer_Land{
    //1为来源页    2为落地页
    static function handle($type=1)
    {
        if($type==1){
            self::getTrackRefererList();
        }elseif($type==2){
            self::getTrackLandList();
        }
    }

    //来源页列表
    static function getTrackRefererList(){
        $condition=array();
        $request = Func_Input::filter(array(
             'month'=>'string',
             'date_time'=>'int',
             'url'=>'string',
        ),$_REQUEST);
        if(!empty($request['month'])){
            $this_month  = "_".date("Ym",strtotime($request['month']));
        }else{
            $this_month  = "_".date("Ym");
        }
        if(!empty($request['date_time'])){
            $condition['datetime']=date("Y-m-d",strtotime($request['month'].'-'.$request['date_time']));
        }
        if(!empty($request['url'])){
            $condition['referer_url']=$request['url'];
        }
        $rs = Data_Mysql_Table_Track_Referer_Url::subTable($this_month)->page(0, 0, "*", $condition, 'order by create_time desc');
        Tpl_Smarty::assign('_data',$rs);
        Tpl_Smarty::display('OA_Static','user_track.v1.0/track_referer_list.tpl');
    }

    //落地页列表
    static function getTrackLandList(){
        $condition=array();
        $request = Func_Input::filter(array(
            'month'=>'string',
            'date_time'=>'int',
            'url'=>'string',
        ),$_REQUEST);
        if(!empty($request['month'])){
            $this_month  = "_".date("Ym",strtotime($request['month']));
        }else{
            $this_month  = "_".date("Ym");
        }
        if(!empty($request['date_time'])){
            $condition['datetime']=date("Y-m-d",strtotime($request['month'].'-'.$request['date_time']));
        }
        if(!empty($request['url'])){
            $condition['land_url']=$request['url'];
        }
        $rs = Data_Mysql_Table_Track_Land_Url::subTable($this_month)->page(0, 0, "*", $condition, 'order by create_time desc');
        Tpl_Smarty::assign('_data',$rs);
        Tpl_Smarty::display('OA_Static','user_track.v1.0/track_land_list.tpl');
    }
}