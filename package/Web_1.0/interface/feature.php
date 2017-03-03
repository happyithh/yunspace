<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/15
 * Time: 10:19
 */

Tpl_Smarty::assign('nav_index', 5);
switch (Core::$urls['action']) {
    case 'enter.html':
        Data_Config_Site::seo('超值套餐，强势来袭');
        Tpl_Smarty::display('feature/2015.5/enter.tpl');
        break;
    case 'publish.html':
        Data_Config_Site::seo('超值套餐，带上PPT就能开的发布会');
        Tpl_Smarty::display('feature/2015.5/publish.tpl');
        break;
    case 'party.html':
        Data_Config_Site::seo('超值套餐，路演活动，屌丝偶遇女神般的回头率');
        Tpl_Smarty::display('feature/2015.5/party.tpl');
        break;
    case 'tasting.html':
        Data_Config_Site::seo('超值套餐，品过才说好,谁用谁知道');
        Tpl_Smarty::display('feature/2015.5/tasting.tpl');
        break;
    case 'salon.html':
        Data_Config_Site::seo('有你，有我，有款，有范，这才是『我们』。');
        Tpl_Smarty::display('feature/2015.5/salon.tpl');
        break;
    case 'annual_meeting.html':
        Data_Config_Site::seo('一年一会，做老板就应该对自己的员工好一点！');
        Tpl_Smarty::display('feature/2015.5/annual_meeting.tpl');
        break;
    case 'meeting.html':
        Data_Config_Site::seo('会议逼格，你享我有！');
        Tpl_Smarty::display('feature/2015.6/meeting.tpl');
        break;
    case 'media.html':
        Data_Config_Site::seo('光影新感觉，优秀多媒体制作商户推荐！');
        Tpl_Smarty::display('feature/2015.7/media.tpl');
        break;
    case 'tea.html':
        Data_Config_Site::seo('主题会议沙龙--禅茶，云space专属定制！');
        Tpl_Smarty::display('feature/2015.7/tea.tpl');
        break;
    case 'zen_tea.html':
        Data_Config_Site::seo('『禅· 茶』 沙龙在浮华中回归宁静');
        Tpl_Smarty::display('feature/2015.7/zen_tea.tpl');
        break;
}
