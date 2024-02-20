# 特定地域で報告された変異株の報告数を取得し、一定期間で高頻度に出現している変異株を絞り込み
# 変異株ごとの変異情報を取得し、Nタンパクでのメジャー変異をヒートマップで図示
# /Resultに保存、細かい条件はメンバ変数で調整

# Invalid token. Please reauthenticate by calling the authenticateUser() function.
# が表示されたら以下を実行
# library(outbreakinfo)
# authenticateUser()

# メンバ変数
# 90 -> 解析日から90日間のデータを使用する、90日以前の変異株はother表記となる
windowDays = 60 
location = "Japan"
# 0.05 -> 一定期間で5%以上の頻度で報告されている変異株のみを選択、それ以外はother
prevalenceThresholdToCount = 0.05
# 0.10 -> その変異株で10%以上の頻度で出現する変異
mutationFrequencyThreshold = 0.10
# N -> nucleocapsid proteinにおける変異頻度を解析する
genesToCheck = "N"
# c("BA.1", "BA.2")、変異解析にて流行の有無に関わらず解析したい変異株
mustCompareVariant = c("")
fileNameOfResult = "Result.pdf"

# 実行日をファイル名に反映
analysisDate = format(Sys.time(), "%Y%m%d%H%M")
fileNameOfResult = paste(analysisDate, fileNameOfResult, sep = "")

# 一定期間で報告された変異株の個数を取得
lineagesPrevalentInJapan = getAllLineagesByLocation(location = location, ndays = windowDays, other_threshold = prevalenceThresholdToCount)
# データフレームに含まれる変異株の名前を抽出
lineagesPrevalentInJapan = unique(lineagesPrevalentInJapan$lineage)
# 報告数が一定以下の変異株はother表記、不要なので配列から削除
lineagesPrevalentInJapan = lineagesPrevalentInJapan[-which(lineagesPrevalentInJapan %in% "other")]
lineagesPrevalentInJapan = toupper(lineagesPrevalentInJapan)
# 比較対象として指定した変異株をリストに追加
lineagesPrevalentInJapan = c(lineagesPrevalentInJapan, mustCompareVariant)
# 高頻度で報告された変異株のN proteinへの変異情報を取得
mutations = getMutationsByLineage(pangolin_lineage = lineagesPrevalentInJapan, frequency = mutationFrequencyThreshold, logInfo = FALSE)

# 解析結果の保存先の指定
if(!dir.exists("Result")){
  dir.create("Result")
}
normalDireftory = getwd()
storageDirectory = paste(normalDireftory, "/Result", sep = "")
setwd(storageDirectory)

# 解析結果をpdfで出力
pdf(fileNameOfResult)
# ヒートマップ作成
plotMutationHeatmap(mutations, gene2Plot = genesToCheck, title = "N-gene mutations in lineages")
dev.off()

# working directoryをもとに戻しておく
setwd(normalDireftory)