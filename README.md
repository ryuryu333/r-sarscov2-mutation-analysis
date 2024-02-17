# r-sarscov2-mutation-analysis
Docker+RStudioでSARS CoV-2 変異情報の解析

ホストOS：Windows11
WSL2 Ubuntu 22.04.3 LTS
Docker Desktop for Windows

git clone thisURL
docker compose up -d
ブラウザでRStudio Serverにアクセス
http://localhost:8787/
ID rstudio
PW admin

RStudioのconsoleで以下を実行
install.packages("devtools")
devtools::install_github("outbreak-info/R-outbreak-info")

