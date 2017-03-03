<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/9/23
 * Time: 17:14
 */
class Api_Raiders_List extends Api
{
    static function handle($args='')
    {

//        q(32);
        $result = self::handlegetList($args);
        return $result;
    }


    static function handlegetList($args)
    {
        $request = Func_Input::filter(array(
            'category_id' => 'int',
            'create_time' => 'int',
        ),$args);
//        q($request['create_time']);   && $request['create_time']!=0

        if(empty($request['category_id'])) {
            $request['category_id'] = 0;
        }

        $conditions['status =?'] = 1;

        //调用的文章时间不能大于当前时间
        if(empty($request['create_time'])) {
            $conditions['{table}.create_time < ?'] = time();
        }
        //加载更多的列表传过来的时间
        if(!empty($request['create_time'])) {
            $conditions['{table}.create_time < ?'] = $request['create_time'];
        }
        if ($request['category_id']) {
            $category_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($request['category_id']);
            $conditions[] = 'category_id IN (' . implode(',', $category_id) . ')';
        }
        if($request['category_id'] == 0)  {
            $wenku_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
            $conditions[] = 'category_id NOT IN (' . implode(',', $wenku_id) . ')';
        }

        $order = 'ORDER BY {table}.create_time desc';
        $conditions['id<?']=5500;
        $rs = Data_Mysql_Table_Raiders_Info::select('*', $conditions,$order,10);
        foreach($rs as $k=>$v) {
            $rs[$k]['logo'] = Page_Site_Global::displayMedia($v['logo'],718,424);
        }
//        q($rs);
//        foreach($rs as $key =>$val){
//            $rs[$key]['create_time'] = Date('Y-m-d H:i:s',$val['create_time']);
//        }
        if($rs>0) {
//            $results = array(
//                'status' => 1,
//                'msg' => "成功",
//                "data" => $rs
//            );
            $result = self::request('success',$rs,'成功');
        }else{
            $result = self::request('error','','失败');
        }
        return $result;
    }
}