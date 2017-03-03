<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/4
 * Time: 16:16
 * 零售页面-》合作品牌详情
 */
class Api_Retail_Cooperation_Brand_Detail extends Api
{
    static function detail($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ), $args);
        if (empty($request['id'])) {
            return false;
        }
        $conditions['id = ?'] = $request['id'];
        $conditions['status = ?'] = 1;
        $conditions['type = ?'] = 1;
        $data = Data_Mysql_Table_Cooperation_Brand::select('*', $conditions);
        if (!empty($data[0]['attr'])) {
            $data[0]['attr'] = json_decode($data[0]['attr'], 1);
        }
        if (!empty($data[0]['brand_pic'])) {
            $data[0]['brand_pic'] = json_decode($data[0]['brand_pic'], 1);
        }
        if (!empty($data[0]['brand_case'])) {
            $data[0]['brand_case'] = json_decode($data[0]['brand_case'], 1);
        }
        // 去除外链
        preg_match_all ('/<a href=\"(.*?)\".*?>(.*?)<\/a>/i',$data[0]['content'],$content);
        if(!empty($content[0])){
            foreach($content[0] as $k=>$v){
                $data[0]['content'] = str_replace($v,$content[2][$k],$data[0]['content']);
            }
        }

        return $data;
    }
}