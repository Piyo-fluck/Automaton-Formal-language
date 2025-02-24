#import "@preview/diverential:0.2.0": *
#show math.equation: set text(11pt)
#set text(11pt)
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

= 第１章　オートマトンと形式言語ことはじめ
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
#block(
  fill: luma(20%),
  inset: 8pt,
  radius: 4pt,
)[
#text(white)[
例１　状態機械\
]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
)[
- 50円硬貨のみを受け付ける自動販売機
- 返却ボタン付きで、ボタンをオスと内部のお金を全部出力する
- 150円揃うと、カードを出力する
この状態機械の#text(red)[状態遷移図]を下に示す。
#set align(center)
#set figure(numbering: none)
#figure(
  image("auto1_1.png", width: 80%),
  caption: [
    図1.1: 50円硬貨3枚でカードが1枚出る,返却ボタン付き状態機械の状態遷移図
  ],
)]]
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
  image("auto1_2.png", width: 70%),
  caption: [
    図1.2: 図1.1を形式的に表した状態遷移図
  ],
)
#set align(left)
この状態機械は出力も行うので、出力付きオートマトンと呼ばれる。
　出力付きオートマトンに対して、出力なしのオートマトンを考えることができる。
それは、状態 $q$ から $q'$ への矢印に対して入力記号だけを付したものになる。形式言語を考える場合は出力を考えないことが多く、
ある特別の状態にたどり着くことのみを目的にする。その特別な状態のことを#text(red)[受理状態]（accepting state）という。
受理状態にたどり着くような記号列の全部の集まりを、
オートマトンが#text(red)[受理する言語]（accepting language）、あるいは、オートマトンの#text(red)[受理言語]という。\
　図1.3の状態遷移図をオートマトンは、出力なしオートマトンの一つの例である。入力記号は $a$ と $b$ の二つで、
$q_2$ は受理状態である。例えば、記号列 $a a b b a$ は、初期状態 $q_0$ から始めて左から順に１文字ずつ読んでは、
今の状態と今読んだ文字が記された矢印に従って状態を変え、全ての文字を読み終えたときに受理状態にたどり着くので、$a a b b a$ はこのオートマトンの受理言語に含まれる。
#set align(center)
#figure(
  image("auto1_3.png", width: 45%),
  caption: [
    図1.3: 受理状態が存在する状態遷移図の例
  ],
)
#set align(left)
　より詳しく述べれば、初めに状態 $q_0$ において記号列 $a a b b a$ の一番左端の $a$ を読むと、
$q_0$から出ている矢印のうち、 $a$ と書かれている矢印の先にある状態 $q_2$ に移る。
状態 $q_2$ で左から２番目の $a$ を読んで、$q_2$ から出ている矢印のうち、$a$ と書かれている矢印の先にある状態 $q_0$ に移る。
同様に、$q_0$ で次の $b$ を読んで $b$ が記された矢印に従って $q_1$ へ行き、さらに次の $b$ で $q_0$ へ、最後の $a$ で状態 $q_2$ に移る。\
　記号列を全て読み終えたときに受理状態にいるので、このオートマトンは $a a b b a$ を受理する。
しかし、例えば $b b a a$ は、$q_0$ から始めて最後にたどり着く状態が受理状態ではない状態 $q_0$ なので、受理言語には含まれない。
#block(
  fill: luma(20%),
  inset: 8pt,
  radius: 4pt,
)[
#text(white)[
例２　状態機械２\
]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
)[
　入力を０と１の２つの記号とする。\
次の受理言語をもつオートマトンの状態遷移図を描け。\
(1) 全ての記号列からなる言語\
(2) 文の最後が２つ以上の１で終わる記号列からなる言語
$circle$ 解答例\
(1) ０と１からなる全ての記号列の集まりは { 0, 1, 00, 01, 10, 11, 000, 001, 010, 100, ... } である。図1.4の状態遷移図を持つオートマトンを考えれば、上の集合のどの要素に対しても受理状態で終わる。
#set align(center)
#figure(
  image("auto1_4.png", width: 45%),
  caption: [
    図1.4: 解答例. 0, 1の２つの記号の入力から、\
    全ての記号列からなる言語を受理するオートマトンの状態遷移図
  ],
)
#set align(left)
(2) 問いの言語は { 11, 011, 111, 0011, 0111, 1011, 1111, 0011, ... } である。図1.5の状態遷移図を持つオートマトンは、それらの要素を過不足なく全て受理する。
#set align(center)
#figure(
  image("auto1_5.png", width: 50%),
  caption: [
    図1.5: 解答例. 0, 1の２つの記号の入力から、
    最後が２つ以上の１で終わる記号列からなる言語を受理するオートマトンの状態遷移図
  ],
)
]]
=== 1.3.2 形式言語
　オートマトンに続いて、#text(red)[形式言語]について説明しよう。そのために、まず#text(red)[形式文法]の概念について述べる。形式文法とは、特定の言語に属する文と属さない文とを区別する規則の集合のことである。ここで規則とは、例えば\
- 文は、主部と述部からなる。
- 主部は、名詞句と格助詞からなる。
- 述部は、副詞句と述語からなる。
といったものである。
　自然言語（英語、日本語、中国語など）の文法や計算機言語（Java, C++, Python, XMLなど）の文法はこのような規則の集合とみなせる。\
　形式言語の分野では、（形式）言語に先立ってまず形式文法が定められ、それに基づいて（形式）言語が定義される。すなわち定義された特定の文法を用いて定義される（形式）言語（Formal language）とは、 もととなる有限個の記号から、 文法の規則に従って作られる#text(red)[記号列]の全体の集合のことである。逆に、ある与えられた記号列がその言語に属するか否かの判断にも言語の文法は用いられる。\
　以下本書では、処理能力に差がある幾つかの代表的なオートマトンについてみていく。それらは、有限状態オートマトンとプッシュダウンオートマトン、線形拘束オートマトン、チューリングマシンである。\
　また、形式文法についてもいくつかの有名なものについて詳述する。それらは、正規文法と文脈自由文法、文脈依存文法、句構造文法である。\
　この４種類のオートマトンと４種類の文法との間には、受理する言語あるいは生成する言語を介在させると、見事な対応関係がある。
#set align(center)
#figure(
  image("auto1_6.png", width: 60%),
  caption: [
    図1.6: 記号列の集合と（形式）言語
  ],
)
#figure(
  image("auto1_7.png", width: 45%),
  caption: [
    図1.7: 各種オートマトンと各種文法の対応関係\
  $circle.filled.small a:$有限状態オートマトン、正規文法\
  $circle.filled.small b:$プッシュダウンオートマトン、文脈自由文法\
  $circle.filled.small c:$線形拘束オートマトン、文脈依存文法\
  $circle.filled.small d:$チューリングマシン、句構造文法\
  ]
)
#set align(left)
これらのオートマトンや形式文法、さらにはそれらの間の階層構造とそれらの対応関係を詳述するために必要な数学を以降で簡単にまとめよう。
#set par(linebreaks: "simple")
== 1.4 数学的準備
$circle.filled.small$ 集合\
　#text(red)[集合]は区別できるモノの集まりである。集合の中身である区別できるモノを、その集合の#text(red)[要素]という。$a$ が集合 $A$ の要素であることを、$a in A$ と書く。また、$b$ が $A$ の要素でないことを、$b in.not A$ と書く。空の集合、つまり要素が１つも無い集合も認め、それを空集合と言い、$emptyset$ で表す。\
　集合 $A$ と $B$ とが等しい、すなわち $A=B$ が成り立つのは、$A$ の要素と $B$ の要素が完全に一致しているときである。
集合 $A,B$ について、について、任意の $x in A$ が $x in B$ であるとき $A subset.eq B$ と書き、$A$ は $B$ の#text(red)[部分集合]という。\
集合 $A$ と $B$ との要素を全てあわせた集合を $A$ と $B$ の#text(red)[合併集合]あるいは#text(red)[結び]といい、\
$A union B = {x | x in A "または" x in B}$ である。\
集合 $A$ と $B$ との共通集合すべての集合を#text(red)[共通集合]あるいは#text(red)[交わり]といい、\
$A inter B = {x | x in A "または" x in B}$ である。\
#block(
  fill: luma(20%),
  inset: 8pt,
  radius: 4pt,
)[
#text(white)[例４　合併集合]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
)[
　次節で説明する写像を用いると、以下のような集合の結びを考えることができる。\
$Q$ を $Q = {q_0,q_1,q_2,q_3,q_4}$なる要素が５個の集合だとする。\
また、$Q'$を $Q' = {q_0,q_1,q_2}$なる $Q$ の部分集合だとする。加えて、$delta$ は $Q$ から $Q$
の部分集合の集合への集合で、$delta(q_0) = emptyset, delta(q_1) = {q_1,q_3}, delta(q_2) = {q_2}$\
とする。このとき、\
#set align(center)
$display(union.big_(q in Q')delta(q))=display(delta(q_0) union delta(q_1) union delta(q_2)=emptyset union {q_1,q_3} union {q_2}={q_0,q_1,q_2})$\
#set align(left)
となる。この例は、写像や部分集合の集合という概念が出てくるので少々分かりづらいかもしれない。しかし、後で必要となるので、再び同じ例を挙げて説明する。
]]

#block(
  fill: luma(20%),
  inset: 8pt,
  radius: 4pt,
)[
#text(white)[例5　直積集合、ベキ集合\
]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
)[
  (1) 集合 ${1,2}$ と集合 ${a,b}$ の直積集合を求めよ。\
  (2) 集合 ${a,b}$ に対して、そのベキ集合 $2^{a,b}$ を求めよ。\
$circle$ 解答例\
  (1) 集合 ${1,2}$ と ${a,b}$ の直積集合の要素は、${1,2}$ の要素である１あるいは２と、${a,b}$ の要素である $a$ あるいは $b$ の順序ついであるので、${(1,a),(1,b),(2,a),(2,b)}$\
  (2) 集合 ${a,b}$ のベキ集合は、{a,b} の部分集合全てからなる集合であるから、
${emptyset,{a},{b},{a,b}}$
]]

== 1.5 写像
#block(
  fill: luma(20%),
  breakable: true,
  inset: 8pt,
  radius: 4pt,
)[
#text(white)[例６　写像\
]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
)[
  (1) 任意の正の実数 $x$ にその平方根を対応させる関係は写像か。\
  (2) 集合 ${a,b}$ からベキ集合 $2^{a,b}$ への写像で全射は存在するか。\
  (3) 集合 ${a,b}$ からベキ集合 $2^{a,b}$ への写像で単射の例をつくれ。\
$circle$ 解答例\
  (1) $+sqrt(x) "と" -sqrt(x)$との二つが対応するので写像ではない。\
  (2) 集合 ${a,b}$ の要素数は $2$ で、$2^{a,b}$ の要素数は４だから、${a,b}$ から $2^{a,b}$ への全射はない。\
  (3) 例えば、$f:a arrow.r.long.bar {a},f:b arrow.r.long.bar {b}$
]]

== 1.6 数学的帰納法
（省略）

== 1.7 形式言語理論の用語
　本書の最後に、形式言語に関する用語を本節で確かめておこう。次章以降の記述の理解の為には、本章で述べる記法に慣れておく必要がある。\
　アルファベット（alphabet）とは、ある有限集合を指す。\
#block(
  fill: luma(20%),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
#text(white)[1.11 アルファベット\
]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
  $sum_1={0,1}, sum_2={a,b}, sum_3={あ,い}$\
  アルファベットの要素を#text(red)[記号]（symbol）という。
]]
#block(
  fill: luma(20%),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
#text(white)[1.12 記号\
]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
  $sum_1={0,1}$ では、 $0$ と $1$ が記号である。また、$sum_2={a,b}$ では $a$ と $b$ が記号で、
  $sum_3={あ,い,う}$ では、「あ」、「い」、「う」が記号である。
]]

　記号の有限列を#text(red)[語]（word）という。アルファベット $sum$ 中の要素を有限個並べたモノが $sum$ 上の語である。
すなわち、$sum$ 上の語は $sum$ の要素である記号を有限個並べた#text(red)[記号列]である。
#block(
  fill: luma(20%),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
#text(white)[1.13 語\
]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
  $sum_1={0,1}$ では、$0,1,00,10,111, ...$ のそれぞれが $sum_1$ 上の語である。$sum_2 = {a,b}$
では、$a,b, a a,a b,b b, a a a, ...$ が $sum_2$ 上の語である。$sum_3 = {あ、い、う}$ では、
「あ」,「い」,「う」,「ああ」,「あい」,...のそれぞれが $sum_3$ 上の語である。
]]
　記号を一つも含まない語を#text(red)[空語]（empty word, null word）という。空後は $epsilon$ と表す。\
また、アルファベット $sigma$ の#text(red)[語すべての集合]を $sum^*$ と書き、$sum^*$の#text(red)[閉包]という。さらに、
$sum^*$ から $epsilon$ を除いた語の集合を $sum^+$ と書き、$sum$ の#text(red)[正の閉包]という。
#block(
  fill: luma(20%),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
#text(white)[1.14 $sum$ の閉包\
]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
  $sum_1={0,1}$ とすると、$sum_1^* = {epsilon,0,1,00,01,10,11,000,001,010,011,...}$,\
  $sum_1^+ = {0,1,00,01,10,11,000,001,010,011,...}$ である。
]]
$sum^*$ の（任意の）部分集合 $L subset.eq sum^*_1$ を、$sum$ 上の言語（language over $sum$）という。
#set page(columns:1)
#block(
  fill: luma(20%),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
#text(white)[1.15 言語\
]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
  $sum_1={0,1}$ では、たとえば $L_0 = {0,00,000,...}$ や $L_1 = {01,0011,000111,...}$\
  などが $sum_1$ 上の言語である。
]]
語 $w in sum^*$ に現れる記号の延べ数を $abs(w)$ と書き、$w$ の長さ（length）という。
#block(
  fill: luma(20%),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
#text(white)[1.16 語の長さ\
]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
  $abs(000) = 3, abs(1010) = 4, epsilon$ の長さ、すなわち $abs(epsilon)$ は $0$ である。
]]
　さらに、語の連接と接頭辞、接尾語の定義を与えよう。語 $u$ と $v$ とをこの順でくっつけて $w$ ができるとき、
$w = u dot.c v$ または、$w = u v$ と書く。$w$ を、$u$ と $v$ の#text(red)[連接]また#text(red)[連結]（concatenation）という。
語 $w$ について、$w = u v$ となるとき、$v$ を $w$ の#text(red)[接尾語]（suffix word）、
$u$ を $w$ の#text(red)[接頭語]（prefix word）という。語 $w$ について、$w = u v x$ となる $v$ を $w$ の #text(red)[部分語]（subword）という。
#block(
  fill: rgb("#21902c"),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
#text(white)[Exercise 1.1　連結\
]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
  (1) $u = a a a, v = b b b$ のとき、$u$ と $v$ の連結を示せ。 $underline(a a a b b b)$\

  (2) $u = a b a b, v = epsilon$ のとき、$u$ と $v$ の連結を示せ。$underline(a b a b)$\

  (3) $u = a, v = a b a b$ のとき、$u dot.c v$ を示せ。$underline(a a b a b)$\

  (4) $u = 0, v = 11$ のとき、$u dot.c v dot.c v dot.c u$ を示せ。$underline(011110)$\
]]
#block(
  fill: rgb("#21902c"),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
#text(white)[Exercise 1.2　集合\
]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
  (1) 集合 ${q_0,q_1}$ と 集合 ${p_0,p_1}$ の直積集合を求めよ。\

  (2) 集合 ${q_0,q_1,q_2}$ と 集合 ${p_0,p_1,p_2}$ の直積集合を求めよ。\

  (3) 集合 ${0,1}$ に対して、$2^{0,1}$ を求めよ。\

  (4) 集合 ${q_0,q_1,q_2}$ に対して、そのベキ集合を求めよ。\

  $circle$ 解答例\
  　(1) ${(q_0,p_0),(q_0,p_1),(q_1,p_0),(q_1,p_1)}$\
  　(2) ${(q_0,p_0),(q_0,p_1),(q_0,p_2),(q_1,p_0),(q_1,p_1),(q_1,p_2),(q_2,p_0),(q_2,p_1),(q_2,p_2)}$\
  　(3) ${emptyset,{0},{1},{0,1}}$\
  　(4) ${emptyset,{q_0},{q_1},{q_2},{q_0,q_1},{q_0,q_2},{q_1,q_2},{q_0,q_1,q_2}}$

]]

#set page(columns:1,)
#block(
  fill: rgb("#21902c"),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
#text(white)[Exercise 1.2　集合\
]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
  (1) アルファベット $sum = {a,b,c}$ とする。\
　(i) $sum^*$ 上の記号を列挙せよ。\
　(ii) $sum^*$ 上の語を５個挙げよ。\
　(iii) $|a a b b c c|$ を求めよ。\

  (2) アルファベット $sum = {0}$ とする。$sum^*$ を求めよ。\

  (3) アルファベット $sum = {0,1}$ とする。\
　(i) $sum^*$ を求めよ。\
　(ii) 長さ３の語だけを含み、かつ長さ３の語を全て含む $sum$ 上の言語を書け。\

  $circle$ 解答例\
  　(1)　(i) $a,b,c$\
  　　　 (ii) $a,b,c,a a,a b$\
  　　　 (iii) $6$\
  　(2) ${epsilon,0,00,000,0000,00000}$\
  　(3)　(i) ${emptyset,0,1,00,01,10,11,000,001,010,011,100,101,110,111,0000,...}$\
  　　　 (ii) ${000,001,010,011,100,101,110,111}$
]]

#set page(columns:1)
#set align(center)
= 第２章　有限状態オートマトン
#set align(left)
　新たな概念を上記の集合関連の概念を用いて作り上げているため、抽象度が高く、定理の証明を読むのに慣れがいる。
例えば、有限状態オートマトンは「５つ組」：状態・入力アルファベット・状態遷移関数・初期状態・受理状態と定義され、
また、非決定性有限状態オートマトンというオートマトンでは、新たな状態を状態のベキ集合の要素として定義していく。
以下では、前章で説明した自動販売機の状態機械としての側面に着目して、まず、決定性有限状態オートマトンの形式的定義づけを行う。
それに引き続き、有限状態オートマトンが受理する言語や、決定性以外の有限状態オートマトン、さらには状態数が最小の最簡オートマトンなどを紹介する。

== 2.1 決定性有限状態オートマトンと受理言語
=== 2.1.1 決定性有限状態オートマトン
　状態機械のうち、次を満たす状態機械が決定性有限状態オートマトン（deterministic finite state automata : DFA）と呼ばれるものである。\
+ 状態の個数が有限である。
+ 各状態に対し、アルファベットのどの記号が入力として与えられても、遷移先の状態が一意に決まる。
+ 状態のうち、初期状態と受理状態と呼ばれる状態がある。初期状態は必ず一つだけあり、受理状態はいくつあってもよい。（なくてもよい）\
\
　この記述に基づいた形式敵定義を与える前に、決定性有限状態オートマトンの状態遷移図を導入する。決定性有限状態オートマトン $M$ の #text(red)[状態遷移図]は以下のような図である。
1. $M$ がとる状態のラベルが着いた円が、$M$ の状態数（有限個）だけある。
#figure(
  image("auto2_1.png", width: 70%),
  caption: [
    図2.1: DFAの状態遷移図の例\
  ]
)
2. 各円から他の円へ、あるいは自分自身へ向かう矢印がある。その矢印には、アルファベットと呼ばれる有限集合の要素（記号と呼ばれる）が、一つあるいは複数ついている。
  どの円についても、アルファベットのどの記号もその円から出る記号のうち一本だけに必ず付いている。
+ 出どころがない矢印で指される一つだけ特別な円がある。また、円の中には２重円が合ってもよい。

=== 2.1.2 決定性有限状態オートマトンの定義
　決定性有限状態オートマトンは次の要素からなる。\
(1) #text(red)[状態] (state) の有限集合.ふつう $Q$ と書く.\
(2) #text(red)[入力記号] (input symbols) の有限集合.ふつう $sum$ と書く.\
(3) 状態と入力記号を与えると状態を返す#text(red)[遷移関数] (transition function) ふつう $delta$ と書く.
先にオートマトンを直感的に図で示したとき我々は状態遷移関数 $delta$ を, 状態間のラベル付き辺によって表した.
つまり, $q$ から $p$ へラベル $a$ のついた矢印があるとき $delta(q,a)$ の値は $p$ である.\
(4) #text(red)[開始状態] (start state). これは $Q$ の一つの要素である.\
(5) #text(red)[最終状態] (final state) または#text(red)[受理状態] (accepting state) の集合. これは $Q$ の部分集合で, ふつう $F$ と書く.\

#rect(
    inset: 9pt,
    width: 100%,
    stroke:(
    left: 2pt + rgb("#390dc9"),
  ),
    fill: rgb("#efeafd")
)[
  #text(rgb("#390dc9"))[決定性オートマトンの数学的な定義（５つ組）]\
  
  $A = (Q,Sigma,delta,q_0,F)$\
  #h(10pt) $A$ は $D F A$ の名前である.\
  #h(10pt) $Q$ はある有限集合である. $Q$ の要素を#text(red)[状態]という.\
  #h(10pt) $Sigma$ もある有限集合である. $Sigma$ の要素を#text(red)[入力アルファベット（入力記号）]という.\
  #h(10pt) $delta:Q times Sigma -> Q$ は関数（写像）であり, #text(red)[状態遷移関数]と呼ばれる.\
  #h(10pt) $q_0$ は $Q$ のある要素, すなわち $q_0 in Q$ で, #text(red)[開始状態（初期状態）]と呼ばれる.\
  #h(10pt) $F$ は $Q$ のある部分集合, すなわち $F subset.eq Q$ で,#text(red)[受理状態]と呼ばれる.
]

念押しとして, 状態遷移関数 $delta:Q times Sigma -> Q$ について注意を述べる.
#set align(center)
#figure(
  numbering: none,
table(
  columns: 4,
  [状態 $backslash$ 入力記号], [$a_0$], [$dots.c$], [$a_m$],
  [$q_0$],[$q_00$],[],[$q_(0m)$],
  [$dots.v$],[],[],[$dots.v$],
  [$q_n$],[$q_(n 0)$],[$dots.c$],[$q_(n m)$],
),
caption: [
  ただし, $q_(i j) in {q_0,...q_n}.$
 ]
)
#set align(left)
- 定義域は $Q times Sigma$, すなわち ${(q,a) | q in Q$ かつ $a in Sigma}$ である.\
- 値域は $Q$ である.\
- すなわち, 状態遷移関数は, 各状態と各入力記号の順序対に対して一つの状態を対応付ける.\
  現在の状態 $q$ と入力記号 $a$ とに対して $delta$ の出力, すなわち $delta(q,a)$ は,状態機械がとる次の状態を示している.\

=== 2.1.3 $D F A$ はどのように列を処理するか
　$D F A$ について最初に理解すべきことは, $D F A$ が与えられた入力記号列を「受理」するか否かをどのようにして決めるか、
その方法を知ることである. $D F A : A = (Q,Sigma,delta,q_0,F)$ に対して,
$a_1 a_2 ... a_n$ を入力記号として与えるとする. $D F A$ が仕事を始めるときは必ずまずその状態を開始状態 $q_0$ にセットする.
そして, 最初の入力記号 $a_1$ によって $A$ がどの状態に進むのかを知るには, 状態遷移関数 $delta$ を使って $delta(q_0,q_1)$ を調べればよい.
今 $delta(q_0,q_1) = q_1$ だとしよう. 入力列の次の記号 $a_2$ を読み込んだときの状態は $delta(q_1,q_2)$ となる.
この状態を $q_2$ とする. 以後同様にして, $delta(q_(i-1),a_i) = q_i$ の関係にある状態 $q_3,q_4,...,q_n$ を見つける.
もし $q_n$ が $F$ の要素（すなわち, 受理状態）であれば, 入力列 $a_1a_2...a_n$ は受理され, そうでなければ「拒否」される.
このようにして $D F A : A$ が受理する記号列の全体を $A$ の「言語」と呼ぶ. 
#set page(columns:1,height:auto)
#block(
  fill: rgb("#21902c"),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
#text(white)[Exercise 2.1 入力列から $D F A$ を作成する\
]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
  0と1からなる列で, その中に01がどこかに現れるものの全てを, そしてそれのみを受理する $D F A$ を上の定義に従って構成してみよう。この言語 $L$ は次のように表される.\
  ${ x 0 1 y | x,y in Sigma^*}  (because Sigma = {0,1})$\
  (1) 既に01に出会ったか？もしそうなら, 以後どんな入力記号をよんでも受理する.\ 
  #h(10pt)すなわち, 以後は受理状態に留まる.\
  (2) まだ0に出会ってないが直前に読んだ記号が0のとき, もし次に1を読んだら,\
  #h(10pt)01を続けて読むことになるからその後何を読んでも受理してよい.\
  (3) まだ01に出会わず, 直前に読んだ記号は0でない（つまり, まだ１つも記号を読\
  #h(10pt)んでいないか、または直前に1を読むまで入力を受理しない.\
  状態遷移関数を列挙する.\
  $delta(q_0,1)=q_0, delta(q_0,0)=q_2, delta(q_2,0)=q_2, delta(q_2,1)=q_1, delta(q_1,0)=delta(q_1,1)=q_1$\
  $Q={q_0,q_1,q_2}$ で, $q_0$ が開始状態であり, $q_1$ が唯一の受理状態すなわち, $F = {q_1}$ である.
  こうして, 01を部分列として持つ列全体からなる $L$ を受理するオートマトン $A$ の完全な記述は
  $A = ({q_0,q_1,q_2},{0,1},delta,q_0,{q_1})$

  例2.1の $delta$ に対応する遷移表を図2.5に示す. 図の遷移表には開始状態を示す「開始」の矢印 $->$ と受理状態を示す星印 $*$ も併せて記載してある.この図で, $D F A$ の状態の集合と入力記号の集合に関する情報もそれぞれ表の行と列の見出しで示されているから,
  遷移表によって有限オートマトンは完全に曖昧さ無く表される.

#set table(
  stroke: none,
  fill: (x, y) =>
    if y == 0 {
      gray.lighten(10%)
    }
    else if y == 1 or y == 3 {
      gray.lighten(60%)
    }
    else {
      none
    },
)
#set table.vline(stroke: 0.3pt)
#set table.hline(stroke: 0.3pt)
  #figure(
  numbering: none,
table(
  columns: 3,
  table.hline(stroke:0.5pt),
  [状態 $backslash$ 入力記号],table.vline(), [$0$], table.vline(),[$1$],
  table.hline(),
  [$-> q_0$],[$q_2$],[$q_0$],
  [$*q_1$],[$q_1$],[$q_1$],
  [$q_2$],[$q_2$],[$q_2$],
  table.hline()
),
caption: [
  図2.5 例2.1の $D F A$ に対する遷移表
 ]
)
 ]]

=== 2.2.4 遷移関数の拡張
　$D F A$ が一つ与えられるとそれによって一つの言語（つまり、$D F A$ を開始状態から受理状態に導くような入寮記号列の全体）が定義できることを, 章のはじめに簡単に述べた. 遷移図に即していうと, $D F A$ の言語とは, 開始状態から出発して受理状態に至る経路（パス）のラベルを繋いでできる記号列の全体に他ならない.\
　ところで, $D F A$ の言語という概念を性格に述べるにはどうすればよいだろうか. そのためには, 任意の状態から出発して入力列を読みながら進むとどの状態に到達するかを表す関数（それを拡張された遷移関数と呼ぶ）を定義すればよい. 今, $delta$ が DFA $A$ の遷移関数のとき,
その拡張を $hat(delta)$ とすると, $hat(delta)$ は各状態 $q$ と各入力記号列 $w$ に対してオートマトン $A$ が $q$ から出発して入力列 $w$ 読み進んで行ったとき到達する状態を返す関数である. この $hat(delta)$ は次のように入力列 $w$ の長さに関して再帰的に定義することができる.\

$bold("基礎 : ")hat(delta)(q,epsilon)=q$, 状態 $q$ で何も入力を読まないとき, 状態は $q$ のままである.\
$bold("再帰 : ")$ 列 $w$ が $x a$ の形だとする. すなわち, $w$ の最後の記号が $a$ でその前の部分が $x$ だとする.
例えば, $w=1101$ を $x=110$ と $a=1$ に分解する.このとき\
#set align(center)
$hat(delta)(q,w)=delta(hat(delta)(q,x),a)$\
#set align(left)
とおく. $hat(delta)(q,w)$ を計算するには, まず状態 $q$ から初めて記号列 $w$ の最後の記号を除いた部分 $x$ によって到達する状態 $hat(delta)(q,x)$ を計算する. この状態を $p$ とする. すなわち, $hat(delta)=p$ とする. そのとき, 求める $hat(delta)(q,w)$ は, $w$ 
の最後の入力記号 $a$ によって $p$ から遷移する先の状態に等しい. すなわち, $hat(delta)(q,w) = delta(p,a)$ である.\ 

#set page(columns:1, height: auto)
#block(
  fill: rgb("#21902c"),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
  #v(4pt)
  #text(white)[Exercise 2.4 次の言語を受理する $D F A$ を求めよう\
  #h(10pt) $L = {w | w$ は偶数個の $0$ と偶数個の $1$ を含む $}$\
  ]
#block(
  fill: luma(290),
  inset: 8pt,
  radius: 4pt,
  width: 100%
)[
  容易に想像されるように, そのDFAの状態では, それまでに読み込んだ $0$ の個数と $1$ の個数が偶数か奇数かをともに記憶する. 
  すなわちそれらの状態は, それまでに読んだ $0$ の個数が偶数か奇数かを共に記憶する. 従って, 全部で次の四つの状態が必要である.\
  #h(5pt) $q_0:$ それまでに読んだ $0$ の個数と $1$ の個数は共に偶数である.\
  #h(5pt) $q_1:$ それまでに読んだ $0$ の個数は偶数で $1$ の個数は奇数である.\
  #h(5pt) $q_2:$ それまでに読んだ $0$ の個数は奇数で $1$ の個数は偶数である.\
  #h(5pt) $q_3:$ それまでに読んだ $0$ の個数と $1$ の個数は共に奇数である.\
  ここで, 状態 $q_0$ は唯一の開始状態である. それが開始状態である理由は, 入力がそれまでに読んだ $0$ の個数と $1$ の個数が共に $0$ であるからである. それが唯一の受理状態である理由は, $q_0$ の条件そのものが, 入力列が言語 $L$ に属するための条件だからである.\
  #h(5pt) 言語 $L$ に対する DFA は, 次によって与えられる.\
  #h(10pt) $A=({q_0,q_1,q_2,q_3},{0,1},delta,q_0,{q_0})$\
#set table(
  stroke: none,
  fill: (x, y) =>
    if y == 0 {
      gray.lighten(10%)
    }
    else if y == 1 or y == 3 {
      gray.lighten(60%)
    }
    else {
      none
    },
)
#set table.vline(stroke: 0.3pt)
#set table.hline(stroke: 0.3pt)
   #figure(
  numbering: none,
table(
  columns: 3,
  table.hline(stroke:0.8pt),
  [状態 $backslash$ 入力記号],table.vline(), [$0$], table.vline(),[$1$],
  table.hline(),
  [$*-> q_0$],[$q_2$],[$q_1$],
  [$q_1$],[$q_3$],[$q_0$],
  [$q_2$],[$q_0$],[$q_3$],
  [$q_3$],[$q_1$],[$q_2$],
    table.hline(stroke: 0.8pt)
),
caption: [
  図2.7 例2.4の DFA のための遷移表
 ])
]]

=== 2.2.5 DFAの言語
  ここでDFA $A = (Q,Sigma,delta,q_0,F)$ の言語（language）を定義しよう.
  この言語は $L(A)$ で表され, その定義は\
  #h(10pt) $L(A)={w | hat(delta)(q_0,w)$は $F$ に属する $}$\
  である. すなわち, $A$ の言語は, 開始状態 $q_0$ を受理状態の一つに導くような入力列 $w$ の全体である. $L$ があるDFA $A$ 
  の言語 $L(A)$ と一致するとき, $L$ を#emph(text()[正則言語]) (regular language) と呼ぶ.