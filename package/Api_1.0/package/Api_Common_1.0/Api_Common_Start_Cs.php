<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/10/17
 * Time: 16:22
 */

class Api_Common_Start_CS extends Api {
        static function handle(){
            return  self::startCaptchaServlet();
        }

        static function startCaptchaServlet(){
           $data = Func_Start_Cs::startCs();
            if($data){
                return json_decode($data,1);;
            }else{
                return '';
            }
        }
} 