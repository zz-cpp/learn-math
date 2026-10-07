// ═══════════════════════════════════════════════════════════════
// math-answer-note · 按日归档问答记录
// 结构：每个独立问题 = 一个一级标题（=），子问题用（== / ===）
// 轨道：数学轨
// ═══════════════════════════════════════════════════════════════
#import "@preview/ilm:2.1.1": *
#import "@preview/cetz:0.5.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

// ═══ 判断框体系（与课程笔记同构）═══
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

// ═══ booktabs-table ═══
#let booktabs-table(columns: (), ..rows) = block(width: 100%)[
  #table(
    columns: columns,
    stroke: (top: 1.2pt + black, bottom: 1.2pt + black, x: none, y: 0.5pt + luma(160)),
    fill: none,
    inset: (x: 8pt, y: 5pt),
    ..rows,
  )
]

// ═══ 尺寸预设 ═══
#let dia-scale = 1.0
#let sz-full = 1.5cm
#let sz-wide = 1.3cm
#let sz-normal = 1.0cm

#show: ilm.with(
  title: [数学与 CS 问答记录],
  authors: ("math-answer-note",),
  date: datetime(year: 2026, month: 9, day: 4),
  abstract: [按日归档的问答记录：每个独立问题一个一级标题（=），子问题用（== / ===）；三问反思法（关键点/变式/同类归类）+ 讲课叙事流 + 四色判断框，结构与课程笔记同构。],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

// 关闭 ilm 模板默认的公式自动编号 (1),(2),……
#set math.equation(numbering: none)

= 🎯 问题 7：为什么"偶函数的 Taylor 级数没有奇次幂项"？

读者问：manipulating power series 笔记中说"偶函数的 Taylor 级数没有奇次幂项"，这个结论出现在笔记哪里？为什么会有这个结论？#footnote[来源：结论出现于 manipulating-power-series-work 笔记《奇偶性：免费拿到一半系数》（$x dot sin x$ 例题后）与《方法二：奇偶性省掉一半工作》（$sec x$ 一节）；本问答为读者对笔记结论的追问与推导澄清，非材料原文。]

== 直接解答

*理由一句话：偶函数的级数逐项满足 $f(-x) = f(x)$，代进 $-x$ 一比较，所有奇次幂的系数必须为 0*。设 $f(x) = sum a_n x^n$，代入 $-x$（收敛半径内合法，见问题 6）：

$ f(-x) = sum_(n=0)^(oo) a_n (-x)^n = sum_(n=0)^(oo) a_n (-1)^n x^n $

*符号表*：$(-x)^n = (-1)^n x^n$：$n$ 偶数时是 $+x^n$，$n$ 奇数时是 $-x^n$。

偶函数条件 $f(-x) = f(x)$ 逐项对照：

$ sum_(n=0)^(oo) a_n (-1)^n x^n = sum_(n=0)^(oo) a_n x^n $

*符号表*：两边是同一个函数，由 Taylor 展开唯一性，同次幂系数必须相等。

于是对每个 $n$：$a_n (-1)^n = a_n quad => quad a_n (1 - (-1)^n) = 0$。当 $n$ 为奇数时 $1 - (-1)^n = 2 != 0$，只能 $a_n = 0$；$n$ 为偶数时 $1 - (-1)^n = 0$，方程自动成立，$a_n$ 自由。*结论：奇次幂系数全为 0，只剩偶次幂*。

*等价路线（看导数，更贴近 Taylor 公式）*：$f$ 偶函数 ⇒ $f'$ 是奇函数，于是 $f^((2k+1))$ 都是奇函数，任何奇函数在 $x = 0$ 处取值必为 0：

$ a_(2k+1) = f^((2k+1))(0) / (2k+1)! = 0 quad => quad "奇次幂项全部消失" $

*符号表*：$a_n = f^((n))(0)/n!$；奇函数 $g$ 满足 $g(0) = -g(0)$，故 $g(0) = 0$。两条路线互相印证（与问题 6"代入 $-x$"一致，也解释了笔记观察的 $sin$ 只含奇次幂、$cos$ 只含偶次幂）。

== 关键点

#importantbox[
  *一句话灵魂*：奇偶性是幂级数系数的"免费过滤器"：偶函数 ⇒ 奇次系数全 0；奇函数 ⇒ 偶次系数全 0。这是因为 $(-x)^n$ 的符号逐项交替，偶函数要求逐项相消，只有同号（偶次幂）项能存活。
]

== 变式检验

1. *cos x（偶函数）*：$1 - x^2/(2!) + x^4/(4!) - dots.c$，只有偶次幂——正是该结论。

2. *sin x（奇函数）*：$x - x^3/(3!) + x^5/(5!) - dots.c$，只有奇次幂。

3. *偶函数之积*：$sec x = 1/cos x$ 偶函数，展开 $1 + x^2/2 + 5x^4/24 + dots.c$ 无奇次项；$x dot sin x$（奇×奇 = 偶）也只含偶次幂——笔记的两处应用。

4. *反例自检*：$e^x$ 不是奇也不是偶，级数 $sum x^n/n!$ 奇偶次幂都有——说明"奇次幂全 0"不是普遍性质，是偶函数专属。

== 同类归类

- 与笔记"官方练习 6：奇偶性白送两个新级数"同构（那个用代入 $-x$ 验证 $sin$、$cos$ 奇偶性）；
- 与问题 6（代入 $-x$ 的合法性）直接衔接：本结论就是代入 $-x$ 后逐项比较的结果；
- 与笔记"幂级数会隐藏函数性质"互补：级数*暴露*奇偶性（看幂次即可），但*隐藏*周期性。

== 易错点

#warningbox[
  - "偶函数没有奇次幂"成立的前提是展开*中心在 0*（Maclaurin 级数）；在 $x = 1$ 处展开偶函数时这个说法不适用（对称点是 $x=1$ 不是 $x=0$）。
  - 别把方向弄反：偶函数 ⇒ 没有奇次幂（不是"没有偶次幂"）；奇函数 ⇒ 没有偶次幂。
  - 该结论只判"系数是否为 0"，不告诉你非零系数是多少（$sec x$ 的 $x^2$、$x^4$ 系数仍需另法求）。
  - 从 $f$ 偶函数推 $f'$ 奇函数成立，但"奇数阶导在 0 处为 0"是唯一用到的结论，其余奇偶性交替变化不影响推理。
]

= 🧬 问题 8：error function（误差函数）是什么？笔记里为什么像凭空出现？

读者问：manipulating power series 笔记中 $upright("erf")$ 像凭空出现一样，解释一下什么是 error function。本节回答定义、来历与"凭空感"的真相。#footnote[来源：本问答基于 manipulating-power-series-work 笔记《演示四：e^(-t²) 与误差函数——代换 + 积分 = 新函数》（转录 v15 + 网页 page-06）；解答为读者追问的澄清，属于概率论/特殊函数标准内容，非材料原文。]

== 直接解答

*它是什么*：误差函数 $upright("erf")$ 是下面这个定积分定义的函数（笔记第 531-532 行，与材料一致）：

$ upright("erf")(x) = 2/sqrt(pi) integral_0^x e^(-t^2) dif t $

*符号表*：把 $t$ 从 0 积到 $x$，被积函数是高斯钟形曲线 $e^(-t^2)$；前面的 $2/sqrt(pi)$ 是归一化因子。它读作"误差函数"——名字来自统计学：测量误差常近似服从正态分布，误差的概率就落在这样的积分里（Φ(x) = 1/2 (1 + upright("erf")(x/sqrt(2)))）。

*为什么笔记里"凭空出现"*：因为 $e^(-t^2)$ 没有初等原函数。也就是说，*没有任何一个由多项式、指数、三角、对数、开方经四则与复合构成的已知函数*是它的积分——官方原话："cannot be expressed in terms of functions that we already know with algebraic operations."。所以它不可能从 $1/(1-x)$、$e^x$、$sin x$ 这些"老函数表"里推出来；要认识它，只能*直接定义*成积分，再想办法算它。

而"算它的办法"正是本课机床的最后一跳：对 $e^x$ 做代换 $x = -t^2$ 得 $e^(-t^2) = sum (-1)^n t^(2n)/n!$，然后逐项积分（半径 $oo$ 内合法）：

$ upright("erf")(x) = 2/sqrt(pi) (x - x^3/3 + x^5/(5 dot 2!) - x^7/(7 dot 3!) + dots.c) = 2/sqrt(pi) sum_(n=0)^(oo) (-1)^n x^(2n+1)/((2n+1) n!) $

*符号表*：$integral t^(2n) dif t = t^(2n+1)/(2n+1)$——分母多出的 $2n+1$ 是积分贡献的；在原 $n!$ 基础上相乘。这就是 $upright("erf")$ 的"出生证明"：*一个没有初等表达式的新函数，被幂级数完整捕获*。

*归一化 $2/sqrt(pi)$ 的来历*：高斯积分 $integral_0^oo e^(-t^2) dif t = sqrt(pi)/2$，所以 $upright("erf")(oo) = 1$。概率论里"分布总概率 = 1"，这一因子把钟形曲线下的总面积"校准"成 1。

== 关键点

#importantbox[
  *一句话灵魂*：$upright("erf")$ 不是从"已知函数"里变出来的，而是 *"没有初等原函数"这一事实的化身*——它被定义为高斯钟形曲线的有界积分，计算则完全靠"代换 + 逐项积分"得到的幂级数。笔记里的"凭空"正是课程要传达的：级数能凭空造出计算器也会用的新函数。
]

== 变式检验

1. *为什么不能直接积分*：如果 $e^(-t^2)$ 有初等原函数，我们就不需要定义新名字了——正因为遍寻无果（可证明不存在），才把积分"A 记作 upright("erf")"。

2. *它的特殊值*：$upright("erf")(0) = 0$；$upright("erf")(-x) = -upright("erf")(x)$（奇函数，级数只有奇次幂——问题 7 的结论直接适用）；$upright("erf")(oo) = 1$。

3. *与概率论的连接*：正态分布 Φ(x) = 1/2 (1 + upright("erf")(x/sqrt(2)))；"3σ 法则"即 Φ(3) ≈ 0.9987 = 1/2 (1 + upright("erf")(3/sqrt(2)))——工程误差判决的底层数字。

4. *数值计算*：笔记说计算器"probably does it by this method"——正是用上面的级数（或类似逼近）算 upright("erf") 的值；$upright("erf")(1)$ 也是 Taylor 余项定理那节的实例。

== 同类归类

- 与笔记"演示四"直接同构：$e^(-x^2)$ 级数 → 逐项积分 → 新函数，是"代换 + 积分 = 新函数"机床的第 4 件产品；同族还有 Fresnel 积分 $S(x)$（$sin(t^2)$ 的积分）——也是没有初等表达式、靠级数定义。
- 与"$upright("cosh") x$ 的悬案"呼应：那里用级数识破"这是另一个函数"；这里用级数*定义*一个未知函数——双向翻译机的另一面。
- 与笔记收尾"解析失效处，级数接棒"一致：$upright("erf")$、Fresnel 都是现代科学计算的真实对象（概率、信号处理、光学）。

== 易错点

#warningbox[
  - $upright("erf")$ 不是"算错了的函数"：error function 的"error"是*测量误差*的 error，不是"错误"——别望文生义。
  - 别把 $upright("erf")(x)$ 当成 $e^(-x^2)$：前者是积分（一个数/函数值），后者是被积函数本身；$e^(-x^2)$ 只是 $upright("erf")$ 的"原料"。
  - $upright("erf")$ 的级数半径是 $oo$（由 $e^(-x^2)$ 的 $R = oo$ 逐项积分得来），端点没有特殊问题；但归一化因子 $2/sqrt(pi)$ 别忘了——它的作用是 $upright("erf")(oo) = 1$。
  - 考试里如果要求 $integral e^(-x^2) dif x$ 的"闭式"，答案不是"算不出来"而是"就是这个新定义"——注意题目想要的是级数还是 upright("erf") 记号。
]
