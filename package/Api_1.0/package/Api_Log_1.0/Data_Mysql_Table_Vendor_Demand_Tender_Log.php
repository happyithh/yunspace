<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/9/9
 * Time: 11:10
 */
class  Data_Mysql_Table_Vendor_Demand_Tender_Log extends Data_Mysql_Table
{
    public $cols = array(
        'php_class ' => '50',
        'php_func ' => '50',
        'behavior ' => '100',         //行为
        'account_id' => 'int',      //
        'tender_id' => 'int',      //
        'scheme_id' => 'int',      //
        'loginInfo' => 'array',
        'create_time' => 'int',
    );
    public $index = array(

    );

}