<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-11-2
 * Time: 下午2:25
 */
class Spacepedia_Case_Management{
    static function handle(){
        $request=Func_Input::filter(array(
            'space_id'=>'int',
        ));
        if(empty($request['space_id'])){
            Func_Header::back('参数缺失！！');
        }
        $_REQUEST['case_action']=empty($_REQUEST['case_action'])?"case_list":$_REQUEST['case_action'];
        switch($_REQUEST['case_action']){
            case "case_list":
                self::getMatchCaseList();
                break;
            case "case_edit":
                self::caseEdit();
                break;
            case "case_submit":
                self::caseSubmit();
                break;
            default:
                Func_Header::notFound();
        }
    }
    static function getMatchCaseList(){
        //定义操作内容
        $cate_id=array();
        $cate = Data_Mysql_Table_Raiders_Info::$category_name;
        foreach($cate as $k=>$v){
            $cate_id[$v['id']]=$v;
        }
        Tpl_Smarty::assign('_category', $cate_id);

        //定义文章状态
        $status = Data_Mysql_Table_Raiders_Info::$status;
        Tpl_Smarty::assign('status', $status);



        //获取百科信息
        $spacepedia=Api_Spacepedia_List_And_Info::getSpacepediaInfoById($_REQUEST['space_id']);
        if(empty($spacepedia[0])){
            Func_Header::back('数据不存在！！');
        }
        Tpl_Smarty::assign("spacepedia",$spacepedia[0]);

        //获取搜索到的活动案例
        if(!empty($_REQUEST['case_name'])){
            $search_list=array();
            $search_condition['title']=$_REQUEST['case_name'];
            $search_condition['status']=1;
            if(!empty($_REQUEST['create_time'])){
                $search_condition['create_time < ?']=$_REQUEST['create_time'];
            }
            $search_list = Data_Mysql_Table_Raiders_Info::select('*',$search_condition, 'ORDER BY create_time DESC', 20);
            //没有更多的时候显示最初始的数据
            $return_search=array();
            if(empty($search_list) && !empty($_REQUEST['create_time'])){
                $search_condition2['title']=$_REQUEST['case_name'];
                $search_condition2['status']=1;
                $search_list = Data_Mysql_Table_Raiders_Info::select('*',$search_condition2, 'ORDER BY create_time DESC', 20);
            }
            foreach($search_list as $k=>$v){
                if(!empty($v['space_ids'])){
                    $space_ids=array();
                    $space_ids=explode(",",$v['space_ids']);
                    if(!in_array($spacepedia[0]['id'],$space_ids)){
                        $return_search[]=$v;
                    }
                }
            }
            Tpl_Smarty::assign('search_list',$return_search);
        }
        $match_data=array();
        $order=empty($_REQUEST['order'])?"update_time":$_REQUEST['order'];
        $sort=empty($_REQUEST['sort'])?"DESC":$_REQUEST['sort'];
        $match_data=Data_Mysql_Table_Raiders_Info::page(0,20,"*",array("space_ids"=>$spacepedia[0]['id']),'ORDER BY '.$order." ".$sort);
//        if(!empty($match_data['rows'])){
//            $raider_ids=array();
//            foreach($match_data['rows'] as $k=>$v){
//                if(empty($v['baike_category_id'])){
//                    $raider_ids[]=$v['id'];
//                }
//            }
//            if(!empty($raider_ids)){
//                $condi[]="id IN(".implode(',',$raider_ids).")";
//                Data_Mysql_Table_Raiders_Info::update($condi,array('baike_category_id'=>$spacepedia[0]['category_id']));
//            }
//        }
        Tpl_Smarty::assign("_data",$match_data);
        Tpl_Smarty::display("OA_Static","spacepedia_case/case_list.tpl");

    }

    //编辑/修改文章调用数据
    static function caseEdit(){
        $request=Func_Input::filter(array(
            'space_id'=>'int',
            'raiders_id'=>'int',
        ));
        if(empty($request['space_id'])){
            Func_Header::back('参数缺失！！');
        }
        if(!empty($request['raiders_id'])){
            $data = Data_Mysql_Table_Raiders_Info::select('*', array('id =?' => $request['raiders_id']), '', 1);
            if (!empty($data[0])) {
                $_data = Data_Mysql_Table_Raiders_Info::rowFormat($data[0]);
                $_data['id'] = $data[0]['id'];
                Tpl_Smarty::assign('_data', $_data);
            } else {
                Func_Header::back('没有相关数据！');
            }
        }
        //获取副标题
        $spacepedia=Api_Spacepedia_List_And_Info::getSpacepediaInfoById($request['space_id']);
        if(empty($spacepedia[0])){
            Func_Header::back('数据不存在！！');
        }
        Tpl_Smarty::assign("spacepedia",$spacepedia[0]);
        // 获取百科分类
        $baike_category = Data_Mysql_Table_Spacepedia::$category_name;
        Tpl_Smarty::assign('baike_category',$baike_category);
        $cate = Data_Mysql_Table_Raiders_Info::$category_name;
        $categoryName = OA_Raiders_Info::getCatTree($cate);
        $status = Data_Mysql_Table_Raiders_Info::$status;
        Tpl_Smarty::assign('status', $status);
        Tpl_Smarty::assign('category_name', $categoryName);
        $vendorAttr = Data_Config_Vendor_Attr::get('attr');
        Tpl_Smarty::assign('attr', $vendorAttr['服务行业']);
        Tpl_Smarty::display("OA_Static","spacepedia_case/case_edit.tpl");
    }

    //文章表单提交
    static function caseSubmit(){
        $request=Func_Input::filter(array(
           'space_id'=>'int',
           'raiders_id'=>'int',
            'data'=>'array',
            'subhead'=>'string'
        ));
        if(intval(date("H",strtotime($request['data']['create_time'])))<7){
            $request['data']['create_time']=date("Y-m-d",strtotime($request['data']['create_time']))." ".date("H:i:s");
        }
        $request['data']['create_time'] = strtotime($request['data']['create_time']);
        $update_data=self::handleSubmitData($request['data']);

        if (!empty($request['raiders_id'])) {
            //更新文章
            $rs= Data_Mysql_Table_Raiders_Info::update(array("id"=>$request['raiders_id']),$update_data);
        } else {
            //添加文章
            $update_data['counter_view'] = mt_rand(36,68);
            $update_data['counter_praise'] = mt_rand(6,18);
            $update_data['from_where']=1;
            $rs= Data_Mysql_Table_Raiders_Info::insert($update_data);
            //更新关联百科的文章总数
            if(!empty($update_data['space_ids'])){
                $space_ids=explode(",",$update_data['space_ids']);
                Api_Baike_Article_Count::updateAricleCountBySpaceIds($space_ids);
            }
        }
        if(empty($rs[0])){
            Func_Header::back('添加/修改失败！！');
        }else{
            if(!empty($request['raiders_id']) && !empty($update_data['cont'])){
                //清除缓存文件
                $clear_data['s_key']=$request['raiders_id'];
                $clear_data['subTable']='raiders_content';
                Api_Common_Cache::clearCacheByKey($clear_data);
            }
            if(!empty($request['subhead'])){
                $raiders_id=empty($request['raiders_id'])?$rs[0]:$request['raiders_id'];
                //获取百科的副标题
                $spacepedia=Api_Spacepedia_List_And_Info::getSpacepediaInfoById($request['space_id']);
                $subhead=array();
                if(!empty($spacepedia[0]) && !empty($spacepedia[0]['subhead'])){
                    $subhead=$spacepedia[0]['subhead'];
                }
                $subhead[$raiders_id]=$request['subhead'];
                //更新百科的副标题
                Data_Mysql_Table_Spacepedia::query('UPDATE {table} SET subhead = ? WHERE id = ?',array(json_encode($subhead),$request['space_id']));
            }
            $msg="文章信息已添加/更新成功!";
            if(strpos($update_data['cont'],'http://mmbiz.qpic.cn/mmbiz')){
                $msg="文章内容含有微信图片可能无法显示!";
            }
            Func_Header::to(" ".$msg,'?action=case&case_action=case_list&space_id='.$request['space_id']);
        }
    }

    //处理提交数据
    static function handleSubmitData($handle_data){
        $files = Func_Input::filter(array(
            'accessory' => 'array',
            'logo_f' => 'array',
        ), $_FILES);
        if (!empty($files['logo_f']['name'])) {
            $logo = Func_Upload::image('logo_f');
            if (!empty($logo)) {
                $handle_data['logo_f'] = $logo;
            }
        }
        $ss = Data_Mysql_Table_Raiders_Info::$category_name;
        foreach ($ss as $k => $v) {
            if ($handle_data['category_id'] == $v['id']) {
                if ($v['parent'] == 12 || $v['id'] == 12) {
                    $files = Func_Input::filter(array(
                        'accessory' => 'array',
                    ), $_FILES);
                    if (!empty($files['accessory']['name'])) {

                        if (!empty($files['accessory']['name'])) {
                            $intelligence = Func_Upload::file('accessory');
                            if (is_array($intelligence) && $intelligence['code'] == 0) {
                                Func_Header::back($intelligence['msg']);
                            } else {
                                $handle_data['accessory']['name'] = $intelligence;
                            }
                        }
                        $handle_data['accessory']['size'] = $files['accessory']['size'];
                        $handle_data['accessory']['filename'] = $files['accessory']['name'];

                    }
                    if (empty($handle_data['accessory']['filename']) && empty($files['accessory']['name'])) {
                        Func_Header::back('必须上传文件！');
                    }
                }
            }
        }
        $data=Func_Input::filter(array(
            'title' => 'string',
            'author' => 'string',
            'status' => 'int',
            'category_id' => 'int',
            'des' => 'string',
            'cont' => 'html',
            'tags_info' => 'array',
            'baike_word' => 'array',
            'create_time' => 'int',
            'accessory' => 'array',
            'detail_des' => 'array',
            'logo' => 'string',
            'logo_f'=>'string',
            'hide_logo' => 'int',
            'is_hot' => 'int',
            'is_good' => 'int',
            'from_url'=>'string',
            'space_ids'=>'string',
            'actor'=>'string',
            'img_set'=>'string',
        ),$handle_data);

        if (empty($data['title'])) {
            Func_Header::back('标题不能为空！');
        }
        if (empty($data['category_id'])) {
            Func_Header::back('请选择类别！');
        }
        if($data['category_id']==28 && empty($data['actor'])){
            Func_Header::back('演员名称不能为空！');
        }
        if (empty($data['tags_info'])) {
            Func_Header::back('关键词不能为空！');
        }
        if (empty($data['des'])) {
            Func_Header::back('简介不能为空！');
        }
        if (empty($data['cont'])) {
            Func_Header::back('请填写文章内容！');
        }

        // 获取百科分类ID
        $baike_category_id='';
        if(!empty($data['space_ids'])){
            $space_id_arr=explode(",",$data['space_ids']);
//            if(strstr($data['space_ids'],',')){
//               $sId =  substr($data['space_ids'],0,strpos($data['space_ids'],','));
//            }else{
//                $sId = $data['space_ids'];
//            }
            $con[] ='id in ('.implode(",",array_filter($space_id_arr)).')' ;
            $baike_category = Data_Mysql_Table_Spacepedia::select('category_id',$con,'',count($space_id_arr));
            if(!empty($baike_category)){
                foreach($baike_category as $k=>$v){
                    $category_arr[]=$v['category_id'];
                }
                $baike_category_id=implode(',',array_unique($category_arr));
            }
        }
        $update_data['baike_word'] = $data['baike_word'];
        $update_data['create_time'] = $data['create_time'];
        $update_data['tags_info'] = $data['tags_info'];
        $update_data['title'] = $data['title'];
        $update_data['author'] = $data['author'];
        $update_data['status'] = $data['status'];
        $update_data['category_id'] = $data['category_id'];
//        $update_data['baike_category_id'] = $baike_category_id;
        $update_data['baike_cid'] = $baike_category_id;
        $update_data['des'] = $data['des'];
        $update_data['cont'] = $data['cont'];
        $update_data['accessory'] = $data['accessory'];
        $update_data['detail_des'] = $data['detail_des'];
        $update_data['hide_logo'] = empty($data['hide_logo'])?0:$data['hide_logo'];
        $update_data['is_good'] = $data['is_good'];
        $update_data['logo'] = empty($data['logo_f'])?$data['logo']:$data['logo_f'];
        $update_data['from_url'] = $data['from_url'];
        $update_data['space_ids'] = $data['space_ids'];
        $update_data['actor'] = $data['actor'];
        if(!empty($handle_data['is_jump'])){
            $update_data['is_jump']=$handle_data['is_jump'];
        }
        if(!empty($handle_data['original_link'])){
            $update_data['original_link']=$handle_data['original_link'];
        }
        if(!empty($data['img_set'])){
           $img_set = Data_Mysql_Table_Raiders_Info::handleImgSet($data['img_set']);
            if($img_set){
                $update_data['img_set'] = $img_set;
            }
        }
        return $update_data;

    }
}