bsound

чтобы запустить добжны стоять на компе node.js и mongodb
к тому же должны быть установлниы глобыльно следующие модули
- npm install grunt-cli -g
- npm install bower -g
а ну и надо запустить серверы базы
для этого надо найти на компе файл mongod(.exe) и запустить его

<pre>
git clone https://github.com/piraman/bsound
...
cd bsound
npm install
...
cd public/admin
bower install
...
cd ../shop
bower install
...
cd ../../
grunt (чтобы редактировать)
node server.js
</pre>>
все