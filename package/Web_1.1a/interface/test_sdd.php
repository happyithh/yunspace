<?php
/**
 * Created by PhpStorm.
 * User: sdd
 * Date: 2016/8/17
 * Time: 16:05
 */

function getId($w_id){
    $condition['id>?'] = $w_id;
//    Data_Mysql_Table_Winchance::debug(1);
    $rs = Data_Mysql_Table_Winchance::select('*', $condition, '', 50);
    if(!empty($rs)){
//        var_dump(666666);
        Export($rs);
        $w_info = end($rs);
        $w_id = (int)$w_info['id'];
        getId($w_id);
    }else{
//        var_dump($rs);
        Q("执行完成'");
    }
}

function Export($rs){
    foreach($rs as $k=>$v){
        $result = Data_Mysql_Table_Winchance_New::select('id',array('ip_name=?'=>$v['resource_name']),'',1);
        if(!empty($result)){
            continue;
        }
        $v['tags_info'] = json_decode( $v['tags_info'] ,1);
        $v['attr'] = json_decode( $v['attr'] ,1);
        $v['media'] = json_decode( $v['media'] ,1);
        switch($v['area']){
            case  "1":
               $v['min_area'] = 0;
               $v['max_area'] = 100;
                break;
            case  "2":
                $v['min_area'] = 100;
                $v['max_area'] = 500;
                break;
            case  "3":
                $v['min_area'] = 500;
                $v['max_area'] = 1000;
                break;
            case  "4":
                $v['min_area'] = 1000;
                $v['max_area'] = 3000;
                break;
            case  "5":
                $v['min_area'] = 3000;
                break;
            default:
                $v['min_area'] = '';
                $v['max_area'] = '';
                break;
        }
        $category = Data_Mysql_Table_Winchance::$category;
        $data=array(
            // 储备信息
            'ip_name' => $v['resource_name'],  // ip项目名称
            'company' => $v['attr']['IP所属单位'],    // 公司名称
            'country' => $v['attr']['资源来自国家'], //来源国家
            // 审核上线信息
            'active_name' => $v['title'],  // 上线活动名称
            'ip_des'=>$v['marketing_title'],        //一句话简介
            'conform_crowd' => $v['conform_crowd'], // 符合人群  例：儿童,老人,20-30岁
            'category' => $category[$v['category']],  // 分类
            'feature_tag'=>$v['tags_info'][0],//特色标签
            'cover_picture'=>$v['media'],//封面图
            'ip_brief_introduction'=>$v['marketing_title'],//ip简介
            'budget'=>$v['attr']['预算上限'].'-'.$v['attr']['预算下限'],//预算
            'online_status'=>0, //上线状态

            // 拜访或电话
            'agent' => array(
                '授权代理公司' => $v['attr']['被授权公司'],
                '联系人' =>$v['attr']['联系人'],
                '职务' =>$v['attr']['职位'],
                '电话' =>$v['attr']['联系电话'],
                '邮箱' =>$v['attr']['邮箱'],
            ),  // 授权代理详情信息 （联系人、电话、授权公司名称、授权期限等）
            'city' => $v['operation_range'],//运营范围 例如：上海,北京
            'manifestation' => $v['manifestation'], //表现形式
            'mandate_expire' => $v['attr']['年限'],  // 授权期限
            'min_area' =>  $v['min_area'],  //最小面积
            'max_area' =>  $v['max_area'] ,  //最大面积

            //完善IP信息
//        'cooperating_state'=>'100',//合作状态
            'cooperating_mode' => $v['cooperating_mode'],//合作模式
            'grant_country' => $v['attr']['运营团队所属国家'], //运营团队授权国家
            'curator' => $v['attr']['策展人'],  // 策展人  无策展人时为空，有策展人时必填
            'grant_fee' => array(
                '授权费' =>array(
                    0 => $v['attr']['授权费'],
                     1 =>'场次'
                    ),
                  '搭建费' =>array(
                      0 => $v['attr']['搭建费'],
                      1 =>'场次'
                  ),
                  '道具费' =>array(
                      0 => $v['attr']['道具费'],
                      1 =>'场次'
                  ),
                  '运营费' =>array(
                      0 => $v['attr']['运营费'],
                      1 =>'场次'
                  ),
            ) ,//授权费用信息
            'schedule' => $v['attr']['档期'], //档期  开始时间/结束时间
            'materiel_source' => $v['attr']['物料'],  // 物料来源

            // 签订协议
            'accessory' => !empty($v['accessory'])?json_decode($v['accessory'],1):'',  //  合同附件

            // 整体同步存在的字段
            'admin_id' => $v['yun_principal'],  // 负责人ID
            'note' => $v['remarks'], // 备注
            'create_time' => $v['create_time'],
            'update_time' => $v['update_time'],
            'step' => 1, // 进度 （当前处在哪个状态）
            'status' => 0, // 区分已入驻/未入驻 1 已入住 0 未入驻 -1已删除
        );
        $space_data = array(
            'space_name'=>$data['active_name'],
            'status'=>0,
            'category_id'=>200
        );
        $result= Data_Mysql_Table_Spacepedia::update($space_data);
        if($result){
            $data['space_id']=$result[0];
        }
//        $data[$k]['ip_name'] = $v['resource_name'];
//        $data[$k]['active_name'] = $v['title'];
//        $data[$k]['ip_des'] = $v['marketing_title'];
//        $data[$k]['category'] = $v['category'];
//        $data[$k]['create_time'] = (int)$v['create_time'];
//        $data[$k]['update_time'] = (int)$v['update_time'];
//        $data[$k]['cover_picture'] = $v['media'];
//        $data[$k]['online_status'] = (int)$v['status'];
//        $data[$k]['feature_tag'] = $v['tags_info'];
//        $data[$k]['admin_id'] = (int)$v['yun_principal'];
//        $data[$k]['manifestation'] = $v['manifestation'];
//        $data[$k]['city'] = $v['operation_range'];
//        $data[$k]['conform_crowd'] = $v['conform_crowd'];
//        $data[$k]['note'] = $v['remarks'];
//        $attr[$k] = json_decode($v['attr'],1);
//        $data[$k]['country'] = $attr[$k]['资源来自国家'];
//        $data[$k]['mandate_expire'] = $attr[$k]['年限'];
//        $data[$k]['materiel_source'] = $attr[$k]['物料'];
//        $data[$k]['grant_country'] = $attr[$k]['运营团队所属国家'];
//        $data[$k]['schedule'] = $attr[$k]['档期'];
//        $data[$k]['curator'] = $attr[$k]['策展人'];
//        $date = array();
//        $date['授权费'] = $attr[$k]['授权费'];
//        $date['搭建费'] = $attr[$k]['搭建费'];
//        $date['道具费'] = $attr[$k]['道具费'];
//        $date['运营费'] = $attr[$k]['运营费'];
//        $data[$k]['grant_fee'] = json_encode($date);
//        $agent = array();
//        $agent['联系人'] = $attr[$k]['联系人'];
//        $agent['职位'] = $attr[$k]['职位'];
//        $agent['邮箱'] = $attr[$k]['邮箱'];
//        $agent['联系电话'] = $attr[$k]['联系电话'];
//        $agent['被授权公司'] = $attr[$k]['被授权公司'];
//        $data[$k]['agent'] = json_encode($agent);
//        $budget = array();
//        $budget['预算上限'] = $attr[$k]['预算上限'];
//        $budget['预算下限'] = $attr[$k]['预算下限'];
//        $data[$k]['budget'] = json_encode($budget);
//        switch($v['area']){
//            case  "1":
//                $data[$k]['max_area'] = 100;
//                break;
//            case  "2":
//                $data[$k]['min_area'] = 100;
//                $data[$k]['max_area'] = 500;
//                break;
//            case  "3":
//                $data[$k]['min_area'] = 500;
//                $data[$k]['max_area'] = 1000;
//                break;
//            case  "4":
//                $data[$k]['min_area'] = 1000;
//                $data[$k]['max_area'] = 3000;
//                break;
//            case  "5":
//                $data[$k]['min_area'] = 3000;
//                break;
//            default:
//                $data[$k]['min_area'] = '';
//                $data[$k]['max_area'] = '';
//                break;
//        }
        Data_Mysql_Table_Winchance_New::insert($data,1);
        unset($data);
    }
}
//Data_Mysql_Table_Winchance_New::debug(1);

getId(0);
