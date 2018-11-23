export default class Photo {

  //コンストラクタ
  constructor() {
    console.log('コンストラクタ');
    this.title = '写真一覧'
  }

  sayHello() {
    const hello = 'HELLO';
    console.log(hello);
    console.log(this.title);

    return hello;
  }
}
