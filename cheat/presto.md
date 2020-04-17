# date

    date_format(now() - interval'1'day, '%Y%m%d00') 
    date_format(now() - interval'1'day, '%Y%m%d') 
    date_format(date_parse(dt, '%Y%m%d'), '%Y-%m-%d')
    date_trunc('month', date_parse(ad_logs.date, '%Y-%m-%d'))

# ad

    sum(impnum) impnum,
    sum(clicknum) clicknum,
    sum(convnum) convnum,
    sum(pricesum) pricesum,
    TRY(sum(pricesum) * 1000 / SUM(impnum)) AS eCPM,
    TRY(cast(SUM(clicknum) AS double) * 100 / SUM(impnum)) AS CTR

    d_logs.media_idfrom mtburn.s3_ad
        cross join UNNEST(CAST(json_extract(s3_ad.extras, '$.ads') AS array<json>)) as x (s3_ad_ads)
        inner join mtburn.ads on (ads.dt='20170906' and cast(ads.id as varchar)=json_extract_scalar(s3_ad_ads, '$.ad_id'))

# map

    element_at(m, key) -> v

# GROUP_CONCAT

    array_join(array_agg(b), ',')
    array_join(array_agg(distinct b), ',')

