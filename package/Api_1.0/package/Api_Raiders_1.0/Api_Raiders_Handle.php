<?php
/*
 * Created by PhpStorm
 * User: yl
 * Date: 2015/9/23
 * Time: 17:13
 * 云发现文章处理接口
 */
class Api_Raiders_Handle extends Api
{
    static function handle($args=""){

        return self::handleRaiders($args);
    }
    static function handleRaiders($args){
        $action=$args['action'];
        switch($action){
            case "change_tags":
                $data=self::handleChangeTags();
                break;
            case "remove_tags":
                $data=self::removeRaidersTags();
                break;
            case "is_good":
                $data=self::handleIsGood();
                break;
            case "praise_tread":
                $data=self::handlePraiseTread();
                break;
            default:
                $data=self::request('error','','操作错误！');
                break;
        }
        return $data;
    }

    //更新云发现的space_ids
    static function handleChangeTags(){
        $request = Func_Input::filter(array(
            'space_id' => 'string',
            'raiders_id' => 'int',
        ));
        if (!$request['raiders_id'] || !$request['space_id']) {
            return self::request('error','','参数缺失！');
        }
        //获取当前云发现的space_ids
        $data=Data_Mysql_Table_Raiders_Info::select('id,space_ids',array("id"=>$request['raiders_id']));
        if(empty($data[0])){
            return self::request('error','','数据不存在！');
        }
        $space_id_arr=explode(",",$data[0]['space_ids']);
        array_push($space_id_arr,$request['space_id']);
        $space_id_arr=array_filter(array_unique($space_id_arr));
        //更新云发现的space_ids和baike_category_id
        $baike_category_id=0;
        if(!empty($space_id_arr)){
            $con[] ='id in ('.implode(",",$space_id_arr).')' ;
            $baike_category = Data_Mysql_Table_Spacepedia::select('category_id',$con,'',count($space_id_arr));
            if(!empty($baike_category)){
                foreach($baike_category as $k=>$v){
                    $category_arr[]=$v['category_id'];
                }
                $baike_category_id=implode(',',array_unique($category_arr));
            }
        }
        $space_id_str=implode(',',$space_id_arr);
        $r = Data_Mysql_Table_Raiders_Info::update(array('id'=>$request['raiders_id']),array("space_ids"=>$space_id_str,'baike_cid'=>$baike_category_id));
        if (empty($r[0])) {
            return self::request('error','','操作失败！');
        }else{
            return self::request('success','','操作成功！');
        }
    }

    //将场地百科的名称从文章的关键词中移除
    static function removeRaidersTags(){
        $request = Func_Input::filter(array(
            'space_id' => 'string',
            'raiders_id' => 'int',
        ));
        if (!$request['raiders_id'] || !$request['space_id']) {
            return self::request('error','','参数缺失！');
        }
        //获取当前云发现的space_ids
        $data=Data_Mysql_Table_Raiders_Info::select('id,space_ids',array("id"=>$request['raiders_id']));
        if(empty($data[0])){
            return self::request('error','','数据不存在！');
        }
        $space_id_arr=explode(",",$data[0]['space_ids']);
        array_push($space_id_arr,$request['space_id']);
        $space_id_arr=array_filter(array_unique($space_id_arr));
        foreach($space_id_arr as $k=>$v){
            if($v==$request['space_id']){
                unset($space_id_arr[$k]);
            }
        }
        //更新云发现的space_ids和baike_category_id
        $baike_category_id='';
        if(!empty($space_id_arr)){
            $con[] ='id in ('.implode(",",$space_id_arr).')' ;
            $baike_category = Data_Mysql_Table_Spacepedia::select('category_id',$con,'',count($space_id_arr));
            if(!empty($baike_category)){
                foreach($baike_category as $k=>$v){
                    $category_arr[]=$v['category_id'];
                }
                $baike_category_id=implode(',',array_unique($category_arr));
            }
        }
        $space_id_str=implode(',',$space_id_arr);
        $r = Data_Mysql_Table_Raiders_Info::update(array('id'=>$request['raiders_id']),array("space_ids"=>$space_id_str,'baike_cid'=>$baike_category_id));
        if (empty($r[0])) {
            return self::request('error','','操作失败！');
        }else{
            return self::request('success','','操作成功！');
        }
    }

    //文章加精推荐/取消推荐
    static function handleIsGood(){
        $request=Func_Input::filter(array(
           'raiders_id'=>'int',
            'is_good'=>"int",
        ));
        if(empty($request['raiders_id'])){
            return self::request('error','',"参数缺失！！");
        }
        //更新云发现的标签
        $r = Data_Mysql_Table_Raiders_Info::update(array('id'=>$request['raiders_id']),array("is_good"=>$request['is_good']));
        if (empty($r[0])) {
            return self::request('error','','操作失败！');
        }else{
            return self::request('success','','操作成功！');
        }

    }

    //文章点赞，踩
    static function handlePraiseTread(){
        $request=Func_Input::filter(array(
            'raiders_id'=>'int',
            'click_type'=>"string",
        ));
        if(empty($request['raiders_id'])){
            return self::request('error','',"参数缺失！！");
        }
        //点赞
        if($request['click_type']=="praise"){
            $r=Data_Mysql_Table_Raiders_Info::query("UPDATE {table} SET counter_praise=counter_praise+1 WHERE id=?",array($request['raiders_id']),1);
        }elseif($request['click_type']=="tread"){
            $r=Data_Mysql_Table_Raiders_Info::query("UPDATE {table} SET counter_tread=counter_tread+1 WHERE id=?",array($request['raiders_id']),1);
        }else{
            return self::request('error','',"没有点赞和踩的操作！！");
        }
        if (empty($r[0])) {
            return self::request('error','','操作失败！');
        }else{
//            //增加相关联百科的点赞数量
//            if($request['click_type']=="praise"){
//                $space_name=self::getRelateSpaceByRaidersId($request['raiders_id']);
//                foreach($space_name as $k=>$v){
//                    Data_Mysql_Table_Baike_Statistical::query('INSERT INTO {table} (space_name ,is_good) VALUES ("'.$v.'", 1)  ON DUPLICATE KEY UPDATE is_good = is_good +1');
//                }
//            }
            return self::request('success','','操作成功！');
        }
    }

    static function getRelateSpaceByRaidersId($raidersId){
        $space_ids=array();
        $rs=Data_Mysql_Table_Raiders_Info::select('id,baike_word',array("id"=>$raidersId));
        if(empty($rs[0]) || empty($rs[0]['baike_word'])){
            return false;
        }
        $baike_word=json_decode($rs[0]['baike_word'],1);
        $condition[]="space_name in (".implode(",",$baike_word).")";
        $data=Data_Mysql_Table_Spacepedia::select('id,space_name',$condition,'',10);
        foreach($data as $k=>$v){
            $space_ids[]=$v['id'];
        }
        return $space_ids;

    }
}