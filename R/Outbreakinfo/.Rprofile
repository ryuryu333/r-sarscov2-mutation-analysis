# 初回使用時は下記2行を実行
# install.packages("devtools")
# devtools::install_github("outbreak-info/R-outbreak-info")
library(utils)
library(magrittr)
library(stringr)
library(dplyr)
library(ggplot2)
library(outbreakinfo)

plotLineagesPrevalence = 
  function (location, other_threshold = 0.05, nday_threshold = 10, 
            ndays = 180, other_exclude = NULL, cumulative = FALSE, include_title = TRUE) 
  {
    #outbreakinfoライブラリのplotAllLineagesByLocationを改変
    #コメント箇所が追加/編集した部分
    #必須ライブラリ
    library(magrittr)
    library(stringr)
    library(dplyr)
    library(ggplot2)
    library(outbreakinfo)
    #色分けパターンを定義
    #memo 現状だと10個以上の変異株は表示できないが10個も表示されない予定なので無視
    COLORPALETTE <- brewer.pal(10, "Set3")
    #期間が短いと図のx軸の表記がおかしくなる
    minimumWindowDays = 150
    ndays = ifelse(ndays < minimumWindowDays, minimumWindowDays, ndays)
    #ここから元の関数のろぎっく部分（編集箇所はあるので注意）
    df <- getGenomicData(query_url = "prevalence-by-location-all-lineages", 
                         location = location, other_threshold = other_threshold, 
                         nday_threshold = nday_threshold, ndays = ndays, other_exclude = other_exclude, 
                         cumulative = cumulative)
    if (is.null(df)) 
      return(df)
    df$lineage = factor(df$lineage, levels = unique(c("other", 
                                                      df %>% arrange(desc(prevalence_rolling)) %>% pull(lineage))))
    numLineages = levels(df$lineage) %>% length()
    if (numLineages > length(COLORPALETTE)) {
      COLORPALETTE = c(COLORPALETTE, rep("#bab0ab", numLineages - 
                                           length(COLORPALETTE)))
    }
    cat("Plotting data...", "\n")
    #図示する期間を指定する為、limits引数を追加
    p <- ggplot(df, aes(x = date, y = prevalence_rolling, group = lineage, 
                        fill = lineage)) + geom_area(colour = "#555555", 
                                                     size = 0.2) + scale_x_date(date_labels = "%b %Y", limits = as.Date(c(Sys.Date() - ndays, Sys.Date())),
                                                                                expand = c(0, 0)) + scale_y_continuous(labels = scales::percent, 
                                                                                                                       expand = c(0, 0)) + scale_fill_manual(values = COLORPALETTE) + 
      theme_minimal() + labs(caption = "Enabled by data from GISAID (https://gisaid.org/)") + 
      theme(legend.position = "bottom", legend.background = element_rect(fill = "#eeeeec", 
                                                                         colour = NA), panel.grid = element_blank(), axis.ticks = element_line(size = 0.5, 
                                                                                                                                               colour = "#555555"), axis.ticks.length = unit(5, 
                                                                                                                                                                                             "points"), axis.title = element_blank()) + 
      theme(legend.position = "bottom", axis.title = element_blank(), 
            plot.caption = element_text(size = 18))
    if (include_title == T) {
      p <- p + ggtitle(paste0("Lineage prevalence in ", 
                              str_to_title(location)))
    }
    return(p)
  }

authenticateUser()
