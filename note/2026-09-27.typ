// ═══════════════════════════════════════════════════════════════
// math-answer-note · 按日归档问答记录
// 结构：每个独立问题 = 一个一级标题（=），子问题用（== / ===）
// 轨道：数学轨
// 规范：2026-09-05 math-answer-note 新版（无 practicebox/无 dia-scale，
//       含 titledbox/unnumbered；公式编号全局关闭）
// ═══════════════════════════════════════════════════════════════
#import "@preview/ilm:2.1.1": *
#import "@preview/cetz:0.5.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

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

// ═══ 标题栏框（tcolorbox attach 标题栏近似）═══
#let titledbox(
  title,
  body,
  bg: rgb("#eefaf1"),
  title-bg: rgb("#2e9e5b"),
  title-fg: white,
  stroke: 1pt + luma(70),
) = block(
  width: 100%,
  breakable: true,
  radius: 0pt,
  fill: bg,
  stroke: stroke,
  inset: 0pt,
)[
  #block(width: 100%, fill: title-bg, inset: (x: 8pt, y: 3pt), radius: 0pt)[
    #text(fill: title-fg, weight: "bold")[#title]
  ]
  #block(width: 100%, inset: (x: 9pt, y: 7pt))[#body]
]

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

// ═══ 图内公式编号助手（本文件全局关闭编号，此处备用）═══
#let unnumbered(body) = {
  set math.equation(numbering: none)
  body
}

#show: ilm.with(
  title: [数学与 CS 问答记录],
  authors: ("math-answer-note",),
  date: datetime(year: 2026, month: 9, day: 27),
  abstract: [按日归档的问答记录：每个独立问题一个一级标题（=），子问题用（== / ===）；三问反思法（关键点/变式/同类归类）+ 讲课叙事流 + 判断框，结构与课程笔记同构。],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

// 关闭 ilm 模板默认的公式自动编号 (1),(2),……
#set math.equation(numbering: none)


= 📍 问题 108：笔记里哪里有「线积分基本定理」的证明？

读者问：我的笔记里哪里有证明线积分基本定理吗。#footnote[来源：全量检索 ~/note/2026 各课程 .typ（关键词：线积分基本定理、梯度定理、FTLI）；定位结果与章节行号均已核对。]

== 直接回答：在 `18.02.2x/lec-07` 的「材料 4」

- *文件*：`~/note/2026/18.02.2x/lec-07/fundamental-theorem-of-line-integrals.typ`；
- *章节*：*`= 材料 4 · 定理的证明（Fundamental theorem proof）`*（第 570–736 行）；
- *三小节*：① 教授的思路：把它写成全微分；② 把线积分改写成“对 $f$ 的微分”；③ 证明：参数化 -> 链式法则 -> 一元基本定理。

== 证明的三步骨架（笔记自己的提炼）

#booktabs-table(
  columns: (0.8fr, 3.4fr, 1.6fr),
  [步骤],
  [内容],
  [性质],
  [①],
  [认出全微分：$integral_C f_x dif x + f_y dif y = integral_C dif f$],
  [“看出来”],
  [②],
  [参数化 $+$ 链式法则：$= integral_(t_0)^(t_1) (dif f) slash (dif t) dif t$],
  [“算出来”],
  [③],
  [一元基本定理收尾：$= f(P_1) - f(P_0)$],
  [“背下来”],
)

*笔记原话*：“第 1 步是‘看出来’，第 2 步是‘算出来’，第 3 步是‘背下来’。真正需要动脑的只有第 1 步——而它成立的理由是 $nabla f$ 的定义本身。”

== 教授的洞察（笔记照录的原话）

#importantbox[
  - “那意味着我实际上在积分 $f_x dif x + f_y dif y$。或者，如果你愿意，*这和积分 $dif f$ 是同一件事*。”
  - “那么，*它就等于 $f$ 的改变量*。”
  - “在这种形式下，*它其实和单变量微积分里的说法是同一个陈述*。”

  *一句话浓缩*（笔记自测题的参考答案）：*梯度场的线积分，本质上就是“把全微分沿路径累加”，而累加全微分得到的是函数值的总变化。*
]

== 笔记里的其他相关位置

#booktabs-table(
  columns: (2.4fr, 3.4fr),
  [位置],
  [内容],
  [lec-07 材料 1 $slash$ 3],
  [定理的引入与运用（同一积分三种算法的对比：定义 $slash$ 路径无关 $slash$ 基本定理）],
  [*lec-07 材料 4*],
  [*完整证明*（参数化 -> 链式法则 -> 一元基本定理）★],
  [lec-14 复习],
  [“保守场与线积分基本定理”节：公式 $+$ 成立条件],
  [lec-08 格林定理],
  [对比提及（“第 7 讲处理保守场；本讲处理一般场”）],
  [18.02.3x],
  [无对应（3x 讲三维通量 $slash$ 散度，不含此证明）],
)

== 关键点

#importantbox[
  *结论*：想看证明，直接翻 `18.02.2x/lec-07` 的*材料 4*（第 570 行起）——那里有从“全微分直觉”到“严格三步证明”的完整推导，还附了一道“把证明翻译成一句话”的自测题。
]

= 📖 问题 109：线积分基本定理的证明（全文复制自 lec-07 材料 4）

读者要求：将证明的内容复制到日期文件。#footnote[来源：~/note/2026/18.02.2x/lec-07/fundamental-theorem-of-line-integrals.typ 的“材料 4 · 定理的证明”（第 570–734 行）原文复制；为适配日期文件组件做了两处转换（practicebox -> knowledgebox、figure 改为文字说明），内容未删改。]


== 教授的思路：把它写成全微分

#knowledgebox[
  材料 4 页视频转录，教授的原话（照录）：

  "也许我应该说：如果你试着把它用坐标写出来——那也是一种有用的思考方式。
  如果我给你沿 $C$ 的线积分，梯度场的分量是 $f_x$ 与 $f_y$。"

  "*那意味着我实际上在积分 $f_x dif x + f_y dif y$。
  *或者，如果你愿意，这和积分 $dif f$ 是同一件事。
  也就是说，我在积分函数 $f$ 的微分。"
]

#importantbox[
  教授紧接着的关键一句（照录）：

  "*那么，它就等于 $f$ 的改变量*。"

  "*而且当然，如果你把它写成这种形式，那么*这件事为什么成立，对你来说大概就相当明显了。
  我的意思是，在这种形式下，*它其实和单变量微积分里的说法是同一个陈述*。"
]

#knowledgebox[
  最后一句是整段证明的灵魂（照录）：

  "*实际上，*这就是我们证明这个定理的方式。所以让我们来证明它。
  我们怎么证呢？"

  "*假设我给你一条曲线，让你计算这个积分。你会怎么做？
  嗯，你实际计算积分的方式，*是选一个参数，然后把一切都用那个参数表示出来。"
]

#knowledgebox[
  这段讲解把证明拆成了两步：

  #enum(
    numbering: "1.",
    [先看形式：把 $f_x dif x + f_y dif y$ 认成全微分 $dif f$——
      于是它变成"累加微小变化得到总变化"，这一步几乎不用算],
    [再走流程：参数化 + 链式法则 + 一元基本定理——
      把二维问题降回一元],
  )

  教授先讲"为什么显然"，再讲"怎么严格证"，这个顺序值得学习：
  理解了为什么，证明就只是把直觉写清楚。
]

== 把线积分改写成"对 $f$ 的微分"

#importantbox[
  材料原文（照录）："*从梯度场 $nabla f = (f_x, f_y)$ 出发，
  我们可以把'计算 $nabla f$ 沿曲线 $C$ 做功'的线积分写成如下形式*："

  $ integral_C f_x dif x + f_y dif y = integral_C dif f $

  "*其中 $dif f$ 是全微分（total differential）*。"

  "*如果曲线从 $P_0$ 开始、到 $P_1$ 结束，那么基本定理告诉我们*"

  $ integral_C dif f = f(P_1) - f(P_0) $

  符号表：

  - $dif f$：全微分——它是 $dif x$、$dif y$ 的线性组合
    $f_x dif x + f_y dif y$；
  - $integral_C dif f$：对"微小变化"沿路径累加；
  - 这一步把"向量积分"变成了"标量函数微分"的积分——证明的全部技巧就在这里。
]

#knowledgebox[
  为什么这一步是关键？因为"沿路径把微小变化累加起来，得到总变化"这件事，
  本身就无须任何计算：

  #booktabs-table(
    columns: (auto, 1fr),
    table.header([说法], [含义]),
    [积分读法], [$integral_C dif f$ = 沿路径把所有微小变化加起来],
    [结果], [总变化 = 终点值 − 起点值],
  )

  剩下要做的，只是把 $integral_C dif f$ 这件事用微积分语言严格写出来。
]

#knowledgebox[
  *（原文配图，此处以文字代替）*：一条从 $P_0$ 出发、到 $P_1$ 结束的轨迹。基本定理说：这条轨迹是曲是直、是长是短都不影响结果，只要认准两个端点。
]

== 证明：参数化 → 链式法则 → 一元基本定理

#importantbox[
  材料原文（照录，逐步）："*为了证明它，我们会用到全微分这个概念，
  以及（一元微积分里的）微积分基本定理*。"

  "*我们从一条曲线 $C$ 和一个梯度场 $nabla f$ 开始。
  计算 $nabla f$ 沿 $C$ 做功的线积分是*"

  $ integral_C f_x dif x + f_y dif y $

  "*为了求这个积分，我们参数化 $C$*："

  $ x = x(t), quad dif x = x'(t) dif t, quad y = y(t), quad dif y = y'(t) dif t quad (t_0 <= t <= t_1) $
]

#importantbox[
  代入并合并：

  $ integral_C f_x dif x + f_y dif y = integral_C f_x x'(t) dif t + f_y y'(t) dif t = integral_(t_0)^(t_1) (dif f) slash (dif t) dif t $

  其中用到了链式法则（材料单独列出）：

  $ (dif) slash (dif t) f(x(t), y(t)) = f_x(x(t), y(t)) x'(t) + f_y(x(t), y(t)) y'(t) $

  符号表：

  - $x'(t) dif t$、$y'(t) dif t$：把两个微分换成对 $t$ 的微分；
  - $f_x x' + f_y y'$：恰好是复合函数 $f(x(t), y(t))$ 对 $t$ 的导数——
    这是链式法则在二维的形态；
  - 于是整个积分变成 $integral_(t_0)^(t_1) (dif f slash dif t) dif t$——
    一个标准的一元积分。
]

#importantbox[
  最后一步：直接用一元微积分基本定理：

  $ integral_(t_0)^(t_1) (dif f) slash (dif t) dif t = f(x(t), y(t)) |_(t_0)^(t_1) = f(x(t_1), y(t_1)) - f(x(t_0), y(t_0)) = f(P_1) - f(P_0) $

  符号表：

  - $t_0$、$t_1$：参数区间的两端；
  - $(x(t_0), y(t_0)) = P_0$：起点；$(x(t_1), y(t_1)) = P_1$：终点；
  - 证明完成——注意整个过程用到的唯一"硬"工具，就是一元的基本定理。
]

#knowledgebox[
  把这份证明的逻辑骨架抽出来，它就三句话：

  #enum(
    [numbering: "1."],
    [把向量积分写成 $integral_C dif f$——需要认出被积的是全微分；],
    [参数化，用链式法则把 $integral_C dif f$ 变成 $integral_(t_0)^(t_1) (dif f slash dif t) dif t$；],
    [用一元基本定理收尾],
  )

  第 1 步是"看出来"，第 2 步是"算出来"，第 3 步是"背下来"。
  真正需要动脑的只有第 1 步——而它成立的理由是$nabla f$ 的定义本身
  （梯度场正是"能写成全微分的场"）。
]

#knowledgebox[
  自测：把上面的证明"翻译"成一句话。

  （参考答：梯度场的线积分，本质上就是"把全微分沿路径累加"，
  而累加全微分得到的就是函数值的总变化。

  记住这句话，就不需要再背证明过程——需要时能当场复述出来。
  这也是本讲最该带走的一句话。）
]

= 🎯 问题 110：笔记中「势函数」的定义与相关内容（检查 $+$ 复制）

读者要求：检查我的笔记中对于势函数的定义和相关内容，并复制。#footnote[来源：定义部分为 ~/note/2026/18.02.2x/lec-07（第 444–465 行）原文复制；两种求法与存在性为 lec-10 材料 5 $slash$ 6 与相关问答的综合整理（原文位置见文末索引）。]

== 一、定义（lec-07 原文照录）

=== 定义：势函数

#importantbox[
  材料原文（照录）："*假设 $arrow(F) = nabla f$ 是一个梯度场。
  那么我们称 $f(x, y)$ 为 $arrow(F)$ 的势（potential）*。"
]

#warningbox[
  材料的 Remark（照录，这是数学与物理最容易打架的地方）：

  "*数学家的势的定义，与物理学家的势的定义差一个负号*。
  在物理中我们写 $arrow(F) = - nabla f$，此时称 $f$ 为势。
  *因此物理中的势，是数学中的势的相反数*。"

  举例说明：

  #booktabs-table(
    columns: (auto, auto, auto),
    table.header([领域], [约定], [后果]),
    [数学], [$arrow(F) = nabla f$], [沿曲线积分 $= f(P_1) - f(P_0)$，递增],
    [物理], [$arrow(F) = - nabla f$], [沿曲线积分 $= f(P_0) - f(P_1)$，递减],
  )

  这不是小事：物理里“势能降低、动能增加”的直觉，
  在数学约定下会变成“势函数增加”。做题时先看题目用的是哪套约定。
]

== 二、两种求法（lec-10 材料 5 $slash$ 6）

=== 方法一：用线积分求势函数

#importantbox[
  *定义* $f(x, y) = integral_C arrow(F) dot dif arrow(r)$，其中 $C$ 是从某起点到 $(x, y)$ 的一条*路径*——把“求势函数”变成“算线积分”。

  *路径选择*（越简单越好）：

  #booktabs-table(
    columns: (2fr, 2.4fr, 2.8fr),
    [路径],
    [参数化],
    [注意什么],
    [$C_1$（水平段）],
    [$(0, 0) -> (x, 0)$],
    [$y = 0$ 是常数，所以 $dif y = 0$——只剩 $M dif x$],
    [$C_2$（竖直段）],
    [$(x, 0) -> (x, y)$],
    [$x$ 是常数，所以 $dif x = 0$——只剩 $N dif y$],
  )
]

=== 方法二：用不定积分（四步法）

#importantbox[
  *出发点*：解偏微分方程组 $f_x = M$、$f_y = N$。

  #enum(
    numbering: "1.",
    [对 $f_x = M$ 关于 $x$ 求原函数：$f(x, y) = integral M(x, y) dif x + g(y)$；],
    [对 $f$ 关于 $y$ 求偏导：$f_y = partial_y (integral M dif x) + g'(y)$；],
    [与 $N$ 对上，解出 $g'(y)$，再积出 $g(y)$；],
    [检验：对求得的 $f$ 分别求 $f_x$、$f_y$，与 $M$、$N$ 核对。],
  )
]

#knowledgebox[
  *多变量积分最大的差别*：*“积分常数”不是常数，而是任意只含 $y$ 的函数 $g(y)$*。

  #booktabs-table(
    columns: (3.2fr, 2.6fr),
    [情形],
    [积分“常数”],
    [一元：$integral f(x) dif x$],
    [常数 $C$],
    [多元：对 $x$ 积分 $f(x, y)$],
    [*任意只含 $y$ 的函数 $g(y)$*],
  )

  理由：对 $x$ 求偏导时，任何只含 $y$ 的项都会被当常数消掉——反推时必须把它们补回来。
]

=== 两法对比（lec-10 原文）

#booktabs-table(
  columns: (2.6fr, 3.6fr),
  [方法],
  [关键操作 $slash$ 注意事项],
  [方法一（线积分）],
  [选“先水平再竖直”的路径，让每段只剩一项；步骤固定，*不易出错*],
  [方法二（不定积分）],
  [对 $M$ 积分得 $g(y)$，再用 $N$ 匹配定出 $g$；*更快，但“必须小心怎么做”*（教授原话）],
)

*两种方法得到同一个势函数（相差常数）*；考试上会要求“用两种方法各求一次”。

== 三、存在性：局部不等于整体（lec-10）

#warningbox[
  追问“*对于哪些（区域）可以定义势函数*”——答案是：*旋度为零只是局部条件*。

  典型逻辑链（材料 3）：

  #enum(
    numbering: "1.",
    [算旋度 $->$ 得到 $0$（看起来是好消息）；],
    [查定义域 $->$ 发现原点是个洞；],
    [结论 $->$ 判据不成立，它不是梯度场；],
    [更深一层 $->$ 它在原点之外*局部地*是梯度场，但*整体上*势函数“绕一圈会跳变”，*无法在挖洞区域上定义出单值势函数*。],
  )

  *一句话*：旋度（局部）为零，但保守性（整体）不成立——定义域的单连通性是判据的另一半。
]

== 四、检索索引（全文在哪）

#booktabs-table(
  columns: (3.2fr, 2.4fr, 1.4fr),
  [内容],
  [文件],
  [行号],
  [*定义：势函数*（含数学 $slash$ 物理差负号）],
  [18.02.2x lec-07],
  [444–465],
  [主定理 $integral_C nabla f dot dif arrow(r) = f(P_1) - f(P_0)$],
  [18.02.2x lec-07],
  [471–497],
  [定理的证明（全微分法）],
  [18.02.2x lec-07 材料 4],
  [570–734],
  [*方法一：线积分*（含例 41）],
  [18.02.2x lec-10 材料 5],
  [910–1096],
  [*方法二：不定积分*（四步法）],
  [18.02.2x lec-10 材料 6],
  [1097 起],
  [两法对比 $+$ 例题（$e^(x + y)$ 型）],
  [18.02.2x lec-10],
  [190–258],
  [存在性（局部 vs 整体）],
  [18.02.2x lec-10 材料 3],
  [466–517],
  [复习（保守场与线积分基本定理）],
  [18.02.2x lec-14],
  [758 起],
)


= 🌉 问题 111：线积分基本定理 vs 格林定理——分别是什么、有什么联系

读者问：线积分基本定理和格林定理分别是什么，他们有联系吗。#footnote[来源：两定理表述分别取自笔记 lec-07（材料 1$slash$3）与 lec-08（材料 2）原文，联系部分整理自 lec-08 第 111–118 行与第 460–473 行的“闭环”分析。]

== 一、两个定理并排看

#booktabs-table(
  columns: (1.8fr, 3fr, 3fr),
  [ ],
  [*线积分基本定理*（FTLI）],
  [*格林定理*（Green）],
  [公式],
  [$integral_C nabla f dot dif arrow(r) = f(P_1) - f(P_0)$],
  [$integral.cont_C arrow(F) dot dif arrow(r) = integral.double_R ("curl" arrow(F)) dif A$],
  [分量形式],
  [$integral_C f_x dif x + f_y dif y$],
  [$integral.cont_C M dif x + N dif y = integral.double_R (N_x - M_y) dif A$],
  [适用场],
  [*梯度场*（保守场，$arrow(F) = nabla f$）],
  [*一般场*（旋度可以不为零）],
  [路径],
  [任意曲线（开曲线也行）],
  [*逆时针闭曲线*（区域的边界）],
  [结果],
  [端点处势函数之*差*],
  [区域内*旋度*的二重积分],
  [前提],
  [存在势函数],
  [$C$ 逆时针围住 $R$；$arrow(F)$ 在 $R$ 上处处有定义且可微],
  [笔记位置],
  [18.02.2x lec-07],
  [18.02.2x lec-08],
)

== 二、联系（三层，由浅入深）

=== 联系 1：格林定理是 FTLI 的“一般化”

#importantbox[
  - *FTLI 只处理特例*：$arrow(F) = nabla f$——此时旋度恒为零（“旋度 $= 0$ 且处处有定义 $=>$ 线积分就是 $0$，不用算”）；
  - *格林定理补上缺口*：“假设我有一个一般的向量场，旋度不会是 $0$，而我仍然想计算沿闭曲线的线积分”——格林定理给出了那条路。
]

=== 联系 2（*最关键*）：FTLI 的“闭路为零”是格林定理的推论

#importantbox[
  *一行动机就通了*：若 $arrow(F) = nabla f$，则

  $ N_x - M_y = f_(y x) - f_(x y) = 0 quad ("混合偏导数相等") $

  代入格林定理：

  $ integral.cont_C arrow(F) dot dif arrow(r) = integral.double_R 0 dif A = 0 $

  ——“*保守场沿任何闭曲线的环量为零*”这条结论，正是*格林定理在旋度恒零情形下的特例*。
]

=== 联系 3：笔记里的“闭环”（lec-08 的四个等价说法）

#knowledgebox[
  第 7 讲铺开的四个等价说法（保守 $arrow.l.r$ 路径无关 $arrow.l.r$ 闭路零环量 $arrow.l.r$ 旋度为零），最后一环是由*格林定理*完成的：

  #booktabs-table(
    columns: (1.6fr, 1.8fr, 2.6fr),
    [环节],
    [在哪一讲完成],
    [用什么工具],
    [$(1) arrow.l.r (2)$],
    [第 7 讲],
    [线积分基本定理],
    [$(3) => (2)$],
    [第 7 讲],
    [线积分基本定理],
    [$(2) => (3)$],
    [第 7 讲（勾画）],
    [构造势函数],
    [$(3) => (4)$],
    [上一讲],
    [偏导数相等],
    [*(4) => (1)*],
    [*本讲（lec-08）*],
    [*格林定理*],
  )

  *笔记原话*：“所以*格林定理在这里的角色是‘闭环’*：它证明了‘旋度处处为零’蕴含‘保守’。”
]

== 三、统一的视角：都是“广义斯托克斯定理”的一张面孔

#importantbox[
  三个定理共享同一个模式——*边界上的积分 $=$ 内部的“微分”积分*：

  #booktabs-table(
    columns: (2.2fr, 3.4fr, 2.2fr),
    [定理],
    [公式],
    [“边界”是什么],
    [一元基本定理],
    [$integral_a^b F'(x) dif x = F(b) - F(a)$],
    [区间的两个端点],
    [*线积分基本定理*],
    [$integral_C nabla f dot dif arrow(r) = f(P_1) - f(P_0)$],
    [曲线的两端点],
    [*格林定理*],
    [$integral.cont_C arrow(F) dot dif arrow(r) = integral.double_R "curl" arrow(F) dif A$],
    [闭曲线（区域的边界）],
  )

  *下一步的扩展*：斯托克斯定理（空间闭曲线 $->$ 曲面上的旋度通量）与高斯定理（闭曲面 $->$ 立体内的散度）继续把这张表补齐——这是整个多变量微积分后半段的主题。
]

== 关键点

#importantbox[
  *一句话灵魂*：*FTLI 管“保守场”*（结果只依赖端点，$f(P_1) - f(P_0)$）；*格林定理管“一般场”*（把闭曲线环量换成区域内旋度的二重积分）。二者的联系是*包含关系*——保守场旋度恒零，代入格林定理立刻得到“闭路环量为零”，所以*FTLI 的闭环结论是格林定理的特例*；而在四等价说法的证明链条里，*格林定理正是补上最后一环（旋度零 $=>$ 保守）的那把钥匙*。
]

= 🔗 问题 112：线积分 vs $arrow(F) dot dif arrow(r)$——两类线积分的联系（复习讲解）

读者问：我对于线积分和 $arrow(F) dot dif arrow(r)$ 沿着曲线的积分有什么联系出现了遗忘，使用我笔记中的内容，为我讲解和回忆。#footnote[来源：lec-04（标量线积分）、lec-06（向量线积分：核心恒等式第 126 行、三个视角材料 11）；数值断言经 Python 复核（三视角同值）。]

== 一、先分清：这是*两类*不同的线积分

#booktabs-table(
  columns: (1.8fr, 3fr, 3fr),
  [ ],
  [*第一类：标量线积分*],
  [*第二类：向量线积分*],
  [记号],
  [$integral_C f dif s$],
  [$integral_C arrow(F) dot dif arrow(r)$],
  [被积对象],
  [标量函数 $f$],
  [向量场 $arrow(F) = (M, N)$],
  [微元],
  [$dif s$（弧长元，*恒正*）],
  [$dif arrow(r)$（位移微元，*有方向*）],
  [物理含义],
  [质量（密度 $times$ 弧长）],
  [功（力 $times$ 位移）],
  [与走向的关系],
  [*无关*（正反走同值）],
  [*有关*（反向变号）],
  [笔记位置],
  [lec-04],
  [lec-06],
)

== 二、联系的桥梁：一个恒等式

#importantbox[
  $ dif arrow(r) = hat(T) dif s quad ("位移微元 = 单位切向量" times "弧长微元") $

  代入即得：

  $ arrow(F) dot dif arrow(r) = arrow(F) dot hat(T) dif s $

  *这就是两类线积分的桥*：*向量线积分就是“加权版的标量线积分”*——被积函数换成“*场沿切向的分量*” $arrow(F) dot hat(T)$ 即可。
]

#knowledgebox[
  *笔记 lec-06 原话*（第 126 行附近）：这三条式子说的是同一件事的三种写法——
  $arrow(F) dot dif arrow(r) = arrow(F)(arrow(r)(t)) dot arrow(r)'(t) dif t = (M, N) dot (dif x, dif y) = arrow(F) dot hat(T) dif s$。

  而 *lec-04* 的工具（参数化、$dif s$ 的算法、弧长公式）正是为第一类积分准备的——*lec-06 开场的原话*：“我们会借用为*标量函数*线积分已经发展出来的工具，*目标是把同样的过程套上去*。”
]

== 三、三种视角（lec-06 材料 11 的“三视图”）

#importantbox[
  #booktabs-table(
    columns: (1.6fr, 2.4fr, 3fr, 2.2fr),
    [视角],
    [把 $dif arrow(r)$ 换成],
    [得到的积分],
    [什么时候最好用],
    [参数化],
    [$arrow(r)'(t) dif t$],
    [$integral_a^b arrow(F) dot arrow(r)'(t) dif t$],
    [曲线有现成参数化时],
    [分量],
    [$(dif x, dif y)$],
    [$integral_C M dif x + N dif y$],
    [路径由 $x = "常数"$ 或 $y = "常数"$ 拼成时],
    [几何],
    [$hat(T) dif s$],
    [$integral_C arrow(F) dot hat(T) dif s$],
    [能一眼看出夹角时],
  )

  *关键*：三者不是“三种不同的积分”，而是“*同一个积分的三种读法*”——选哪条路，只看哪条最省事。
]

== 四、数值验证：三视角必然同值

例：$arrow(F) = (x, y)$，$C$：从 $(0, 0)$ 沿 $y = x$ 到 $(1, 1)$（即 $arrow(r)(t) = (t, t)$，$t in [0, 1]$）：

#booktabs-table(
  columns: (2fr, 4fr, 1.6fr),
  [视角],
  [计算],
  [值],
  [参数式],
  [$integral_0^1 (t, t) dot (1, 1) dif t = integral_0^1 2 t dif t$],
  [$1$],
  [分量式],
  [$integral x dif x + y dif y$],
  [$1 slash 2 + 1 slash 2 = 1$],
  [几何式],
  [$hat(T) = (1, 1) slash sqrt(2)$、$dif s = sqrt(2) dif t$；$integral sqrt(2) t dot sqrt(2) dif t = 2 integral_0^1 t dif t$],
  [$1$],
)

*三者一致* ✓（数值复核：$1.00000000 = 1.00000000 = 1.00000000$）

== 五、为什么要建立这个联系（三个理由）

#knowledgebox[
  #enum(
    numbering: "1.",
    [*工具复用*：标量线积分（lec-04）发展出的全套工具——参数化、$dif s$ 的计算、弧长公式——*直接搬来用*；],
    [*物理直觉*：$arrow(F) dot hat(T)$ 就是“*力沿路径方向的分量*”——“只有沿位移方向的分量做功”，这正是 $arrow(F) dot dif arrow(r)$ 作为功的本质；],
    [*几何直觉*：$arrow(F) dot hat(T) = abs(arrow(F)) cos theta$——*垂直为零、平行最大*（lec-06 例 30 $slash$ 31 的判据）。],
  )
]

== 六、两个最容易忘的差别

#warningbox[
  - *$dif s$ 恒正、$dif arrow(r)$ 有向*：$integral_C f dif s$ *与走向无关*；$integral_C arrow(F) dot dif arrow(r)$ *与走向有关*（反向变号）——这是两类积分的根本差别（lec-06 材料 9 的核心 Remark）；
  - *$dif x$ 不是长度*：$integral_C M dif x$ 里的 $dif x$ 可正可负（“$x$ 变化了多少”），而 $dif s$ 永远非负（“沿曲线走了多远”）。
]

== 关键点

#importantbox[
  *一句话回忆*：*向量线积分 $integral arrow(F) dot dif arrow(r)$ 就是“加权版”的标量线积分*——权重是“*场沿切向的分量*” $arrow(F) dot hat(T)$；桥是一个恒等式 $dif arrow(r) = hat(T) dif s$；同一个积分有三种读法（参数 $slash$ 分量 $slash$ 几何），做题时选最省事的那条。
]
