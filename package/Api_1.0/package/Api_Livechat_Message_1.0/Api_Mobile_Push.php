<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/27
 * Time: 15:27
 */

/**
 * android推送使用
 */

use JPush\Model as M;
use JPush\JPushClient;

class  Api_Mobile_Push
{
    //app  推送
    static function appPush($args)
    {
//    1002   需求竞标推送
//        'tags' => array(
//        'key' => 1002,
//        'val' => array(
//            'url' => $url,
//            'message' => '您有1份新的需求报价'
//        ),
//    ),
        $request = Func_Input::filter(array(
            'content' => 'string',
            'total' => 'int',
            'to_account_id' => 'string',
            'tags' => 'array'
        ), $args);
        if (empty($request['to_account_id'])) {
            return false;
        }
        $sendSms = true;
        //ios
        $device_token = Data_Mysql_Table_App_Login::select('id,device_token_iphone,jpush_register_id', array('user_id =?' => $request['to_account_id']));
        $push_push = @$device_token[0];
        if (!empty($push_push['device_token_iphone'])) {
            Api_Mobile_Push::iosPush($push_push['device_token_iphone'], $request['total'], $request['content'], $request['tags']);
            $sendSms = false;
        }
        //安卓
        if (!empty($push_push['jpush_register_id'])) {
            self::androidPush($push_push['jpush_register_id'], $request['total'], $request['content'], $request['tags']);
            $sendSms = false;
        }
        return $sendSms;

    }

    /**
     * @param $device_token      设备号
     * @param $total            消息数量
     * @param $title            标题
     * @param $dataArray
     * @苹果的推送
     */
    static function iosPush($device_token, $total, $title, $optionArray = false)
    {
        if (empty($device_token) || empty($total) || empty($title)) {
            return false;
        }
        $total = intval($total);
        date_default_timezone_set('PRC');
// Report all PHP errors
        error_reporting(-1);
// Using Autoload all classes are loaded on-demand
        require_once 'plugins/apnsphp/ApnsPHP/Autoload.php';
// Instantiate a new ApnsPHP_Push object
        if (Func_Input::isLocal()) {
            $push = new ApnsPHP_Push(
                ApnsPHP_Abstract::ENVIRONMENT_SANDBOX,
                dirname(__FILE__) . '/plugins/apnsphp/server_certificates_bundle_sandbox_test.pem'
            );
        } else {
            $push = new ApnsPHP_Push(
                ApnsPHP_Abstract::ENVIRONMENT_PRODUCTION,
                dirname(__FILE__) . '/plugins/apnsphp/server_certificates_bundle_push.pem'
            );
        }


// Set the Provider Certificate passphrase
// $push->setProviderCertificatePassphrase('test');

// Set the Root Certificate Autority to verify the Apple remote peer
//$push->setRootCertificationAuthority('entrust_root_certification_authority.pem');

// Connect to the Apple Push Notification Service
        $push->connect();

// Instantiate a new Message with a single recipient
        $message = new ApnsPHP_Message($device_token);
//bc4020b7ae057e06a5ef5aa77cd4a462888aac531980b6d12049674d69004295 ipad
//f886a4874c12b36b103af61c1503e89c7a15a7dab818bc28ebf4702063bf669c iphone 6 plus

// Set a custom identifier. To get back this identifier use the getCustomIdentifier() method
// over a ApnsPHP_Message object retrieved with the getErrors() message.
        $message->setCustomIdentifier("Message-Badge-3");

// Set badge icon to "3"
        $message->setBadge($total);

// Set a simple welcome text
        $message->setText($title);

// Play the default sound
        $message->setSound();

// Set a custom property
        $message->setCustomProperty($optionArray['key'], $optionArray['val']);

// Set another custom property
//        $message->setCustomProperty('acme3', array('bing', 'bong'));

// Set the expiry value to 30 seconds
        $message->setExpiry(30);

// Add the message to the message queue
        $push->add($message);

// Send all messages in the message queue
        $push->send();

// Disconnect from the Apple Push Notification Service
        return $push->disconnect();

    }

    /**
     * @param $device_token     设备号
     * @param $total            消息数量
     * @param $title            标题
     * @param $tags            标题
     * @Android推送
     *
     */
    static function androidPush($device_token, $total, $content, $tags = array())
    {
        if (empty($device_token) || empty($content)) {
            return false;
        }
//        $tags['key']  = 1002   需求竞标推送
        //暂时没有用到total
        $total = intval($total);
        error_reporting(-1);
        require_once 'plugins/vendor/autoload.php';
        $app_key = '9a3f506f90be10c7b7c7729d';
        $master_secret = "75686df70c549d8d725b98f9";
        $client = new JPushClient($app_key, $master_secret);

        return $client->push()
            ->setPlatform(M\all)
            ->setAudience(M\audience(M\registration_id(array($device_token))))
            ->setNotification(M\notification($content))
            ->setOptions(M\options(intval($tags['key']), null, null, true))
            ->send();
    }
}
