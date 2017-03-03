<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/5/28
 * Time: 16:58
 */
class Admin_Data_Stat
{
    static function vendor()
    {
        $rs = Data_Mysql_Table_Vendor_Info::select('count(*) as c, FROM_UNIXTIME({table}.update_time,"%Y %m") as m', array('status>=0'), 'GROUP BY m', 100);
        echo '<table>';
        foreach ($rs as $k => $v) {
            echo '<tr>';
            echo '<td>';
            echo $v['m'];
            echo '</td>';
            echo '<td>';
            echo $v['c'];
            echo '</td>';
            echo "</tr>";
        }
        echo '</table>';
        $rs = Data_Mysql_Table_Vendor_Info::select('count(*) as c, FROM_UNIXTIME({table}.update_time,"%Y %m") as m', array('status>=0 AND vendor_account_id > 0'), 'GROUP BY m', 100);
        echo '<hr><table>';
        foreach ($rs as $k => $v) {
            echo '<tr>';
            echo '<td>';
            echo $v['m'];
            echo '</td>';
            echo '<td>';
            echo $v['c'];
            echo '</td>';
            echo "</tr>";
        }
    }
} 