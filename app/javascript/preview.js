document.addEventListener('DOMContentLoaded', function() {
  const postForm = document.getElementById('item-name')

  if(!postForm) return null; // document読み込み時のエラーを回避

  // プレビューを表示するスペースを取得「
  const previewList = document.getElementById('previews');

  // 画像のファイル選択をしたときイベントが駆動する
  const fileField = document.querySelector('input[type="file"][name="item[image]"]')
  fileField.addEventListener('change', function(e){
    // 古いプレビューがあった場合は消す
    const alreadyPreview = document.querySelector('.preview');
    if(alreadyPreview) {
      alreadyPreview.remove();
    }
    
    // 画像ファイルのURLを取得
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    // 画像要素を作る
    const previewWrapper = document.createElement('div');
    previewWrapper.setAttribute('class', 'preview');
    const previewImage = document.createElement('img');
    previewImage.setAttribute('class', 'preview-image');
    previewImage.setAttribute('src', blob);
    // 取得した画像を表示させる
    previewWrapper.appendChild(previewImage);
    previewList.appendChild(previewWrapper);
  })
})