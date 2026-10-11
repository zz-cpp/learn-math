// ═══════════════════════════════════════════════════════════════
// math-answer-note · 按日归档问答记录
// 结构：每个独立问题 = 一个一级标题（=），子问题用（== / ===）
// 轨道：待定（按当日首条问答判断：数学轨 / CS 轨）
// 规范：math-answer-note 新版（无 practicebox/无 dia-scale；三色判断框
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
  authors: ("math-answer-note",),
  date: datetime(year: 2026, month: 10, day: 8),
  abstract: [按日归档的问答记录：每个独立问题一个一级标题（=），子问题用（== / ===）；三问反思法（关键点/变式/同类归类）+ 讲课叙事流 + 判断框，结构与课程笔记同构。本日主题：待记录（上一条为 10-07 的问题 133 · 经线 = 半大圆；本日问答自问题 134 起逐条追加）。],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

// 关闭 ilm 模板默认的公式自动编号 (1),(2),……
#set math.equation(numbering: none)

= 📌 本日起点

新的一天，档案已按 math-answer-note 规范建好：今日所有问答按 `= 主题` 追加在本节之后，一条问答一个一级标题（本日编号自 *问题 134* 起）。

#importantbox[
  *上一次记录（10-07）* 见 `note/2026-10-07.typ`——那一日只有一条问答（问题 133，配一张 CeTZ 双子图）：

  #booktabs-table(
    columns: (1fr, 3fr, 2.6fr),
    table.header([*编号*], [*主题*], [*结论一句话*]),
    [问题 133],
    [为什么"第 10 条经线"的长度是 $pi R$ 而不是 $2 pi R$（MIT 18.02 网页「Check your understanding 1」；与 `18.02.3x/lec02/notes.typ` 的「习题课一：球面的面积微元」是同一份材料的相邻两问）],
    [经线只从北极走到南极，是*半个大圆* $->$ $pi R$；$2 pi R$ 属于完整大圆（赤道，或第 10 条 $+$ 第 190 条经线拼成的整条子午圈）；纬线是完整*小*圆，故第 45 条纬线 $= 2 pi R cos 45 degree approx 2.666 times 10^4$ km——低纬度上纬线反而比经线长],
  )
]

#warningbox[
  *待办清单（更新于 10-08，承接 10-07）*：

  #enum(
    numbering: "1.",
    [格林公式的*补线法*——仍未展开（考研高频技巧：边界不闭合时补线，再套格林公式）],
    [考纲第八章「常微分方程」在工作区*仍无*对应笔记材料（张宇 30 讲含此章，可作主材）],
  )
]

// ══════════════════════════════════════════════════════════════════════
// 问题 134：单位半球面上各点到原点的"平均距离"（引导轮 · 解答待补全）
// ══════════════════════════════════════════════════════════════════════

= 🧭 问题 134：$H$ 上的点到原点的"平均距离"（引导轮 · 解答待补全）

#importantbox[
  *本条为"引导轮"*：用户表示"不太能理解这个问题，目前没有什么切入点"，故先落盘*题干照录* $+$ *引导脚手架*，暂不写结论；待用户作答后补齐 `== 直接解答 / == 关键点 / == 变式检验 / == 同类归类 / == 易错点` 五模块。
]

== 题干（照录）

原题开头有一句预设：*"In the next few problems, you will use spherical coordinates to solve the following problem."*

$S$ 是半径 $1$、球心在原点的*球面（sphere）*；$H$ 是 $S$ 的 upper half portion（$z > 0$）。求 $H$ 上的点到原点的*平均距离（average distance）*。第一小问：下列哪个式子给出所求的距离？

#footnote[来源：MIT 18.02 网页「Distance 1」（球坐标单元习题，与问题 133 同一材料）。]

== 引导脚手架（三层入口 $+$ 两个对照）

#enum(
  numbering: "1.",
  [*辨对象（最关键）*：$H$ 是*曲面片*还是*实心块*？英文 `sphere`（球面，$x^2 + y^2 + z^2 = R^2$）与 `ball`（球体，$x^2 + y^2 + z^2 <= R^2$）不是同一个对象；题干写的是 "upper half portion of $S$"。],
  [*写定义式*：$S = \{ (x,y,z) : x^2 + y^2 + z^2 = 1 \}$；任取 $P = (x,y,z) in H$，展开 $abs(O P)^2 = x^2 + y^2 + z^2$，看它在 $H$ 上*可以取哪些值*。],
  [*写"平均"的形式*：面积平均 $"average" = (1 \/ "Area"(H)) integral_H f dif A$；被平均量 $f$ 就是"点到原点的距离"，把第 2 步的结果代进 $f$，再看这个积分还剩什么可算。],
  [*对照一（实心版）*：把 $H$ 换成上半球体（$z > 0$ 且 $x^2 + y^2 + z^2 <= 1$），第 2 步的取值集合还退化成一个数吗？——这决定了要不要真做三重积分。],
  [*对照二（换轴版）*：若改问"$H$ 上的点到 $z$ 轴的平均距离"，被平均量变成 $sqrt(x^2 + y^2)$，这时才是*非平凡*的球面积分——$dif A = sin phi dif phi dif theta$ 与 $phi in [0, pi \/ 2]$ 在这里才真正派上用场。],
)

== 待补全

- 用户作答：*待填写*（三层入口的答案 $+$ 选择题选项内容）；
- 完整解答（五模块）：*待补全*；补全时本条目标题去掉"引导轮"字样。
