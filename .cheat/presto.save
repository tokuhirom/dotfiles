    date_format(now() - interval'1'day, '%Y%m%d00') 
    date_format(now() - interval'1'day, '%Y%m%d') 

    date_trunc('month', date_parse(ad_logs.date, '%Y-%m-%d'))

    sum(impnum) impnum,
    sum(clicknum) clicknum,
    sum(convnum) convnum,
    sum(pricesum) pricesum,
    TRY(sum(pricesum) * 1000 / SUM(impnum)) AS eCPM,
    TRY(cast(SUM(clicknum) AS double) * 100 / SUM(impnum)) AS CTR

    ad_logs.media_id NOT IN (3767, 3768, 3245,3247,3782,3783,3245,3247,3784,3785,3237,3238) /* exclude moretab, naver まとめ,livedoor blog,Naverまとめ,news rc */


    from mtburn.s3_ad
        cross join UNNEST(CAST(json_extract(s3_ad.extras, '$.ads') AS array<json>)) as x (s3_ad_ads)
        inner join mtburn.ads on (ads.dt='20170906' and cast(ads.id as varchar)=json_extract_scalar(s3_ad_ads, '$.ad_id'))

    SELECT count(*) FROM hive.linets.user_stats_snapshot where log_date='20170904'

    array_join(array_agg(b), ',')


    (case campaigns.product_type
    when 0 then 'Basic'
    when 1 then 'Push'
    when 2 then 'DPA'
    when 3 then 'DPAP'
    when 4 then 'R&F'
    when 5 then 'CPF'
    when 6 then 'Re-engagement'
    when 7 then 'FV'
    else 'other'
    end) product_type

    (
    case adspots.ad_type
    when 5 then 'infeed(114x114)'
    when 6 then 'infeed(640x200)'
    when 7 then 'infeed(640x320)'
    when 9 then 'infeed(1200x628)'
    when 10 then 'video(16:9)'
    when 15 then 'infeed(1080x1080)'
    when 16 then 'video(1:1)'
    when 17 then 'video(9:16)'
    else 'other'
    end) ad_type

    (
    case campaigns.charge_type
    when 0 then 'CPM'
    when 1 then 'CPC'
    when 2 then 'CPA'
    when 3 then 'CPM_FIXED'
    when 4 then 'CPC_FIXED'
    when 5 then 'CPA_FIXED'
    else 'other'
    end) charge_type

    select id, IF(name LIKE 'AM%', 'AM', name) name from mtburn.media where publisher_id=869 and dt=date_format(now() - interval'1'day, '%Y%m%d')

    -- useable ad type
    ad_type in (5,6,7,9,10,13,15,16,17)


    admuter as (
        select distinct mid from mtburn.s3_ad where publisher_id=869 and dt between '2017100900' and '2017101523' and cast(json_extract_scalar(s3_ad.extras, '$.filtered_count.admute_reject_ads_count') as bigint) > 50
    )

https://wiki.linecorp.com/pages/viewpage.action?pageId=756483015

with media as (
    select id, IF(name LIKE 'AM%', 'AM', name) name from mtburn.media where dt='20180605' and publisher_id=869
)

        (
        case platform
        when '0' then 'iOS'
        when '1' then 'android'
        when '2' then 'mobile-web'
        when '3' then 'pc web'
        when '4' then 'inappweb'
        else 'other'
        end
        ) platform,


    with publishers as (
        select id, corp
        from mtburn.publishers
        where dt='20180630' and network_type=1 and is_enabled=1
    ), media as (
        select media.id, publishers.corp publisher, IF(media.name like 'AM%', 'AM', media.name) name
        from mtburn.media
            inner join publishers on (publishers.id=media.publisher_id)
        where dt='20180630'
    ), agencies as (
        select id, is_filler from mtburn.agencies where dt='20180630' and is_qa=0
    ), advertisers as (
        select advertisers.id, IF(is_filler=1, 'Filler', 'Non-Filler') is_filler
        from mtburn.advertisers
            inner join agencies on (agencies.id=advertisers.agency_id)
        where dt='20180630'
    )


    adspots as (
        select id, regexp_replace(name, '\[(Image|Video)\] ') name
        from mtburn.adspots
        where dt='20180630'
    )

    creatives as (
        select id, ad_type, (
            case ad_type
            when 5 then 'infeed(114x114)'
            when 6 then 'infeed(640x200)'
            when 7 then 'infeed(640x320)'
            when 9 then 'infeed(1200x628)'
            when 10 then 'video(16:9)'
            when 15 then 'infeed(1080x1080)'
            when 16 then 'video(1:1)'
            when 17 then 'video(9:16)'
            else 'other'
            end) ad_type_name
        from mtburn.creatives
        where dt='20180630'
    )

