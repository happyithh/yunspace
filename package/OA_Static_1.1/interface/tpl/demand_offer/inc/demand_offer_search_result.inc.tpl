                        {if ($_REQUEST['type']==1 || $_REQUEST['type']==2) && $_data['rows']}
                            {foreach $_data['rows'] as $k=>$v}
                                <tr>
                                    <td><a href="{$_root}service_info/{$v['product_id']}.html" target="_blank">{$v['product_id']}</a></td>
                                    <td class="list_none"><a href="{$_root}baike/{$v['space_name']}"
                                                             style="text-decoration: none" target="_blank">{$v['item_name']}</a></td>
                                    <td>{$v['min_price']/100}--{$v['max_price']/100}</td>
                                    <td>{$v['min_people']}--{$v['max_people']}</td>
                                    <td>{$v['size']}{if $v['size']}m<sup>2</sup>{/if}</td>
                                    <td>{$v['city']}</td>
                                    <td>{$_categories[112][$v['category_id']]}</td>
                                    <td>{$v['contacts']}</td>
                                    <td class="list_none">{$v['phone']}</td>
                                    {*<td class="red">{$v['scheme_sum']}</td>*}
                                    <td>
                                        {if $v['notice_time']==0}
                                         <a class="btn btn-info btn-xs send_message" result-id="{$v['result_id']}" demand_id="{$_demand['id']}">发送短信</a>
                                            <a class="btn btn-danger btn-xs delete_result" result-id="{$v['result_id']}" demand_id="{$_demand['id']}">删除</a>
                                            {else}
                                            <!--查看商品详情-->
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                        {/if}
                        {if $_result_list}
                            {foreach $_result_list as $k=>$v}
                                <tr>
                                    <td><a href="{$_root}service_info/{$v->product_id}.html" target="_blank">{$v->product_id}</a></td>
                                    <td ><a href="{$_root}baike/{$v->space_name}"
                                            style="text-decoration: none" target="_blank">{$v->item_name}</a></td>
                                    <td>{$v->price_down/100}--{$v->price_up/100}</td>
                                    <td>{$v->people_down}--{$v->people_up}</td>
                                    <td>{$v->size}&nbsp;m<sup>2</sup></td>
                                    <td>{$v->city}</td>
                                    <td >{$v->contacts}</td>
                                    <td >{$v->phone}</td>
                                    {*<td class="red">{$v['scheme_sum']}</td>*}
                                    {*<td>*}
                                    {*<td>*}
                                        {*<a class="btn btn-info btn-xs send_message" item-value="{$v['id']}" demand_value="{$_demand['id']}">发送短信</a>*}
                                    {*</td>*}
                                </tr>
                            {/foreach}
                        {/if}
                        {if $_REQUEST['type']==3 && $_data}
                            {foreach $_data as $k=>$v}
                                <tr>
                                    <td>{$v->item_id}</td>
                                    <td ><a href="{$_root}baike/{$v->space_name}"
                                            style="text-decoration: none" target="_blank">{$v->item_name}</a></td>
                                    <td>{$v->price_down/100}--{$v->price_up/100}</td>
                                    <td>{$v->people_down}--{$v->people_up}</td>
                                    <td>{$v->city}</td>
                                    <td >{$v->contacts}</td>
                                    <td >{$v->phone}</td>
                                    {*<td class="red">{$v['scheme_sum']}</td>*}
                                    <td width="8%">
                                        <button class="btn btn-info btn-xs expend" data-toggle="modal" href="#basic"  data-value="{$v->item_id}" >
                                            拓展</button>
                                        {*<a href="" class="btn btn-info btn-xs">拓展</a>*}
                                        {*<a  href="" class="btn btn-info btn-xs send_message" >发送短信</a>*}
                                    </td>
                                </tr>
                            {/foreach}
                        {/if}
                        {if $_REQUEST['type']==4 && $_data}
                            {foreach $_data['rows'] as $k=>$v}
                                <tr>
                                    <td><a href="{$_root}service_info/{$v['product_id']}.html" target="_blank">{$v['product_id']}</a></td>
                                    <td class="list_none"><a href="{$_root}baike/{$v['space_name']}"
                                                             style="text-decoration: none" target="_blank">{$v['item_name']}</a></td>
                                    <td>{$v['min_price']/100}--{$v['max_price']/100}</td>
                                    <td>{$v['min_people']}--{$v['max_people']}</td>
                                    <td>{$v['size']}{if $v['size']}m<sup>2</sup>{/if}</td>
                                    <td>{$v['city']}</td>
                                    <td>{$_categories[112][$v['category_id']]}</td>
                                    <td>{$v['contacts']}</td>
                                    <td class="list_none">{$v['phone']}</td>
                                    {*<td class="red">{$v['scheme_sum']}</td>*}
                                    <td width="10%">
                                        {if $v['expand_status']==0 || $v['expand_status']==-3 || $v['expand_status']==-1}
                                        <button class="btn btn-info btn-xs expend" data-toggle="modal" href="#basic"  data-value="{$v['id']}" space-id="{$v['space_id']}" >
                                            拓展</button>
                                            &nbsp;
                                            <button class="btn btn-danger btn-xs change_down"  data-value="{$v['id']}" >
                                                下移</button>
                                            {else}
                                            <a class="btn btn-success btn-xs send_message_new" offer-id="{$_offer_id}" demand-id="{$_demand['id']}" item-id="{$v['id']}" >发送短信</a>
                                       {/if}
                                        {*<a href="?action=detail&id={$v['id']}" class="btn btn-info btn-xs">拉黑</a>*}
                                    </td>
                                </tr>
                            {/foreach}
                        {/if}
