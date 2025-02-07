#import "@preview/diverential:0.2.0": *
#show math.equation: set text(14pt)
#show math.equation: set text(font: "New Computer Modern Math")
#set text(font: "Times New Roman") // 本文のフォント指定
#let mixed(body) = {
  set text(weight: "medium")
  show regex("[\p{scx:Han}\p{scx:Hira}\p{scx:Kana}\d]"): set text(font: "Times New Roman")
  body
} // 和欧混植のフォント別々指定

//#set page(header: mixed[M7-S5]) // 柱へ応用

#let title(body) = {
  set align(center)
  set text(size: 2em)
  set text(style:"italic")

  v(0em)
  mixed(body) // タイトルへ応用
} // タイトルのスタイル設定
#title[Automaton-Formal-language] // タイトルの呼び出し

#show heading: mixed// 見出しへ応用
#set align(center)

= Introduction
#set align(left)
== 1.1 オートマトンと形式言語を学ぶ意義
  　Webマイニングやコンパイラ・文書解析、生物学では物質の構造推定に用いられる。このレポジトリには二冊の参考書のまとめに加え、大学院試験の対策や演習問題とその解答を挙げていこうと思う。
== 1.2 オートマトンと形式言語とは
　#text(red)[オートマトン]（s:automaton, p:automata）は、計算をしたり、ある文がある言語に属するか否かを判断したり、文を生成したりする抽象的機械である。計算とは何かを定義づける為の議論において登場する。一方、#text(red)[文法]（grammar）は、特定の言語に属する文（記号列）と、属さない文とを判別する#text(red)[規則]の集まりである。
== 1.3 オートマトン
=== 1.3.1 状態機械
　「計算」を行うとみなせる機械は全てオートマトンである。与えられた記号列がある言語に属するか否かを判定する機械も、「その判別を行う「計算」を実行する」とみなせるので、そのような機械もオートマトンである。また、その言語に属する記号列（文）を生成する機会も「その生成をするための「計算」を行う」とみなせるのでオートマトンである。\
　また、オートマトンは状態機械（state machine）ととらえることができる。#text(red)[状態機械]とは、以下の性質を持つものである。\
- 内部に状態を持っており、入力に応じて状態を変える。
- 入力と状態に応じて出力をするかもしれない。\
例１　状態機械\
- 50円硬貨のみを受け付ける自動販売機
- 返却ボタン付きで、ボタンをオスと内部のお金を全部出力する
- 150円揃うと、カードを出力する\
この状態機械の#text(red)[状態遷移図]を下に示す。
#set align(center)
#set figure(numbering: none)
#figure(
  image("auto1_1.png", width: 80%),
  caption: [
    図1.1: 50円硬貨3枚でカードが1枚出る,返却ボタン付き状態機械の状態遷移図
  ],
)
\
#set align(left)
以下では、例１の状態機械を例に、形式的に記述していく。\
- 50円硬貨の入力を $a$, 返却ボタンの入力を $b$ で表す。
- 出力も,カードを $x$, 50円を $y$, 100円を $z$ とする。
- 状態に通し番号付きで $q_0$, $q_1$, $q_2$ と記号を付ける。$phi.alt$ は「なし」を表す。
- 状態 $q$ から状態 $q'$ に向かう矢印をつける。ただし、ここでは $q$ と $q'$ は、$q_0$, $q_1$, $q_2$ のいずれかである。さらに, $q$ から $q'$ へ向かう矢印のそばに入力/出力を記す
- 初期状態に矢印「$->$」をつける。
#set align(center)
#figure(
  image("auto1_2.png", width: 80%),
  caption: [
    図1.2: 図1.1を形式的に表した状態遷移図
  ],
)
#set align(left)
この状態機械は出力も行うので、出力付きオートマトンと呼ばれる。