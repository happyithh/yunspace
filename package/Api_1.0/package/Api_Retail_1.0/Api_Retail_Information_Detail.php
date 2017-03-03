<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/4
 * Time: 17:32
 * 零售页面-》行业资讯内页
 */
class Api_Retail_Information_Detail extends Api{
    static function detail($args){
        $request = Func_Input::filter(array(
            'id'=>'int',
        ),$args);
        if(empty($request['id'])){
            return false;
        }
        $conditions['id = ?']=$request['id'];
        $conditions['status = ?']=1;
//        $conditions['baike_category_id'] = 400;
        $conditions['baike_cid'] = 400;
        $data = Data_Mysql_Table_Raiders_Info::select('*',$conditions);
        if(!empty($data[0]['tags_info'])){
            $data[0]['tags_info'] = json_decode($data[0]['tags_info'],1);
            
            // 去除外链
            preg_match_all ('/<a href=\"(.*?)\".*?>(.*?)<\/a>/i',$data[0]['cont'],$content);
            if(!empty($content[0])){
                foreach($content[0] as $k=>$v){
                    $data[0]['cont'] = str_replace($v,$content[2][$k],$data[0]['cont']);
                }
            }
        }
        return $data;
    }
}