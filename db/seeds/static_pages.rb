StaticPage.create(name: :about, title: '当サイトについて', published: true,
                  content: %q{<p>
EC-TRIPとは、Ruby on Rails / Amazon Web Services をベースにして動作する、デモ専用のECサイトです。
</p>})

StaticPage.create(name: :commercial, title: '特定商取引法に基づく表記', published: true,
                  content: %q{<table class='table mt-5'>
<tr>
<td style='width: 180px'>販売業者</td>
<td></td>
</tr>
<tr>
<td>運営責任者</td>
<td></td>
</tr>
<tr>
<td>住所</td>
<td></td>
</tr>
<tr>
<td>電話番号</td>
<td></td>
</tr>
<tr>
<td>メールアドレス</td>
<td></td>
</tr>
<tr>
<td>URL</td>
<td></td>
</tr>
<tr>
<td>商品以外の必要代金</td>
<td></td>
</tr>
<tr>
<td>注文方法</td>
<td></td>
</tr>
<tr>
<td>支払方法</td>
<td></td>
</tr>
<tr>
<td>支払期限</td>
<td></td>
</tr>
<tr>
<td>引渡し時期</td>
<td></td>
</tr>
<tr>
<td>返品・交換について</td>
<td></td>
</tr>
</table>})

StaticPage.create(name: :privacy, title: 'プライバシーポリシー', published: true,
                  content: %q{<p>
本ウェブサイト上で提供するサービス（以下,「本サービス」といいます。）におけるプライバシー情報の取扱いについて，以下のとおりプライバシーポリシー（以下，「本ポリシー」といいます。）を定めます。
</p>
<h2 class='h5 mt-4'>第一条（プライバシー情報）</h2>
<ol>
<li class='my-3'>プライバシー情報のうち「個人情報」とは，個人情報保護法にいう「個人情報」を指すものとし，生存する個人に関する情報であって，当該情報に含まれる氏名，生年月日，住所，電話番号，連絡先その他の記述等により特定の個人を識別できる情報を指します。</li>
<li class='my-3'>プライバシー情報のうち「履歴情報および特性情報」とは，上記に定める「個人情報」以外のものをいい，ご利用いただいたサービスやご購入いただいた商品，ご覧になったページや広告の履歴，ユーザーが検索された検索キーワード，ご利用日時，ご利用の方法，ご利用環境，郵便番号や性別，職業，年齢，ユーザーのIPアドレス，クッキー情報，位置情報，端末の個体識別情報などを指します。</li>
</ol>})

StaticPage.create(name: :terms, title: '利用規約', published: true,
                  content: %q{<p>
この利用規約（以下，「本規約」といいます。）は，EC-TRIP（以下，「運営者」といいます。）がこのウェブサイト上で提供するサービス（以下，「本サービス」といいます。）の利用条件を定めるものです。登録ユーザーの皆さま（以下，「ユーザー」といいます。）には，本規約に従って，本サービスをご利用いただきます。
</p>
<h2 class='h5 mt-4'>第1条（適用）</h2>
<p>本規約は，ユーザーと当社との間の本サービスの利用に関わる一切の関係に適用されるものとします。</p>
<h2 class='h5 mt-4'>第2条（利用登録）</h2>
<ol>
<li class='my-3'>登録希望者が当社の定める方法によって利用登録を申請し，当社がこれを承認することによって，利用登録が完了するものとします。</li>
<li class='my-3'>
運営者は，利用登録の申請者に以下の事由があると判断した場合，利用登録の申請を承認しないことがあり，その理由については一切の開示義務を負わないものとします。
<div class='my-3'>
(1) 利用登録の申請に際して虚偽の事項を届け出た場合
</div>
</li>
</ol>})