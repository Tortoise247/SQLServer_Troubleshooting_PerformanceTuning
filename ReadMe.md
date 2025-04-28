## WSL上のSQLServerへの接続メモ
- Docker Desktopを利用しない場合
- WSL上のSQLServerに接続するための設定
    - WSLのIPアドレスを確認
        - `ip a | grep eth0`
    - Windows Powershellでポートフォワーディングを設定
        - `netsh interface portproxy add v4tov4 listenport=1433 connectaddress=xxx.xx.xxx.xx connectport=1433`


## CPU負荷をかけてみる
### Docker環境のCPUコア数を確認する
```bash
docker info | grep CPUs
```

```bash
lscpu
```
