// ═══════════════════════════════════════════════════════════════
// answer-note · 按日归档问答记录
// 结构：每个独立问题 = 一个一级标题（=），子问题用（== / ===）
// 轨道：数学轨（标量线积分的几何理解与参数化——18.02.2x lec-04 节选）
// 规范：answer-note（无 practicebox/无自测框；三色判断框
//       + titledbox + subfigure/plotline/unnumbered；公式编号全局关闭）
// ═══════════════════════════════════════════════════════════════
#import "@preview/ilm:2.1.1": *
#import "@preview/cetz:0.5.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/cetz-plot:0.1.4": chart, plot

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

// ═══ 行内 raw（机器符号 `...`）样式：等宽 + 淡底、保持内联 ═══
// 注意：不要用全局 #show raw.line —— 它会把行内反引号也渲染成带行号的整行方块
#show raw.where(block: false): it => box(
  fill: luma(243),
  inset: (x: 1.6pt, y: 0.3pt),
  radius: 1.5pt,
)[#text(font: "DejaVu Sans Mono", size: 0.88em)[#it.text]]

// ═══ codelisting（CS 轨用）═══
#let codelisting(code, lang: "typst", caption: none) = figure(caption: caption, block(
  width: 100%,
  breakable: true,
  stroke: 0.8pt + luma(200),
  inset: 8pt,
)[
  // 行号规则只在 codelisting 内部局部生效
  #show raw.line: line => box(width: 100%)[
    #box(width: 2.4em)[#text(fill: luma(150), size: 0.72em)[#str(line.number)]]
    #line.body
  ]
  #set text(size: 0.9em)   // 对应 listings 的 \small；raw 无自动折行，长行手动折
  #raw(code, lang: lang, block: true)
])

// ═══ booktabs-table ═══
#let booktabs-table(columns: (), ..rows) = block(width: 100%, breakable: true)[
  #table(
    columns: columns,
    stroke: (top: 1.2pt + black, bottom: 1.2pt + black, x: none, y: 0.5pt + luma(160)),
    fill: none,
    inset: (x: 8pt, y: 5pt),
    ..rows,
  )
]

// ═══ 子图助手（对应 lecture-to-notes 的 subcaption）═══
#let subfigure(items, caption: none, columns: (1fr, 1fr), gutter: 0.6cm) = figure(
  grid(
    columns: columns,
    gutter: gutter,
    ..(for i in range(items.len()) {
        let item = items.at(i)
        let body = item.at(0)
        let label = item.at(1, default: none)
        let letters = ("a", "b", "c", "d", "e", "f", "g", "h")
        (
          [
            #align(center)[#body]
            #if label != none [
              #align(center)[*（#letters.at(calc.min(i, letters.len() - 1))）#label*]
            ]
          ],
        )
      }),
  ),
  caption: caption,
)

// ═══ 折线助手（CeTZ 0.5.2 无 plot）═══
#let plotline(points, stroke: 1pt + black) = cetz.draw.line(..points, stroke: stroke)

// ═══ 图内公式编号助手（本文件全局关闭编号，此处备用）═══
#let unnumbered(body) = {
  set math.equation(numbering: none)
  body
}

#show: ilm.with(
  title: [数学与 CS 问答记录],
  authors: ("answer-note",),
  date: datetime(year: 2026, month: 10, day: 16),
  abstract: [按日归档的问答记录：每个独立问题一个一级标题（=），子问题用（== / ===）；三问反思法（关键点/变式/同类归类）+ 讲课叙事流 + 判断框，结构与课程笔记同构。本日主题：问题 140 · 标量线积分的几何理解与参数化（lec-04 笔记节选）；问题 141 · 参数化定义里的符号与维度辨析（$S$、$R$ vs $RR$、单位正方形）；问题 142 · 三维球坐标 $theta$、$phi$ 几何图示（CeTZ 重绘·数学约定版）（上一条为 10-15 的问题 139 · 为什么单位圆被视为"一维单位球面"（$S^n$ 的下标 = 内蕴维数，已五模块完整收口）；本日问答自问题 140 起逐条追加。仍未收口的是 10-08 的问题 134 · 半球面平均距离（仍在"引导轮"状态）与 10-14 的问题 136 第 1 卷 · 线积分六道回忆题待答）],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

// 关闭 ilm 模板默认的公式自动编号 (1),(2),……
#set math.equation(numbering: none)

= 📌 本日起点

新的一天，档案已按 answer-note 规范建好：今日所有问答按 `= 主题` 追加在本节之后，一条问答一个一级标题（本日编号自 *问题 140* 起）。

#importantbox[
  *上一次记录（10-15）* 见 `note/2026-10-15.typ`——那一日有*一条*记录：

  #booktabs-table(
    columns: (1fr, 2.6fr, 2.6fr),
    table.header([*编号*], [*主题*], [*状态*]),
    [问题 139],
    [为什么单位圆被视为"一维单位球面"——$S^n$ 的下标数的是*内蕴维数*，不是它被摆放的空间维数],
    [*已收口*：直接解答（三条判据：参数个数 $slash$ 约束方程数 $slash$ 局部形状）$+$ 关键点 $+$ 变式检验 $+$ 同类归类 $+$ 易错点；顺带辨析 sphere/ball，接通问题 134 的根源],
  )
]

#warningbox[
  *待办清单（更新于 10-16，承接 10-15）*：

  #enum(
    numbering: "1.",
    [*问题 136 的第 1 卷*——线积分复习的六道回忆题，随时可答；答完进入批改环节（10-15 未作答，仍挂起）],
    [*问题 134 的引导尚未收口*——等读者回答三层入口（$H$ 是曲面还是实体？$abs(O P)$ 在 $H$ 上取哪些值？被平均量 $f$ 是什么？）并给出选择题选项截图，随后补齐五模块],
    [格林公式的*补线法*——仍未展开（考研高频技巧：边界不闭合时补线，再套格林公式）],
    [考纲第八章「常微分方程」在工作区*仍无*对应笔记材料（张宇 30 讲含此章，可作主材）],
    [18.02.3x 的*符号就地注释*：目前只覆盖 `lec01` 样板段——读到卡壳处随时报位置，按同一模式补（问题 139 正是"即时报卡壳"模式的一次实例）],
  )
]

// ══════════════════════════════════════════════════════════════════════
// 本日问答自下方开始追加：一条问答一个一级标题（= 主题）

= 🧵 问题 140：标量线积分的几何理解与参数化（笔记节选）

读者要求：把笔记中「几何理解」与「参数化」两部分节选整理进日期文件——不必全文照录，挑关键。#footnote[来源：`~/note/2026/18.02.2x/lec-04/line-integrals.typ` 材料 1（"一个哲学"四步模板）、材料 2（弧长与斜边）、材料 5（定义、$dif s$、铁丝密度、计算式）、材料 10（参数化无关性）节选；几何直观综合本工作区 `note/2026-09-28.typ` 问题 114（铁丝与密度）、问题 115（把曲线抬到 3D 的"窗帘"）。]

== 一、几何理解：$integral_C f dif s$ 在做什么

=== 一句话：把"函数值 $times$ 弧长"沿曲线累加

#importantbox[
  *标量线积分（scalar line integral）= 沿一条曲线，把"函数值 $times$ 小段弧长"累加起来*。记号本身就写着一个算法：

  $ integral_C f(x, y) dif s $

  - $f(x, y)$：曲线上的*函数值*——$f$ 是*标量函数*（一个数），不是向量场（本条只讲这一类，即*第一类*线积分）；
  - $dif s$：曲线切成的小段的*长度*（小弧长）；
  - *读法（切 — 算 — 加 — 取极限）*：把 $C$ 切成短弧；每段算 $f dot "arc length"$，其中 $(x, y)$ 是*该弧所在位置*；全部相加；弧长趋于零时和式的极限就是积分。
]

=== 核心图像：$C$ 是一根铁丝，$f$ 是密度

#importantbox[
  设 $C$ 是一根铁丝，$f(x, y)$ 是点 $(x, y)$ 处的*线密度（line density）*，那么

  $ integral_C f(x, y) dif s = "铁丝的总质量" $

  符号表：

  - $f(x, y)$：线密度（kg/m），*只在曲线上的点处取值*，不是平面上的任意点；
  - $dif s$：小段弧长（m）；
  - 两者相乘得这一小段的质量（kg），积分号把全部小段的质量加起来。

  *量纲检查模板*：$"k g\/m" times "m" = "k g"$——任何线积分都可以先用"单位相乘"判断结果的物理意义。
]

=== 几何化身：把曲线抬到 3D 的"窗帘"

#figure(
  cetz.canvas(length: 2.6cm, {
    import cetz.draw: *
    let g = x => 0.35 * x * x
    let f = x => 0.75 * x
    // 帘布：从底曲线竖直立起的布条
    for i in range(0, 11) {
      let x = i / 10
      line((x, g(x)), (x, g(x) + f(x)), stroke: 0.35pt + luma(165))
    }
    // 顶边：把曲线每点抬到 z = f 之后连成的线
    let pts-top = range(0, 41).map(i => { let x = i / 40; (x, g(x) + f(x)) })
    line(..pts-top, stroke: (paint: rgb("#d06a2f"), thickness: 0.9pt, dash: "dashed"))
    // 底曲线 C
    let pts-base = range(0, 41).map(i => { let x = i / 40; (x, g(x)) })
    line(..pts-base, stroke: (paint: rgb("#2f6fd0"), thickness: 1.4pt))
    // 一根代表竖条：帘布的高度 f
    line((0.55, g(0.55)), (0.55, g(0.55) + f(0.55)), stroke: (paint: rgb("#d64541"), thickness: 1.1pt), mark: (end: "stealth"))
    // 标注
    content((0.24, g(0.24) - 0.09), [曲线 $C$], anchor: "north")
    content((0.60, 0.30), [高度 $f(x, y)$], anchor: "west")
    content((0.5, -0.45), [$"窗帘面积" = integral_C f dif s$], anchor: "center")
  }),
  caption: [
    *把曲线抬到 3D 的"窗帘"示意*（CeTZ 自绘示意）：底曲线是 $C$，每个点竖起的高度是 $f(x, y)$，扫出的帘幕面积就是 $integral_C f dif s$——这正是定义里 $sum f Delta s$ 的几何化身。
    #footnote[来源：直观解释见 `note/2026-09-28.typ` 问题 115（"把曲线抬到 3D"）；定义依据 lec-04 材料 5。]
  ],
)

把它与定义式对照：*每根竖条贡献"高度 $times$ 小段弧长"，全部加起来就是帘幕（fence）面积*。同一个积分有两张面孔——材料从"质量"角度讲，这里从"几何"角度想。

#warningbox[
  *它不同于"曲线下的面积"*：单变量积分 $integral_a^b f dif x$ 是*平面区域面积*；线积分的"底"是*曲线*、$f$ 沿曲线取值、可正可负，所以结果是*带符号的累加*——可以为负。准确对照：线段加高度得平面面积；*曲线加高度得空间窗帘*。
]

== 二、参数化：怎么把它算出来

=== $dif s$ 的本质：小直角三角形的斜边

#importantbox[
  把每一小段弧*近似成一条直线*——宽 $dif x$、高 $dif y$ 的小直角三角形的*斜边*：

  $ dif s = sqrt((dif x)^2 + (dif y)^2) $

  符号表：

  - $dif x$、$dif y$：这一小段的横向、纵向位移；
  - $dif s$：斜边，即这一小段弧的长度。

  *"line integral" 名字的来历*就是这条斜边：小弧用直线（line）逼近。材料坦承这是误称——*path integral（路径积分）或 curve integral（曲线积分）* 更贴切。
]

=== 公式：化成单变量定积分

#importantbox[
  设 $C$ 由 $(x(t), y(t))$ *参数化（parametrization）*，$t$ 从 $a$ 走到 $b$，则

  $ integral_C f(x, y) dif s = integral_a^b f(x(t), y(t)) sqrt(x'(t)^2 + y'(t)^2) dif t $

  符号表：

  - $f(x(t), y(t))$：把函数值改写成 $t$ 的函数（在曲线上的点处取样）；
  - $sqrt(x'(t)^2 + y'(t)^2)$：*速度大小*——"每走一个 $dif t$，弧长增加多少"，即 $dif s$ 对 $dif t$ 的换算率；
  - $a$、$b$：参数区间两端，*由参数化决定，不由曲线端点坐标决定*。

  *两个因子各管一件事*：$f$ 管*被积函数*，$sqrt(x'^2 + y'^2)$ 管*弧长权重*。这就是线积分"可以算"的全部秘密——抽象对象变成了普通一元定积分。
]

=== 结果与参数化无关

#importantbox[
  材料 10 的 Remark：*记号里没有端点*——$integral_C f dif s$ 里的 $C$ 指*那一条曲线*，不是*某一种走法*；$C$ 的任意参数化都给出同一个答案。
]

#booktabs-table(
  columns: (1.1fr, 0.9fr, 3fr),
  table.header([*改动*], [*结果*], [*为什么*]),
  [反向走], [*不变号*], [$dif s$ 是*长度*（恒正），$f$ 在曲线上的取值与走向无关],
  [改变速度], [*不影响*], [$abs(arrow(r)'(t)) dif t$ 这个组合不变——速度变大时 $dif t$ 相应变小，恰好抵消],
  [改变曲线], [*有时会变*], [例：同起终点的三段曲线，$integral_C x y dif s$ 分别为 $1 \/ 2$、$sqrt(2) \/ 6$、$0$],
)

#knowledgebox[
  *一个可算的见证*（材料 10 原题）：$C$ 取连接 $(1, 0)$ 与 $(0, 1)$ 的单位圆四分之一弧，则 $integral_C y dif s$ 在三种参数化下都等于 $1$：

  - $(cos t, sin t)$、$0 <= t <= pi \/ 2$：$dif s = dif t$，$integral_0^(pi \/ 2) sin t dif t = 1$；
  - $(sin t, cos t)$、$0 <= t <= pi \/ 2$：*反向*走同一段弧，$dif s = dif t$，$integral_0^(pi \/ 2) cos t dif t = 1$；
  - $(t, sqrt(1 - t^2))$、$0 <= t <= 1$：*变速*走，$dif s = dif t \/ sqrt(1 - t^2)$，与 $y = sqrt(1 - t^2)$ 相乘后*根号恰好抵消*，$integral_0^1 dif t = 1$。
]

=== 参数化技巧（材料 2 节选）

#knowledgebox[
  - *显函数曲线最省事*：形如 $y = g(x)$ 的曲线，直接令 $x = t$，$(t, g(t))$ 就是现成的参数化；
  - *参数区间由起终点反推*：代入起点、终点各得一个 $t$ 值；范围必须让曲线*恰好走一遍*（不能多走、不能少走）；
  - 例：$y = x^2$ 从 $(0, 0)$ 到 $(2, 4)$，取 $(t, t^2)$，$0 <= t <= 2$。
]

== 关键点

#importantbox[
  *几何理解给意义，参数化给算法，无关性给合法性*：几何图像回答"它在做什么"（沿曲线加权累加——质量、窗帘面积）；参数化回答"怎么算"（化为一元定积分）；"结果与参数化无关"保证两者指向*同一个数*——几何对象与计算结果不脱节。
]

== 变式检验

#enum(
  numbering: "1.",
  [*三维版*：$C$ 换成空间曲线，$dif s = sqrt(x'^2 + y'^2 + z'^2) dif t$——只多一个平方项，*右边仍是一元定积分*（材料 5 的 Spoiler）。],
  [*常数密度 $f = k$*：$integral_C k dif s = k L$（$L$ 为曲线总弧长）——线积分退化为"数乘弧长"，可用它反查公式是否写对。],
  [*换一个被积函数*：同为四分之一圆弧，把 $y$ 换成 $x$，由对称性 $integral_C x dif s$ 也等于 $1$——两种算法可互查。],
)

== 同类归类

- 与 *本工作区问题 114、115（`note/2026-09-28.typ`）*：那两条是"直观整理"，本条是"节选归档"——几何（铁丝、窗帘）与参数化（公式、无关性）两条轴各取要点；
- 与 *单变量积分、二重积分*（微元法谱系；本工作区问题 89、92 也在梳理这条脉络）：同一套"切 — 算 — 加 — 取极限"模板，"底"从线段变成曲线、区域；
- 与 *向量线积分*（问题 116、lec-06）：把 $dif s$ 换成 $dif arrow(r)$ 后，"反向变号"与"路径无关性"都会变样——两类不能混；
- 与 *材料 8 的平均值与质心、材料 9 的扫雪车*：同一公式的应用（加权平均；雪深 $times$ 弧长得体积），见 lec-04 对应节。

== 易错点

#warningbox[
  #enum(
    numbering: "1.",
    [*漏掉弧长权重*：把 $f(x(t), y(t)) dif t$ 直接当线积分——忘了乘 $sqrt(x'(t)^2 + y'(t)^2)$；],
    [*忘记替换*：留着 $x y$ 对 $t$ 积分——被积函数根本没在曲线上取值；],
    [*用错参数区间*：区间由*参数化*决定——$(t^2, t^4)$ 走完抛物线时区间是 $[0, sqrt(2)]$，不是 $[0, 2]$；],
    [*把结果当"面积"*：$f$ 可正可负，线积分可为负；窗帘是*带符号*的帘幕，不等于永正的几何面积。],
  )
]

= 🧭 问题 141：$S$、$R$、$u v$ 平面与 $[0, 1] times [0, 1]$——参数化定义里的符号与维度辨析

读者问：lec01 笔记 4.1「A parametrization of a surface」里——$S$ 指的是 $RR^3$ 中的球吗？$R$ 是一维空间吗？$u v$ 作为一个平面不应该是二维空间里的吗？unit square $[0, 1] times [0, 1]$ 是什么意思？这和叉乘有什么关系吗？#footnote[来源：`~/note/2026/18.02.3x/lec01/notes.typ` 第 4 节 4.1「定义本身」（材料第 3 页 Definition (3.24) 与例 4）；辨析按集合记号约定与材料原句整理。]

== 直接解答

=== 一、$S$：泛指"被参数化的曲面"，不是"球"

定义写的是 $S subset.eq RR^3$——*$S$ 是三维空间中任意一张被参数化的曲面*，只是个占位字母（球面、柱面、环面、抛物面都可以是 $S$）。例 4 里的球面只是 *$S$ 取"二维单位球面"时的特例*，那时映射写作 $arrow(r): R -> S^2$：

$ S^2 = {(x, y, z) in RR^3 | x^2 + y^2 + z^2 = 1} $

- $S$ 与 $S^2$：前者泛指、后者特指——"$S$ 是球"只在例 4 的语境里成立；
- 另外注意：参数化的对象是*球面*（壳，2 维），不是实心球体（$B^3$，3 维）。

=== 二、$R$ 不是 $RR$：字母撞脸的两个人

这是本条的核心：定义里两个"长得像"的符号毫无关系——

#booktabs-table(
  columns: (1.4fr, 2.5fr, 1.5fr),
  table.header([*符号*], [*是什么*], [*维数*]),
  [$RR$（黑板粗体 R）], [*实数集*——全部实数排成的一条数轴], [1（即 $RR^1$）],
  [$R$（普通斜体 R）], [*区域（region）*——$u v$ 平面上的一个子集，$R subset.eq RR^2$], [2],
)

"$R$ 是一维空间"的说法来自把 $R$ 读成了 $RR$。$R$ 只是给"参数定义域"起的一个名字（region 的首字母）——改叫 $D$、$Omega$ 都行，它是*二维平面里的一块*。

#importantbox[
  一句话区分：*$RR$ 是数轴（一维）；$R$ 是平面上的一块（二维）*。定义 $arrow(r): R -> S$ 读作"从平面区域 $R$，铺到曲面 $S$"——*两端都是二维对象*，参数化不升维、不降维。

  材料还特别声明：$R$ 不必是整个 $u v$ 平面——"The plane sheet does not need to be the entirety of the $u v$ plane, it can be any subset $R$."
]

=== 三、$u v$ 平面确实在二维空间里——你说得对

$u v$ 平面（几何上和 $x y$ 平面没有区别）就是 $RR^2$，二维 ✓。这正是"曲面需要*两个*参数"的原因：用二维的一块参数空间去"铺"二维的曲面。维度账：

#booktabs-table(
  columns: (1.1fr, 2.2fr, 1.1fr, 1.7fr),
  table.header([*对象*], [*身分*], [*自身维数*], [*住在哪*]),
  [$S$], [被参数化的曲面（如 $S^2$）], [2], [$RR^3$],
  [$R$], [参数定义域（一块区域）], [2], [$RR^2$（$u v$ 平面）],
  [$(u, v)$], [一对参数——$R$ 中的一个点], [—], [—],
  [$arrow(r)$], [把参数点送到曲面点的映射], [—], [$R -> S$],
)

=== 四、unit square $[0, 1] times [0, 1]$：笛卡尔积

*"unit square"（单位正方形）就是 $[0, 1] times [0, 1]$*，这里的 $times$ 是*笛卡尔积（Cartesian product）*：

$ [0, 1] times [0, 1] = {(u, v) | 0 <= u <= 1, 0 <= v <= 1} $

读法："从第一个区间取 $u$、从第二个区间取 $v$，*所有*组合"——几何上就是一个边长 $1$、左下角在原点、右上角在 $(1, 1)$ 的正方形。它是参数化最常用的定义域（材料原话："Very often we use the unit square"）。

=== 五、这个 $times$ 与叉乘无关

$times$ 在小衫数学里至少两义，区分看"两侧是谁"：

#booktabs-table(
  columns: (1.6fr, 1.7fr, 2.3fr),
  table.header([*写法*], [*名字*], [*两侧是谁*]),
  [$[0, 1] times [0, 1]$], [笛卡尔积（集合的积）], [两侧是*集合*（区间）→ 产出"点集"（点对的全集）],
  [$arrow(a) times arrow(b)$], [向量叉积（cross product）], [两侧是*向量*→ 产出"向量"（方向垂直于两者）],
)

本条里的 $[0, 1] times [0, 1]$ 是前者。叉积是本讲后文与 lec03 的主角（算面积微元用到 $norm(arrow(r)_u times arrow(r)_v)$）——*那是另一个语境*，与单位正方形只是"符号撞脸"。

== 关键点

#importantbox[
  四句总结：*①* $S$ = 泛指"被参数化的曲面"（例 4 中取 $S^2$，且指球面而非球体）；*②* $R$ ≠ $RR$——$R$ 是"平面上的一块区域"（二维），不是数轴；*③* $u v$ 平面 = $RR^2$ 的化身（二维）；参数化把二维参数区域铺到二维曲面上；*④* $[0, 1] times [0, 1]$ 的 $times$ 是笛卡尔积（把两个区间配成点对），与向量叉积无关。
]

== 变式检验

#enum(
  numbering: "1.",
  [*曲线版本*：目标是一维曲线 $C$ 时，定义怎么变？——参数定义域变成*一维*区间 $[a, b] subset.eq RR$，映射写作 $gamma: [a, b] -> C$。注意：*参数空间的维数 = 目标对象的维数*（曲线 1 对 1、曲面 2 对 2）——"定义域是一维的"这个说法只在曲线场景成立，正好是 $R$ 被误读为"一维"的源头。],
  [*环面的定义域*：$R = [0, 2 pi] times [0, 2 pi]$ 也是区域吗？——是。$R$ 可以是任何 $u v$ 平面子集（矩形、圆盘、正方形……），不限于单位正方形。],
  [*$R$ 换成整个平面*：抛物面取 $R = RR^2$ 时 $arrow(r)(x, y) = (x, y, x^2 + y^2)$ 描出整张抛物面；换成 $R = [0, 1]^2$ 只剩一小块——*同一个映射配不同的 $R$ 得到不同的曲面片*（lec01 4.1 的陷阱框原话）。],
)

== 同类归类

- 与 *「线积分回顾」的参数曲线*（$gamma: [a, b] -> C$）：同一套"参数空间 → 几何对象"模板，维数账完全平行；
- 与 *问题 139（单位圆为什么是一维单位球面）*：同一笔"维数账"——*数对象自己的自由度，不数它住的空间*：$S subset.eq RR^3$ 而自身 2 维；$R subset.eq RR^2$ 且自身 2 维；
- 与 *本讲后文*：$z = f(x, y)$ 型曲面的图像型参数化取 $R = $ 曲面在 $x y$ 平面上的*投影*——定义域 $R$ 的几何含义与"塑料片"图像完全一致。

== 易错点

#warningbox[
  #enum(
    numbering: "1.",
    [*把 $R$ 当 $RR$*：$R$ 是定义域的名字（region），$RR$ 是实数集——定义里两者同屏出现，务必分开读；],
    [*把 $times$ 一律读成叉积*：两侧是集合 → 笛卡尔积；两侧是向量 → 叉积。看邻居、不看符号；],
    [*把 $S$ 与 $S^2$ 混用*：$S$ 泛指、$S^2$ 特指；"$S$ 是球"只在例 4 的语境成立；],
    [*以为 $R$ 必须是整个平面或单位正方形*：$R$ 是任意的平面子集——选哪个 $R$ 直接决定铺出曲面片的哪一块。],
  )
]

= 🗺️ 问题 142：三维球坐标 $theta$、$phi$ 几何图示（CeTZ 重绘·数学约定版）

读者要求：把笔记中"将三维球坐标 $theta$、$phi$ 的关系一起展示"的图示找出来，记录到日期文件里。*重绘修正*：原图（材料 Figure 8 样式）把 $x y$ 平面内的角记作 $phi$（物理约定）；按一般惯例与本课程主约定，$x y$ 平面内的角应记作 $theta$——本条目收录的是按此修正后的重绘版。#footnote[说明：构图参照材料网页「Spherical Coordinates and Calculus」Figure 8「Position vector on a sphere」（lec02 笔记 `fig_03_spherical_coordinates_001.svg` 即该图的抠图，标注为物理约定样式）；重绘按数学约定修正标注：$x y$ 平面内的角记作 $theta$、从 $z$ 轴量的角记作 $phi$。]

== 图示（CeTZ 重绘）

#figure(
  cetz.canvas(length: 1.3cm, {
    import cetz.draw: *
    // ── 手工调校的伪 3D 坐标（解析计算后硬编码；P' 沿两轴的分解关系已校验）──
    let O = (3.0, 2.6)
    let R = 2.0
    let Xh = (-0.71, -0.70)   // x 轴方向（左下）
    let Yh = (0.99, -0.12)    // y 轴方向（右略下）
    let P = (3.55, 3.75)      // 位置向量端点（球面点，投影落在球内右上）
    let Pp = (3.42, 2.35)     // P 到 xy 平面的投影
    let A = (2.82, 2.42)      // P' 沿 y 方向到 x 轴的交点：Pp - A ∥ Yh
    let B = (3.60, 2.53)      // P' 沿 x 方向到 y 轴的交点：Pp - B ∥ Xh
    // 球体
    circle(O, radius: R, fill: luma(233), stroke: 0.7pt + luma(80))
    // 赤道（横向半轴 R、纵向半轴 0.62 的椭圆，左右极点与球轮廓相切）
    line(..range(0, 73).map(i => {
      let s = i / 72 * 2 * calc.pi
      (O.at(0) + R * calc.cos(s), O.at(1) + 0.62 * calc.sin(s))
    }), stroke: 0.5pt + luma(130))
    // 坐标轴（z / x / y，末端箭头）
    line(O, (O.at(0), O.at(1) + 2.9), stroke: 0.8pt, mark: (end: "stealth"))
    line(O, (O.at(0) + 2.9 * Xh.at(0), O.at(1) + 2.9 * Xh.at(1)), stroke: 0.8pt, mark: (end: "stealth"))
    line(O, (O.at(0) + 2.9 * Yh.at(0), O.at(1) + 2.9 * Yh.at(1)), stroke: 0.8pt, mark: (end: "stealth"))
    // 投影虚线：P→P'、P'→x 轴交点 A、P'→y 轴交点 B
    line(P, Pp, stroke: (paint: luma(110), thickness: 0.5pt, dash: "dashed"))
    line(A, Pp, stroke: (paint: luma(110), thickness: 0.5pt, dash: "dashed"))
    line(B, Pp, stroke: (paint: luma(110), thickness: 0.5pt, dash: "dashed"))
    // 位置向量 r（端点 P 处加实心点）
    line(O, P, stroke: 0.9pt, mark: (end: "stealth"))
    circle(P, radius: 0.05, fill: luma(40), stroke: none)
    // 极角弧 φ：从 z 轴方向到 r 方向（屏幕角度自 90° 线性内插到 64.4°，半径 0.62）
    line(..range(0, 8).map(i => {
      let a = 90deg + (64.4deg - 90deg) * i / 7
      (O.at(0) + 0.62 * calc.cos(a), O.at(1) + 0.62 * calc.sin(a))
    }), stroke: 0.55pt + luma(60))
    // 方位角弧 θ：赤道面内从 x 轴方向到 P' 方向（沿 X̂/Ŷ 参数化，半径 0.55，参数角 67°）
    line(..range(0, 9).map(i => {
      let s = 67deg * i / 8
      (O.at(0) + 0.55 * (calc.cos(s) * Xh.at(0) + calc.sin(s) * Yh.at(0)),
       O.at(1) + 0.55 * (calc.cos(s) * Xh.at(1) + calc.sin(s) * Yh.at(1)))
    }), stroke: 0.55pt + luma(60))
    // 标签（位置已避开线条）
    content((3.68, 3.82), [$P$])
    content((3.0, 5.64), [$z$])
    content((0.82, 0.42), [$x$])
    content((6.00, 2.22), [$y$])
    content((3.31, 3.30), [$phi$])
    content((2.80, 2.06), [$theta$])
  }),
  caption: [*球坐标的标准几何图*（CeTZ 重绘，按数学约定标注）：从原点指向球面上一点 $P$ 的位置向量 $arrow(r)$；$theta$ 在 $x y$ 平面内从 $x$ 轴量起（方位角）；$phi$ 从 $z$ 轴量起（天顶角）；虚线是 $P$ 到 $x y$ 平面的投影路径，并在两轴上作分解。],
)

== 图里的"关系"怎么读

按*数学约定*（本课程主约定，也是本图的标注方式）：

- $arrow(r)$ —— 原点到球面上 $P$ 点的位置向量，长度 $r$；
- $theta$（方位角，azimuth）—— 把 $arrow(r)$ 投影到 $x y$ 平面后，从 $x$ 轴量到投影的夹角，只决定"绕 $z$ 轴转了多少"；
- $phi$（天顶角，zenith angle）—— $z$ 轴与 $arrow(r)$ 的夹角，只决定"离北极多远"（高度）。

两者*联合*才能锁定一个方向，换算公式（数学约定）：

$ x = r cos(theta) sin(phi), quad y = r sin(theta) sin(phi), quad z = r cos(phi) $

符号表：

- $r$ —— 到原点的距离，$r >= 0$；
- $theta$ —— 方位角（绕赤道量），$0 <= theta < 2 pi$；
- $phi$ —— 天顶角（与北极的夹角），$0 <= phi <= pi$。

*结构记忆*：$z$ 分量只含 $phi$（$z = r cos phi$）——绕竖直轴旋转不改变高度；$x, y$ 里先有"纬圈半径" $r sin(phi)$，再乘方向 $(cos theta, sin theta)$。

== 关键点

#importantbox[
  两句话：*①* 两条角的分工是"*一竖一横*"——$phi$ 从 $z$ 轴量（定高度、定纬圈），$theta$ 在赤道面里量（定经度、定方位）；*②* 本图按*数学约定*标注（$x y$ 平面内是 $theta$）——这是本课程（MITx 18.02.3x）多数内容与北美主流教材的惯例。注意*物理 / ISO 约定*（Wikipedia、多数物理工程教材）把两者对调：那里 $x y$ 平面内是 $phi$、$z$ 轴角是 $theta$——遇到物理约定的材料，把图中两个字母互换即可。
]

== 同类归类

- 与 *lec02「球坐标：两套约定的战争」*：那里有物/数两套约定的对照表与四道约定练习题——判断口诀：*天顶角叫 $phi$ = 数学约定；天顶角叫 $theta$ = 物理约定*；
- 与 *lec01 的球面角度参数化（$(u, v)$：$u$ 方位角、$v$ 天顶角）*：同一个几何——数学约定下 $u$ 对应 $theta$、$v$ 对应 $phi$；
- 与 *柱坐标 $(r, theta, z)$*：柱坐标的 $theta$（赤道面内绕 $z$ 轴量角）与球坐标的 $theta$（数学约定）是同一个角色。

== 易错点

#warningbox[
  #enum(
    numbering: "1.",
    [*把两套约定的 $theta$、$phi$ 混用*：先看 $z$ 分量——$z = r cos phi$ 是数学约定、$z = r cos theta$ 是物理约定；],
    [*把 $theta$ 当成"离北极的距离"*：$theta$ 在赤道面内量（图中下方的小角），与高度无关；],
    [*忘掉 $sin(phi)$ 因子*：$x, y$ 的半径是 $r sin(phi)$（纬圈半径），不是 $r$——越靠北纬圈越小。],
  )
]
// ══════════════════════════════════════════════════════════════════════
