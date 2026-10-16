// ═══════════════════════════════════════════════════════════════
// answer-note · 按日归档问答记录
// 结构：每个独立问题 = 一个一级标题（=），子问题用（== / ===）
// 轨道：数学轨（18.02.3x 球面记号：S^n 的维数含义）
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
  date: datetime(year: 2026, month: 10, day: 15),
  abstract: [按日归档的问答记录：每个独立问题一个一级标题（=），子问题用（== / ===）；三问反思法（关键点/变式/同类归类）+ 讲课叙事流 + 判断框，结构与课程笔记同构。本日主题：待记录（上一条为 10-14 的问题 136 · 线积分 90 分钟复习开场（第 1 卷待答）、137 · 18.02.3x 全 12 讲顺序检查与修正、138 · 笔记可读性改造（材料地图 + 渲染修复）；本日问答自问题 139 起逐条追加。仍未收口的是 10-08 的问题 134 · 半球面平均距离与 10-14 的问题 136 第 1 卷）],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

// 关闭 ilm 模板默认的公式自动编号 (1),(2),……
#set math.equation(numbering: none)

= 📌 本日起点

新的一天，档案已按 answer-note 规范建好：今日所有问答按 `= 主题` 追加在本节之后，一条问答一个一级标题（本日编号自 *问题 139* 起）。

#importantbox[
  *上一次记录（10-14）* 见 `note/2026-10-14.typ`——那一日有*三条*记录：

  #booktabs-table(
    columns: (1fr, 2.6fr, 2.6fr),
    table.header([*编号*], [*主题*], [*状态*]),
    [问题 136],
    [线积分 90 分钟回忆复习（回忆式考试）——第 1 卷「全景地图」已出卷],
    [*等读者作答*：6 小题（术语清单 $slash$ 两支分家 $slash$ 四种写法 $slash$ 三根台柱 $slash$ 等价链 $slash$ 自评）],
    [问题 137],
    [18.02.3x 全 12 讲笔记「节顺序 vs 材料顺序」检查],
    [*已收口*：8 处修正 $+$ `lec07` 补写例 21，全部编译验证],
    [问题 138],
    [18.02.3x 笔记可读性改造（材料地图 $+$ 渲染修复）],
    [*已收口*：12 讲材料地图 $+$ 数学字体修复；符号注释留待续],
  )
]

#warningbox[
  *待办清单（更新于 10-15，承接 10-14）*：

  #enum(
    numbering: "1.",
    [*问题 136 的第 1 卷*——线积分复习的六道回忆题，随时可答；答完进入批改环节],
    [*问题 134 的引导尚未收口*——等读者回答三层入口（$H$ 是曲面还是实体？$abs(O P)$ 在 $H$ 上取哪些值？被平均量 $f$ 是什么？）并给出选择题选项截图，随后补齐五模块],
    [格林公式的*补线法*——仍未展开（考研高频技巧：边界不闭合时补线，再套格林公式）],
    [考纲第八章「常微分方程」在工作区*仍无*对应笔记材料（张宇 30 讲含此章，可作主材）],
    [18.02.3x 的*符号就地注释*：目前只覆盖 `lec01` 样板段——读到卡壳处随时报位置，按同一模式补（或在后续日期文件中逐讲深挖）],
  )
]

// ══════════════════════════════════════════════════════════════════════
// 本日问答自下方开始追加：一条问答一个一级标题（= 主题）
// ══════════════════════════════════════════════════════════════════════

= 🔵 问题 139：为什么单位圆被视为"一维单位球面"？

读者问：为什么单位圆被视为一维单位球面？#footnote[来源：承接 `~/note/2026/18.02.3x/lec01/notes.typ` 的「参数化的定义」节（$S^2$ 记号首现于例 4）与 `lec02` 的球坐标两节；与本工作区问题 134 的 `sphere`/`ball` 之辨同源。]

== 直接解答：维数数的是"它自己"，不是"它住的空间"

#importantbox[
  一句话：*$S^n$ 的下标 $n$ 是曲面自身的维数（内蕴维数）——在它上面定位一个点需要几个独立参数；而不是它被摆放在几维空间里。*

  单位圆上定位一点只需*一个*参数（角度 $t$），所以它是*一维*球面 $S^1$；单位球面上定位一点需要*两个*参数（两个角），所以是*二维*球面 $S^2$。
]

三条判据，条条给出"1"：

#enum(
  numbering: "1.",
  [*参数个数*：$(x(t), y(t)) = (cos(t), sin(t))$ 里只有 $t$ 一个自变量。对照单位球面：$arrow(r)(u, v) = (sin v cos u, sin v sin u, cos v)$ 要 $u, v$ 两个（`lec01` 例 4）。],
  [*约束方程数*：在 $RR^2$ 里，一个方程 $x^2 + y^2 = 1$ 从两个坐标中"锁掉"一个自由度，剩 $2 - 1 = 1$ 维。对照球面：$RR^3$ 里一个方程 $norm(x) = 1$，剩 $3 - 1 = 2$ 维。],
  [*局部形状*：圆上每一小段拉直了都像一段*线段*（1 维）；球面上每一小块摊平了都像一张*平面片*（2 维）。"局部像几维的平直空间"正是流形维数的定义。],
)

*一般记号*：$S^n$ 是 $RR^(n+1)$ 中到原点距离恰好为 $1$ 的所有点：

$
S^n = {x in RR^(n+1) : norm(x) = 1}
$

符号表：

- $n$ —— *球面自身的维数*（它内部需要的参数个数）；
- $n + 1$ —— *环境空间*的维数（球面被嵌入的空间）：$S^1$ 住在 $RR^2$、$S^2$ 住在 $RR^3$、$S^0$ 住在 $RR^1$；
- 于是"球面维数"总比"所在空间维数"少 $1$——这与"$n+1$ 个坐标减去 $1$ 个约束"是同一条账。

== 顺带辨析：sphere 与 ball（球面 vs 球体）

#knowledgebox[
  这是问题 134 里"$H$ 是曲面还是实体"之辨的根源：*球面（sphere）$S^n$ 只有壳，球体（ball）$B^(n+1)$ 是实心的*。$S^1$ 的实心版是*圆盘*（2 维，记 $D^2$ 或 $B^2$）；$S^2$ 的实心版是*球体*（3 维，记 $B^3$）。维数上正好差一：球面是球体的*边界*。
]

#booktabs-table(
  columns: (1.2fr, 1fr, 1.2fr, 1.6fr),
  table.header([*对象*], [*记号*], [*自身的维数*], [*住在哪*]),
  [两个点 $-1, +1$], [$S^0$], [$0$], [$RR^1$（一条直线）],
  [单位圆], [$S^1$], [$1$], [$RR^2$（一张平面）],
  [单位球面], [$S^2$], [$2$], [$RR^3$（三维空间）],
  [（对照）单位圆盘], [$D^2$], [$2$], [$RR^2$],
  [（对照）单位球体], [$B^3$], [$3$], [$RR^3$],
)

== 关键点

#importantbox[
  *"第几维"永远问它自己，不问它住哪*：$S^1$ 与圆盘 $D^2$ 都躺在平面里，但一个 1 维、一个 2 维；$S^2$ 与球体 $B^3$ 都在三维空间里，一个 2 维、一个 3 维。判据只有一条——*独立参数（自由度）有几个*。这也正是 `lec01` 把"曲面用两个参数、曲线用一个参数"当作本质区别的原因。
]

== 变式检验

#enum(
  numbering: "1.",
  [*$S^0$ 是什么？* $RR^1$ 里满足 $abs(x) = 1$ 的点只有 $-1$ 与 $+1$——*两个点*，定位它们一个参数都不需要，所以 $0$ 维。这是记号链条的最低一档。],
  [*$S^3$ 是什么？* 它是 $RR^4$（四维空间）里的单位球面，自身*三维*——单位四元数与 $"SU"(2)$ 都与它同胚。所以听到"三维球面"时先问：说的是 $S^3$，还是"三维空间里的球面"（=$S^2$）？],
  [*圆环面 $T^2 = S^1 times S^1$ 几维？* 两个各自 1 维的对象做乘积，维数相加：$1 + 1 = 2$（经度一个参数、纬度一个参数——正好也是 `lec01` 环面例子的 $u, v$）。],
  [*球体 $B^3$ 的表面是几维？* 是 $S^2$，2 维——"取边界"把维数减一，与"$n+1$ 个坐标减 $1$ 个约束"是同一回事。],
)

== 同类归类

- 与 *`lec01` 例 4（球面的角度参数化）*：那里写的 $arrow(r): R -> S^2$，$R = [0, 2 pi] times [0, pi]$——参数平面是 2 维、球面也是 2 维，*参数个数与目标维数同为 2* 不是巧合，而是参数化的要求；
- 与 *`lec02` 的球坐标*：$theta, phi$ 两个角 = 两个自由度 = $S^2$ 的内部坐标；
- 与 *问题 134（半球面平均距离）的 `sphere`/`ball` 之辨*：本题是那处混乱的总根源——"半球面"是 $S^2$ 的上半片（2 维曲面），"半球体"才是 $B^3$ 的上半块（3 维实体）；
- 与 *`lec09` 的单连通*：$S^1$ *不是*单连通的（它自己就是一个"洞"），而 $S^n$（$n >= 2$）都单连通——这正是"$RR^2$ 挖掉原点"（绕 $S^1$）与"$RR^3$ 挖掉原点"（绕 $S^2$）上保守场判据不同的几何原因；
- 与 *`lec07`/`lec10` 的环量与电势*：绕原点圆上的环量 $integral.cont_C arrow(F) dot dif arrow(r) = 2 pi != 0$（旋转场），对照球面上无旋场的任意闭路环量为零——同一笔维数账的两种后果。

== 易错点

#warningbox[
  #enum(
    numbering: "1.",
    [*把"三维空间里的球面"说成"三维球面"*：严格记号里"三维球面"是 $S^3$（住在四维空间）。想说 $S^2$ 时，规范表述是"*三维空间中的二维球面*"或直接"球面 $S^2$"——`lec01`–`lec03` 的笔记只用 $S^2$ 记号，避免歧义。],
    [*把球面维数当成球体维数*：$S^1$ 是 1 维，但它的实心版圆盘 $D^2$ 是 2 维；把"圆"叫"2 维对象"就属于这类混乱。],
    [*以为维数由"几个坐标字母"决定*：球面公式里明明写着 $x, y, z$ 三个字母——但在球面*上*它们被一个方程绑住，真正自由的只有两个。*数坐标是数环境，数自由度才是数维数。*],
  )
]
