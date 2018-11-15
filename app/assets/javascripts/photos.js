'use strict';

class PhotoUpload {
  constructor(title) {
    this._title = title;
    if ($('#preview').length) {
      console.log('initw!!');
    } else {
      console.log('not exists');
    }
  }

  preview() {
    if ($('#preview').length) {
      console.log('preview!!');
    }
  }
}
