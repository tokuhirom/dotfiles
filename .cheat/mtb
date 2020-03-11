[17:34:40 mtburn@ip-10-0-1-103 mtburn /(T_T)\]$ plenv exec carton exec perl -Ilib -e 'use MTBurn::Container qw/container/; use Data::Dumper; print Dumper(container(qw/cache_ad/)->get(6238))' | egrep 'maximum_cpc|target_cpa' | grep -v undef


mysql> select * from campaigns_optimized_automator inner join campaigns on (campaigns.id=campaign_id) where campaigns_optimized_automator.is_enabled=1 and campaigns.is_enabled=1;
Empty set (0.00 sec)


select time_local, media.name media, sum(impnum) impnum, sum(clicknum) clicknum, sum(pricesum) pricesum
from ad_timed_logs
    inner join (
        select id, IF(name like 'AM%', 'AM', name) name
        from media
        where publisher_id=869
    ) media
group by time_local, media.name

