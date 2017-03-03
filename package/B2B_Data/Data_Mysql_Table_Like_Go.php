<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2015/12/25
 * Time: 11:24
 * 我喜欢和现场足迹数据
 */
class Data_Mysql_Table_Like_Go extends Data_Mysql_Table{
    public $cols = array(
        'space_id'=>'int',              // 百科ID
//        'account_id'=>'int',            //  账户ID
        'wechat_id'=>'int',            //  微信ID
        'like_go'=>'int',               // 1 为我喜欢   2 为现场足迹
        'create_time'=>'int',
        'update_time'=>'int',           //update_time=1为假数据
    );
    public $index=array(
        'space_id,wechat_id,like_go'=>'u',
    );
    public $title=array(
        'space_id'=>'百科ID',
        'wechat_id'=>'账户ID',
        'like_go'=>'我喜欢和现场足迹',
        'create_time'=>'创建时间',
        'update_time'=>'创建时间',
    );
}