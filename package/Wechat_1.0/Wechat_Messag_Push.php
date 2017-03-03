<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/6/29
 * Time: 16:25
 */
class Wechat_Messag_Push
{
    /**
     * @param $template_id
     * @param $to_openid
     * @param $k1
     * @param $k2
     * @return mixed
     * @通用 -消息通知
     */
    static function handleAskNotice($template_id, $to_openid, $k1, $k2, $url = 'www.yunspace.com.cn')
    {
        if (!is_numeric($template_id)) {
            return false;
        }
        $data = Data_Config_Message_Template::get($template_id);
        $data['touser'] = $to_openid;
        $data['data']['keyword1']['value'] = urlencode($k1);
        $data['data']['keyword2']['value'] = urlencode($k2);
        if (!empty($url)) {
            $data['url'] = $url;
        }

        return self::push($data);
    }

    /**
     * @param $data
     * @return mixed
     * @  推送
     */
    static function push($data)
    {
        if (Func_Input::isLocal()) {
            $phone = '18616809072, 13651613353, 13253638122, 13127808798, 15692121909, 13761718098, 18616708501, 13120753293, 18149790202, 13764692936,
                13916545254, 15236792622, 15221833067, 15106392807, 15618052290, 18521534351, 13661937429, 18521038557, 15021114785, 13788989606, 13636540020';
            $conditions[] = "t1.phone IN (" . $phone . ")";
            $table = "{table} as t1 LEFT JOIN  {prefix}account_wechat as t2 ON t1.id  =t2.account_id";

            $accountData = Data_Mysql_Table_Account::select('t2.openid', $conditions, '', 100, $table);
            $is = false;
            foreach ($accountData as $val) {
                if ($data['touser'] == $val['openid']) {
                    $is = true;
                }
            }
            if ($is == false) {
                return json_decode(json_encode(array('errcode' => 1, 'msg' => '此用户不在本地白名单', 'data' => '0')), true);
            }
        }
        $access_token = Wechat_Config::accessToken();
        $url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" . $access_token;

        $rs = self::http_request($url, urldecode(json_encode($data)));
        Data_Mysql_Table_Wechat_Push_Log::createLog($data, $rs);

        return json_decode($rs, true);
    }

    /**
     * @param $data
     * @return mixed
     * @ 管家服务号推送
     */
    static function ManagerPush($data)
    {
        $access_token = Wechat_Config::ManagerAccessToken();
        $url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" . $access_token;
        $rs = self::http_request($url, urldecode(json_encode($data)));
        $arr = json_decode($rs, true);
        if ($arr['errcode'] == 40001) {
            Wechat_Config::ManagerAccessTokenReset();
        }
        return $arr;
    }

    /**
     * @param $data
     * @return mixed
     * @ 销售抢单服务号推送
     */
    static function salePush($data)
    {

        $access_token = Wechat_Config::saleAccessToken();
        $url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=" . $access_token;
        $rs = self::http_request($url, urldecode(json_encode($data)));
        $rs_data = json_decode($rs, true);
        if ($rs_data['errcode'] == 40001) {
            Wechat_Config::saleAccessReset();
        }
        return $rs_data;
    }

    static function http_request($url, $data = array())
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        $output = curl_exec($ch);
        curl_close($ch);
        return $output;
    }

}