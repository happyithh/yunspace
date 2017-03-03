<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/6/30
 * Time: 9:44
 */

class Api_App_Product_List extends Api
{
	static function handle($args='')
	{
		return [
//			"total_count"=> 2,
//			"incomplete_results"=> false,
		//*推荐搜索数据如下格式*/

				array(
					'product_name'=>'空间场地',
					'product_link'=>'',
					'product_des'=>'',
					'product_img'=>''
				),
				array(
					'product_name'=>'配套服务',
				),
				array(
					'product_name'=>'超值套餐'
				)

		];
	}
}