<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/3
 * Time: 17:01
 * 合作品牌提交
 */
class Api_Cooperation_Brand_Submit extends Api
{
    static function brandSubmit($args)
    {

        $request = Func_Input::filter(array(
            'id' => 'int',
            'title' => 'string',
            'attr' => 'array',
            'des' => 'html',
            'content' => 'html',
            'logo'=>'string',
            'mobile_logo'=>'string',
            'brand_pic' => 'array',
            'brand_case' => 'array',
            'status'=>'int',
            'type'=>'int',
        ), $args);
        $files = Func_Input::filter(array(
            '品牌banner' => 'array',
            '品牌移动端banner' => 'array',
        ), $_FILES);
        if (!empty($files['品牌banner']['name'])) {
            $logo = Func_Upload::image('品牌banner');
            if (!empty($logo)) {
                $request['logo'] = $logo;
            }
        }
        if (!empty($files['品牌移动端banner']['name'])) {
            $mobile_logo = Func_Upload::image('品牌移动端banner');
            if (!empty($mobile_logo)) {
                $request['mobile_logo'] = $mobile_logo;
            }
        }
        if (empty($request['title'])) {
            Func_Header::back('标题不能为空！');
        }
        if (empty($request['logo'])) {
            Func_Header::back('PC端logo不能为空！');
        }
        $data['title'] = $request['title'];
        $data['des'] = $request['des'];
        $data['content'] = $request['content'];
        if(!empty($request['brand_pic'])){
            unset($request['brand_pic']['$$']);
            $data['brand_pic'] = $request['brand_pic'];
        }
        if(!empty($request['brand_case'])){
            unset($request['brand_case']['$$']);
            $data['brand_case'] = $request['brand_case'];
        }
//        if(empty(array_filter($data['brand_case']))){
//            Func_Header::back('请添加品牌图片！');
//        }
        $data['logo'] = $request['logo'];
        $data['mobile_logo'] = $request['mobile_logo'];
        $data['attr'] = $request['attr'];
        $data['status'] = $request['status'];
        if(!empty($request['type'])){
            $data['type']=$request['type'];
        }else{
            $data['type']=1;
        }
//        q($request,$data);
        if (!empty($request['id'])) {
            $data['update_time'] = time();
            $res = Data_Mysql_Table_Cooperation_Brand::update(array('id=?' => $request['id']), $data);
        } else {
            $data['create_time'] = time();
            $data['update_time'] = time();
            $res = Data_Mysql_Table_Cooperation_Brand::insert($data);
        }
        return $res;
    }
}