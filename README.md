# withMyChild

## Requirement

[Docker for Mac](https://docs.docker.com/docker-for-mac/)

## Development

open a terminal app:

```
git clone <this repository uri> withMyChild
cd withMyChild
docker-compose build
docker-compose up
docker-compose run app bundle exec rake db:setup
docker-compose run app bundle exec rake ridgepole:apply
```

以下のコマンドでアプリケーションにアクセス

```
open "http://localhost:3000"
```

## Debug

open a terminal app:

```
docker attach withMyChild_app_1
```

コンソールがattachされるので、pryを仕込んで確認する

*pry自体は`quit`コマンドで終了できる。そのあと、 **`Ctrl + C`などでdockerの接続を終了すると、コンテナ自体が終了してしまう。** デタッチするときは`Ctrl-P Ctrl-Q`で抜ける。*

Enjoy!
