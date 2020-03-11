    to_date('2016-12-31', 'yyyy-MM-dd')
    date_format(current_date(), 'yyyyMMdd')
    date_format(date_sub(current_date(), 1), 'yyyyMMdd')
    date_trunc('DD', broadcast.dispatched_date)

    %sparksql cacheTable=basic

    sum(impnum) impnum, 
    sum(clicknum) clicknum,
    sum(pricesum) pricesum,
    (sum(pricesum) * 1000 / SUM(impnum)) AS eCPM,
    (SUM(clicknum)*100/sum(impnum)) ctr

    SELECT get_json_object('{"a":"b"}', '$.a');

    https://people.apache.org/~pwendell/spark-nightly/spark-master-docs/latest/api/sql/index.html#get_json_object

