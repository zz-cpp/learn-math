// ═══════════════════════════════════════════════════════════════
// answer-note · 按日归档问答记录
// 结构：每个独立问题 = 一个一级标题（=），子问题用（== / ===）
// 轨道：待定（按当日首条问答判断：数学轨 / CS 轨）
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
  date: datetime(year: 2026, month: 10, day: 14),
  abstract: [按日归档的问答记录：每个独立问题一个一级标题（=），子问题用（== / ===）；三问反思法（关键点/变式/同类归类）+ 讲课叙事流 + 判断框，结构与课程笔记同构。本日主题：待记录（上一条为 10-12 的问题 135 · 18.02.3x 全 12 讲的考研优先级地图，已五模块完整落盘；10-13 未新增问答，本日问答自问题 136 起逐条追加。仍未收口的是 10-08 的问题 134 · 半球面平均距离，仍在"引导轮"状态）],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

// 关闭 ilm 模板默认的公式自动编号 (1),(2),……
#set math.equation(numbering: none)

= 📌 本日起点

新的一天，档案已按 answer-note 规范建好：今日所有问答按 `= 主题` 追加在本节之后，一条问答一个一级标题（本日编号自 *问题 136* 起）。

#importantbox[
  *上一次记录（10-12）* 见 `note/2026-10-12.typ`——那一日把 *问题 135（18.02.3x 全 12 讲的考研优先级地图）* 五模块完整落盘（含补面法 CeTZ 重绘图、MIT 记号与考纲记号的翻译表）。10-13 未新增问答（当日未建文件）。至今仍未收口的是 10-08 落下的问题 134：

  #booktabs-table(
    columns: (1fr, 3fr, 2.6fr),
    table.header([*编号*], [*主题*], [*结论一句话*]),
    [问题 134],
    [单位半球面（球面 $S: x^2 + y^2 + z^2 = 1$ 的上半部分 $H$，$z > 0$）上的点到原点的"平均距离"——*引导轮：只落了脚手架，用户尚未作答*],
    [已落盘题干照录（含题首 "you will use spherical coordinates" 的钩子）+ 三层入口（`sphere`/`ball` 之辨 $->$ 写出 $abs(O P)$ 的取值 $->$ 写出面积平均式）$+$ 两个对照（换成上半球体 / 换成到 $z$ 轴的距离）；五模块解答*待补全*],
  )
]

#warningbox[
  *待办清单（更新于 10-14，承接 10-12）*：

  #enum(
    numbering: "1.",
    [*问题 134 的引导尚未收口*——等用户回答三层入口（$H$ 是曲面还是实体？$abs(O P)$ 在 $H$ 上取哪些值？被平均量 $f$ 是什么？）并给出选择题选项截图，随后补齐 `直接解答 / 关键点 / 变式检验 / 同类归类 / 易错点` 五模块（标题去掉"引导轮"字样）],
    [格林公式的*补线法*——仍未展开（考研高频技巧：边界不闭合时补线，再套格林公式）。10-12 的问题 135 已在 knowledgebox 里点明它是"补面法"的二维同胞，二维版本本身仍待补],
    [考纲第八章「常微分方程」在工作区*仍无*对应笔记材料（张宇 30 讲含此章，可作主材）],
    [问题 135 给出的学习顺序（`lec04 -> lec03 -> lec05/06 -> lec08 -> lec07`）尚未落成"逐讲打勾"的进度表——若要执行，可在后续日期文件中维护],
  )
]

// ══════════════════════════════════════════════════════════════════════
// 本日问答自下方开始追加：一条问答一个一级标题（= 主题）
// ══════════════════════════════════════════════════════════════════════

= 🎯 问题 136：线积分 90 分钟回忆复习（回忆式考试）

读者说：线积分的知识有些遗忘，用"考试 $+$ 回忆"的形式帮忙回忆这部分内容；先回忆大脉络、再针对小细节；总时长控制在 90 min 内。#footnote[来源：`~/note/2026/18.02.2x/` 的线积分七讲链条（`lec-04` `line-integrals` $->$ `lec-05` `parametric-curves-and-arc-length` $->$ `lec-06` `force-fields-and-work` $->$ `lec-07` `fundamental-theorem-of-line-integrals` $->$ `lec-08` `greens-theorem` $->$ `lec-09` `extended-greens-theorem` $->$ `lec-10` `gradients-and-curl`）$+$ 本工作区既有问答（问题 108–116、121–122、126、129）。]

== 本场安排：四卷 $+$ 收口（总时长 ≤ 90 min）

#booktabs-table(
  columns: (0.9fr, 3fr, 0.9fr, 1.2fr),
  table.header([*卷*], [*内容*], [*限时*], [*回忆层级*]),
  [第 1 卷], [*全景地图*：术语清单、两支分家、四种写法、三根台柱、等价链], [15 min], [大脉络],
  [第 2 卷], [*定义与计算*：七讲的知识链条、两类线积分的定义 $slash$ 计算 $slash$ 性质], [20 min], [中观],
  [第 3 卷], [*三根台柱*：线积分基本定理、格林定理、扩展格林定理（条件与结论）], [25 min], [中观 $->$ 细节],
  [第 4 卷], [*技巧与陷阱*：判据决策路径、补线 $slash$ 挖洞、定向与符号、易错点], [25 min], [细节],
  [收口], [标准答案卡 $+$ 错题归位 $+$ 落盘], [5 min], [—],
)

*推进方式*：每卷由助手出题、读者凭记忆作答（关键词即可），答完本卷后助手对照笔记批改、给出"标准答案卡"，再发下一卷。*不跳卷、不留白*——写不出来就写"忘了"，那也是有效答案。

== 第 1 卷 · 全景地图（15 min · 大脉络）

*作答方式*：不看笔记；关键词 $slash$ 短句即可；答完发回。

#importantbox[
  *卷一只考"骨架"*：能不能把整块线积分知识从空地上画出来。细节写不出没关系，*别翻笔记*——翻了这一卷就白考了。
]

=== 题 1-1 · 默写清单

不看笔记，写出"线积分"主题下能想起的全部关键术语（名词、定理名、记号、量名），至少 10 个，不设上限。

=== 题 1-2 · 两支分家

线积分分*标量型*与*向量型*两支，各自回答四问：

#enum(
  numbering: "1.",
  [记号写法是什么？],
  [微元分别是什么（$dif s$ 与 $dif x$、$dif y$ 的含义与正负性）？],
  [物理原型是什么（哪种现实量逼出了它）？],
  [反向走一遍曲线，积分值变不变？],
)

=== 题 1-3 · 四种写法

`lec-06` 总结页把*向量型*线积分写成*四种等价记法*。默写。

=== 题 1-4 · 三根台柱

`lec-04`–`lec-10` 的定理主线是*线积分基本定理*、*格林定理*、*扩展格林定理*。对每一根台柱用一句话回答：它解决什么问题？前提条件是什么？

=== 题 1-5 · 等价链关系图

把下面六个说法铺开成一张关系网（谁 $->$ 谁；哪些互相等价；哪些必须加*前提*才等价）：

- 存在势函数 $f$（$arrow(F) = nabla f$）
- 路径无关
- 沿任意*闭*曲线的功为零
- $N_x = M_y$（无旋）
- 定义域*单连通*
- 场是*保守场*

=== 题 1-6 · 自评

哪一题最心虚？线积分里最没底的环节是什么？（此答案决定后三卷的配重。）

= 🎯 问题 137：18.02.3x 全 12 讲笔记「节顺序 vs 材料顺序」检查

读者说：检查 18.02.3x 笔记的其他部分（承接 lec01 第三节、第四节反序的修正）。#footnote[来源：`~/note/2026/18.02.3x/` 的 `lec01`–`lec12` 各讲 `notes.typ`；材料页先后依据网页公式编号（全课程连续递增，3.1 → 6.205）、例题编号与 `pages/` 全页截图引用三重交叉验证。]

== 检查方法

#enum(
  numbering: "1.",
  [用 `typst query <file> "heading"` 提取每讲的*真实*一级标题——避免把 `$...$` 块公式内的续行（如 `= (2 y - b y) ...`）误判为标题，`lec07` 曾出现两行此类误报，已排除；],
  [把各讲材料页按*公式编号*排序（编号全课程连续：`lec01` 3.1–3.72 $->$ `lec02` 3.73– $->$ … $->$ `lec12` 6.205；缺号段无对应页），并用例题编号独立印证（例 4、5 在 Parametrizing 页，例 6–10 在 Examples 页，例 11 在 Linear Approximation 页）；],
  [用笔记中的 `image("pages/pageNN_...png")` 引用与 caption 里的网页名（如「Divergence Theorem in Two Dimensions」）把每个节*精确*钉到材料页，再比对两侧顺序。],
)

== 发现汇总（6 讲有问题、3 讲干净）

#booktabs-table(
  columns: (0.7fr, 2.6fr, 2.8fr),
  table.header([*讲*], [*笔记现状*], [*材料顺序（依据）*]),
  [`lec02`], [柱面 $+$ Möbius 两节在前、球坐标两节在后], [球坐标页 (3.74, 3.76–3.77) $->$ Möbius 页 (3.78–3.79)：*两处对调*],
  [`lec03`], [Introduction（"这一讲的地图与本讲目标"）在文末追加区（第 7 节）], [Introduction 是第 1 页（开场页，引用了其全页截图）：*应移到第一节*],
  [`lec05`], ["散度定理（二维版本）"在第 3 节], [二维版本页 (4.182) 在 Practice (4.173–4.180) 之后：*与"通量的行为"对调*],
  [`lec08`], ["与 Green 定理的对照"在"Stokes 定理的陈述"之前], [Stokes 陈述 (5.137) $->$ Green 对照 (5.138–5.144)：*两处对调*],
  [`lec10`], [电势在第 3 节、Gauss 定律在第 4 节], [Gauss's Law (6.24–6.48) $->$ Electrostatic Potentials (6.49–6.56)：*两处对调*],
)

*`lec01` 遗留*（上次已报告、未修）：第 5、7 节与材料互反——材料序为 环面 (3.38–3.41) $->$ 线性近似 (3.42–3.49) $->$ 柱坐标 (3.50–3.51)，笔记为 柱坐标 $->$ 线性近似 $->$ 环面。

*习题课位置差异*：`lec04` 的"习题课"插在"几何解释"之前（材料里 recitation 内容在 Summary 之后）；`lec07` 的"完整例题"（5.85–5.96）与"习题课：螺旋线上的线积分"（5.75–5.84）互反。（`lec01`/`02`/`05`/`08` 的习题课均紧邻收尾节，符合"习题课 $->$ 全章小结 $->$ 总结与延伸"的模板惯例，不算问题。）

*结构观察*：`lec03`/`08`/`09`/`10`/`11`/`12` 在"总结与延伸"之后另有追加区节（`lec03` 的追加区里正藏着 Introduction）；`lec06` 无独立"全章小结"节（Summary 页内容并入"陈述与读法"）；`lec07` 材料页 5.48–5.57（Exact Differential Forms，例 21 判定 $a = 2$、$b = 3$）未见对应内容。

*干净*：`lec09`、`lec11`、`lec12` 未发现顺序问题。

== 待办

修正范围待读者裁决：A 类 5 处 $+$ `lec01` 遗留（"主体节对齐材料"）；C 类 2 处（"习题课位置"）。修正时同步改过渡句并重编译各讲 PDF $slash$ HTML。

== 修正记录（同日执行）

读者裁决"全修 8 处 $+$ 补写例 21"，逐讲完成（每讲留 `notes.typ.bak5` 备份；所有块对调均以 `sort` 校验内容零丢失，并同步修正过渡句）：

#booktabs-table(
  columns: (0.7fr, 3fr, 0.8fr),
  table.header([*讲*], [*动作*], [*编译*]),
  [`lec01`], [§5 柱坐标 $<->$ §7 环面（现序：环面 $->$ 线性近似 $->$ 柱坐标）$+$ 4 处过渡句], [✓],
  [`lec02`], [球坐标两节 $<->$ 柱面 $+$ Möbius 两节 $+$ 2 处过渡句], [✓],
  [`lec03`], [Introduction 节移到文件首（现为第一节）$+$ 小结改写], [✓],
  [`lec04`], [习题课移到几何解释之后 $+$ 1 处引用修正], [✓],
  [`lec05`], [散度定理（二维版本）$<->$ 通量的行为（无需改句）], [✓],
  [`lec07`], [完整例题 $<->$ 习题课；补写*例 21*节（恰当微分形式：$a = 2$、$b = 3$）], [✓],
  [`lec08`], [Stokes 定理的陈述 $<->$ 与 Green 定理的对照（无需改句）], [✓],
  [`lec10`], [Gauss 定律 $<->$ 电势 $+$ 1 处过渡句], [✓],
)

*未动*：`lec06`（无全章小结，Summary 并入"陈述与读法"）、`lec09`/`lec11`/`lec12`（检查未发现问题）、各讲"总结与延伸"之后的补充区（`lec03`/`08`/`09`/`10`/`11`/`12`，视为有意追加保留）。

*产物*：8 讲 `notes.pdf`（零警告）与 `notes.html`（exit 0；HTML 轨延续既有的 `pagebreak()` 无害警告）已全部重建，逐讲复核通过。

= 🎯 问题 138：18.02.3x 笔记可读性改造（材料地图 $+$ 渲染修复 $+$ 符号注释）

读者反馈：18.02.3x 笔记要更好助读——"缺乏上下文、数学符号看不懂、显示效果不好、与 web 内容割裂"（附截图：`lec01`「从参数曲线说起」节的 $abs(gamma'(t)) -> norm(arrow(r)_u times arrow(r)_v)$ 一句）。#footnote[来源：`~/note/2026/18.02.3x/` 的 12 讲 `notes.typ`、其 HTML/PDF 产物，与本工作区当天记录。]

== 诊断：四类感受 $->$ 四个病根

#booktabs-table(
  columns: (1.1fr, 3.3fr),
  table.header([*读者感受*], [*病根*]),
  [缺乏上下文], [例子 $slash$ 定理"空降"，不说明来自哪一页（如"例 6"无出处）],
  [符号看不懂], [*符号超前引用*且首现无解释（截图句里的 $gamma'(t)$、$arrow(r)_u$、$arrow(r)_v$ 全是后文才讲的东西）],
  [与 web 割裂], [引用用中文译名（「曲面的例子」），与网页英文标题对不上；编号无出处],
  [显示效果不好], [HTML 轨道未指定数学字体 $->$ Chromium 用 fallback 渲染 MathML，$arrow(dot)$ 的*组合箭头错位*（实测显示成 $r$ 前一个独立箭头）；其余符号正常],
)

== 已完成

#enum(
  numbering: "1.",
  [*渲染根治*：12 讲 `notes.typ` 的 HTML_CSS 给 `math` 指定系统已有数学字体（`"DejaVu Math TeX Gyre"`, `"Noto Sans Math"`）——实测箭头归位、字形清晰；PDF 轨不受影响；],
  [*材料地图*：12 讲各在文首新增一节 `= 材料地图`（网页页名 $+$ 笔记对应节 $+$ 网页定位标识：公式编号区间与例题编号），笔记与 MIT Learn 网页可双向对照（读者已定：不附链接、给英文页名即可）；],
  [*`lec01` 样板*：`从参数曲线说起` 节补"这一节从哪来"；`像集` 首现补定义；手写竖线 $|...|$ 修正为 `abs()`；页名改为「Examples of Surfaces」（曲面示例）并说明例 6–10 的编号出处；],
  [*引用抽查*：11 讲的「」引用绝大多数本就是英文页名，无需大改；],
)

== 未做 $slash$ 待续

*符号就地注释*目前只覆盖 `lec01` 的样板段；其余各讲的"符号密集段"还没系统审查——已抽查 11 讲的*节首判断框*，质量普遍合格（多数自带解释），未发现 `lec01` 那种超前引用。后续可按同一模式逐讲推进（发现一处、补一处）。
