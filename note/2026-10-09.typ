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
  date: datetime(year: 2026, month: 10, day: 9),
  abstract: [按日归档的问答记录：每个独立问题一个一级标题（=），子问题用（== / ===）；三问反思法（关键点/变式/同类归类）+ 讲课叙事流 + 判断框，结构与课程笔记同构。本日主题：待记录（上一条为 10-08 的问题 134 · 半球面平均距离，仍在"引导轮"状态未收口；本日问答自问题 135 起逐条追加）。],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

// 关闭 ilm 模板默认的公式自动编号 (1),(2),……
#set math.equation(numbering: none)

= 📌 本日起点

新的一天，档案已按 math-answer-note 规范建好：今日所有问答按 `= 主题` 追加在本节之后，一条问答一个一级标题（本日编号自 *问题 135* 起）。

#importantbox[
  *上一次记录（10-08）* 见 `note/2026-10-08.typ`——那一日只有一条问答，且*尚未收口*（"引导轮"，等用户作答）：

  #booktabs-table(
    columns: (1fr, 3fr, 2.6fr),
    table.header([*编号*], [*主题*], [*结论一句话*]),
    [问题 134],
    [单位半球面上各点到原点的"平均距离"（MIT 18.02 网页「Distance 1」，球坐标单元）——*引导轮：只落了脚手架，用户尚未作答*],
    [已落盘题干照录（含题首那句 "you will use spherical coordinates" 的钩子）+ 三层入口（`sphere`/`ball` 之辨 $->$ 写出 $abs(O P)$ 的取值 $->$ 写出面积平均式）$+$ 两个对照（换成上半球体 / 换成到 $z$ 轴的距离）；五模块解答*待补全*],
  )
]

#warningbox[
  *待办清单（更新于 10-09，承接 10-08）*：

  #enum(
    numbering: "1.",
    [*问题 134 的引导尚未收口*——等用户回答三层入口（$H$ 是曲面还是实体？$abs(O P)$ 在 $H$ 上取哪些值？被平均量 $f$ 是什么？）并给出选择题选项截图，随后补齐 `直接解答 / 关键点 / 变式检验 / 同类归类 / 易错点` 五模块（标题去掉"引导轮"字样）],
    [格林公式的*补线法*——仍未展开（考研高频技巧：边界不闭合时补线，再套格林公式）],
    [考纲第八章「常微分方程」在工作区*仍无*对应笔记材料（张宇 30 讲含此章，可作主材）],
  )
]
