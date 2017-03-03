<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/8/31
 * Time: 14:51
 */

class Api_Wechat_Web_Article_List extends Api{
    static function handle($args = '')
    {

        $result = self::handleGetList($args);
        return $result;
    }


    static function handleGetList($args)
    {
        $request = Func_Input::filter(array(
            'num' => 'int',
            'category_id' => 'int',
            'update_time' => 'int',
        ), $args);
        if(empty($request['category_id'])){
            return self::request('error', '', '参数错误');
        }
//        if(empty($request['num'])){
//            return self::request('error', '', '参数错误');
//        }
        if(empty($request['update_time'])){
            return self::request('error', '', '参数错误');
        }
        $category_id = substr(Func_NumEncode::d($request['category_id']),0,-4);
        $conditions['status =?'] = 1;
        $conditions['category_id =?'] = $category_id;

        //调用的文创时间不能大于当前时间
//        if (empty($request['update_time'])) {
//            $conditions['{table}.update_time < ?'] = time();
//        }
        //加载更多的列表传过来的时间
        if (!empty($request['update_time'])) {
            $conditions['{table}.update_time < ?'] = $request['update_time'];
        }
        if (empty($request['num'])) {
            $request['num'] = 5;
        }

        $list = Data_Mysql_Table_Wechat_Web_Article::select('*',$conditions,'order by update_time desc',$request['num']);
        if ($list) {
            foreach($list as $k=>$v){
                $list[$k]['id']=Func_NumEncode::e($v['id'].'9528');
            }
            Tpl_Smarty::assign('data', $list);
            $tpl = Tpl_Smarty::fetch('Web_Mobile_Static::wechat_web/wechat_article_list_inc.tpl');
            $result = self::request('success', $tpl, '成功');
        } else {
            $result = self::request('error', '', '失败');
        }
        return $result;

    }

}