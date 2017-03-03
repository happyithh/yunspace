<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/22
 * Time: 15:00
 *  $args = array(
 *
 *      'space_name'=>百科名称,
 *      'type'=> 用于区分最新和精华 精华标识：fine 默认为最新 type='',
 *
 * )
 *
 */
class Api_Raiders_Get_List extends Api{
    static function handle($args){
        return self::getArticleList($args);
    }
    static function getArticleList($args)
    {
        $request = Func_Input::filter(array(
//            'space_name'=>'string',
            'space_id'=>'int',
            'type'=>'string',
            'limit'=>'string'
        ),$args);
        if (empty($request['space_id'])) {
            return self::request('error','','参数缺失！');
        }
//        $condition["baike_word"] = $request['space_name'];
        $condition["space_ids"] = $request['space_id'];
//        //精华
        if ($request['type'] == "fine") {
            $condition['is_good'] = 1;
        }
//        $condition["baike_word"] = $request['space_name'];
        $order = "ORDER BY create_time DESC";
        $cols='id,title,logo,author,counter_view,media,counter_praise,create_time,counter_praise';
        if(!empty($request['limit'])){
            $article_list = Data_Mysql_Table_Raiders_Info::select($cols, $condition, $order,$request['limit']);
            if(!empty($article_list)){
                foreach($article_list as $k=>$v){
                    $article_list[$k]['id']=Func_NumEncode::e($v['id']);
                }
            }
            return $article_list;

        }else{
            $article_list = Data_Mysql_Table_Raiders_Info::page(0,10,$cols, $condition, $order);
            if(!empty($article_list['rows'])){
                foreach($article_list['rows'] as $k=>$v){
                    $article_list['rows'][$k]['id']=Func_NumEncode::e($v['id']);
                }
            }
            return $article_list['rows'];

        }

    }
}