# 使用説明書

NaganoCakeの課題の作成です。必須項目のみとなります。


＃会員側(public)のコントローラーとview内容

* customer/顧客の会員情報（マイページ、退会、注文履歴）を収納しております。<br>
-show(顧客マイページ)<br>
-edit(顧客の登録情報編集画面)<br>
-withdrawal(退会画面)<br>

* home/トップ、アバウトページ<br>
-top(トップページ)<br>
-about(ページ)<br>

* item/商品の一覧、詳細の画面になります。<br>
-index(商品一覧)<br>
-show(商品詳細)<br>

* registrations/新規会員登録機能（devise)<br>

* sessions/ログイン機能（devise)<br>

* cart_items/カート機能<br>
-index(カート内商品一覧画面(数量変更・カート削除の要素を含む))<br>

* orders/注文履歴、注文確定情報<br>
-new(注文情報入力画面(支払方法:クレジットor現金振込))<br>
-check(注文情報確認画面)<br>
-thanks(注文完了画面)<br>
-index(注文履歴画面)<br>
-show(注文履歴詳細画面)<br>


＃管理者側(admin)のコントローラーと内容

* sessions/deviseのログイン機能(/admin/sign_in)<br>
-新規登録機能がないので、あらかじめ「rails c」にて新規メールアドレスと、パスワードを入力してください。<br>
-メールアドレス「b＠b」パスワード「bbbbbb」で起動します。<br>

* homes/注文履歴一覧<br>
-top(管理者トップページ(注文履歴一覧))<br>

* items/商品情報（新規登録、詳細画面、更新）<br>
-new(商品新規登録画面)<br>
-index(商品一覧)<br>
-show(商品詳細画面)<br>
-edit(商品編集画面)<br>

* customers/顧客情報（一覧、詳細画面）<br>
-index(顧客一覧画面)<br>
-show(顧客詳細画面)<br>
-edit(顧客編集画面)<br>

* orders/注文詳細画面<br>
-show(注文詳細画面)<br>