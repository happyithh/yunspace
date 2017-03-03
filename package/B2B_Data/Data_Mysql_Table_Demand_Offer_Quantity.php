<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Demand_Offer_Quantity extends Data_Mysql_Table
{
    public $cols = array(
        'demand_id' => 'int',  //订单号
        'c_num' => 'int',  //客户浏览量 5
        'c_num_three' => 'int',  //客户打开次数大于3次 15
        'v_num' => 'int',  //商家浏览 5
        'v_num_five' => 'int',  //商家浏览次数大于5次 15
        'offer_num' => 'int',  //商家报价 5
        'offer_num_three' => 'int',  //商家报价次数大于3次 15
       // 'change_num' =>'int', //交换电话
        'change_num_one'=>'int',//交换电话大于1 20
    );
    public $index = array(
        'demand_id' => 'i',

    );

}

