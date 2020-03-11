# last 1 week

    SELECT count(DISTINCT audience_id) FROM [turnkey-conduit-708:mtburnlog.ad@-604800000-] 

    SELECT count(DISTINCT audience_id) FROM [turnkey-conduit-708:mtburnlog.ad@-86400000-] 

# standard query

    FORMAT_TIMESTAMP('%H', rtb.time, 'Asia/Tokyo')

# 自動単価調整入っている案件の入札価格

    select FORMAT_TIMESTAMP('%Y-%m-%d %H:00:00', ad.time, 'Asia/Tokyo') time_local, ads.ad_id, AVG(ads.price) avg_price, MIN(ads.price) min_price, MAX(ads.price) max_price
    from mtburnlog.ad_20170605 ad
    cross join UNNEST(ads) ads
    where  ads.maximum_cpc is not null or ads.target_cpa is not null
    group by time_local, ads.ad_id

# percentile

    APPROX_QUANTILES(bids[OFFSET(0)].ads[OFFSET(0)].price, 1000)[OFFSET(500)] p50,
    APPROX_QUANTILES(bids[OFFSET(0)].ads[OFFSET(0)].price, 1000)[OFFSET(900)] p90,
    APPROX_QUANTILES(bids[OFFSET(0)].ads[OFFSET(0)].price, 1000)[OFFSET(980)] p98,
    APPROX_QUANTILES(bids[OFFSET(0)].ads[OFFSET(0)].price, 1000)[OFFSET(990)] p99

# DSP 入札価格

    WITH source as (
    select time,bids from mtburnlog.rtb_20170605 union all
    select time,bids from mtburnlog.rtb_20170604 union all
    select time,bids from mtburnlog.rtb_20170603 union all
    select time,bids from mtburnlog.rtb_20170602 union all
    select time,bids from mtburnlog.rtb_20170601 union all
    select time,bids from mtburnlog.rtb_20170531 union all
    select time,bids from mtburnlog.rtb_20170530
    )

    select
    FORMAT_TIMESTAMP('%Y-%m-%d %H:00:00', time, 'Asia/Tokyo') time,
    AVG(bids[OFFSET(0)].ads[OFFSET(0)].price) avg_price
    from source
    where array_length(bids)>0 and array_length(bids[OFFSET(0)].ads)>0
    group by time
    order by time

# range

    SELECT * FROM `mtburnlog.ad_*` WHERE _TABLE_SUFFIX BETWEEN '20170601' AND '20170605'

    TO_JSON_STRING(ads) ads



