<div class="">
    <form action="?action=add_contact_record" method="post">
        <div class="form-group col-md-12">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>编号ID</th>
                    <th>记录ID</th>
                    <th>记录内容</th>
                    <th>记录时间</th>
                </tr>
                </thead>
                <tbody>
                {foreach $contactRecord['rows'] as $key=>$value}
                    <tr>
                        <td>{$value['id']}</td>
                        <td>{$value['contact_id']}</td>
                        <td>{$value['content']}</td>
                        <td>{date('Y-m-d H:i:s',$value['time'])}</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <textarea class="form-control" rows="3" name="content"></textarea>
            <input type="hidden" name="contact_id" value="{$contactRecord['contact_id']}"/>
            <div class="" style="text-align: right; margin-top: 15px"><button type="submit" class="btn btn-primary">提交</button></div>
        </div>
        {*<div class="form-group col-md-12">*}
            {*<lable class="checkbox-inline">*}
                {*<input type="checkbox" class="form-control" name="tags[]">有新需求*}
            {*</lable>*}
            {*<lable class="checkbox-inline">*}
                {*<input type="checkbox" class="form-control" name="tags[]">要看场*}
            {*</lable>*}
            {*<lable class="checkbox-inline">*}
                {*<input type="checkbox" class="form-control" name="tags[]">好沟通*}
            {*</lable>*}
            {*<lable class="checkbox-inline">*}
                {*<input type="checkbox" class="form-control" name="tags[]">难沟通*}
            {*</lable>*}
            {*<lable class="checkbox-inline">*}
                {*<input type="checkbox" class="form-control" name="tags[]">不接电话*}
            {*</lable>*}
            {*<lable class="checkbox-inline">*}
                {*<input type="checkbox" class="form-control" name="tags[]">多次不接电话*}
            {*</lable>*}
            {*<lable class="checkbox-inline">*}
                {*<input type="checkbox" class="form-control" name="tags[]">大客户*}
            {*</lable>*}
        {*</div>*}
        {*<div class="form-group col-md-12">*}
            {*<div class="" style="text-align: right; margin-top: 15px">*}
                {*<button type="submit" class="btn btn-primary">*}
                    {*提交*}
                {*</button>*}
            {*</div>*}
        {*</div>*}
    </form>
    <div class="tab-pane active">
        <div class="pull-right">
            <ul class="pagination">
                {if $contactRecord['page']['dpll']}
                    <li class="prev">
                        <a href="{$contactRecord['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev">
                        <a href="{$contactRecord['page']['dup']}{$contactRecord['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                    </li>
                {else}
                    <li class="prev disabled">
                        <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev disabled">
                        <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                    </li>
                {/if}
                {for $i=$contactRecord['page']['dpl'] to $contactRecord['page']['dpr']}
                    <li{if $i==$contactRecord['page']['dp']} class="active"{/if}>
                        <a href="{$contactRecord['page']['dup']}{$i}">{$i}</a>
                    </li>
                {/for}
                <li class="disabled">
                    <a> {$contactRecord['page']['dtp']} ( {$contactRecord['page']['dp']*$contactRecord['page']['dn']}/{$contactRecord['page']['dt']} )</a></li>

                {if $productInfo['page']['dprr']}
                    <li class="next">
                        <a href="{$contactRecord['page']['dup']}{$contactRecord['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                    </li>
                    <li class="next">
                        <a href="{$contactRecord['page']['dup']}{$contactRecord['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
                    </li>
                {else}
                    <li class="next disabled">
                        <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                    </li>
                    <li class="next disabled">
                        <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                    </li>
                {/if}
            </ul>
        </div>

    </div>
</div>