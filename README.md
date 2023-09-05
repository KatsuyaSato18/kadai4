# 使用説明書

NaganoCakeの課題の作成です。必須項目のみとなります。


＃会員側(public)のコントローラーとview内容

* customer/顧客の会員情報（マイページ、退会、注文履歴）を収納しております。
-show(顧客マイページ)
-edit(顧客の登録情報編集画面)
-withdrawal(退会画面)

* home/トップ、アバウトページ
-top(トップページ)
-about(ページ)

* item/商品の一覧、詳細の画面になります。
-index(商品一覧)
-show(商品詳細)

* registrations/新規会員登録機能（devise)

* sessions/ログイン機能（devise)

* cart_items/カート機能
-index(カート内商品一覧画面(数量変更・カート削除の要素を含む))

* orders/注文履歴、注文確定情報
-new(注文情報入力画面(支払方法:クレジットor現金振込))
-check(注文情報確認画面)
-thanks(注文完了画面)
-index(注文履歴画面)
-show(注文履歴詳細画面)


＃管理者側(admin)のコントローラーと内容

* sessions/deviseのログイン機能(/admin/sign_in)
-新規登録機能がないので、あらかじめ「rails c」にて新規メールアドレスと、パスワードを入力してください。
-メールアドレス「b＠b」パスワード「bbbbbb」で起動します。

* homes/注文履歴一覧
-top(管理者トップページ(注文履歴一覧))

* items/商品情報（新規登録、詳細画面、更新）
-new(商品新規登録画面)
-index(商品一覧)
-show(商品詳細画面)
-edit(商品編集画面)

* customers/顧客情報（一覧、詳細画面）
-index(顧客一覧画面)
-show(顧客詳細画面)
-edit(顧客編集画面)

* orders/注文詳細画面
-show(注文詳細画面)