<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/19
 * Time: 13:03
 *
 * 文创ip管理字段字段处理
 */

class Api_Winchance_New_Ip_Submit_Field_Deal extends Api{

    // 储备信息阶段
    static function stepOne(){

        $request=Func_Input::filter(array(
            'id' => 'int',
            // 储备信息
            'ip_name' => 'string',
            'figure' => 'string',
            'company' => 'string',
            'country' => 'string',
            'submit_type'=>'string'
        ),$_REQUEST);
        if(empty($request['submit_type'])){
            if (empty($request['company'])) {
                Func_Header::back('IP品牌不能为空!');
            }
            if (empty($request['figure'])) {
                Func_Header::back('IP形象不能为空!');
            }
            if (empty($request['ip_name'])) {
                Func_Header::back('IP名称不能为空!');
            }
            if (empty($request['country'])) {
                Func_Header::back('来源国家不能为空!');
            }
        }
        // 储备信息
        $data['company'] = $request['company'];
        $data['figure'] = $request['figure'];
        $data['ip_name'] = $request['ip_name'];
        $data['country'] = $request['country'];
        return $data;
    }

    //审核上线阶段
    static function stepTwo(){
        $request = Func_Input::filter(array(
            // 审核上线信息
            'active_name' => 'string',
            'ip_des' => 'string',
            'conform_crowd' => 'string',
            'age' => 'array',
            'category' => 'array',
            'feature_tag'=>'string',
            'ip_brief_introduction'=>'string',
            'budget'=>'string',
            'storey'=>'string',
            'supporting'=>'string',
            'indoor_outdoor'=>'string',
            'cover_picture'=>'array',
            'submit_type'=>'string',
            'online_status'=>'int'
        ),$_REQUEST);
        unset($request['cover_picture']['$$']);
        if(empty($request['submit_type'])) {
            if (empty($request['active_name'])) {
                Func_Header::back('上线活动名称不能为空!');
            }
            if (empty($request['ip_des'])) {
                Func_Header::back('一句话介绍必须填写!');
            }
            if (mb_strlen($request['ip_des'])>100) {
                Func_Header::back('一句话介绍长度在100个字符内!');
            }
            if (empty($request['conform_crowd'])) {
                Func_Header::back('符合人群不能为空!');
            }
            if (empty($request['feature_tag'])) {
                Func_Header::back('特色标签不能为空!');
            }
            if (empty($request['ip_brief_introduction'])) {
                Func_Header::back('ip简介不能为空!');
            }
//            if (empty($request['budget'])) {
//                Func_Header::back('预算不能为空!');
//            }
//            if (empty($request['storey'])) {
//                Func_Header::back('层高不能为空!');
//            }
//            if (empty($request['supporting'])) {
//                Func_Header::back('配套设施没有填写!');
//            }
//            if (empty($request['cover_picture'])) {
//                Func_Header::back('请上传封面图片!');
//            }
//            if (empty($request['indoor_outdoor'])) {
//                Func_Header::back('室内室外没有填写!');
//            }
            if (empty($request['age'])) {
                Func_Header::back('年龄段不能为空!');
            }
            if (empty($request['category'])) {
                Func_Header::back('分类不能为空!');
            }
        }
        // 审核上线信息
        $data['active_name'] = $request['active_name'];
        $data['ip_des'] = $request['ip_des'];
        $data['conform_crowd'] = $request['conform_crowd'];
        $data['age'] = $request['age'];
        $data['category'] = implode(',',$request['category']);
        $data['feature_tag'] = $request['feature_tag'];
        $data['ip_brief_introduction'] = $request['ip_brief_introduction'];
        $data['budget'] = $request['budget'];
        $data['storey'] = $request['storey'];
        $data['supporting'] = $request['supporting'];
        $data['cover_picture'] = $request['cover_picture'];
        $data['indoor_outdoor'] = $request['indoor_outdoor'];
        $data['online_status'] = isset($request['online_status'])?$request['online_status']:0;
        return $data;
    }

    // 电话或拜访阶段
    static function stepThree(){
        $request = Func_Input::filter(array(
            // 拜访或电话
            'agent' => 'array',
            'city' => 'array',
            'ip_age' => 'int',
            'manifestation' => 'string',
            'mandate_expire' => 'int',
            'min_area' => 'int',
            'max_area' => 'int',
            'submit_type'=>'string'
        ),$_REQUEST);
        if(empty($request['submit_type'])) {
            if (empty($request['agent']['授权代理公司'])) {
                Func_Header::back('授权代理公司不能为空!');
            }
            if (empty($request['agent']['联系人'])) {
                Func_Header::back('联系人不能为空!');
            }
            if (empty($request['agent']['职务'])) {
                Func_Header::back('职务不能为空!');
            }
            if (empty($request['agent']['电话'])) {
                Func_Header::back('电话不能为空!');
            }
            if (empty($request['agent']['邮箱'])) {
                Func_Header::back('邮箱不能为空!');
            }
            if (empty($request['city'])) {
                Func_Header::back('请选择运营范围!');
            }
            if (empty($request['ip_age'])) {
                Func_Header::back('IP年龄不能为空!');
            }
            if (empty($request['mandate_expire'])) {
                Func_Header::back('授权期限不能为空!');
            }
            if (empty($request['min_area'])) {
                Func_Header::back('场地最小面积不能为空!');
            }
            if (empty($request['max_area'])) {
                Func_Header::back('场地最大面积不能为空!');
            }
            if ($request['min_area'] > $request['max_area']) {
                Func_Header::back('场地最小面积不能大于场地最大面积!');
            }
        }

        // 拜访或电话
        $data['agent'] = $request['agent'];
        $data['city'] = implode(',', $request['city']);
        $data['ip_age'] = $request['ip_age'];
        $data['manifestation'] = $request['manifestation'];
        $data['mandate_expire'] = $request['mandate_expire'];
        $data['min_area'] = $request['min_area'];
        $data['max_area'] = $request['max_area'];
        return $data;

    }

    // 完善IP信息
    static function stepFour(){
        $request = Func_Input::filter(array(
            //完善IP信息
            'cooperating_mode' => 'array',
            'grant_country' => 'string',
            'czr' => 'int',
            'curator' => 'string',
            'grant_fee' => 'array',
            'unit'=>'array',
//            'schedule_start' => 'string',
//            'schedule_end' => 'string',
            'schedule' => 'string',
            'materiel_source' => 'string',
            'submit_type'=>'string'
        ),$_REQUEST);
        if(empty($request['submit_type'])) {
            if (empty($request['cooperating_mode'])) {
                Func_Header::back('合作模式不能为空!');
            }
            if (empty($request['grant_country'])) {
                Func_Header::back('运营团队所属国家不能为空!');
            }
            if (!empty($request['czr']) && empty($request['curator'])) {
                Func_Header::back('策展人不能为空!');
            }
            if (empty($request['grant_fee']['授权费'][0])) {
                Func_Header::back('授权费不能为空!');
            }
            if (empty($request['grant_fee']['搭建费'][0])) {
                Func_Header::back('搭建费不能为空!');
            }
            if (empty($request['grant_fee']['道具费'][0])) {
                Func_Header::back('道具费不能为空!');
            }
            if (empty($request['grant_fee']['运营费'][0])) {
                Func_Header::back('运营费不能为空!');
            }
            if (empty($request['schedule'])) {
                Func_Header::back('请填写档期信息!');
            }
//            if (strtotime($request['schedule_start']) > strtotime($request['schedule_end'])) {
//                Func_Header::back('档期开始时间应小于结束时间！');
//            }
            if (empty($request['materiel_source'])) {
                Func_Header::back('物料来源不能为空!');
            }
        }
        //完善IP信息
        $data['cooperating_mode'] = implode(',', $request['cooperating_mode']);
        $data['grant_country'] = $request['grant_country'];
        $data['curator'] = $request['curator'];
        $data['grant_fee']['授权费'][0] = $request['grant_fee']['授权费'];
        $data['grant_fee']['授权费'][1] = $request['unit']['授权费'];
        $data['grant_fee']['搭建费'][0] = $request['grant_fee']['搭建费'];
        $data['grant_fee']['搭建费'][1] = $request['unit']['搭建费'];
        $data['grant_fee']['道具费'][0] = $request['grant_fee']['道具费'];
        $data['grant_fee']['道具费'][1] = $request['unit']['道具费'];
        $data['grant_fee']['运营费'][0] = $request['grant_fee']['运营费'];
        $data['grant_fee']['运营费'][1] = $request['unit']['运营费'];
//        $data['schedule'][] = $request['schedule_start'];
//        $data['schedule'][] = $request['schedule_end'];
        $data['schedule'] = $request['schedule'];
        $data['materiel_source'] = $request['materiel_source'];
        return $data;
    }

    // 协议签订
    static function stepFive(){
        $request = Func_Input::filter(array(
            // 签订协议
            'agreement' => 'array',
            'accessory' => 'array',
            'submit_type'=>'string'
        ),$_REQUEST);
        unset($request['accessory']['$$']);
        if(empty($request['submit_type'])) {
            if (empty($request['agreement']['协议内容制定'])) {
                Func_Header::back('协议内容制定必须是已完成状态!');
            }
            if (empty($request['agreement']['授权资质'])) {
                Func_Header::back('授权资质必须是已完成状态!');
            }
            if (empty($request['agreement']['对方法务审核'])) {
                Func_Header::back('对方法务审核必须是已完成状态!');
            }
            if (empty($request['agreement']['协议发回'])) {
                Func_Header::back('协议发回必须是已完成状态!');
            }
            if (empty($request['agreement']['签订完成'])) {
                Func_Header::back('签订完成必须是已完成状态!');
            }
            if (empty($request['accessory'])) {
                Func_Header::back('请上传文件!');
            }
        }

        //签订协议
        $data['agreement'] = $request['agreement'];
        $data['accessory'] = $request['accessory'];
        return $data;
    }

    // check表需要搜索的字段
    static function checkSearchUserField(){
            $search = Func_Input::filter(array(
                'ip_name' => 'string',
                'conform_crowd' => 'string',
                'category' => 'string',
                'city' => 'string',
                'manifestation' => 'string',
                'min_area' => 'int',
                'max_area' => 'int',
                'cooperating_mode' => 'string',
            ), $_REQUEST);
            if(empty($search['min_area'])){
                $search['min_area'] = 0;
            }
            if(empty($search['max_area'])){
                $search['max_area'] = 0;
            }
        return $search;
    }
}