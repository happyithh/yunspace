{****延时操作******}
<div class="actions" id="delay" style="display: none">
    <div class="btn-group">
        <span class="btn btn-default" id="js-delay">
        延时1小时
        </span>
    </div>
</div>
{static 'core/yunspace.js'}

<script>
    var end_time = "{$value}";
    var demand_id = "{Func_NumEncode::e($demand_id)}";
    if(end_time > 0){
          document.getElementById('delay').style.display='block';
          document.getElementById('js-delay').addEventListener('click',function(){
                YunSpace.api('demand/setDelay.json',{
                        demand_id:demand_id,
                        time:3600
                },function(data){

                    top.alert(data.msg);
                    window.location.reload();
              });
          });
    }
</script>