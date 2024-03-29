# r-sarscov2-mutation-analysis
## 概要
SARS CoV-2 変異情報の解析  
地域/期間を限定して流行している変異株を抽出  
変異株のN抗原のメジャー変異をヒートマップ形式で出力  

## 利用上の注意
コードの使用、及び、改変は下記サービスの利用規約に準ずる  
[GISAID](https://gisaid.org/)  
[R package for outbreak.info](https://outbreak-info.github.io/R-outbreak-info/)  

## 動作環境
ホストOS：Windows11
WSL2 Ubuntu 22.04.3 LTS
Docker Desktop for Windows

## 使用方法
[GISAID](https://gisaid.org/)のアカウントを取得  
git clone  

    git clone git@github.com:ryuryu333/r-sarscov2-mutation-analysis.git
    docker compose up -d  

任意のWebブラウザで[RStudio Server](http://localhost:8787/)にアクセス  

    http://localhost:8787/  
    ID rstudio  
    PW admin  

RStudioのconsoleタブで以下を実行

    install.packages("devtools")  
    devtools::install_github("outbreak-info/R-outbreak-info")  

RStudioのFileタブで以下のプロジェクトファイルを開く  
    
    Home/Outbreakinfo/Outbreakinfo.Rproj

下記スクリプトを実行、Resultフォルダに結果が出力される  
MainScript冒頭の各変数にて解析に用いる地域/期間等を調整可能  
注意：GISAIDへのログインが必須  

    Home/Outbreakinfo/MainScript.R  
