<#
- 自分用の録画サーバの自動圧縮スクリプトです。
- 適当なフォルダ(自分環境だとEドライブ) のTSファイルをmp4(H264)に圧縮しまう
- 事前にffmepgをpathに追加すること
- 使い方
    - .\ffmpeg_auto.ps1 <tsファイルが置いてあるファオルダ名:例:"e:\"
#>

# 環境情報
## カレントディレクトリの情報を取得する
$str_path = (Convert-Path .)
## ファイル名用に時間を取得する
$date = Get-Date -Format yyMMdd_HHmm
## logファイルの保存先
$log_file = "$($str_path)\logs\$($date)_result.log"
## 対象ディレクトリの選択
$target_dlr = $args[0]

# 作業開始
## message
$msg = "[info], $($date) 動画自動圧縮スクリプトを実行します" |Out-File -FilePath $log_file -Append -Encoding default


# 対象ディレクトリのファイルを取得する
$file = Get-ChildItem "$($target_dlr)\*.*" -include *.ts

foreach($file_check in $file){
    $st_msg = "[info], $($date) $($file_check.name)をmp4に変換します" |Out-File -FilePath $log_file -Append -Encoding default

    # ffmmpegの実行
    ffmpeg -i "$($target_dlr)\$($file_check.name)" -c:v libx265 "$($target_dlr)\$file_check.name).mp4"

    # 出力メッセ
    $end_msg = "[info, $($date) $($file_check.name)をmp4に変換しました" |Out-File -FilePath $log_file -Append -Encoding default
}