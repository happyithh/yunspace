<?php
/**
 * 用户头像
 */
//('Cache-Control:no-cache,must-revalidate');
//header('Pragma:no-cache');
if (!strpos(Core::$urls['action'], '.jpg') || substr(Core::$urls['action'], -4) !== '.jpg') {
    Func_Header::notFound();
}
$accountId = intval(substr(Core::$urls['action'], 0, -4));
if ($accountId == 0) {
    Func_Header::notFound();
}
// 大于0的查找自己。然后默认  大于-10000小于0 的默认头像
//小于-10000的合成图片
switch ($accountId) {
    case $accountId > 0 :
        $accountInfo = Api_Account_GetBaseInfo::getBaseInfoById(array('account_id' => $accountId));
        if (empty($accountInfo['avatar'])) {
            $head_img_url = Core::$urls['assets'] . 'images/avatar.jpg';
        } else {
            $head_img_url = $accountInfo['avatar'];
        }
        break;
    case ($accountId == -1 && $accountId > -10000) :
        $head_img_url = Core::$urls['assets'] . 'images/head.jpg';
        break;
    case ($accountId == -2 && $accountId > -10000) :
        $head_img_url = Core::$urls['assets'] . 'images/demand_tender_head.jpg';
        break;
    case $accountId < -10000:
        $head_img_url = groupImg($accountId);
        break;
    default:
        Func_Header::notFound();
        break;
}
header('location: ' . $head_img_url);

function groupImg($groupID)
{
    //头像缓存, 如果变更群组成员则删除此文件
    if (file_exists(Core::$paths['root'] . "upload/group/" . $groupID . ".jpg")) {
        return "/upload/group/" . $groupID . ".jpg";
    }
    $grouplist = Api_Livechat_Group_GetInfo::getGroupInfoById(array('group_id' => $groupID));
    if ($grouplist) {
        $groupids = array();
        $i = 0;
        $total = $grouplist['members_total'] > 9 ? 9 : $grouplist['members_total'];
        foreach ($grouplist['members'] as $k => $v) {
            if ($i < $total) {
                $groupids[] = $k;
            }
            $i++;
        }
    } else {
        Func_Header::notFound();
    }
    if ($groupids) {
        $accountList = array();
        foreach ($groupids as $v) {
            $accountList[] = Api_Account_GetBaseInfo::getBaseInfoById(array('account_id' => $v));
        }
    } else {
        Func_Header::notFound();
    }
    $accountAvatarLIst = array();
    if ($accountList) {
        foreach ($accountList as $k => $v) {
            $v['avatar'] = strpos($v['avatar'], '://') ? $v['avatar'] : "http://" . Core::$urls['host'] . $v['avatar'];
            if (!strpos($v['avatar'], '://')) {
                $v['avatar'] = Core::$paths['root'] . substr($v['avatar'], 1);
                if (!file_exists($v['avatar'])) {
                    continue;
                }
            }
            $accountAvatarLIst[] = $v['avatar'];
        }
    } else {
        Func_Header::notFound();
    }
    $totalAvatar = count($accountAvatarLIst);
    if ($totalAvatar < 2) {
        $accountAvatarLIst[] = Core::$paths['root'] . substr(Core::$urls['assets'], 1) . 'images/head.jpg';
        $totalAvatar++;
    }
    switch ($totalAvatar) {
        case 0:
            $head_img_url = Core::$urls['assets'] . 'images/head.jpg';
            break;
        case $totalAvatar >= 1 :
            Func_Image::mergeImage($accountAvatarLIst, Core::$paths['root'] . "upload/group/" . $groupID . ".jpg");
            $head_img_url = "/upload/group/" . $groupID . ".jpg";
            break;
        default:
            Func_Header::notFound();
            break;
    }
    return $head_img_url;
}