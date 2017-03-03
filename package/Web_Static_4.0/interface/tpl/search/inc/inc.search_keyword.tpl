<input type="hidden" name="city" value="{$page->getKeyword['city']}">
{if !empty($page->getKeyword['active_type'])}
    <input type="hidden" name="active_type" value="{$page->getKeyword['active_type']}">
{/if}
{if !empty($page->getKeyword['size_range'])}
 <input type="hidden" name="size_range" value="{$page->getKeyword['size_range']}">
{/if}
{if !empty($page->getKeyword['price_range'])}
        <input type="hidden" name="price_range" value="{$page->getKeyword['price_range']}">
{/if}
{if !empty($page->getKeyword['people_range'])}
    <input type="hidden" name="people_range" value="{$page->getKeyword['people_range']}">
{/if}
{if !empty($page->getKeyword['category'])}
    <input type="hidden" name="category" value="{$page->getKeyword['category']}">
{/if}
{if !empty($page->getKeyword['is_outside'])}
    <input type="hidden" name="is_outside" value="{$page->getKeyword['is_outside']}">
{/if}
{if !empty($page->getKeyword['rank'])}
    <input type="hidden" name="rank" value="{$page->getKeyword['rank']}">
{/if}
{if !empty($page->getKeyword['industry_type'])}
    <input type="hidden" name="industry_type" value="{$page->getKeyword['industry_type']}">
{/if}
{if !empty($page->getKeyword['lat'])}
    <input type="hidden" name="lat" value="{$page->getKeyword['lat']}">
{/if}
{if !empty($page->getKeyword['lng'])}
    <input type="hidden" name="lng" value="{$page->getKeyword['lng']}">
{/if}
{if !empty($page->getKeyword['keyword2'])}
    <input type="hidden" name="keyword2" value="{$page->getKeyword['keyword2']}">
{/if}
