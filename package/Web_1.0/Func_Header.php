<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 17:59
 */
class Func_Header
{
    static function notFound()
    {
        ob_clean();
        header("Status: 404 Not Found");
        header("HTTP/1.0 404 Not Found");
        if(!empty($_SERVER['HTTP_HOST']) && ($_SERVER['HTTP_HOST'] == 'yun.mm' || $_SERVER['HTTP_HOST'] == 'm.yunspace.com.cn')){
            Tpl_Smarty::display('Web_Mobile', '404.tpl');
        } else {
            Data_Config_Site::cityShow();
//            Tpl_Smarty::display('Web', '404.tpl');
            Tpl_Smarty::display('Web_Static', 'search/wrong.tpl');
        }
        die();
    }

    static function location($path)
    {
        header("location: " . $path);
        die();
    }

    static function alert()
    {
        echo "alert";
    }

    static function back($info = '')
    {
        if (Core::$package['name'] != 'Admin' && Core::$package['name'] != 'Wechat' && Core::$package['name'] != 'Web_Mobile') {
            self::backToTpl($info);
        } else {

            if ($info) {
                self::jsEcho("top.alert(\"" . addslashes($info) . "\"); function a(){window.history.go(-1);} setTimeout('a()',100)");
            } else {
                self::jsEcho("function a(){window.history.go(-1);} setTimeout('a()',200)");
            }
            die();
        }
    }
    static function backNew($info = '',$target = '')
    {
        if (Core::$package['name'] != 'Admin' && Core::$package['name'] != 'Wechat' && Core::$package['name'] != 'Web_Mobile') {
            self::backToTplNew($info,$target);
        } else {

            if ($info) {
                self::jsEcho("top.alert(\"" . addslashes($info) . "\"); function a(){window.history.go(-1);} setTimeout('a()',100)");
            } else {
                self::jsEcho("function a(){window.history.go(-1);} setTimeout('a()',200)");
            }
            die();
        }
    }
    static function backToTplNew($info = '',$target = '')
    {
        if ($info&&$target) {
            Tpl_Smarty::assign('isBack', 'true');
            Tpl_Smarty::assign('url_back', 'javascript:window.history.go(-1)');
            Tpl_Smarty::assign('info', $info);
            Tpl_Smarty::assign('target', $target);
            Tpl_Smarty::display('Web_Static::v2.0/alert_messages.tpl');


        } else {
            self::jsEcho("function a(){window.history.go(-1);} setTimeout('a()',200)");
        }
        die();
    }
    static function backToTpl($info = '')
    {
        if ($info) {
            Tpl_Smarty::assign('isBack', 'true');
            Tpl_Smarty::assign('url_back', 'javascript:window.history.go(-1)');
            Tpl_Smarty::assign('info', $info);
            Tpl_Smarty::display('Web', 'alert_messages.tpl');

        } else {
            self::jsEcho("function a(){window.history.go(-1);} setTimeout('a()',200)");
        }
        die();
    }

    static function to($info = '', $url = '')
    {
        if (!$url) {
            if (!empty($_COOKIE['url_back'])) {
                setcookie('url_back', '');
                $url = $_COOKIE['url_back'];
            } else {
                $url = !empty($_SERVER['HTTP_REFERER'])
                    ? $_SERVER['HTTP_REFERER']
                    : Core::$urls['host'];
            }
        }

        if ($info && Core::$package['name'] != 'Admin') {
            return self::toTpl($info, $url);
        }
        $script = '';
        if ($info) {
            $script .= "top.alert(\"" . addslashes($info) . "\");";
        }

        $script .= "function a(){window.location.href='{$url}';} setTimeout('a()',200)";
        self::jsEcho($script);
        die();
    }


    static function toTpl($info = '', $url = '')
    {
        if ($info) {
            Tpl_Smarty::assign('url_back', $url);
            Tpl_Smarty::assign('info', $info);
            //self::jsEcho("function a(){window.history.go(-1);} setTimeout('a()',3000)");
            Tpl_Smarty::display('Web', 'alert_messages.tpl');
        }
        die();
    }

    static function toTplNoTime($info = '')
    {
        if ($info) {
            Tpl_Smarty::assign('info', $info);
            //self::jsEcho("function a(){window.history.go(-1);} setTimeout('a()',3000)");
            Tpl_Smarty::display('Web', 'alert_messages_no_time.tpl');
        }
        die();
    }

    static function post($url, $data, $encode = 'utf-8')
    {
        $html = "<form action='{$url}' method='post'>";
        foreach ($data as $k => $v) {
            $html .= "<input type='hidden' name='{$k}' value='{$v}' />";
        }
        $html .= '</form>';
        $script = "function a(){document.forms[0].submit();} setTimeout('a()',200)";
        self::jsEcho($script, $html, $encode);
        die();
    }

    static function opener($url = '')
    {
        if ($url || !empty($_SERVER['HTTP_REFERER'])) {
            $url or $url = $_SERVER['HTTP_REFERER'];
            self::jsEcho("window.opener.location.href='{$url}'; function a(){ window.opener=null;  window.open('', '_self', ''); window.close();} setTimeout('a()',100) ;");
        } else {
            self::jsEcho("window.opener.location.reload(); function a(){ window.opener=null;  window.open('', '_self', ''); window.close();} setTimeout('a()',100) ;");
        }
        die();
    }

    static function close()
    {
        self::jsEcho("function a(){ window.close();} setTimeout('a()',100) ;");
        die();
    }


    static function jsEcho($script, $body = '', $encode = 'utf-8')
    {
        ob_clean();
        header('Cache-Control:no-cache,must-revalidate');
        header('Pragma:no-cache');
        $html = '
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=' . $encode . '" />
</head>
<body>';
        $html .= "<script type='text/javascript'>{$script}</script>{$body}</body></html>";
        if ($encode != 'utf-8') {
            $html = mb_convert_encoding($html, 'utf-8', $encode);
        }
        echo $html;
    }

    static function noPic()
    {
        ob_clean();
        header("Status: 404 Not Found");
        header("HTTP/1.0 404 Not Found");
        header('location: /package/Web_1.0/interface/assets/public/nopic1.jpg');
        die();
    }
}