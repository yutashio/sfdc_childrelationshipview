# **子リレーション検索画面**
Workbenchを使用すれば、親オブジェクトに関連する子リレーションを確認することができますが、少し使いづらい点があったので作成してみました。  
良ければ、お使いください💁‍♂️  
(Lightning推奨)
  
***

## 検索条件
![検索画面](/READMEimages/image01.png)
- 親オブジェクト名
- 親オブジェクトAPI参照名
- 作成者ID & 最終更新者IDを省く  

## 検索結果
![検索結果](/READMEimages/image02.png)
- オブジェクト名
- オブジェクトAPI参照名
- Standard/Custom (オブジェクト)
- 項目名
- 項目API参照名
- Standard/Custom (項目)
- 子リレーション名
- カスケード削除
  
## 「オブジェクトマネージャ」へ遷移
オブジェクト名をリンク化しております。  
クリックすることで、新規タブで該当のオブジェクトマネージャーを開くことが可能です！！  

例）「取引先」を選択
![リンク押下](/READMEimages/image05.png)
「取引先」設定画面へ遷移完了
![オブジェクトマネージャ](/READMEimages/image06.png)

## 検索時の作成者ID & 最終更新者IDを省く設定
ユーザオブジェクトなどは、子リレーションの件数が多くなってしまうため検索条件として、「作成者ID & 最終更新者IDを省く」チェックボックス✅を用意しております。  

チェックなし(1714件)
![ユーザオブジェクト検索条件なし](/READMEimages/image03.png)
チェックあり(507件)
![ユーザオブジェクト検索条件あり](/READMEimages/image04.png)
  