    library(ggplot2)
    library(grid)
    library(gridExtra)
    library(purrr)

    default_options <- list(
        expand_limits(y = 0),
        theme(axis.text.x = element_text(angle=90, vjust=0.6)),
        scale_y_continuous(labels = scales::comma),
        scale_x_date(date_labels = "%Y-%m-%d")
    )

    r <- collect(sql(paste0("select to_date(dt, 'yyyy-MM-dd') from k")))

    facet_wrap(~advertiser, labeller=label_wrap_gen(width=15))

    grid.arrange(
        grobs=map(default_mappings, function (mapping) ggplot(r, mapping) +
                geom_line(aes(color=is_filler)) +
                facet_grid(cols = vars(inventory), labeller=label_wrap_gen(width=15)) +
                default_options
        ),
        ncol = 1,
        top = textGrob("${service_group} overview",gp=gpar(fontsize=20,font=3))
    )

    

    geom_bar(position="dodge", stat="identity")



    r <- collect(sql(paste0("select * from k")))

    ggplot(r, aes(date, botcnt, fill=volume)) +
        geom_bar(stat="identity") +
        facet_grid(rows=vars(region))


# Errors

## Error: stat_count() must not be used with a y aesthetic.

    geom_bar(stat="identity")

