<div class="actions">
    <div class="btn-group">
              <span class="btn btn-danger ">
                  您还有[<span id="demandInfo"></span>]来处理
              </span>
    </div>
</div>
{static "demands/countdown.js"}
<script>
    //处理倒计时
    function timeOut() {
        var _id = document.getElementById("demandInfo");

        var _time = "{$value}";
        if (_time) {
            _id.parentNode.style.display = 'block';
            countdown("demandInfo", _time);
        }
    }
    timeOut();
</script>