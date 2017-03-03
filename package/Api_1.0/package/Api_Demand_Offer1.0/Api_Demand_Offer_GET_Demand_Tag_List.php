<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/20
 * Time: 10:31
 */
class Api_Demand_Offer_Get_Demand_Tag_List extends  Api{

        static function  handle(){
            return self::getTagList();
        }

        static function getTagList(){
            $ajax_arr=array();
            $request = Func_Input::filter(array(
                'id' => 'int',
                'q' => 'string',
                'search_type'=>'int',
            ));
            $request['search_type'] = empty($request['search_type']) ? 0 : $request['search_type'];
            if (!$request['id'] && !$request['q']&&!$request['search_type']) {
                return self::request('error',"","参数错误!");
            }
            if($request['search_type']==0 ){
                if ($request['id']) {
                    $rs = Data_Mysql_Table_Demand_Tag::select('id, CONCAT( "[", id, "] ", value) as name', array("id" => $request['id']));
                } else {
                    $rs = Data_Mysql_Table_Demand_Tag::select(' CONCAT( "[", id, "] ", value) as name', array("id like ? OR value like ?" => array($request['q'] . '%', $request['q'] . '%')), '', 5);
                }
                $ajax_arr = array(
                    "total_count" => 2,
                    "incomplete_results" => false,
                    "items" => array(
                        array(
                            'id' => 1,
                            'name' => '',
                            'full_name' => ''
                        ),
                    )
                );
                foreach ($rs as $key => $val) {
                    $ajax_arr['items'][$key]['id'] = $val['id'];
                    $ajax_arr['items'][$key]['name'] = $val['name'];
                    $ajax_arr['items'][$key]['full_name'] = $val['name'];
                }
            }elseif($request['search_type']==2){
                //add by yaoli
                $rs = Data_Mysql_Table_Demand_Tag::select('id,tag_value','','',10000);
                foreach($rs as $k=>$v){
                    $ajax_arr[$v['id']] = $v;
                }
            }else{
                $rs = Data_Mysql_Table_Demand_Tag::select('id,tag_value','','',10000);
                $ajax_arr = $rs;
            }
            return self::request('success',@$ajax_arr,"返回匹配的标签");
        }

}