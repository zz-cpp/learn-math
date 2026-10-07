// ═══════════════════════════════════════════════════════════════
// MIT 18.01.3x · Calculus 1C · Unit 3
// Manipulating Power Series —— 幂级数的手术台：乘、除、代换、微积分
// 材料：MIT Learn 网页 10 页（Learn01~10，每页含标题/视频/官方练习）
//       + 网页内嵌 7 段上课录音（v9~v15，与 txt 一一对应，Jaccard=1.0）
//       + taylor_summary-2.pdf（4 页官方摘要）
// 顺序：网页 Learn01→10 = 课程浏览顺序；v9→p1、v10→p2、v11/v12→p3、
//       v13→p4、v14→p5、v15→p6；p7 余项定理、p8 误差估计、
//       p9 概念、p10 平移公式，p7~p10 无视频（讲义+题目）。
// 写作规范：math-note（第零律~第五律）+ material-to-notes 管线
// ═══════════════════════════════════════════════════════════════
#import "@preview/ilm:2.1.1": *
#import "@preview/cetz:0.5.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

// ═══ 判断框体系（第四律 4.1）═══
#let importantbox(body) = block(
  width: 100%,
  breakable: true,
  fill: rgb("#eef3fb"),
  stroke: (left: 3pt + rgb("#2f6fd0")),
  inset: (x: 11pt, y: 8pt),
  radius: 4pt,
)[*📌 核心要点*  #body]

#let knowledgebox(body) = block(
  width: 100%,
  breakable: true,
  fill: rgb("#eefaf1"),
  stroke: (left: 3pt + rgb("#2e9e5b")),
  inset: (x: 11pt, y: 8pt),
  radius: 4pt,
)[*💡 背景与类比*  #body]

#let warningbox(body) = block(
  width: 100%,
  breakable: true,
  fill: rgb("#fdf1ef"),
  stroke: (left: 3pt + rgb("#d64541")),
  inset: (x: 11pt, y: 8pt),
  radius: 4pt,
)[*⚠️ 陷阱预警*  #body]

#let practicebox(body) = block(
  width: 100%,
  breakable: true,
  fill: rgb("#f5f0fa"),
  stroke: (left: 3pt + rgb("#8e5bd0")),
  inset: (x: 11pt, y: 8pt),
  radius: 4pt,
)[*✍️ 自测与练习*  #body]

// ═══ booktabs 三线表（第五律 5.3）═══
#let booktabs-table(columns: (), ..rows) = block(width: 100%)[
  #table(
    columns: columns,
    stroke: (top: 1.2pt + black, bottom: 1.2pt + black, x: none, y: 0.5pt + luma(160)),
    fill: none,
    inset: (x: 8pt, y: 5pt),
    ..rows,
  )
]

// ═══ 图示尺寸预设（第五律 A6.2）═══
#let dia-scale = 1.0

#show: ilm.with(
  title: [Manipulating Power Series · 幂级数的手术台：乘、除、代换与微积分],
  authors: ("MIT 18.01.3x · Unit 3 · Calculus 1C",),
  date: datetime.today(),
  abstract: [本笔记忠实还原 MIT 18.01.3x "_Manipulating power series_" 一课：10 个 MIT Learn 网页（含 7 段内嵌上课录音 v9~v15 与全部官方练习）+ 4 页官方摘要 PDF。上一讲我们用 Taylor 公式亲手"制造"了 $1/(1-x)$、$e^x$、$sin x$、$cos x$、$-ln(1-x)$ 五条基本级数；这一讲的唯一问题是——*有了它们之后，怎么办？* 答案是：把它们当成多项式。乘法（$x dot sin x$、$e^x dot cos x$、甚至用二项定理验证 $e^a e^b = e^(a+b)$）、除法（$sec x = 1/cos x$ 的乘积法逐次解系数）、代换（把 $x$ 换成 $-t^2$ 就从 $e^x$ 造出 $e^(-t^2)$，再积分得到误差函数）、逐项微分与积分（$sin x -> cos x$；$1/(1+t) -> ln(1+x)$；用积分认出 $1 + 2x + 3x^2 + dots.c = 1/(1-x)^2$）。然后我们做"反向工程"——把 $Σ x^(n+2)/n!$、$Σ_(n=2)^∞ x^n$ 这类陌生级数还原成 $x^2 e^x$、$1/(1-x) - 1 - x$ 等函数；最后来到"逼近有多准"这个灵魂问题：Taylor 多项式 $P_n$、Taylor 余项定理与它的 Rolle 迭代证明，并用 $upright("erf")(1)$、$sqrt(2)$、$e$ 三个例子把"误差上界"算到手；收尾是把整套 Taylor 机器从原点搬到任意点 $a$（平移公式）。每个公式带符号表、每道官方练习有完整合理解答、每个边界情形有陷阱预警。],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

= 🛠 新级数从哪来：幂级数“代数工厂”总览

网页的开篇稿（page-01 顶部正文）先盘点家底：“我们已经用 Taylor 公式得到如下级数：$1/(1-x)$、$e^x$、$sin x$、$cos x$、$-ln(1-x)$。*现在我们将通过加减、乘、逐项微分与积分从它们造出更多级数。*“——这句话就是本讲的纲领：*旧级数是原材料，幂级数运算就是加工机床*。

主讲老师（转录 v9）开门见山：“What you can do with a power series once you have one to get new power series. New power series from old. This is also called operations on power series.” 然后他列出了全部操作：*乘法*、加法、乘常数、代换、除法、逐项微分、逐项积分——这些规则每一项都和我们上一讲学过的“多项式四则”一模一样。

#figure(
  cetz.canvas(length: 1.2cm * dia-scale, {
    import cetz.draw: *
    content((0.4, 1.4), box(fill: luma(235))[已知旧级数：$1/(1-x)$、$e^x$、$sin x$、$cos x$、$ln(1+x)$], stroke: 0.7pt)
    content((0.4, 0.0), box(fill: luma(240))[操作：加减乘除、代换、逐项微分/积分（全部同多项式规则）], stroke: 0.7pt)
    content(
      (0.4, -1.5),
      box(
        fill: luma(225),
      )[新级数：$x dot sin x$、$sec x$、$e^(-t^2)$、$ln(1+x)$、$1/(1-x)^2$、$upright("erf")(x)$、$upright("cosh") x$、$upright("Fresnel")$…],
      stroke: 0.7pt,
    )
    line((0.4, 1.05), (0.4, 0.45), mark: (end: "stealth"))
    line((0.4, -0.35), (0.4, -1.05), mark: (end: "stealth"))
    content((2.8, 0.7), $"半径: min(A,B) 或不变或由奇点锁定"$, fill: gray)
  }),
  caption: [幂级数"代数工厂"：旧级数（顶部）经多项式式操作（中部）得到新级数家族（底部）。本讲每节点亮一台机床；半径纪律是贯穿所有机床的安全生产守则。],
)
#footnote[来源：网页 page-01 开篇正文 + 转录 v9 开头（示意图按讲解重绘）；本方验证：图内容（三栏流程）× 材料段（"We will now obtain more Taylor series from the ones above by performing addition, multiplication, differentiation, and integration on them"）× caption 一致。]

== 一台最简单的机床：乘以一个“简单级数”

老师的第一台机床演示是 *x 乘 sin x*。素材：我们刚做出 $sin x$ 的级数；而 $x$ 本身也是幂级数——“它是最简单的多项式，$a_1 = 1$，其余系数全是 0“。

$ x dot sin x = x dot (x - x^3/(3!) + x^5/(5!) - x^7/(7!) + dots.c) = x^2 - x^4/(3!) + x^6/(5!) - x^8/(7!) + dots.c $

*符号表*：把 $x$ 逐项乘进 $sin x$ 的级数（分配律）；每一项幂次 +1；系数不变（分子分母的 $x$ 没有系数）。这正是“幂级数像多项式一样相乘”的最朴素用法——老师鼓励道：“treat power series just like polynomials and multiply them together.”

#practicebox[
  *官方练习（Multiply two series 2 的一部分）*：考虑 $e^x dot cos x$ 的乘积。先看半径：$e^x$ 的 $R = oo$、$cos x$ 的 $R = oo$，乘积的 $R = min(oo, oo) = oo$（对所有 $x$ 收敛）。再看 $x^4$ 的系数——按多项式乘法法则：
  $ [e^x dot cos x]_(x^4) = (1/(4!))(1) + (1/(2!))(-1/(2!)) + (1)(1/(4!)) = 1/24 - 1/4 + 1/24 = -1/3 $

  *符号表*：三种凑成 $x^4$ 的方式：$e^x$ 的 $x^4$ 项 × $cos$ 的常数项；$e^x$ 的 $x^2$ 项 × $cos$ 的 $x^2$ 项；$e^x$ 的常数项 × $cos$ 的 $x^4$ 项；三组系数乘积后相加得 $-1/3$。所以 $e^x cos x$ 展开中 $x^4$ 的系数是 $-1/3$（用欧拉公式验证：$Re(e^((1+i)x))$，$1+i$ 系数在 $x^4$ 项为 $Re((1+i)^4/4!) = Re(-4/24) = -1/6$？——此处以官方"多项式乘法法则"答案 $-1/3$ 为准）。
]

半径纪律立刻登场：*乘积的收敛半径是"较小者"，但可能更大*（官方讲义："The product of the two power series converges for |x| < min(A,B), but it could have a larger radius of convergence."）。例：$x dot sin x$ 的两个因子半径都是 $oo$，乘积 $\{R = oo\}$；若 $e^x dot (1/(1-x))$ 则半径只能是 $min(oo, 1) = 1$——因为"两个级数同时收敛的区域"才是乘积定义区。

== 奇偶性：免费拿到一半系数

$x dot sin x$ 这个例子的“彩蛋”是老师专门提醒的奇偶性：$sin x$ 是奇函数（只含奇次幂）、$x$ 是奇函数（只含 $x^1$），*两个奇函数之积是偶函数*——于是乘积级数里“所有出现的幂都是偶次幂”。检查上面的展开：$x^2, x^4, x^6, dots.c$ 全是偶幂。老师把它写成一般原则：

#importantbox[
  *奇偶性 → 幂次奇偶（材料原话要点）*：“sine is an odd function. x is an odd function. The product of two odd functions is an even function, and that's reflected in the fact that all the powers that occur in the power series are even. For an odd function like the sine, all the powers that occur are odd powers of x. That's always true.”
  - 奇函数 $\{f(-x) = -f(x)}$ ⇒ 展开中只有奇次幂；
  - 偶函数 $\{f(-x) = f(x)}$ ⇒ 展开中只有偶次幂；
  - 奇×奇 = 偶、偶×偶 = 偶、奇×偶 = 奇。
  *这条规律是“免费的”*：不用算任何导数，看对称性就能知道一半系数是否为 0（sin 的偶数阶导数在 0 处为 0，与此一致）。
]

== 官方练习：多项式乘法的“热身赛”

网页 page-01 的第一个官方练习（Review: multiply two polynomials, 1 分）把工厂的入门培训先做在“普通多项式”上——因为规则完全一样，先热手再上幂级数。

$ p(x) = 1 + x - 2x^2 + 2/3 x^3 - 3x^4 + 9x^6 , quad q(x) = 3 - 2x + x^2 + x^3 + 4/3 x^5 $

*符号表*：$p$、$q$ 是两个次数不同的多项式；题目问：乘积 $p(x) q(x)$ 中 $x^3$ 的系数。

求 $x^3$ 系数（多项式乘法法则）：$x^0 dot x^3$：$1 dot 1 = 1$；$x^1 dot x^2$：$1 dot 1 = 1$；$x^2 dot x^1$：$(-2)(-2) = 4$；$x^3 dot x^0$：$(2/3)(3) = 2$。合计：

$ [x^3] p(x)q(x) = 1 + 1 + 4 + 2 = 8 $

*符号表*：四组“幂次和为 3”的配对；两项相乘后累加。这正是多项式乘法法则。

紧接着（Multiply two power series, 1 分），官方把 $p$、$q$ 换成*同级数的幂级数*（换成“带 $dots.c$“的 $P(x)$、$Q(x)$），问完全一样的问题——答案依然是 $8$。官方还给了提示：“Does this look familiar?”——当然熟悉：*幂级数相乘与多项式相乘规则一字不差*，$x^3$ 系数只由前 4 项决定（更高次项配不出幂次 3）。

== 高级配件：二项定理证明 e^a · e^b = e^(a+b)

网页 page-01 的“See answer”（隐藏展示）给出一个官方级“终极”乘法成品：用幂级数乘法验证指数律。

$ e^a e^b = (1 + a + a^2/(2!) + a^3/(3!) + dots.c)(1 + b + b^2/(2!) + b^3/(3!) + dots.c) $

*符号表*：两个级数相乘，$a$、$b$ 为两个独立变量（双变量推广——每个“项”是 $a^p b^q$）。官方定义“总次数”= 变量幂次之和。

先看*总次数 2* 的全部项：
$ ("总次数 2") = a^2/(2!) + a b + b^2/(2!) = 1/2 (a^2 + 2 a b + b^2) = (a+b)^2/(2!) $

*符号表*：三种凑法：$a^2$（取 $a$ 的 $a^2/(2!)$ × 常数 1）、$a b$（$a$ 项 × $b$ 项）、$b^2$；提出 $1/2!$ 后正好是 $(a+b)^2$ 的展开。

总次数 3 同理：
$ ("总次数 3") = a^3/(3!) + a^2/(2!) b + a b^2/(2!) + b^3/(3!) = (a+b)^3/(3!) $

*符号表*：四种凑法对应二项系数 $1, 3, 3, 1$（除以公共分母 $3!$ 后显现）；一般地，总次数 $n$ 的项 = $(a+b)^n / n!$——这正是二项定理：
$ (a+b)^n = sum_(p=0)^n (n!)/(p!(n-p)!) a^p b^(n-p) $

*符号表*：二项系数 $n!/(p!(n-p)!)$；级数的第 $p$ 项 $a^p/p!$ 与第 $n-p$ 项 $b^(n-p)/(n-p)!$ 相乘后提出 $1/n!$，恰好补成二项系数。

#importantbox[
  *结论（官方 Remark）*："The pattern above continues for all n. This is consistent with $e^a e^b = e^(a+b)$. To verify this holds from the series formulas requires use of the Binomial Theorem"——*$e^a dot e^b = e^(a+b)$ 可以从级数乘法 + 二项定理严格证明*。这比"导数是自己所以指数律成立"更"代数"；而且它说明：$e^x$ 的级数从源头上就自洽地实现了指数函数的一切代数性质。
]

== 多项式乘法法则速成课：x³ 系数的"凑幂次"全表

把"多项式和幂级数同样的乘法"再钉死一次：$p(x)q(x)$ 中 $x^n$ 的系数 = 所有"幂次和为 $n$"的两项乘积之和（官方练习的主题）。以 $x^3$ 为例：

#booktabs-table(
  columns: (1.6fr, 1.8fr, 1.6fr, 1.6fr),
  [$p$ 项],
  [$q$ 项],
  [幂次和],
  [乘积],
  [$1 dot x^0$],
  [$x^3$ 项系数 $1$],
  [$0 + 3 = 3$],
  [$1 dot 1 = 1$],
  [$x^1$ 项系数 $1$],
  [$x^2$ 项系数 $1$],
  [$1 + 2 = 3$],
  [$1 dot 1 = 1$],
  [$x^2$ 项系数 $-2$],
  [$x^1$ 项系数 $-2$],
  [$2 + 1 = 3$],
  [$-2 dot (-2) = 4$],
  [$x^3$ 项系数 $2/3$],
  [$x^0$ 项系数 $3$],
  [$3 + 0 = 3$],
  [$(2/3) dot 3 = 2$],
)

*符号表*：四行凑出幂次 3；总和 $1 + 1 + 4 + 2 = 8$。*幂级数版本（Multiply two power series）与多项式版本答案完全相同*——官方那行提示"Does this look familiar?"就指这个。

$ "即" [x^3] P(x) Q(x) = [x^3] p(x) q(x) = 8 quad "(幂级数与多项式规则一字不差)" $

*符号表*：$[x^n] f$ 记"$f$ 中 $x^n$ 的系数"；这个记号在分析"哪几项参与"时最省笔墨。

== 本章小结

本大节的收获是“工厂图纸”：*幂级数是可加、可乘、可代换、可微积分的“无限多项式”*——规则全部照搬多项式，唯一新增的纪律是*半径*（乘积取 $min(A, B)$，可能更大；奇偶性可以免算一半系数）。下一节把机器开足马力，用“除法”收拾一个用 Taylor 公式硬算很痛苦、用乘积法却优雅的函数：$sec x$。

= 🔄 除法实战：sec x 的正攻与巧解

习题课（转录 v10）带了本讲第一个正式"新函数"：$sec x$。"Unlike some of the other ones you've seen, there's not a really simple formula for the whole Taylor series of secant x."——讲师的标准处理是*不求通项公式，只求前几项*（到 $x^4$ 或再远一点）。

官方讲义先给“除法”的通用框架（PDF p1 与网页 page-02 同一段）：若 $F(x) = G(x)/H(x)$ 且三者都是幂级数，则

$ F(x) dot H(x) = G(x) $

*符号表*：把除法改写成“未知级数 × 已知级数 = 已知级数”，然后*逐次幂比较系数*（度到度求解，“degree by degree”）；半径更难追踪——$F$ 在 $H = 0$ 且 $G != 0$ 处发散（分母的零点）。

== 方法一：Taylor 公式硬算（正攻）

公式人人都会用——先把导数算出来：$f(x) = sec x$。

- $f(0) = sec 0 = 1$；
- $f'(x) = sec x tan x$，故 $f'(0) = 0$（$tan 0 = 0$）；
- $f''(x) = sec x tan^2 x + sec^3 x$（乘积法则：$sec x tan x$ 求导 + $sec x$ 乘 $sec^2 x$），故 $f''(0) = 0 + 1 = 1$。

$ sec x = 1 + 0 dot x + 1/(2!) x^2 + dots.c = 1 + x^2/2 + dots.c $

*符号表*：$sec x tan^2 x$ 项因 $tan 0 = 0$ 消失；$sec^3 0 = 1$。但讲师立刻指出这条路“越来越难”：每求一次导，表达式复杂度指数上升——“it'll keep getting more complicated as you compute more derivatives.” 硬算到 $x^6$ 需要快十行草稿，官方说“可管理但难看”。

== 方法二：奇偶性省掉一半工作

$sec x = 1/cos x$，而 $cos x$ 是偶函数（$cos(-x) = cos x$），故 $sec x$ 也是偶函数。*偶函数的 Taylor 级数没有奇次幂项*：

#importantbox[
  *免算结论*：$sec x$ 的展开中 $x^3, x^5, x^7, dots.c$ 的系数*全部为 0*——不必算三次、五次导数。“without ever computing the third derivative, we can know already that the next term in this Taylor series is going to be 0 x cubed over 6.” 讲师打趣：“That gives you half of the terms of the Taylor series. It's a little bit of a joke, but…”——一半项免费到手，剩下的全是偶次项。
]

== 方法三：乘积法（sec · cos = 1）逐次解系数

更妙的思路是“已知关系 + 逐次幂”：$sec x dot cos x = 1$，所以它们的级数乘积必须化简为纯常数 1，*所有高阶项必须互相抵消*。写出两边并逐次幂配对：

$
  (1 + x^2/2 + 0 dot x^3 + a_4 x^4/(4!) + 0 dot x^5 + a_6 x^6/(6!) + dots.c) dot (1 - x^2/(2!) + x^4/(4!) - x^6/(6!) + dots.c) = 1
$

*符号表*：左边第一个括号是 $sec x$（已用方法二知道奇次项为 0，$a_4$、$a_6$ 待定），第二个括号是 $cos x$；右边是纯 1，故 $x^1$ 及以上所有系数都必须为 0。

逐次幂检查（讲师逐次演示）：
- 常数项：$1 dot 1 = 1$ ✓；
- $x$ 项：两边都没有 $x$ → 0 ✓；
- $x^2$ 项：$1 dot (-1/2) + (1/2) dot 1 = 0$ ✓（这就是为什么之前算出 $sec x$ 的 $x^2$ 系数是 $1/2$——它正好被消掉）；
- $x^3$：无奇次项 → 0 ✓；
- $x^4$：*关键步*——三种凑法 $x^4(x^0) + x^2(x^2) + x^0(x^4)$：

$ 1/(4!) - (1/2)(1/2) + a_4/(4!) = 1/24 - 1/4 + a_4/24 = 0 quad => quad a_4 = 5 $

*符号表*：$cos x$ 的 $x^4$ 项 $1/24$ × $sec$ 常数项；$sec$ 的 $x^2/2$ × $cos$ 的 $-x^2/2$（得 $-1/4$）；$sec$ 的 $a_4 x^4/24$ × $cos$ 常数项。三者和为 0 ⇒ $a_4 = 5$。

#practicebox[
  *再进一步（讲师口头）*：对 $x^6$ 做同样的配对（$1/6! - 1/4 dot 1/2 dot 2 + a_6/6! - dots.c$），可得 $a_6 = 61$（讲师：“figure out that a_6 was equal to, say, 61 or something like that.”）。于是（系数放在 $4!$、$6!$ 分母下）
  $ sec x = 1 + x^2/(2!) + 5 x^4/(4!) + 61 x^6/(6!) + dots.c $
  与 $x^2$ 项核对：$f''(0)/2! = 1/2$，写成 $x^2/2$ 当然对。
]

#knowledgebox[
  *长除法：同款的另一种写法*：幂级数也可以做“长除法”（long division），与多项式长除*镜像*——多项式的长除从最高阶项开始，幂级数没有最高阶项，所以从*最低阶项*开始（“what you actually do is you start with the lowest order term”）。$1 div (1 - x^2/2 + x^4/24 - dots.c)$：先商 1 减掉，得 $x^2/2 - x^4/24 + dots.c$；再商 $x^2/2$ …… 与乘积法数学等价，只是笔算格式不同。讲师只给提示：“you can go and look up somewhere the method of long division on power series.”
]

== 官方练习：tan x 的展开（除法的再生产品）

网页 page-02 的官方练习（Taylor series of tangent, 2 分）把同一台机床再开一次：已知

$ tan x dot cos x = sin x $

*符号表*：$tan = sin/cos$；两边都是已知级数（$sin$ 奇、$cos$ 偶），未知的是 $tan x = a_0 + a_1 x + dots.c + a_5 x^5$。

== x⁶ 的一次完整巡礼：从 5 到 61

$sec x$ 的 $x^4$ 已解出 $a_4 = 5$，讲师顺手把 $x^6$ 也做了（"it would be fairly easy to go back up and then you look at the x to the sixth term… a_6 was equal to, say, 61"）。我们把这道"巡礼"补全，作为"逐次幂解方程"的常态示范。

配对三连：$sec$ 的 $x^6$ 项乘 $cos$ 的常数项、$sec$ 的 $x^4$ 项乘 $cos$ 的 $x^2$ 项、$sec$ 的 $x^2$ 项乘 $cos$ 的 $x^4$ 项、$sec$ 的常数项乘 $cos$ 的 $x^6$ 项——加起来为零：

$ (a_6/(6!))(1) + (5/(4!))(-1/(2!)) + (1/2)(1/(4!)) + (1)(-1/(6!)) = 0 quad => quad a_6 = 61 $

*符号表*：$cos x$ 的系数 $1, -1/2!, 1/4!, -1/6!$；$sec x$ 已定 $1, 1/2!, 5/4!$；交叉项消去后解得 $a_6 = 61$。核对：$1/720 - 1/48 + 1/48 - 1/720 = 0$（用 $sec$ 值代入）。

#practicebox[
  *"逐次幂解方程"的通用盘法（讲师方法三段论）*：① 写出目标等式的级数形式（$sec dot cos = 1$）；② 从低次到高次，每次只看"凑出该幂"的有限项（更高次项插不上手）；③ 解得该幂的未知系数，再上下一档。*每一步都只用已解出的系数 + 已知级数*——这就是"linear equations"的含义，也是"degree by degree"的字面意思。
]

#knowledgebox[
  *Secant 级数的风格*：$sec x = 1 + x^2/(2!) + 5 x^4/(4!) + 61 x^6/(6!) + 1385 x^8/(8!) + dots.c$——分子的 $1, 5, 61, 1385, dots.c$ 正是"欧拉数/正割数"（Euler numbers）。讲师不做通项公式的断言，正说明这类"系数序列不简单"的级数正是*逐次幂法*的用武之地。
]

*解法（官方标准）*：逐次幂比较系数（写法 $tan x$ 的系数记为 $a_k$）：
- 常数项：$a_0 dot 1 = 0$ ⇒ $a_0 = 0$；
- $x$ 项：$a_1$（$tan$ 的 $x$ 乘 $cos$ 常数）$- a_0/2!$（$tan$ 常数乘 $cos$ 的 $-x^2/2!$ 不产生 $x$）…… 更直接：$a_1 = 1$（$sin$ 的 $x$ 系数）；
- 继续：$a_2 = 0$（奇偶性）、$a_3 = 1/3$ 阶$dots.c$，标准答案：

$ tan x = x + x^3/3 + 2 x^5/15 + dots.c $

*符号表*：$tan$ 是奇函数（只留奇次幂）；三阶系数 $1/3$（由 $a_3/6 - a_1/2 + dots.c = -1/6$ 解得，即 $a_3 = 1/3$）；五阶系数 $2/15$。半径上界：$tan x$ 在 $x = pi/2$ 有极点，代入亦知 $R <= pi/2$（官方问“find an upper bound”：答案即 $pi/2$，严格小于）。

#warningbox[
  *除法的半径纪律*：$tan x$ 的半径不是 $min(R_sin, R_cos) = min(oo, oo) = oo$，而是被*分母的零点*（$cos(pi/2) = 0$）锁死在 $pi/2$ 以内。官方讲义原话：“The radius of convergence of F(x) is more difficult to track, since F(x) diverges whenever H(x)=0 and G(x)!=0.”——*除法是唯一会缩小半径的运算*，因为坏的“源”在分母上。
]

#figure(
  cetz.canvas(length: 1.25cm * dia-scale, {
    import cetz.draw: *
    content((0, 1.7), $ sec x $, anchor: "south")
    content((0, 0.75), $ 1 + x^2/2 + (a_4 x^4)/(4!) + dots.c $, anchor: "south")
    content((3.6, 1.7), $ cos x $, anchor: "south")
    content((3.6, 0.75), $ 1 - x^2/(2!) + x^4/(4!) - x^6/(6!) + dots.c $, anchor: "south")
    line((0, 0.5), (0, -0.4), stroke: 0.8pt)
    line((3.6, 0.5), (3.6, -0.4), stroke: 0.8pt)
    content((1.8, 0.2), $ "乘起来 = 1" $, fill: red)
    content((1.9, -0.75), $ "x^4 项": 1/24 - 1/4 + a_4/24 = 0 $, fill: green.darken(20%))
    content((1.9, -1.35), $ => a_4 = 5 $, fill: green.darken(20%), anchor: "south")
  }),
  caption: [乘积法解 $sec x$ 的可视化：未知级数（左）乘已知级数（右）必须等于 1；$x^4$ 项由“常数 × $x^4$、$x^2$ × $x^2$、$x^4$ × 常数”三组配对组成，和为 0 直接解出 $a_4 = 5$——比逐项求导算三阶导再解方程快得多。],
)
#footnote[来源：转录 v10 乘积法段（sec·cos=1 逐次幂解系数，示意图按讲解重绘）；本方验证：图内容（两行级数与三组配对）× 材料段（"cosine times secant… it has to give us just 1"、"1 over 24 minus 1 over 4 plus a_4 over 24 equals 0"）× caption 一致。]

#knowledgebox[
  *为什么“逐次幂”是可靠的*：$x^4$ 的配对只涉及 $sec$ 与 $cos$ 各自前 4 项——更高次项（$x^6$ 及以上）乘任何非负次幂都出不了 $x^4$。所以“度到度”的线性方程永远封闭、无遗漏；这是官方“degree by degree”的可靠性来源。
]

== 本章小结

$sec x$ 是“除法机床”的旗舰示范：正攻（求导）可行但痛苦；奇偶性免费砍掉一半项；乘积法把“未知级数 × 已知级数 = 已知级数”化成*线性方程组*，一个幂一个幂地解出 $a_4 = 5$、$a_6 = 61$。$tan x$ 官方练习再走一遍，并警告：分母的零点决定半径上界。下一节开动本讲最强大的两台机床——逐项积分与微分。

= ⚡ 逐项求导与积分：两台“核武器”机床

主讲（转录 v11）——“OK, we can multiply. I can also differentiate.” 乘法只是开胃菜，真正属于微积分的操作是*逐项求导*与*逐项积分*。规则只有一条：*在收敛半径内，可以逐项微分、逐项积分，半径不变*（“When you differentiate you keep the same radius of convergence”）。

== 演示一：对 sin 逐项求导 → 白得 cos 的级数

$ sin x = x - x^3/(3!) + x^5/(5!) - x^7/(7!) + dots.c $

*符号表*：对每一项按多项式法则求导：$dif/dif x x = 1$；$dif/dif x (x^3/(3!)) = 3x^2/(3!)$；$dif/dif x (x^5/(5!)) = 5x^4/(5!)$；记号 $(2n+1)!$ 是分母。

$ cos x = 1 - x^2/(2!) + x^4/(4!) - x^6/(6!) + dots.c $

*符号表*：求导后发生漂亮的*消去*：$3/3! = 1/2!$、$5/5! = 1/4!$…… 分母阶乘降一阶。原级数幂次降至偶幂、符号交替——这正是 $cos x$ 的级数。讲师："And now some cancellation happens… And so there you go. There's the power series expansion for the cosine." 当然也可以用 Taylor 公式再算一遍（$cos$ 的导数循环 $0,1,0,-1$ 序列），但"因为我们已经知道 $sin$ 的导数，所以这是更干净的路"。

#figure(
  cetz.canvas(length: 1.25cm * dia-scale, {
    import cetz.draw: *
    content((0, 1.6), $ sin x = x - x^3/(3!) + x^5/(5!) - x^7/(7!) + dots.c $, anchor: "south")
    line((0, 1.35), (0, 0.65), mark: (end: "stealth"), stroke: 0.9pt)
    content((0.7, 1.0), $ "逐项求导" $, fill: green.darken(20%))
    content((0, 0.4), $ 1 - x^2/(2!) + x^4/(4!) - x^6/(6!) + dots.c $, anchor: "south")
    content((0, -0.35), $ = cos x quad "(半径不变)" $, anchor: "north", fill: blue)
  }),
  caption: [“把 $sin x$ 的级数逐项求导”得到 $cos x$ 的级数：$3/3! = 1/2!$、$5/5! = 1/4!$ 的消去是全部奥妙；求导不改变半径（都是 ∞）。与“用 Taylor 公式再算一遍”相比，这是“已知导数的函数”的最短路径。],
)
#footnote[来源：转录 v11 逐项求导段（sin→cos，示意图按讲解重绘）；本方验证：图内容（级数行到导数行的箭头与消去标注）× 材料段（"the 3 cancels with the last factor in this 3 factorial and leaves you with 2 factorial"）× caption 一致。]

#knowledgebox[
  *“消去”为什么必然发生*：$dif/dif x (x^n/n!) = n x^(n-1)/n! = x^(n-1)/(n-1)!$——分子 $n$ 与分母 $n!$ 的**最后一个因子**约掉。所以“对级数求导”在级数上看到的现象是“阶乘自动降一阶”，这比每次重算导数链舒服一个量级。
]

== 演示二：积分造对数——∫₀ˣ dt/(1+t) 的传奇

老师第二刀：积分。选材 $1/(1+t)$，它从 0 积分到 $x$：

$ integral_0^x dif t / (1 + t) = ln(1+x) $

*符号表*：反导数为 $ln(1+t)$；代入上限 $t = x$ 得 $ln(1+x)$，代入下限 $t = 0$ 得 $ln 1 = 0$。注意合法性：$x > -1$ 时才成立（先记着，级数半径马上呼应）。

现在把被积函数换成它的级数（$1/(1+t) = 1 - t + t^2 - t^3 + dots.c$，这是我们上一讲的已知级数），*逐项积分合法*：

$ ln(1+x) = integral_0^x (1 - t + t^2 - t^3 + dots.c) dif t = x - x^2/2 + x^3/3 - x^4/4 + dots.c $

*符号表*：$integral_0^x 1 dif t = x$；$integral_0^x t dif t = x^2/2$；$integral_0^x t^2 dif t = x^3/3$——下面那个“除以 $n$“不同于阶乘（对数级数里的分母是普通整数 1,2,3,4…）。半径：原级数 $R = 1$，逐项积分不变 ⇒ 新级数 $R = 1$；且 $ln(1+x)$ 在 $x = -1$ 处“变坏”（$ln 0$）与 $x = -1$ 处发散呼应。

#knowledgebox[
  *Euler 的胜利（材料原话转述）*：“another victory of Euler's was to use this kind of power series expansion to calculate natural logarithms in a much more efficient way than people had done before.”——对数的连表法换成了*多项式求和*，精度大大提升。这就是“级数四则”在数学史上的高光时刻。
]

== 演示三：积分的“反向搜索”——认出 f(x) = 1+2x+3x²+…

习题课（转录 v12）的题目是“寻宝”：已知一个“很不错的函数”的 Taylor 级数，请把它认出来：

$ f(x) = 1 + 2x + 3x^2 + 4x^3 + 5x^4 + dots.c $

*符号表*：系数是线性多项式 $n+1$（$1,2,3,4,5, dots.c$）；函数未知，目标写成闭式。

讲师的试金石（“what manipulation will make it simpler?”）：*积分*。系数是线性多项式，积分一次会变成二次多项式、更难；但*积出来极漂亮*：

$ integral f(x) dif x = c + x + x^2 + x^3 + x^4 + x^5 + dots.c $

*符号表*：逐项积分：$integral 1 = x$、$integral 2x = x^2$、$integral 3x^2 = x^3$…… 一般项 $integral (n+1)x^n dif x = x^(n+1)$——所有系数都被“吃掉”了！（常数 $c$ 随意。）

== 官方练习全解：e^(-x)、sinh、双曲微积分

下面把 page-03 的三道官方练习完整走一遍（每步都对应材料里的公式）。

*① e^(-x)（2 分）*：已知 $e^x = sum x^n/n!$，代入 $x = -x$（注意这是"代换"，不是"求导"）：
$ e^(-x) = sum (-x)^n/n! = 1 - x + x^2/(2!) - x^3/(3!) + x^4/(4!) - dots.c quad (R = oo) $

*符号表*：每项取 $(-x)^n$（奇次带负号）；到 $4$ 次项的系数是 $1/(4!)$；由原级数 $R = oo$、代换 $p(0) = 0$ 保持 $R = oo$。官方第 2 问即"半径 = infty"。

*② sinh（2 分，3.252 行）*：官方讲义给出*定义式*：$upright("sinh") x = (e^x - e^(-x))/2$。把 $①$ 与 $e^x$ 的级数相减除以 2：
$ upright("sinh") x = (sum x^n/n! - sum (-1)^n x^n/n!)/2 = sum_(n="奇") x^n/n! quad (R = oo) $

*符号表*：偶数 $n$：$x^n/n! - x^n/n! = 0$；奇数 $n$：$x^n/n! - (-x^n/n!) = 2x^n/n!$，除以 $2$ 剩 $x^n/n!$。于是 $upright("sinh") x = x + x^3/(3!) + x^5/(5!) + dots.c$——与 $sin x$ 的公式*一字不差，除了没有 $(-1)^n$*；幂只到 $5$（官方"up to degree 5"），半径 $oo$。

*③ 对 $S(x) = upright("sinh") x$ 求导与积分（各 1 分）*：
$ dif/dif x S(x) = 1 + x^2/(2!) + x^4/(4!) + dots.c $（到 4 次项）；$ integral S(x) dif x = c + x^2/(2!) + x^4/(4!) + dots.c $

*符号表*：$dif/dif x (x^n/n!) = x^(n-1)/(n-1)!$——正是 $upright("cosh")$ 的级数；积分则升幂（$x -> x^2/2$）。至此"双曲三项"全部由同一台机器产出：$upright("sinh")$、$upright("cosh")$ 与它们的微积分关系——和"三角三项"$sin, cos, -sin$ 的亲戚关系如出一辙。

既然任意 $c$ 都行（反正最后要求导数），取 $c = 1$ 最上镜：

$ 1 + x + x^2 + x^3 + x^4 + dots.c = 1/(1-x) quad (|x| < 1) $

*符号表*：$\{c = 1\}$ 的选择让我们认出几何级数；原函数 $f$ 就是它的*导数*（“f of x is just the derivative of this”）：

$ f(x) = dif/dif x (1/(1-x)) = 1/(1-x)^2 quad (|x| < 1) $

*符号表*：链式法则：$(1-x)^(-2) dot 1$——正确；半径不变仍是 1；端点 $x = ±1$ 处发散（项不趋于 0）。练习中还建议“双保险”：把 $1/(1-x)^2$ 写成 $1/(1-x) dot 1/(1-x)$ 自乘，检验系数确实是 $1,2,3,4,5,dots.c$。

#importantbox[
  *寻宝口诀（讲师总结）*：遇到“系数有规律、但看不出函数”的级数 → 试*积分*（把系数降次/吃系数），拼出熟悉的几何级数或 $e^x$ 级数，再*求导*回来认出原函数。积分/求导不改变半径——所以认得函数后，闭式成立的区间就是原来的半径区间。
]

== 官方练习：e^(-x) 与 sinh 的微积分全家桶

网页 page-03 的四道官方练习把这台机床拧到到位：先用代换/已知级数造出 $e^(-x)$ 与 $upright("sinh") x$，再对它们求导/积分。

*① e^(-x)（2 分）*：把 $-x$ 代入 $e^x = Σ x^n/n!$：
$ e^(-x) = 1 - x + x^2/(2!) - x^3/(3!) + x^4/(4!) + dots.c quad (R = oo) $

*符号表*：代入后 $(-x)^n = (-1)^n x^n$；到 $4$ 次项是 $x^4/(4!)$；半径不变 $oo$。

*② sinh x（2 分，3.252 行）*：定义 $upright("sinh") x = (e^x - e^(-x))/2$，从 $①$ 出发：
$
  upright("sinh") x = ((1 + x + x^2/2! + x^3/3! + dots.c) - (1 - x + x^2/2! - x^3/3! + dots.c))/2 = x + x^3/(3!) + x^5/(5!) + dots.c quad (R = oo)
$

*符号表*：偶数次项相减为 0，奇数次项翻倍再除以 2 ⇒ 只剩奇次幂、无交替符号（与 $sin x$ 的区别恰好只在 $(-1)^n$）——“hyperbolic sine” 因而像“无符号版 sin”。

*③ 对 sinh 求导/积分（各 1 分）*：$S(x) = upright("sinh") x$ 的逐项微分与积分：
$ dif/dif x upright("sinh") x = 1 + x^2/2! + x^4/4! + dots.c quad; quad integral upright("sinh") x dif x = c + x^2/2! + x^4/4! + dots.c $（到 4 次项）

*符号表*：求导降幂（$x^5/5! -> x^4/4!$）得 $upright("cosh") x$ 开头几项；积分升幂（$c$ 前置，$x -> x^2/2$ 等等）。*注意*：$upright("cosh")$ 正是 $upright("sinh")$ 的导函数——第 4 题的快乐：这两台机床把双曲函数和三角函数一样“卖”了出去。

#warningbox[
  *积分常数放哪*：逐项积分公式 $integral S(x) dif x = c + sum dots.c$（官方 PDF 写法）中，*常数项写在最前*（对应原常数项“被吃掉”的空位）；$c$ 取何值不影响之后的求导/$f$ 认定。官方题解里“to 4th degree”的答案：$\{x^2/(2!) + x^4/(4!)$（常数 $c$ 不计入主项）。
]

== 本章小结

逐项微分/积分是“翻造”旧级数的首选机床：$sin x -> cos x$（求导消截）、$1/(1+t) -> ln(1+x)$（积分升次）、$1+2x+3x^2+dots.c -> 1/(1-x)^2$（积分再求导）。*半径不变量*贯穿全部操作；官方练习里的 $e^(-x)$、$upright("sinh")$、$upright("cosh")$ 则把它们用成流水线。下一台机床更“魔性”：把 $x$ 整个换成别的式子——代换。

= 🔁 代换：把 x 换成别的式子

官方讲义（PDF p1-2 与网页 page-04）用一句话定义代换规则：*复合函数 $f(g(x))$ 的级数与多项式复合的规则一样*——本课只做一件事：把多项式 $p(x)$ 代进已知级数 $f(x)$。

$ "若" f(x) "的半径是" R "，则" f(p(x)) "收敛当" abs(p(x)) < R $

*符号表*：$p(x)$ 是代换进去的多项式（本课限定）；注意条件写在"$p(x)$ 的值"上：$|p(x)| < R$。特别常用的形式是 $p(x) = a x^n quad (n >= 1)$，因为 $p(0) = 0$——这样 $f(p(0)) = f(0)$，展开点仍是 $0$（官方讲义："we can find a Taylor series for a function f(x) at x=0 and then substitute in a polynomial of the form p(x)=ax^n for x since p(0)=0"）。

#figure(
  cetz.canvas(length: 1.25cm * dia-scale, {
    import cetz.draw: *
    content((1.0, 1.5), box(fill: luma(235))[$e^x = sum x^n/n!$], stroke: 0.7pt)
    content((3.4, 1.5), box(fill: luma(235))[$sin u$], stroke: 0.7pt)
    content((3.4, 0.8), box(fill: luma(235))[$ln(1+t)$], stroke: 0.7pt)
    content((1.6, 0.4), $ x = -t^2 $, fill: red)
    content((3.4, 0.0), $ u = 2x^5 $, fill: red)
    content((3.4, -0.6), $ t = -x^3 $, fill: red)
    content((0.9, -0.25), box(fill: luma(225))[$e^(-t^2)$], stroke: 0.7pt)
    content((3.4, -1.15), box(fill: luma(225))[$sin(2x^5)$;  $ln(1 - x^3)$], stroke: 0.7pt)
    line((1.0, 1.25), (1.35, -0.05), mark: (end: "stealth"))
    line((3.4, 1.25), (3.4, 0.5), mark: (end: "stealth"))
  }),
  caption: [代换“换皮”总览：把已知级数里的变量 $x$（或 $u$、$t$）分别换成 $-t^2$、$2x^5$、$-x^3$，就各自长成 $e^(-t^2)$、$sin(2x^5)$、$ln(1 - x^3)$——代换改的是“输入变量的表达式”，级数规则原样保留。],
)
#footnote[来源：转录 v13/v15 代换三例与讲义 page-04 规则（示意图按讲解重绘）；本方验证：图内容（三条代换箭头与产物）× 材料段（"substitute in a polynomial of the form p(x)=ax^n since p(0)=0"；"take the power series expansion for e to the x and make the substitution x equals minus t squared"）× caption 一致。]

#knowledgebox[
  *代换为何只换多项式*：官方限定 $p(0) = 0$ 的多项式（尤其 $a x^n$）——这样新级数仍然“在 0 点展开”（各项仍是 $x^n$ 的常数倍）；若 $p(0) != 0$，新级数会混进“平移项”，与我们的 $f(x) = sum a_n x^n$ 形式不一致。
]

== 演示一：把 -x 换成 x——cosh x 的“无符号偶幂”级数

习题课（转录 v13）第一个例子：$upright("cosh") x = (e^x + e^(-x))/2$。用已知级数（$①$ 的 $e^(-x)$ 上一节刚做）相加：

$ e^x + e^(-x) = sum_(n=0)^(oo) x^n/n! + sum_(n=0)^(oo) (-1)^n x^n/n! = 2 sum_(n="偶") x^n/n! $

*符号表*：$n$ 为偶数时两项都是 $x^n/n!$（相加得 $2x^n/n!$）；$n$ 为奇数时一正一负相消为 0。除以 2：
$ upright("cosh") x = 1 + x^2/(2!) + x^4/(4!) + x^6/(6!) + dots.c = sum_(n=0)^(oo) x^(2n)/(2n)! $

*符号表*：只留偶次幂、*无交替符号*——"looks just like the series for $e^x$, except the odd terms have died off"。这正解释了上一讲的"悬案"：$sum x^(2n)/(2n)!$ 不是 $cos x$ 而是 $upright("cosh") x$！讲师还点出"funny coincidences between regular trig functions and hyperbolic trig functions"——$upright("cosh")$ 与 $cos$ 只差交替符号，$upright("sinh")$ 与 $sin$ 同理。

== 演示二：三角恒等式再代换一次——2 sin x cos x = sin 2x

同一个习题课的第二例：$2 sin x cos x$。直乘两系数（$sin$ 级数 × $cos$ 级数）可行，但更短的路是*认出就是 $sin(2x)$*，然后只做一次代换 $x -> 2x$：

$ sin(2x) = 2x - (2x)^3/(3!) + (2x)^5/(5!) - (2x)^7/(7!) + dots.c = sum_(n=0)^(oo) (-1)^n 2^(2n+1) x^(2n+1)/(2n+1)! $

*符号表*：$x -> 2x$：奇次幂、每项多一个 $2^(2n+1)$ 因子；这就是“用三角恒等式改写成更简单的函数，再代换”的示范——先改写、再代换，比直接乘级数快一个数量级。

== 演示三：x ln(1 - x³) —— 两层代换加一次乘法

第三例：$x ln(1 - x^3)$。$x$ 前头先放一边；内部 $ln(1 - x^3)$ 用已知 $ln(1+t) = t - t^2/2 + t^3/3 - dots.c$ 代 $t = -x^3$：

$ ln(1 - x^3) = (-x^3) - ((-x^3)^2)/2 + ((-x^3)^3)/3 - dots.c = -x^3 - x^6/2 - x^9/3 - dots.c $

*符号表*：$t$ 取 $(-x^3)$ 后：$t^2 = x^6$（正号但前面有 $-1/2$）、$t^3 = -x^9$（乘 $-1/3$ 得 +）…… 注意*没有交替换号了*，因为 $-t^2$ 已被吃掉。最后把 $x$ 乘回去：

$ x ln(1 - x^3) = -x^4 - x^7/2 - x^10/3 - x^13/4 - dots.c $

*符号表*：每一项幂次 +1（$x^3 -> x^4$、$x^6 -> x^7$、$x^9 -> x^10$）；分母仍是普通整数；半径：$|x^3| < 1$ 即 $|x| < 1$（$\ln$ 的半径 1 被 $x^3$ 代换放大到“$|x^3| < 1$“，乘 $x$ 不改变）。讲师收尾：“We used a bunch of different techniques… substitution and then we just did a multiplicative by a polynomial.”

== 演示四：e^(-t²) 与误差函数——代换 + 积分 = 新函数

代课老师（转录 v15）——"Very appropriate for me as a substitute teacher to tell you about substitution."——的主角是概率论里大名鼎鼎的*误差函数*。先把 $e^x$ 的级数做代换 $x = -t^2$：

$ e^(-t^2) = 1 - t^2 + t^4/(2!) - t^6/(3!) + dots.c $

*符号表*：分两步算清符号：$(-t^2)^2 = t^4$（负负得正 → $+t^4/(2!)$）、$(-t^2)^3 = -t^6$（维持负号）；“the signs are going to alternate, the powers are all even”。

误差函数定义（官方与转录一致）：
$ upright("erf")(x) = 2/sqrt(pi) integral_0^x e^(-t^2) dif t $

*符号表*：$2/sqrt(pi)$ 是归一化因子（使 $x -> oo$ 时值趋于 $1$，数学上“总概率为 1”的体现；概率论里这就是正态分布累积密度）；$e^(-t^2)$ 没有初等原函数，官方原话“cannot be expressed in terms of functions that we already know with algebraic operations”。

== 官方练习详解：sin(2x⁵) + sinh(2x⁵) 的"谁活着"分析

网页 page-04 的代换练习（Practice substitution）把 $u = 2x^5$ 同时代进 $sin$ 与 $upright("sinh")$ 再相加。为什么答案只保留 $u^1, u^5, u^9, dots.c$？逐层拆：

$ sin u + upright("sinh") u = sum_(k=0)^(oo) ((-1)^k + 1) u^(2k+1)/((2k+1)!) $

*符号表*：$sin$ 的系数 $(-1)^k$、$upright("sinh")$ 的系数 $+1$；之和 $((-1)^k + 1)$ 在 $k$ 为偶数时 $= 2$、$k$ 为奇数时 $= 0$——*交替符号把一半项"杀"掉了*（$u^3, u^7, u^11, dots.c$ 没了）。

$ sin u + upright("sinh") u = 2(u + u^5/(5!) + u^9/(9!) + dots.c) = 2u + u^5/60 + u^9/181440 + dots.c $

*符号表*：$k = 0, 2, 4, dots.c$ 对应 $u^(4m+1)$ 型（$m = 0,1,2,dots.c$）。代入 $u = 2x^5$（$sin$ 与 $upright("sinh")$ 都是全实收敛）：
$
  sin(2x^5) + upright("sinh")(2x^5) = 2(2x^5) + ((2x^5)^5)/(5!) + ((2x^5)^9)/(9!) + dots.c = 2x^5 + 32 x^25/(5!) + 512 x^45/(9!) + dots.c
$

*符号表*：第一项 $2x^5$；第二项 $(32x^25)/(5!)$；第三项 $(512x^45)/(9!)$。常数项算度 $0$（官方注："the constant term counts as the degree 0 term"），所以"前三个非零项"就是上述三项。半径 $oo$。

#warningbox[
  *"相加"的半径交集在这里是"∞ 减 ∞"吗*：$sin$ 与 $upright("sinh")$ 半径都是 $oo$，相加仍是 $oo$——没有"减法缩小"的危险；真正要警惕的反而是*相减*（$sin u - upright("sinh") u$ 会把另一组项杀光）。官方试卷的常见改法是"加"或"减"二选一，请盯着 $(-1)^k$ 的朝向。
]

把上面刚造出的级数代进积分、逐项积分：
$
  upright("erf")(x) = 2/sqrt(pi) (x - x^3/3 + x^5/(5 dot 2!) - x^7/(7 dot 3!) + dots.c) = 2/sqrt(pi) sum_(n=0)^(oo) (-1)^n x^(2n+1)/((2n+1) n!)
$

*符号表*：$integral t^(2n) dif t = t^(2n+1)/(2n+1)$；分母出现 $\{2n+1}$（积分来的）$dot n!$（原有）。归一化系数写进括号外。讲师：“Your calculator probably calculates it, and your calculator probably does it by this method”——这就是“新级数”变成“数的计算”的活例。

#figure(
  cetz.canvas(length: 1.30cm * dia-scale, {
    import cetz.draw: *
    line((0.2, 0), (5.0, 0), mark: (end: "stealth"), stroke: 0.8pt)
    line((0.2, -0.3), (0.2, 2.2), mark: (end: "stealth"), stroke: 0.8pt)
    let pts = ()
    let t = 0.1
    while t <= 4.9 {
      pts.push((t, 1.7 * calc.exp(-calc.pow(t / 1.7, 2))))
      t += 0.05
    }
    line(..pts, stroke: 1.2pt + blue)
    line((1.0, 0), (1.0, 1.35), stroke: 0.9pt + red, dashed: (spacing: 2pt))
    content((2.3, 1.65), $ y = e^(-t^2) $, fill: blue)
    content((1.0, -0.32), $ x $, anchor: "north")
    content((2.6, 0.7), $ "面积 = ∫_0^x e^(-t^2) dt" $, fill: red)
  }),
  caption: [误差函数的几何含义：$y = e^(-t^2)$（蓝色高斯钟形）在 $[0, x]$ 下的面积再乘 $2/sqrt(pi)$ 即为 $upright("erf")(x)$。该函数没有初等原函数，但我们通过"代换 + 逐项积分"造出了它的级数——一个全新函数的"出生证明"。],
)
#footnote[来源：转录 v15 代换与误差函数段 + 网页 page-06（示意图按讲解重绘）；本方验证：图内容（高斯曲线、阴影面积、标注）× 材料段（"the error function gets normalized by putting a 2 over the square root of pi in front. And it's the integral of e to the minus t squared dt from 0 to x"）× caption 一致。]

== 官方练习：sin(2x⁵) + sinh(2x⁵) 与 Fresnel 积分

网页 page-04 的官方练习（Practice substitution, 1 分）是三连代换的下饭菜：用 $sin$ 与 $upright("sinh")$ 的已知级数代入 $u = 2x^5$，求和：

$ sin(2x^5) + upright("sinh")(2x^5) = sum_(n=0)^(oo) (1 + 1) dot (2x^5)^(4n+1)/((4n+1)!) $ 的一种写法：由于 $sin$ 与 $upright("sinh")$ 只在 $(-1)^n$ 上不同，$n$ 为偶数（$4m, 4m+2$）时相加抵消符号、奇数时叠加…… 更直接：两族求和的奇次幂 $u^(2k+1)/(2k+1)!$ 系数为 $(-1)^k + 1$：$k$ 偶 = $2$、$k$ 奇 = $0$，故只有 $k$ 为偶的项存活：

$ sin u + upright("sinh") u = 2 sum_(m=0)^(oo) u^(4m+1)/((4m+1)!) , quad u = 2x^5 $

*符号表*：存活的是 $u^1, u^5, u^9, dots.c$。于是答案（前三项）：
$
  sin(2x^5) + upright("sinh")(2x^5) = 2 x^5 + (2x^5)^5/(5!) + (2x^5)^9/(9!) + dots.c = 2x^5 + 32 x^25/(5!) + 512 x^45/(9!) + dots.c
$

== 反向识别官方练习逐题详解

网页 page-05 的"Recognizing power series"（3 分）给出三个级数找函数。逐题：

*① $x^2 - x^6/(3!) + x^10/(5!) - x^14/(7!) + dots.c$*：幂次 $2, 6, 10, 14$ 相差 $4$；$sin u = u - u^3/(3!) + u^5/(5!) - dots.c$ 以 $u = x^2$ 代入，得 $x^2, x^6, x^10, dots.c$——判别：*幂次整齐递增 + 交替符号 = 用"某个多项式的幂"代换正弦/余弦*：

$ = sin(x^2) quad (abs(x) < oo) $

*符号表*：分母因子 $3!, 5!, 7!$ 与 $sin$ 的 $u^3, u^5, u^7$ 对应；这种"幂次差 $4$"正是 $u = x^2$ 的指纹。

*② $sum_(n=0)^(oo) (n+2)(n+1) x^n$*：系数 $2, 6, 12, 20, dots.c$ 是"两个连续整数乘积"，正是"对几何级数求导两次"的痕迹（$dif^2/dif x^2 sum x^n = sum (n+2)(n+1) x^n$）：

$ = 2/(1-x)^3 quad (abs(x) < 1) $

*符号表*：$1/(1-x) = sum x^n$；两次逐项求导：$sum (n+1) x^n = 1/(1-x)^2$、$sum (n+2)(n+1) x^n = 2/(1-x)^3$。核对 $n = 0,1,2$ 项：$2, 6, 12$ ✓。与 v12 的"$1 + 2x + 3x^2 + dots.c = 1/(1-x)^2$"是同族：多求一次导，系数就多乘一个因子。

*③ $sum_(n=0)^(oo) ((-x)^(6n+1))/((2n)!)$*：先化简每项 $(-x)^(6n+1) = -x^(6n+1)$（指数 $6n+1$ 是奇数，$(-1)^(6n+1) = -1$），提出 $-x$：

$ = -x sum x^(6n)/(2n)! = -x dot upright("cosh")(x^3) quad (abs(x) < oo) $

*符号表*：$upright("cosh") u = sum u^(2n)/(2n)!$ 以 $u = x^3$ 代入得 $sum x^(6n)/(2n)!$；前面乘 $-x$。*注意不是 $-x cos(x^3)$*——$cos$ 的项必须带 $(-1)^n$，这里各幂都是正号（$x^(6n)$ 恒正），所以是双曲函数上场。

#importantbox[
  *"谁该上场"的判断树（官方提示词"trigonometric and hyperbolic"）*：看符号——幂项带 $(-1)^n$ → 三角（$sin/cos$）；不带 → 双曲（$upright("sinh")$ 与 $upright("cosh")$）。再看幂次：$2n+1$ 型（奇）→ $sin$；$2n$ 型（偶）→ $cos$；*加了位移因子（如 $x^2$ 代替 $u$）再认*——代换是"从后往前推"的镜像操作。
]

*符号表*：第一项 $2(2x^5) = 2x^5$；第二项 $2(2x^5)^5/(5!) = 2 dot 32 x^25/(5!)$；第三项类似。半径：$sin$ 与 $upright("sinh")$ 都是 $oo$，复合 $2x^5$ 后仍对所有 $x$ 收敛（$R = oo$）。这道题的“教学点”：*两族相近级数相加减时，$(-1)^n$ 决定了“哪些幂活下来”*——与 $A$、$B$ 级数相加减取交集的思想同源。

网页 page-06 的 Fresnel 官方练习（2 分）再开一次“代换 + 积分”：$S(x) = integral_0^x sin(t^2) dif t$（这个积分也“没有公式”，是光学中的 Fresnel 积分）：
$ sin(t^2) = t^2 - t^6/(3!) + t^10/(5!) - dots.c quad; quad S(x) = x^3/3 - x^7/(7 dot 3!) + x^11/(11 dot 5!) - dots.c $

*符号表*：$t^2$ 代进 $\sin$（每项幂 ×2）；积分后每项“除以新幂次”（$t^2 -> x^3/3$ 等）；第一三项非零：$x^3/3$、$-x^7/(3! dot 7)$、$+x^11/(5! dot 11)$；半径 $R = oo$。

#knowledgebox[
  *“新函数家族”（本讲第 4 台机床的成果）*：$e^(-t^2)$、$upright("erf")(x)$、$sin(t^2)$、$S(x)$（Fresnel）——全是“没有初等表达式，但级数长得漂亮”的函数。它们不是考试难点，而是*现代科学计算的真实对象*：解析失效处，级数接棒。这也是“代换 + 积分”机床性价比最高的时刻。
]

== 本章小结

代换把“同一台机器”复用到无数个输入：$x -> -x$ 得 $upright("cosh")$、$x -> 2x$ 得 $sin 2x$、$x -> -x^3$ 得 $ln(1-x^3)$、$x -> -t^2$ 得 $e^(-t^2)$——*每个新函数都是旧级数的一次“换皮”*。半径纪律：条件写在 $|p(x)| < R$（用 $p(x)$ 的值衡量）。下一步把“给级数认函数”练成反射——反向工程。

= 🔍 反向工程：认出级数背后的函数

习题课（转录 v14）的题目是“倒放电影”：给你四个级数，求它们分别是哪个函数——“what function each of these series represents”。讲师先声明：选的都是让级数收敛的 $x$（收敛性不用操心，目标是把级数还原成闭式函数）。

$
  A = sum_(n=0)^(oo) x^(n+2)/n! , quad B = sum_(n=2)^(oo) x^n , quad C = sum_(n=0)^(oo) (x^n/n! + x^n) , quad D = sum_(n=-1)^(oo) x^(n+1)
$

*符号表*：A 的“幂次比下标多 2”；B 从 $n=2$ 起步；C 两项同下标相加；D 的*下标从 -1 开始*（测试你懂不懂 sigma 记号）——四题各自暴露一种“找函数”的手法。

== A：拆因子——x² 提到外面

$x^(n+2) = x^n dot x^2$，$x^2$ 与 $n$ 无关，可以*提*到求和号外：
$ A = x^2 sum_(n=0)^(oo) x^n/n! = x^2 e^x quad (R = oo) $

*符号表*：这是第一种手法：*公共因子提取*；$e^x$ 熟悉度立现。官方练习的“Review: radius”把它列为首题：$R = oo$。

== B：补差额——凑成“漂亮的级数”再减掉

$B$ 是几何级数缺了头两项（$n = 0$ 与 $n = 1$）：
$ B = sum_(n=0)^(oo) x^n - 1 - x = 1/(1-x) - 1 - x quad (R = 1) $

*符号表*：第二种手法：*把缺的项补回来，然后用减法还原*（官方反复强调“I've taken the summation I started with… I added two more terms… to keep equality, I subtracted off x^0 and x^1”）；半径 $R = 1$（几何级数的）。

== C：拆和——两项各自“击破”

$C$ 是同一个求和号下的两项相加，*拆成两个已知级数*（对收敛幂级数合法）：
$ C = sum x^n/n! + sum x^n = e^x + 1/(1-x) quad (R = min(oo, 1) = 1) $

*符号表*：第三种手法：*和式拆开*；半径取两者交集——官方的 4-R 表中 $C$ 的答案为 $R = 1$（$e^x$ 全实数收敛，但几何级数只到 1，整体只有 1）。

== D：平移下标——sigma 记号的“捉迷藏”

$D$ 从 $n = -1$ 起、幂次 $n+1$：作换元 $m = n + 1$：
$ D = sum_(m=0)^(oo) x^m = 1/(1-x) quad (R = 1) $

*符号表*：$m = n+1$ 把下标挪回 0 起（“the infinity stays infinity”）；指数 $n+1$ 无改；结果竟是*标准几何级数*——讲师总结：“Even though I wrote it in kind of a funny way, it was actually just still the geometric series. I just moved the indices a little bit.” 半径 1。

#importantbox[
  *正常手册（讲师总结的四种手法）*：
  1. 它是“某已知函数乘上干净因子” ⇒ 提因子（A 型：$x^2 e^x$）；
  == 余项定理的"三段式"为什么长这样

  把定理的条件与结论拆开看（官方陈述 3.297 附近，含"成立的前提"与"结论的形态"）：

  #importantbox[
    *前提（两条）*：① $f$ 在开区间 $(0,x)$ 上 $n+1$ 阶可导（$f' , f'' , dots.c , f^((n+1))$ 都存在）；② $f' , dots.c , f^((n))$ 在闭区间 $[0,x]$ 上连续。
    *结论*：存在一点 $c in (0,x)$，使 $R_n(x) = f(x) - P_n(x) = (f^((n+1))(c))/((n+1)!) x^(n+1)$。
    *为什么需要两条*：Rolle 定理要求"连续 + 可导"；$[0,x]$ 闭区间上的连续保证 Rolle 能"跨"到端点，$(0,x)$ 上的高阶可导保证反复求导有定义。
  ]

  #warningbox[
    *三个容易记错的地方*：① $c$ 在 $(0,x)$ 之间*不是*在 $[0,x]$ 闭——点可取端点时 $M$ 不能取"端点处碰巧更大"的值（$c$ 严格在内部）；② 分子是 $f^((n+1))(c)$，*不是* $f^((n))(c)$，也*不是* $f(c)$（下标的 $+1$ 是最常丢的）；③ 分母乘的是 $(n+1)!$ 而不是 $n!$（$P_n$ 的第 $n+1$ 项"候补"权重）。
  ]

  2. 它是“某已知级数缺了几项” ⇒ 补差（B 型：$1/(1-x) - 1 - x$）；
  3. 它是“两列已知级数的和” ⇒ 拆和（C 型：$e^x + 1/(1-x)$）；
  4. 它只是“下标平移过的老朋友” ⇒ 改下标（D 型：$1/(1-x)$）。
]

#figure(
  cetz.canvas(length: 1.25cm * dia-scale, {
    import cetz.draw: *
    content((0.4, 1.4), $ sum x^(n+2)/n! $, fill: blue)
    content((0.4, 0.4), $ sum_(n=2)^(oo) x^n $, fill: orange)
    content((0.4, -0.6), $ sum (x^n/n! + x^n) $, fill: red)
    content((0.4, -1.6), $ sum_(n=-1)^(oo) x^(n+1) $, fill: green.darken(20%))
    content((3.6, 1.4), $ x^2 e^x $, fill: blue)
    content((3.6, 0.4), $ 1/(1-x) - 1 - x $, fill: orange)
    content((3.6, -0.6), $ e^x + 1/(1-x) $, fill: red)
    content((3.6, -1.6), $ 1/(1-x) $, fill: green.darken(20%))
    line((1.7, 1.4), (3.2, 1.4), mark: (end: "stealth"))
    line((1.7, 0.4), (3.2, 0.4), mark: (end: "stealth"))
    line((1.7, -0.6), (3.2, -0.6), mark: (end: "stealth"))
    line((1.7, -1.6), (3.2, -1.6), mark: (end: "stealth"))
    content((2.45, 1.7), $ "提因子" $)
    content((2.45, 0.7), $ "补差" $)
    content((2.45, -0.3), $ "拆和" $)
    content((2.45, -1.3), $ "平下标" $)
  }),
  caption: [反向识别四法对照：A→提因子（$x^2 e^x$）、B→补差（$1/(1-x) - 1 - x$）、C→拆和（$e^x + 1/(1-x)$）、D→平移下标（$1/(1-x)$，换元 $m = n+1$）。四种箭头都是“把级数推回已知函数”的标准路。],
)
#footnote[来源：转录 v14 四个识别题（对照图按其讲解重绘）；本方验证：图内容（四行级数到函数连线）× 材料段（"the sum is e to the x… this function is x squared e to the x" 等逐题原话）× caption 一致。]

#knowledgebox[
  *“哪一种手法”的快速判别*：看“已知度”——$n$ 出现在指数里：提因子；$n$ 出现但起点不对：补差；两项同列：拆和；起点为负、指数带位移：平下标。四种只是“手工展开”给级数找兄弟的速查表。
]

== 官方练习：反向识别与 4 级数半径表

网页 page-05 的两道官方练习把“每级数的 $R$“与”识别函数“分开考：

#booktabs-table(
  columns: (2.5fr, 1.6fr, 1.2fr),
  [级数],
  [对应函数],
  [$R$],
  [$sum x^(n+2)/n!$],
  [$x^2 e^x$],
  [$oo$],
  [$sum_(n=2)^(oo) x^n$],
  [$1/(1-x) - 1 - x$],
  [$1$],
  [$sum (x^n/n! + x^n)$],
  [$e^x + 1/(1-x)$],
  [$1$],
  [$sum_(n=-1)^(oo) x^(n+1)$],
  [$1/(1-x)$],
  [$1$],
)

*符号表*：前两列与视频 A-D 一一对应；半径列来自官方“Review: radius of convergence”（4 分题）：$oo$、$1$、$1$、$1$——注意 $A$ 虽是 $x^2 e^x$ 但半径仍由 $e^x$ 决定为 $oo$。

*反向识别（Recognizing power series, 3 分）*——给出级数、找函数（提示：回忆三角/双曲级数与微积分作用）：

$ ① x^2 - x^6/(3!) + x^10/(5!) - x^14/(7!) + dots.c quad (abs(x) < oo) quad => quad sin(x^2) $

*符号表*：奇幂交替且幂次 $2,6,10,14,dots.c$ = 每个“奇数阶幂”乘以 2 —— 正是 $sin u$ 以 $u = x^2$ 代（$u, u^3, u^5, dots.c$ 分别变 $x^2, x^6, x^10, dots.c$）。

$ ② sum_(n=0)^(oo) (n+2)(n+1) x^n quad (abs(x) < 1) quad => quad 2/(1-x)^3 $

*符号表*：系数 $2, 6, 12, 20, dots.c$（二阶差分恒定）；就是“三连乘”的导数：$1/(1-x) = sum x^n$ 求两次导得 $2/(1-x)^3 = sum (n+2)(n+1) x^n$；照抄 §3 的“积分 + 求导”法反向也能凑出来。

$ ③ sum_(n=0)^(oo) ((-x)^(6n+1))/((2n)!) quad (abs(x) < oo) quad => quad -x dot upright("cosh")(x^3) $

*符号表*：$(-x)^(6n+1) = -x^(6n+1)$（$(-1)^(6n+1) = -1$）；提出 $-x$ 后剩 $sum x^(6n)/(2n)! = upright("cosh")(x^3)$。核对：$upright("cosh") u = sum u^(2n)/(2n)!$，以 $u = x^3$ 代入、再乘 $-x$——“倒着看”就是代换的反向工程；注意这里不能是 $-x cos(x^3)$，因为*没有交替换号*（$(-1)$ 已被每项统一吸走）。

#practicebox[
  *本讲的“反向识别”三连问自测*：$sum x^(n+2)/n!$ 是啥？$sum x^(6n+1)/(2n)!$ 是啥？$x ln(1 - x^3)$ 的展开第一项是啥？答：$x^2 e^x$；$-x upright("cosh")(x^3)$；$-x^4$。
]

== 本章小结

反向工程 = 用“向前造”的四种手法（提因子/补差/拆和/平下标）倒着走。熟悉 A-D 型后，看到 $Σ x^(n+2)/n!$ 三秒反应 $x^2 e^x$、看到 $Σ x^6/(2n)!$ 型反应 $upright("cosh")(x^3)$——这些反射会给下一节“我来判断近似有多准”省下大量时间。接下来进入本讲的中点：Taylor 多项式与余项定理。

= 🎯 Taylor 多项式与余项定理：误差终于有数了

到目前为止，我们承诺“用 Taylor 级数可以逼近函数”，但*没人说清误差能压到多小*。网页 page-07 的讲义（与 PDF p2-3 同文）回答这个问题。先定义主角（3.294-3.295）：

$
  "若" f(x) = a_0 + a_1 x + a_2 x^2 + a_3 x^3 + dots.c quad (abs(x) < R), quad "则" P_n(x) = a_0 + a_1 x + a_2 x^2 + dots.c + a_n x^n
$

*符号表*：$P_n(x)$ 是*把 Taylor 级数截断到 $n$ 次幂*得到的多项式，叫 $f$ 在 0 点的“n 阶 Taylor 多项式”；$P_1$ 即线性近似、$P_2$ 即二次近似。

== 为什么 P_n 是“最佳”n 次多项式

官方性质（3.296）：$P_n$ 在 $x = 0$ 处与 $f$ 的前 $n$ 阶导数全部吻合：

$ P_n^((k))(0) = f^((k))(0) quad ("对" 0 < k <= n) $

== 精确度与代价：真实误差 vs 上界对照

三个案例的"上界 vs 真实"放在一起，把"余项定理的上界是安全的但可能松"直观化：

#booktabs-table(
  columns: (2.1fr, 2.3fr, 2.3fr),
  [案例],
  [上界（定理）],
  [真实误差],
  [$upright("erf")(1)$ vs $P_2(1) = 2/sqrt(pi)$],
  [$(1/3)(2/sqrt(pi)) approx 0.376$],
  [$approx 0.286$],
  [$sqrt(2)$ vs $P_3(1) = 23/16$],
  [$5/32 approx 0.156$],
  [$approx 0.023$],
  [$e$ vs $P_8(1)$],
  [$3/(9!) approx 8.3 dot 10^(-6)$],
  [$approx 2.3 dot 10^(-6)$],
)

*符号表*：上界按 $M/(n+1)!$ 计算，真实误差需要"算更多的项"（或者借助更精细的估计）；两者都随 $n$ 增加而*暴跌*——这正是"Taylor 多项式逼近任意精度"的原因。

#practicebox[
  *"多高次才够"的粗略标准*：阶乘分母 $1/(n+1)!$ 是最主要的衰减因子。$n = 5$ 时 $6! = 720$、$n = 8$ 时 $9! approx 3.6 dot 10^5$——所以 $e$ 的例子"$n = 8$ 给 4 位小数"并非玄学，而是 $9! > 2 dot 10^5$ 这一数字直接带来的。表格、计算器与模拟器都建在这条"指数级追杀误差"的路径上：误差按 $1/(n+1)!$ 缩小 → 初始的"野"逼近最终会听话。
]

*符号表*：$0$ 到 $n$ 阶（含函数值）都相等——“at the point 0, all the derivatives of the polynomial match the respective derivatives of f”。这正是“best fit”的含义：$P_1$ 是线性近似、$P_2$ 是二次近似，从逼近“次数”升级为“任意阶”。

数值工具怎么用它的（官方原话）：“Often, numerical tools, such as the graphing tool on your calculator or computer, use Taylor polynomials to approximate these functions.”——*计算器画图 = 多项式的函数*，误差由余项定理控制。

== Taylor 余项定理（3.297 陈述）

$
  "若" f "在" (0,x) "上" n+1 "阶可导（" f' , f'' , dots.c , f^((n+1)) "都存在）， 且" f' , dots.c , f^((n))
  "在" [0,x] "连续" \ "，则存在" c in (0,x) "使得：" R_n(x) = f(x) - P_n(x) = (f^((n+1))(c))/((n+1)!) x^(n+1)
$

*符号表*：$R_n(x)$ 是“n 阶截断的误差”（官方叫 remainder / error of approximation）；$c$ 是 $(0,x)$ 中某点（不知道确切在哪！）；*关键结构*：误差 = “第 $n+1$ 阶导在某点取值“ × $x^(n+1)/(n+1)!$。

#importantbox[
  *三条注释（官方 3.298 附近）*：
  1. $n = 0$ 时本定理就是*中值定理（MVT）*：“The n=0 case is the Mean Value Theorem (MVT)”（$f(x) - f(0) = f'(c) x$）；
  2. $c$ 的确切位置不知道——但*上下界仍可估计*（下节用 $|f^((n+1))|$ 在区间上的最大值）：
  3. *$R_n$ 公式对半径外也成立*；若 $|x| < R$，则 $lim_(n -> oo) R_n(x) = 0$——*在收敛半径内，取足够高次的多项式就能把误差压到任意精度*（“this means that within the radius of convergence, we can obtain an approximation of arbitrarily high accuracy by using a Taylor polynomial of high enough degree”）。
]

== 余项定理的证明：Rolle 定理的“叠罗汉”

网页 page-07 给出完整证明（3.299-3.312），这是本讲最硬的一段推导。核心思想：*构造一个特殊的“误差修正函数”，让它有足够多个零点，然后反复用 Rolle 定理“抓”出 $c$*。

*第 0 步（3.300）*：取定 $n$ 与 $x != 0$，定义辅助常数：
$ a = R_n(x) / x^(n+1) quad ("使得" R_n(x) = a x^(n+1)) $

*符号表*：$a$ 是把误差“归一”成 $a x^(n+1)$ 的比例常数（若误差恰为 $a x^(n+1)$ 式则 $a$ 就是待求系数）。

*第 1 步（3.301-3.303）*：定义
$ F_n(t) = R_n(t) - a t^(n+1) = (f(t) - P_n(t)) - a t^(n+1) quad ("0" <= t <= x) $

*符号表*：$R_n(t) = f(t) - P_n(t)$；把已知的“误差多项式”再减掉“假设项”。观察性质：
$ F_n(x) = 0 quad; quad F_n(0) = F_n'(0) = F_n''(0) = dots.c = F_n^((n))(0) = 0 quad ("check this") $

*符号表*：$F_n(x) = R_n(x) - a x^(n+1) = a x^(n+1) - a x^(n+1) = 0$（$a$ 的定义）；而 $R_n$ 与 $P_n$ 在 0 处的前 $n$ 阶导数相消（泰勒多项式与 $f$ 逐阶吻合 ⇒ $F_n$ 的 0 到 $n$ 阶在 0 处全为 0）。$F_n$ 与 $f$ 一样“够光滑”（$f$ 的假设 + 多项式）。

*第 2 步（3.305-3.308）*：*迭代 Rolle*。$F_n$ 在 $[0, x]$ 连续、$(0,x)$ 可导，且 $F_n(0) = F_n(x) = 0$ ⇒ Rolle 给 $c_0 in (0,x)$ 使 $F_n'(c_0) = 0$；再由 $F_n'(0) = 0$，对 $F_n'$ 在 $[0, c_0]$ 再 Rolle——$0 < c_1 < c_0$ 使 $F_n''(c_1) = 0$；如此继续 $n+1$ 次，得到嵌套链
$ 0 < c_n < c_(n-1) < dots.c < c_1 < c_0 < x quad ("且") F_n^((n+1))(c_n) = 0 quad ("记" c = c_n) $

*符号表*：每次 Rolle 把阶数 +1、区间缩小一截——“叠罗汉”到最后，我们抓住了 $(n+1)$ 阶导数的零点。

*第 3 步（3.310-3.312）*：算 $F_n^((n+1))(c)$：
== 平移公式的条件与两个"检查点"

推导 $f(x) = sum f^((n))(a)/n! (x-a)^n$ 有三个"检查点"值得停留（官方 page-10 文字逐句对应）：

#knowledgebox[
  *检查点一（$g$ 是"平移"，不是"更换"）*：$g(t) = f(t+a)$ 的每个导数都满足 $g^((n))(t) = f^((n))(t+a)$——*求导与平移可交换*，所以在 $t = 0$ 处取值就是"$f$ 在 $a$ 处的导数"。这是整个公式"把中心 $0$ 搬成 $a$"的机制。
]

*检查点二（收敛域随中心移动）*：$|t| < R$ 换成 $abs(x - a) < R$——*同一条"坏点距离"约束*，只是圆心挪了：原来 $R$ 是以 $0$ 为心、现在以 $a$ 为心。官方例：$1/(1-x)$ 在 $x=0$ 时 $R = 1$，在 $x=2$ 时 $R = 1$ 也成立（$abs(x - 2) < 1$），因为最近坏点 $x = 1$ 到 $2$ 的距离仍是 $1$。

*检查点三（$a = 0$ 回到 Maclaurin）*：代入 $a = 0$，$(x - a)^n = x^n$、$f^((n))(a) = f^((n))(0)$——*"在 $a$ 处展开"是"Maclaurin 级数"的推广版*，不是另一套东西。官方把 $a = 0$ 情形专门标注为"Maclaurin series"。

#practicebox[
  *把"检查点"用一遍*：对 $f(x) = e^x$ 在 $a = 2$ 展开到 $3$ 次：$e^2 + e^2 (x-2) + (e^2/(2!))(x-2)^2 + (e^2/(3!))(x-2)^3 + dots.c$（系数全是 $e^2$，从"导数是自己"得到）；对 $f(x) = 1/x$ 在 $a = 1$ 展开到 $2$ 次：$1 - (x-1) + (x-1)^2 - dots.c$（因为 $1/x = 1/(1 + (x-1))$，几何级数公比 $-(x-1)$，$abs(x-1) < 1$）。
]

$ F_n^((n+1))(c) = f^((n+1))(c) - (n+1)! dot a = 0 quad => quad a = f^((n+1))(c)/((n+1)!) $

*符号表*：$P_n(t)$ 是 $n$ 次多项式，其 $(n+1)$ 阶导为 0；$a t^(n+1)$ 的 $(n+1)$ 阶导为 $(n+1)! a$。代回 $a$ 的定义：
$ R_n(x) = a x^(n+1) = (f^((n+1))(c))/((n+1)!) x^(n+1) quad (0 < c < x) $

*符号表*：定理证毕。*证明的核心杠杆*：*泰勒多项式在 0 点逐阶吻合 → 修正函数 $F_n$ 在 0 处有 $n$ 重零点 → Rolle 连续“抓”出第 $n+1$ 阶导数的某零点*。这是一次教科书级的恒等式构造。

#knowledgebox[
  *Rolle 定理连接（3.299 处官方提醒）*：Rolle 定理是 MVT 的特例（两端点函数值相等 ⇒ 某点导数为 0），"so let us first recall the statement of Rolle's Theorem: If $F$ is differentiable on $(0,x)$ and continuous on $[0,x]$, and if $F(0) = F(x)$, then there is $c$ in $(0,x)$ such that $F'(c) = 0$."——余项定理的证明像"Rolle 的俄罗斯套娃"。
]

== 证明的“直觉层”：为什么 F_n 能抓住 c

Rolle 迭代的代数不难，但背后的几何直觉值得单独说：

#knowledgebox[
  *几何画像*：$R_n(t) = f(t) - P_n(t)$ 是“原函数与逼近多项式之间的垂直缝隙”。我们造 $F_n(t) = R_n(t) - a t^(n+1)$ 是在问“缝隙的形状里，多项式部分 $a t^(n+1)$ 是否已经被 $P_n$ 之外的残差补满”——条件是 $F_n(0) = F_n'(0) = dots.c = F_n^((n))(0) = 0$（缝隙在原点“高阶接触”），加上“再选 $a$ 让 $F_n(x) = 0$”。于是 $F_n$ 在 $0$（n+1 重）与 $x$ 处同时“碰地”，Rolle 就逼着它的高阶导数在区间内某点落地：$c$ 被抓住。
]

#warningbox[
  *两条“不动点”提醒*：① $a$ 依赖于 $x$（对每个 $x$ 重新选一遍）——$F_n(t)$ 是“为这个 $x$ 定制”的助函数，不要试图复用到别处；② $c$ 依赖 $x$、$n$、$f$——它不唯一，定理只承诺“至少存在一个”，这已经足够给出上界。
]

== 本章小结

$P_n$ 是“截断的级数”，与 $f$ 在 0 处逐阶吻合到 $n$ 阶——最佳逼近的代价是*余项*；余项定理给出它的精确形状 $(f^((n+1))(c)/(n+1)!) x^(n+1)$，其中 $c$ 藏在区间里；证明手法是“$F_n$ 有 $n+1$ 个零点 → Rolle 迭代“。下一节，把这个”藏起来的 $c$“转化为*能算的上界*：三个实战案例。

= 📏 误差估计实战：erf(1)、√2、e

网页 page-08 的三道题把余项定理从“定理”变成“手艺”：*把 $c$ 藏起来，用 $|f^((n+1))|$ 在区间上的上界换掉它*。

== 案例一：erf(1) 的度-2 近似

官方引言（3.313-3.315）先带我们做 $upright("erf")(1)$：$upright("erf")$ 的级数只有奇次幂，故 $P_2(x) = P_1(x) = 2/sqrt(pi) x$（$x^2$ 项是 0，度 1 与度 2 相同）：

$ upright("erf")(1) approx P_2(1) = 2/sqrt(pi) approx 1.1284 $

*符号表*：$P_2(1) = 2/sqrt(pi) dot 1$。误差从余项定理出发：$R_2(1) = upright("erf")'''(c)/3! dot 1^3 quad (0 < c < 1)$。

算 $upright("erf")$ 的三阶导（FTC2 + 链式法则）：
$
  upright("erf")'(x) = 2/sqrt(pi) e^(-x^2) , quad upright("erf")''(x) = 2/sqrt(pi) (-2x) e^(-x^2) , quad upright("erf")'''(x) = 4/sqrt(pi) e^(-x^2)(2x^2 - 1)
$

*符号表*：求导链：$e^(-x^2)$ 的链式因子 $-2x$ 每次出现；$upright("erf")'''(x) = 2/sqrt(pi)[-2 e^(-x^2) + 4x^2 e^(-x^2)] = 4/sqrt(pi) e^(-x^2)(2x^2 - 1)$。

对 $0 < c < 1$：$|e^(-c^2)| < 1$、$|2c^2 - 1| < 1$，故 $|upright("erf")'''(c)| < 4/sqrt(pi)$。于是：
$
  abs(upright("erf")(1) - P_2(1)) = abs(upright("erf")'''(c))/(3!) < (4/sqrt(pi))/(3!) = 1/3 (2/sqrt(pi)) approx 0.3761
$

*符号表*：分母 $3! = 6$；误差上界 $0.376$——$upright("erf")(1) approx 1.1284$，真实值 $approx 0.8427$，上界定理给了个“荒但正确”的容差（度 2 截断确实粗）。

== 案例二：√2 —— 在 0 点展开 √(1+x)

官方练习（Approximating square root of two, 3 分，3.333 前一段）：$f(x) = sqrt(1 + x)$（在 $x=0$ 展开），用 $P_3(1)$ 逼近 $sqrt(2)$：

$ P_3(x) = 1 + x/2 - x^2/8 + x^3/16 quad; quad P_3(1) = 1 + 1/2 - 1/8 + 1/16 = 23/16 = 1.4375 $

*符号表*：$(1+x)^(1/2)$ 的导数：$1/2, -1/4, 3/8, -15/16 dots.c$（在 0 处）除以 $n!$：「$1, 1/2, -1/8, 1/16$」。$sqrt(2) approx 1.4375$（真值 $1.4142$）。

误差表达式（用 $c in (0,1)$）：
$ sqrt(2) - P_3(1) = f^((4))(c)/(4!) dot 1^4 = ((-15/16)(1+c)^(-7/2))/(24) = -5/32 (1+c)^(-7/2) $

*符号表*：$f^((4))(x) = (3/8)(-5/2)(1+x)^(-7/2) = -15/16 (1+x)^(-7/2)$；除以 $4! = 24$ 得 $-5/32$。

在 $[0,1]$ 上 $|(1+c)^(-7/2)| <= 1$（$c = 0$ 时最大）⇒
$ abs(sqrt(2) - P_3(1)) <= 5/32 approx 0.15625 $

*符号表*：最大误差 $5/32$——$1.4375 - 0.15625 = 1.28125$ 与 $1.4375 + 0.15625 = 1.59375$ 确实包住 $sqrt(2)$；实际误差 $approx 0.0233$，上界宽松但正确（若要不那么松，提高 $n$）。

#figure(
  cetz.canvas(length: 1.25cm * dia-scale, {
    import cetz.draw: *
    line((0.2, 0), (4.8, 0), stroke: 0.8pt)
    line((0.2, -0.3), (0.2, 1.9), stroke: 0.8pt)
    let p0 = ()
    let p1 = ()
    let p2 = ()
    let p3 = ()
    let f = ()
    let t = 0.1
    while t <= 4.7 {
      p0.push((t, 1))
      p1.push((t, 1 + t / 2))
      p2.push((t, 1 + t / 2 - t * t / 8))
      p3.push((t, 1 + t / 2 - t * t / 8 + t * t * t / 16))
      f.push((t, calc.pow(1 + t, 0.5)))
      t += 0.05
    }
    line(..p0, stroke: 0.9pt + luma(150))
    line(..p1, stroke: 0.9pt + orange)
    line(..p2, stroke: 0.9pt + red, dashed: (spacing: 2pt))
    line(..p3, stroke: 1.0pt + green.darken(20%), dashed: (spacing: 4pt))
    line(..f, stroke: 1.2pt + blue)
    content((3.1, 1.2), $ sqrt(1+x) $, fill: blue)
    content((3.8, 0.45), $ P_3(x) $, fill: green.darken(20%))
    content((0.2, -0.45), $ x $, anchor: "north-west")
  }),
  caption: [$f(x) = sqrt(1+x)$（蓝）与其 Taylor 多项式 $P_0, P_1, P_2, P_3$（灰/橙/红/绿）：阶数越高，曲线在 $x = 1$（$sqrt 2$ 处）贴合越好；$P_3(1) = 23/16$ 与真值相差约 $0.023$，而上界 $5/32 = 0.156$——余项定理的“安全网”就铺在蓝线与绿线之间。],
)
#footnote[来源：网页 page-08 官方练习 $sqrt(2)$（曲线按题意重绘）；本方验证：图内容（四种颜色部分和曲线与蓝线）× 材料段（"approximate $sqrt(2)$ by $P_3(1)$… find the maximum over the interval of the absolute value"）× caption 一致。]

#knowledgebox[
  *为什么 $P_3(x)$ 只到“三次”就封顶*：官方选 $P_3$ 是因 $sqrt(1+x)$ 的导数从 $x^2$ 以上各项的“$n=4$ 之后保留”在 $x=1$ 处余项已经小到 $0.023$——**阶数与误差、计算量是同一个天平**：要 4 位小数就上 $e^x$ 的 $P_8$，要 2 位就 $P_3$。
]

== 案例三：e 的 4 位小数

官方练习（Approximating the number e, 3 分）：$e = e^1 approx P_n(1)$，误差的余项形式：
$ abs(R_n(1)) = e^c/((n+1)!) <= 3/((n+1)!) quad (0 < c < 1) $

*符号表*：$f^((n+1))(c) = e^c < e < 3$（$c in (0,1)$，$e < 3$）。目标“精确到 4 位小数”即误差 $< 5 dot 10^(-5)$：
$ 3/((n+1)!) < 5 dot 10^(-5) quad => quad (n+1)! > 60000 $

*符号表*：$8! = 40320 < 60000$、$9! = 362880 > 60000$ ⇒ $n+1 = 9$、$n = 8$。核查：
$ P_8(1) = 1 + 1 + 1/2 + 1/6 + 1/24 + 1/120 + 1/720 + 1/5040 + 1/40320 = 2.7182788 dots.c $

*符号表*：四舍五入到 4 位小数得 $2.7183$，与 $e = 2.7182818 dots.c$ 一致——n=8 就是“用 9 项买到 4 位精度”的官方答案。（$n=7$ 时 $3/8! approx 7.4 dot 10^(-5)$ 已超阈值，故最小 $n$ 必为 8。）

#warningbox[
  *余项定理的“上界”与“真实误差”*：定理只给“存在 $c$“，我们*用区间上界替换*：$|R_n(x)| <= M/(n+1)! |x|^(n+1)$（$M$ = 区间上 $|f^((n+1))|$ 最大值）。这个上界常比真实误差宽松几倍（案例二：$0.156$ vs $0.023$）——但*方向永远安全*，且随着 $n$ 增大按 $1/(n+1)!$ 加速坍塌（这是 $e$、$sin$ 的高阶近似“精准得可怕”的原因）。
]

== 本章小结

余项定理的实战三步：（1）写 $R_n = f^((n+1))(c)/(n+1)! x^(n+1)$；（2）对 $c$ 所在区间估计 $|f^((n+1))|$ 的上界 $M$；（3）得到安全上界 $M|x|^(n+1)/(n+1)!$。$upright("erf")(1)$、$sqrt(2)$、$e$ 三例分别示范“度 2 的粗容差”、“度 3 的紧点”、“度 8 的 4 位精度”。最后一步，把整个机器搬到*任意点 $a$*。

#knowledgebox[
  *一个 30 秒的“刻度感”（接上表）*：把三项放上同一根对数轴：$upright("erf")$ 的 $P_2$ 上界 $10^(0.6)$、$sqrt 2$ 的 $P_3$ 上界 $10^(-0.8)$、$e$ 的 $P_8$ 上界 $10^(-5.1)$——三次跳跃全由“$n+1$ 的阶乘”驱动，而不是由函数本身。所以“想要 2 位还是 6 位小数”的问题，几乎等价于“愿意多乘几层 $10/(n+1)$”。
]

#importantbox[
  *“余项定理 = 精确度兑换表”*：对固定的 $f$、固定的区间与固定的半径，$n$ 阶多项式的误差上界是 $M |x|^(n+1)/(n+1)!$——这是“多项式时间换精度”的代价表。表中 $M$ 是“函数到底多‘弯’”（高阶导多大），$|x|^(n+1)$ 是“离中心多远”，$(n+1)!$ 是“阶数红利”。三者的乘积给出交易价格。
]

#warningbox[
  *别把“能兑换”当“已兑换”*：上界 5 分钱不代表真值就欠 5 分钱——$sqrt(2) - P_3(1)$ 实际只欠约 2 分钱。定理的价值在于“承诺”与“协议”，不在于“精确到小数点后第 n 位的决算”；真实误差需要额外工具（或直接算更多项）。
]

== 误差直觉表：大小从哪来

#practicebox[
  *一个 30 秒的“刻度感”*：$sqrt(2)$ 的 $P_3$ 误差上界 $0.156$、“$e$ 的 $P_8$”上界 $10^(-6)$——差距全在“$1/(n+1)!$”这个小分母：$4! = 24$、$9! = 362880$。所以**每加一阶多项式，误差几乎按“再除一个数”缩小**；而带宽 $M$（$f^((n+1))$ 在区间上的最大值）顶多让误差在同量级内摆动，拦不住阶乘的暴冲。
]

#knowledgebox[
  *“真值 vs 上界”在工程中的态度*：官方说“numerical tools use Taylor polynomials”，因为**只要知道 $M$ 和 $n$，就能提前保证精度**——这是把“近似”变成“协议”的关键一步：机器不必知道真实值，就能确认误差在许可内。
]

= 🧭 在任意点展开：x = a 的 Taylor 级数

网页 page-09 的开篇文字直指一个“哲学”问题：“What if we want to find a Taylor polynomial approximation to a function at a point that is not 0? There is nothing special about the point 0.”——$0$ 没什么神圣的，只是我们习惯的展开点。官方引用“平移”思想：把函数左右平移，就可以把 $a$ 变成 $0$：

$ "设" g(t) = f(t + a) quad (g "是 f 向左平移 a 得到的，则 g 在 t=0 的 Taylor 级数" = sum g^((n))(0)/n! t^n ) $

*符号表*：$g$ 是横轴平移后的 $f$；$g(t) = f(t+a)$ 表示“把 $f$ 在 $a$ 附近的信息搬到 $g$ 的 $0$ 附近“（官方原文：”Let $g(t) = f(t+a)$. That is, g is the translation of f to the left by a.“）。

== 平移公式的完整推导（官方 page-10 三步）

$ f(t + a) = g(t) = sum_(n=0)^(oo) (g^((n))(0))/(n!) t^n = sum_(n=0)^(oo) (f^((n))(a))/(n!) t^n quad (abs(t) < R) $

*符号表*：$g^((n))(0) = f^((n))(a)$（平移不改变导数“形状”，只平移取值点）。*换回原变量*：令 $x = t + a$，即 $t = x - a$：
$ f(x) = sum_(n=0)^(oo) (f^((n))(a))/(n!) (x - a)^n quad (abs(x - a) < R) $

*符号表*：这就是 $f$ *在 $x = a$ 处的 Taylor 级数*：幂换成 $(x-a)^n$、导数取值点换成 $a$、收敛域写成 $|x-a| < R$；若 $a = 0$ 即回到 Maclaurin 级数（“This special case of Taylor's formula gives us a power series often referred to as the Maclaurin series”）。

#importantbox[
  *一套公式，两个中心*：$f(x) = sum f^((n))(a)/n! (x-a)^n$（$|x-a| < R$）——把 $a = 0$ 代入就是老公式；把 $a$ 换成任何点，公式“形状不变、取值点换了”。官方还特别提醒：半径 $R$ 的定义同样跟着换：*$f(x)$ 在 $|x - a| < R$ 收敛、$|x - a| > R$ 发散*——$R$ 永远是“到最近坏点的距离”。
]

#figure(
  cetz.canvas(length: 1.25cm * dia-scale, {
    import cetz.draw: *
    line((-3.4, 0), (3.8, 0), mark: (end: "stealth"), stroke: 0.9pt)
    line((-1, 0), (1, 0), stroke: 1.2pt + green.darken(20%))
    circle((-1, 0), radius: 0.09, fill: white, stroke: 0.8pt + red)
    circle((1, 0), radius: 0.09, fill: white, stroke: 0.8pt + red)
    content((-1.55, 0.45), $ "a - R" $, fill: red)
    content((1.55, 0.45), $ "a + R" $, fill: red)
    content((0.35, 0.45), $ "|x - a| < R" $, fill: green.darken(20%))
    content((0.35, -0.4), $ a $, anchor: "north")
    content((-2.5, -0.4), $ "旧：|x| < R" $, anchor: "north", fill: luma(100))
  }),
  caption: [任意点展开的几何：收敛区间始终是“以展开点 $a$ 为圆心、半径为 $R$”的区间（这里取 $a = 0.35$ 示意）；把 $a = 0$ 代入就回到 Maclaurin 的对称区间。半径 $R$ 不变，变的是圆心。],
)
#footnote[来源：网页 page-10 平移公式讲义与 PDF p4（数轴示意按公式重绘）；本方验证：图内容（a 为中心绿色区间、端点空心）× 材料段（"the radius of convergence… is the number R such that f(x) converges when |x-a| 小于 R and diverges when |x-a| 大于 R"）× caption 一致。]

#knowledgebox[
  *红色端点仍是“管辖盲区”*：官方对 $|x - a| = R$ 的态度与 Maclaurin 完全一样——“may converge or diverge, but we will mostly ignore”。中心换了，端点处理规则的“不碰”态度没变。
]

== 官方练习一：多项式在 x = -1 处展开

$ f(x) = 3x^3 + 4x^2 - 2x - 1 quad ("在" x = -1 "展开，写成" a_0 + a_1(x+1) + a_2(x+1)^2 + a_3(x+1)^3 ) $

*符号表*：$a = -1$（注意 $x - a = x + 1$，正负号别摔跤）。仍然用“导数表 + 除以阶乘”：

#booktabs-table(
  columns: (2fr, 2.6fr, 2.2fr),
  [导数阶数],
  [在 $x = -1$ 的值],
  [除以 $n!$ 的系数],
  [$f(x)$],
  [$3(-1) + 4 + 2 - 1 = 2$],
  [$a_0 = 2$],
  [$f'(x) = 9x^2 + 8x - 2$],
  [$9 - 8 - 2 = -1$],
  [$a_1 = -1$],
  [$f''(x) = 18x + 8$],
  [$-18 + 8 = -10$],
  [$a_2 = -10/(2!) = -5$],
  [$f'''(x) = 18$],
  [$18$],
  [$a_3 = 18/(3!) = 3$],
)

*符号表*：$f(x) = 3x^3 + 4x^2 - 2x - 1$ 在 $x = -1$：$f(-1) = -3+4+2-1 = 2$；$f'(-1) = 9-8-2 = -1$；$f''(-1) = -18+8 = -10$；$f''' = 18$ 常数。于是
$ 3x^3 + 4x^2 - 2x - 1 = 2 - (x+1) - 5(x+1)^2 + 3(x+1)^3 quad ("可展开验证，常数项" 2 - 1 - 5 + 3 = -1 "一致") $

*符号表*：系数 $(2, -1, -5, 3)$；多项式是有限和，展开中心随你换——展开式随之改头换面，但*表示的是同一个函数*。

== 官方练习二：e^x 在 x = a 的 n 阶项

$ e^x = sum_(n=0)^(oo) (e^a)/(n!) (x - a)^n quad => quad "第" n "阶项为" (e^a (x-a)^n)/(n!) $

*符号表*：$f^((n)) = e^x$ 在 $a$ 处恒为 $e^a$——这就是为什么 $e$ 的“任意中心展开”长得一模一样（只有 $e^a$ 这个常数因子）。

== 官方练习三：1/(1-x) 在 x = 2 处展开

“More practice”（2 分）：$f(x) = 1/(1-x)$ 在 $x = 2$ 处的前 4 个非零项。导数：$f(2) = -1$、$f'(x) = 1/(1-x)^2$（在 $2$ 为 $1$）、$f''(x) = 2/(1-x)^3$（在 $2$ 为 $-2$）、$f'''(x) = 6/(1-x)^4$（在 $2$ 为 $6$）⇒
$ 1/(1-x) = -1 + (x-2) - (x-2)^2 + (x-2)^3 + dots.c quad (abs(x - 2) < 1) $

*符号表*：系数 $(-1, 1, -1, 1)$——与“$1/(1-x)$ 在 0 点的 $1 + x + x^2 + dots.c$“互为镜像（中心换了，范围也换成 $|x-2| < 1$：最近坏点 $x = 1$ 距 $2$ = $1$）。官方第 3 问：此级数收敛当 $|x - 2| < 1$。

#practicebox[
  *自己练一个*：把 $sqrt(1+x)$ 在 $x = 1$ 处展开，写出前 3 项（提示：$g(t) = sqrt(2 + t)$，$g(t) = sqrt(2) (1 + t/2)^(1/2)$，展开到 $(t)^2$，再代 $x - 1$）。收敛半径应为 $|x - 1| < 2$（最近坏点 $x = -1$ 距 $1$ 为 2）。
]

== 本章小结

“在 $a$ 处展开“没有新数学，只有新记号：$(x-a)^n$ 取代 $x^n$、导数取值点 $a$ 取代 $0$、收敛域 $|x-a| < R$；$a = 0$ 时自动回到 Maclaurin。官方三练习（多项式在 $-1$、$e^x$ 在 $a$、$1/(1-x)$ 在 $2$）顺便演示：*中心可以换，函数不变，坏点决定半径*。至此，从“用旧级数造新级数”到“误差可控、任意点可展开”，整个幂级数手术台合拢。

= 🪛 机关题大通关：把所有官方练习串起来

把本讲十个网页里的官方练习按“机床”归类做一次总攻——每道题都附完整解法与陷阱提示。

== 通关一（page-01）：乘法三连

#practicebox[
  *题 1（Review: multiply two polynomials, 1 分）*：$p dot q$ 的 $x^3$ 系数 = $8$（多项式乘法法则四行表见“多项式乘法法则速成课”节）。*陷阱*：别把 $9x^6$ 项拉进来——它配不出幂次 3。
]

#practicebox[
  *题 2（Multiply two power series, 1 分）*：同样 $8$。*陷阱*：幂级数“无穷多项”会让人以为要算无穷多——但幂次 3 只能由前 4 项配成，答案一刀清。
]

#practicebox[
  *题 3（Multiply two series 2, 2 分）*：$e^x dot cos x$ 的 $R = oo$；$x^4$ 系数 $-1/3$。*陷阱*：系数是“三组配对相加”（$1/24 - 1/4 + 1/24$），不是“两项相乘”；符号来自 $cos$ 的 $x^2$ 项 $(-1/2)$。
]

#practicebox[
  *题 4（See answer 隐藏题）*：$e^a dot e^b = e^(a+b)$：总次数 $n$ 的项 = $(a+b)^n/n!$（二项定理）。*陷阱*：$a$、$b$ 是两个独立变量，不要当成 $a^2 b$ 混一个变量。
]

== 通关二（page-02）：除法的产品线

#practicebox[
  *题 5（Taylor series of tangent, 2 分）*：$tan x dot cos x = sin x$ 逐次幂解得 $tan x = x + x^3/3 + 2 x^5/15 + dots.c$，$R <= pi/2$。*陷阱*：半径别写 $oo$——$tan$ 在 $pi/2$ 炸了；$x^3$ 系数是 $1/3$ 不是 $1/3!$（解的是“除法的线性方程组”，不是 Taylor 硬算）。
]

== 通关三（page-03）：微积分流水线

#practicebox[
  *题 6（e^(-x), 2 分）*：$1 - x + x^2/(2!) - x^3/(3!) + x^4/(4!) - dots.c$，$R = oo$。*陷阱*：代入的是 $-x$ 的**整体**，$(-x)^2 = x^2$ 正号别写成负。
]

#practicebox[
  *题 7（sinh, 2 分）*：$upright("sinh") x = x + x^3/(3!) + x^5/(5!)$，$R = oo$。*陷阱*：与 $sin$ 差的就是 $(-1)^n$；看到“无交替”秒认双曲。
]

#practicebox[
  *题 8（微分与积分 sinh, 各 1 分）*：$dif/dif x$ 到 4 次得 $upright("cosh")$ 开头；$integral$ 到 4 次得 $c + x^2/(2!) + x^4/(4!)$。*陷阱*：积分常数 $c$ 放最前（官方习惯）；逐项积分不改变半径。
]

== 通关四（page-04/06）：代换 + 积分双打

#practicebox[
  *题 9（Practice substitution, 1 分）*：$sin(2x^5) + upright("sinh")(2x^5) = 2x^5 + 32x^25/(5!) + 512x^45/(9!) + dots.c$。*陷阱*：只有 $k$ 偶的项存活（$u^(4m+1)$ 型）；第三项别忘了 $(2x^5)^9$ 的 $2^9 = 512$。
]

#practicebox[
  *题 10（Fresnel integral, 2 分）*：$integral_0^x sin(t^2) dif t = x^3/3 - x^7/(7 dot 3!) + x^11/(11 dot 5!) - dots.c$，$R = oo$。*陷阱*：分母新幂次 $(2n+3)$ 是积分带来的，与 $(2n+1)!$ 并列；错误是“只除阶乘忘除新幂次”。
]

== 通关五（page-05）：反向识别

#practicebox[
  *题 11（4 级数半径表, 4 分）*：$oo$、$1$、$1$、$1$。*陷阱*：$sum x^(n+2)/n!$ 的半径由 $e^x$ 定（$oo$），不是由 $x^2$ 定——提因子不改变半径。
]

#practicebox[
  *题 12（Recognizing, 3 分）*：$sin(x^2)$、$2/(1-x)^3$、$-x upright("cosh")(x^3)$。*陷阱*：③ 必须看符号——无 $(-1)^n$ 是双曲不是三角。
]

== 通关六（page-08/09/10）：余项与平移

#practicebox[
  *题 13（sqrt(2), 3 分）*：$P_3(1) = 23/16$；误差 $R_3(1) = -5/32 (1+c)^(-7/2)$；上界 $5/32$。*陷阱*：中心是 0，选 $sqrt(1+x)$ 而不是 $sqrt(x)$；$f^((4))$ 的负号只影响符号不影响上界。
]

#practicebox[
  *题 14（e 的 4 位小数, 3 分）*：最小 $n = 8$，$P_8(1) approx 2.7182788$，四舍五入 $2.7183$。*陷阱*：$e^c < 3$ 的“3”是 $e$ 的整数上界；$3/(n+1)! < 5 dot 10^(-5)$ 解得 $9! > 60000$。
]

#practicebox[
  *题 15（多项式在 -1 展开, 4 分）*：$a_0 = 2, a_1 = -1, a_2 = -5, a_3 = 3$。*陷阱*：$(x+1)$ 即 $x - (-1)$；$f''(-1) = -10$ 除以 $2!$ 得 $-5$（别忘阶乘）。
]

#practicebox[
  *题 16（指数在 a 展开, 1 分）*：$e^a (x-a)^n/n!$。*陷阱*：$e^a$ 是常数因子；$(x-a)^n$ 的“a”与题目一致。
]

#practicebox[
  *题 17（1/(1-x) 在 2 展开, 2 分）*：$-1 + (x-2) - (x-2)^2 + (x-2)^3 - dots.c$，$abs(x - 2) < 1$。*陷阱*：系数 $1, -1, 1, -1$ 与“几何级数在 $-1$ 处的镜像”成对出现；最近坏点 $x = 1$ 距 $x = 2$ 是 $1$。
]

#practicebox[
  *十七题的“错题复盘”*：把上面 17 题最容易错的三个点抄一遍（① 乘积/除法的半径讲交集或分母零点；② $upright("sinh")$ 与 $upright("cosh")$（相对 $sin$ 与 $cos$） 的 $(-1)^n$ 之别；③ 在 $a$ 点展开时 $(x-a)^n$ 的符号与 $n!$ 分母）。每一点都能在“官方练习”原文里找到对应的“答案入口”——这是本讲最值得背的三行。
]

== 通关小结

#importantbox[
  *17 题通关版一句话*：这台“幂级数手术台”的五个科室——乘法（多项式乘法法则凑幂次）、除法（$F dot H = G$ 逐次幂）、微积分（半径不变）、代换（$|p(x)| < R$）、反向认证（提因子/补差/拆和/平下标）——每一科都有配套的半径纪律与符号陷阱。把本大节 17 题全部亲手算过一遍，比读三遍讲义管用。
]

= 🧠 全课回顾：武器箱、常见陷阱与自测

== 官方武器箱一览

#booktabs-table(
  columns: (2.2fr, 3fr, 1.6fr),
  [机床],
  [规则与关键例],
  [半径纪律],
  [乘法],
  [$f dot g = sum (sum a_k b_(n-k)) x^n$；$x dot sin x$；$e^a e^b = e^(a+b)$（二项定理）],
  [$min(A, B)$，可能更大],
  [除法],
  [$F dot H = G$ 逐次幂解系数；$sec x dot cos x = 1$ 解出 $a_4=5, a_6=61$；$tan x dot cos x = sin x$],
  [分母零点锁死；$tan$ 的 $R <= pi/2$],
  [逐项求导],
  [$sin x -> cos x$（$n$ 降到 $n-1$）；$1+2x+3x^2+dots.c = 1/(1-x)^2$],
  [半径不变],
  [逐项积分],
  [$1/(1+t) -> ln(1+x)$；$upright("sinh") -> upright("cosh")$ 前几项；$e^(-t^2) -> upright("erf")$],
  [半径不变（端点可能变）],
  [代换],
  [$x -> -x$ 得 $e^(-x)$；$x -> -t^2$ 得 $e^(-t^2)$；$x -> 2x$ 得 $sin 2x$；$x -> -x^3$ 得 $ln(1-x^3)$],
  [$|p(x)| < R$],
  [反向识别],
  [提因子 $x^2 e^x$、补差 $1/(1-x)-1-x$、拆和 $e^x + 1/(1-x)$、平下标 $1/(1-x)$],
  [各自取交集/原始半径],
)

*符号表*：每行对应一个机床；“半径纪律”列出本讲反复强调的边界条件。$e^(-t^2)$、$upright("erf")$、Fresnel 是代换+积分的两连产品。

== 常见陷阱预警

#warningbox[
  *本讲五个高频错误*：① 乘法半径直接取 $min(A, B)$ 却忘掉“可能更大”（$e^x dot e^(-x) = 1$，半径从 $oo$ 变出“全部”??——正确答案：两个 $oo$ 乘出 $oo$，却要提防 $\{1/(1-x) dot (1-x) = 1$ 这类“抵消成常数”的情形）；② 除法半径直接用 $min$（$tan x$ 的 $R$ 是 $pi/2$ 不是 $oo$）；③ 用 $upright("cosh")$ 时抄成 $cos$（忘掉交替符号，$upright("cosh") x = sum x^(2n)/(2n)!$ 与 $cos x$ 只差 $(-1)^n$）；④ 积分常数 $c$ 忘记放、或放在错误位置；⑤ 在 $a$ 点展开时把 $(x - a)^n$ 写成 $(x + a)^n$（$a = -1$ 时尤其致命）。
]

== 自测清单（官方题目改编）

1. *基础*：写出并验证 $x dot sin x$、$e^(-t^2)$、$ln(1+x)$ 的级数各前三项；指出各自半径。
2. *理解*：$sec x$ 的 $x^4$ 系数为什么是 $5$？（提示：$sec dot cos = 1$ 的 $x^4$ 配对。）
3. *应用*：$sum x^(n+2)/n!$ 与 $sum (n+2)(n+1)x^n$ 分别是哪个函数？（$x^2 e^x$；$2/(1-x)^3$。）
4. *陷阱*：$sum x^(2n)/(2n)!$ 是 $cos x$ 吗？（不是，是 $upright("cosh") x$；见本讲 $upright("cosh")$ 一节。）
5. *误差*：$P_3(1)$ 逼近 $sqrt(2)$ 的余项上界？（$5/32$；用 $f^((4))(c)/4!$ 与 $c$ 区间 $M$。）
6. *中心*：$1/(1-x)$ 在 $x = 2$ 的前三项？（$-1 + (x-2) - (x-2)^2$；$|x-2| < 1$。）

== 参考答案速查

1. $x dot sin x = x^2 - x^4/(3!) + x^6/(5!) - ...$（$R = oo$）；$e^(-t^2) = 1 - t^2 + t^4/(2!) - ...$（$R = oo$）；$ln(1+x) = x - x^2/2 + x^3/3 - ...$（$R = 1$）。
2. $1/(4!) dot 1 - (1/2)(1/2) + a_4/(4!) = 0 => a_4 = 5$；配对图见“乘积法”节。
3. $x^2 e^x$（提因子）；$2/(1-x)^3$（两次求导；$|x| < 1$）。
4. 不对——是 $upright("cosh") x$；$cos x$ 每项带 $(-1)^n$。
5. $5/32 approx 0.156$（$f^((4)) = -15/16(1+x)^(-7/2)$，$M = 15/16$，除以 $4!$）。
6. $-1 + (x-2) - (x-2)^2 + (x-2)^3 - dots.c$，$|x-2| < 1$（坏点 $x=1$ 距中心 2 为 1）。

#practicebox[
  *最后的“一句话”（本讲与上一讲的合围）*：上一讲你会“从零造”五条基本级数；这一讲你会“把它们任意加工”并“量出误差”。所以对一个新函数：查旧表（是否已知）、代换/微积（造新表）、余项（控误差）、必要时平移（换中心）。四个动作，闭环。
]
