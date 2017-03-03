<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/9/15
 * Time: 16:47
 */

switch (Core::$urls['action']) {
    case 'cron_list':
        OA_Cron_Manage::handle();
        break;
    case 'import_log':
        OA_Import_Log::handle();
        break;
    case 'rebuild_index':
        OA_Rebuild_Index::handle();
        break;
    case 'update_search_keyword':
        OA_Update_Search_Keyword::handle();
        break;
    case 'user_track_list':
        OA_User_Track_List::handle();
        break;
    case 'track_referer':
        OA_Track_Referer_Land::handle(1);
        break;
    case 'track_land':
        OA_Track_Referer_Land::handle(2);
        break;
    default:
        Func_Header::notFound();
        break;
}