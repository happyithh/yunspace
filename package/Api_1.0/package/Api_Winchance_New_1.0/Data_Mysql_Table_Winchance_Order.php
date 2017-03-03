<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/7
 * Time: 13:43
 * IP数据表
 */
class Data_Mysql_Table_Winchance_Order extends Data_Mysql_Table{
    public $cols = array(
        'space_name'=>'300',  // 场地
        'city'=>'20',  // 场地
        'admin_id'=>'300',  // 负责人id
        'admin_name'=>'300',  // 负责人名称
        'contact_name'=>'100', // 联系人姓名
        'contact_phone'=>'15',    // 联系人手机号
        'regions'=>'100', //所需区域
        'need_point'=>'300',  // 所需点位
        'need_area'=>'100', // 所需面积
        'active_start_time'=>'string', // 活动开始时间
        'active_end_time'=>'string', // 活动结束时间
        'active_name'=>'50',  // 活动主题名称
        'budget'=>'int',  // 活动预算
        'final_ip'=>'300',//最终ip
        'ip_info'=>'array',//所选ip及备注
        'protocol_content'=>'int',//协议内容制定
        'authorization_qualification'=>'int',//授权资质
        'legal_audit'=>'int',//对方法务审核
        'protocol_back'=>'int',//协议发回
        'sign_completion'=>'int',//签订完成
        'agreement_files'=>'array',//协议文件
        'remarks'=>'500',//备注
        'step_time'=>'array',//各阶段完成时间
        'create_time'=>'int',//创建时间
        'update_time'=>'int',//修改时间
        'step'=>'50', // 进度 （当前处在哪个状态）
        'status'=>'int', // 状态
        'source'=>'int'
    );
    public $index = array(
        'space_name' => 'i',
        'active_name' => 'i',
        'final_ip' => 'i',
        'city' => 'i',
        'step' => 'i',
    );

    static $step = array(
        '0'=>'了解需求',
        '1'=>'明确需求',
        '2'=>'合同流程',
        '3'=>'已签约，待确认',
        '4'=>'完成',
    );
    static $status =array(
        '0'=>'跟进中',
        '1'=>'完成',
        '-1'=>'已取消',
    );
    static $city_name = array(
        'sh' => '上海',
        'bj' => '北京',
        'gz' => '广州',
        'sz' => '深圳',
        'cd' => '成都',
        'hz' => '杭州',
        'nj' => '南京',
        'suzhou' => '苏州',
        'chongqing' => '重庆',
        'wuhan' => '武汉',
        'xian' => '西安',
        'changsha' => '长沙',
        'nanchang' => '南昌',
        'guiyang' => '贵阳',
        'dalian' => '大连',
        'jinan' => '济南',
        'qingdao' => '青岛',
        'xiameng' => '厦门',
    );


    //云负责人
//    static $yun_principal  = self::getTeamUserList();
//     static $yun_principal  =array(
//        85=>array(
//            'name'=>'Applecheng',
//            'auth'=>1
//        ),
//        27=>array(
//            'name'=>'yvon',
//            'auth'=>0
//        ),
//        206=>array(
//            'name'=>'angee',
//            'auth'=>0
//        ),
//        37=>array(
//            'name'=>'kingsley',
//            'auth'=>0
//        ),
////        30=>array(
////            'name'=>'测试gil',
////            'auth'=>1
////        ),
//    );
    static function getTeamUserList(){
        $condition= array(
            '{prefix}department_member.team_name = ?'=>'KA-文创中心',
            '{table}.status = ?'=>1,
        );
        $result = Api_Administrator_List::getAdminList( $condition,1);
        $new_list = array();
        if(!empty($result)){
            foreach($result as $k=>$v){
                $new_list[$k]['name'] = $v['username'];
                $new_list[$k]['fullname'] = $v['fullname'];
                $new_list[$k]['auth'] = $v['level'];
            }
        }
        return $new_list;
    }
}