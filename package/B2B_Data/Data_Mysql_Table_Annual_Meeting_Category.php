<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/11/9
 * Time: 15:30
 */

class Data_Mysql_Table_Annual_Meeting_Category  extends Data_Mysql_Table{

      public  $cols = array(
          'category' => '100',
          'status' => 'int',
          'des' => '300',
          'create_time'=>'int',
          'update_time'=>'int',
      );
    public $index = array(
        'category' => 'i',
    );
} 