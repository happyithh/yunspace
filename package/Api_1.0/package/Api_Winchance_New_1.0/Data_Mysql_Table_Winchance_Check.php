<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/7
 * Time: 21:11
 * 审核列表
 */
class Data_Mysql_Table_Winchance_Check extends Data_Mysql_Table{
    public $cols = array(
        'ip_id'=>'int',  //
        'ip_step'=>'int', // ip进度状态
        'data'=>'array',  // 更新的数组
        'status'=>'int', // 0 待审核  1 已审核 -1 已拒绝 2 保存草稿 -2主表数据已删除
        'create_time'=>'int',
        'update_time'=>'int',
        'check_time'=>'int', //审核时间
        'admin_id'=>'int',  // 负责人ID
        'operator_id'=>'int',  // 操作者ID
        'rejectReason'=>'3000',  // 拒绝理由
        'conform_crowd'=>'1000', // 适用人群
        'space_id'=>'int',
        /*
         * 搜索使用
         * */
        'ip_name'=>'3000',
        'city'=>'3000',
        'category'=>'1000',
        'cooperating_mode'=>'3000',
        'manifestation'=>'500',
        'min_area' => 'int',  //最小面积
        'max_area' => 'int',  //最大面积
    );
    public $index = array(
        'ip_id'=>'i',
        'ip_step'=>'i',
        'check_time'=>'i',
        'admin_id'=>'i',
        'operator_id'=>'i',
        'city'=>'attr',
        'cooperating_mode'=>'attr',
        'category'=>'attr',
        'min_area'=>'i',
        'max_area'=>'i',
        'manifestation'=>'i',
        'ip_name'=>'title'
    );
}