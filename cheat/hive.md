    select time, date_format(time, 'yyyy-MM-dd HH:00') time, IF(get_json_object(extras, '$.ads') is null, 'empty', 'not empty') empty
    from mtburn.s3_ad
    where dt between '2017091504' and '2017091504' and publisher_id=869


select dt, concat(substr(dt, 1,4), '-', substr(dt,5,2), '-', substr(dt,7,2),' ',substr(dt,9,2),':00') time
from mtburn.s3_ad
where dt between '2017110104' and '2017110104'
limit 1


    dt between date_format(date_sub(current_timestamp(),1), 'yyyyMMddHH') and date_format(current_timestamp(), 'yyyyMMddHH')

