<?php
/**
 * Created by PhpStorm.
 * User: bll
 * Date: 15/10/27
 * Time: 下午5:37
 */
@session_start();
Tpl_Smarty::assign('__seo', array(
    '网页标题'=>'【年底福利】云SPACE创意年会投票_奖品送不停_叫上朋友一起来吧',
));
Data_Config_Site::cityShow();
$rs = Data_Mysql_Table_YearMeeting_Vote::select("COUNT(id) as c", '', 'GROUP BY year_id', 9);
Tpl_Smarty::assign('tickets', $rs);
Tpl_Smarty::display('Web_Feature_Static::year/year.tpl');