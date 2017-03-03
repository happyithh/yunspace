<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/9/20
 * Time: 16:13
 * 零售ADM详情
 */
class Web_Retail_Adm_Info extends Web_Global
{
    function seo()
    {
        return array(
            '网页标题' => $this->detail['title'].'_2016ADM亚洲设计管理论坛暨生活创新展',
            '网页关键词' => $this->detail['title'].'_'.$this->detail['attr']['keyword'].'ADM，2016ADM，亚洲设计管理论坛，生活创新展，云SPACE，联合承办',
            '网页简介' =>mb_substr($this->detail['des'],0,150),
        );
    }

    function id()
    {
        $id = substr(Core::$urls['action'], 0, -5);
        return Func_NumEncode::d($id);
    }

    function detail()
    {
        $condition['id'] = $this->id();
        $condition['status'] = 1;
        $condition['type'] = 2;
        $data = Data_Mysql_Table_Cooperation_Brand::select('*', $condition);
        if(!empty($data[0]['brand_case'])){
            $data[0]['brand_case'] = json_decode($data[0]['brand_case'],1);
        }
        if(!empty($data[0]['brand_pic'])){
            $data[0]['brand_pic'] = json_decode($data[0]['brand_pic'],1);
        }
        if(!empty($data[0]['attr'])){
            $data[0]['attr'] = json_decode($data[0]['attr'],1);
            if(empty($data[0]['attr']['keyword'])){
                $data[0]['attr']['keyword'] = '';
            }
        }
        return $data[0];

    }
}