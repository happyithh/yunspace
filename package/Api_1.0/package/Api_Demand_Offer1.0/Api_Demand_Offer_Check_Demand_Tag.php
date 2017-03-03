<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/20
 * Time: 14:28
 */
class Api_Demand_Offer_Check_Demand_Tag extends Api{

    static function handle(){
        return self::CheckTags();
    }

    static function CheckTags(){
        $request = Func_Input::filter(array(
            'tags' => 'string',
        ));
        @session_start();
        if(empty($request['tags'])){
            return self::request('error',"","参数错误!");
        }
        $tag_list = explode(',',$request['tags']);
        $tag_list_new = array();
        foreach($tag_list as $k=>$v){
          $v =  Func_Input::filter(array(
                'value' => 'string',
            ),array('value'=>$v));
            if(empty($v['value'])||!(strpos($v['value'],'jQuery')===false)){
                continue;
            }else{
                $tag_list_new[$k]['tag_value'] = $v['value'];
                $tag_id = self::getTagID($v['value']);
                if($tag_id){
                    $tag_list_new[$k]['id'] =$tag_id;
                }else{
                    continue;
                }

            }
        }
        if(!empty($tag_list_new)){
            return self::request('success',$tag_list_new,"返回数据成功!");
        }else{
            return self::request('error',$tag_list_new,"数据错误!");
        }
    }

    static function getTagID($tag_value){
        $request =  Func_Input::filter(array(
            'tag_value' => 'string',
        ),array('tag_value'=>$tag_value));
        if(empty($request['tag_value'])){
            return false;
        }
        $rs = Data_Mysql_Table_Demand_Tag::select('id,tag_value',array("tag_value =?" => $request['tag_value'] ),'',1);
        if(!empty($rs)){
           return $rs[0]['id'];
        }else{
            @session_start();
            if(!isset($_SESSION['administrator']['id'])){
                return false;
            }else{
                $data =array(
                    'tag_value' =>$request['tag_value'],
                    'admin_id' =>$_SESSION['administrator']['id'],
                    'create_time' => time(),
                    'update_time' => time(),
                );
                $rs_new = Data_Mysql_Table_Demand_Tag::insert($data);
                $administratorAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$_SESSION['administrator']['id']));
                if(!empty($administratorAccount['account_id'])){
                    $account_id =$administratorAccount['account_id'];
                }
                Data_Mysql_Table_Account_Log::insertAccountLog($account_id, $_SESSION['administrator']['id'], '添加新的场地标签',  $_SESSION['administrator']['username'].'添加新的场地标签'.$request['tag_value'], $rs_new[0]);
                return $rs_new[0];
            }
        }
    }
}