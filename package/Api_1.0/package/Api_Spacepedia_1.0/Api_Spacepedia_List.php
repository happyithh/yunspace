<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/2/2
 * Time: 14:16
 */
class Api_Spacepedia_List extends Api{

    static function handle($args){
        return self::getMoreList($args);
    }
    static function getMoreList($args){
        //接受页数和条件 数据要整理 有城市 和分类
        $request = Func_Input::filter(array(
            'city'=>'string',
            'category_id'=>'int',
            'dp'=>'int'
        ),$args);
        if(empty($request['city'])){
            return self::request('error','','城市不能为空！');
        }
        $condition=array();
        $condition['city'] = $request['city'];
        if(!empty($request['category_id'])){
            $condition['category_id'] = $request['category_id'];
        }
        $condition['status'] = 1;
        $order='ORDER BY order_index DESC,click DESC' ;
        $list  =  Data_Mysql_Table_Spacepedia_Search::page(empty($request['dp'])?0:$request['dp'],8,'id,space_name,logo,des',$condition,$order);
        $data = array();
        if(!empty($list['rows'])){
            foreach($list['rows'] as $k=>$v){
                $data[$k]['title'] = $v['space_name'];
                $data[$k]['img'] = $v['logo'];
                $data[$k]['des'] = mb_substr($v['des'],0,80,'utf-8');
            }
        }
        $new_data=array();
//        $new_data['next_dp'] =(($request['dp']+1)>=$list['page']['dtp'])?$list['page']['dtp']:$request['dp']+1;
        $new_data['next_dp'] =$request['dp']+1;
        $new_data['data'] = $data;
        $new_data['total_num'] = $list['page']['dt'];
        return self::request('success',$new_data,'返回数据成功！');
    }

}