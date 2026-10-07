// ═══════════════════════════════════════════════════════════════════════════
// lec-02 数量积·向量积·混合积 — 一高数《高等数学（下）》8-2
// 素材：B 站 BV1SJ4m1W73g（ai-zh 字幕 + 1080P 视频帧，图均已三方验证）
// 模板：lecture-to-notes 的 Typst 轨道（material-to-notes notes-template.typ）
// 版本：typst 0.15.1 / cetz 0.5.2 / ilm 2.1.1 / cetz-plot 0.1.4 / fletcher 0.5.8
// ═══════════════════════════════════════════════════════════════════════════
#import "@preview/ilm:2.1.1": *
#import "@preview/cetz:0.5.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/cetz-plot:0.1.4": plot, chart

#let importantbox(body) = block(
  width: 100%, breakable: true,
  fill: rgb("#eef3fb"), stroke: (left: 3pt + rgb("#2f6fd0")),
  inset: (x: 11pt, y: 8pt), radius: 4pt,
)[*📌 核心要点*  #body]

#let knowledgebox(body) = block(
  width: 100%, breakable: true,
  fill: rgb("#eefaf1"), stroke: (left: 3pt + rgb("#2e9e5b")),
  inset: (x: 11pt, y: 8pt), radius: 4pt,
)[*💡 背景与类比*  #body]

#let warningbox(body) = block(
  width: 100%, breakable: true,
  fill: rgb("#fdf1ef"), stroke: (left: 3pt + rgb("#d64541")),
  inset: (x: 11pt, y: 8pt), radius: 4pt,
)[*⚠️ 陷阱预警*  #body]

#let titledbox(
  title, body,
  bg: rgb("#eefaf1"), title-bg: rgb("#2e9e5b"), title-fg: white,
  stroke: 1pt + luma(70),
) = block(
  width: 100%, breakable: true, radius: 0pt, fill: bg, stroke: stroke, inset: 0pt,
)[
  #block(width: 100%, fill: title-bg, inset: (x: 8pt, y: 3pt), radius: 0pt)[
    #text(fill: title-fg, weight: "bold")[#title]
  ]
  #block(width: 100%, inset: (x: 9pt, y: 7pt))[#body]
]

#show raw.where(block: false): it => box(fill: luma(243), inset: (x: 1.6pt, y: 0.3pt), radius: 1.5pt)[#text(font: "DejaVu Sans Mono", size: 0.88em)[#it.text]]

#let codelisting(code, lang: "typst", caption: none) = figure(
  caption: caption,
  block(width: 100%, breakable: true, stroke: 0.8pt + luma(200), inset: 8pt)[
    #show raw.line: line => box(width: 100%)[
      #box(width: 2.4em)[#text(fill: luma(150), size: 0.72em)[#str(line.number)]]
      #line.body
    ]
    #set text(size: 0.9em)
    #raw(code, lang: lang, block: true)
  ],
)

#let booktabs-table(columns: (), ..rows) = block(width: 100%, breakable: true)[
  #table(
    columns: columns,
    stroke: (top: 1.2pt + black, bottom: 1.2pt + black, x: none, y: 0.5pt + luma(160)),
    fill: none, inset: (x: 8pt, y: 5pt), ..rows,
  )
]

#let unnumbered(body) = { set math.equation(numbering: none); body }
#let c-red = rgb("#c0392b")
#let c-blue = rgb("#2f6fd0")
#let c-green = rgb("#2e9e5b")

#let note-title    = [数量积、向量积与混合积]
#let note-subtitle = [一高数《高等数学（下）》8-2：向量代数与空间解析几何（中篇）]
#let note-author   = [lecture-to-notes]
#let src-type      = [B 站教学视频（1080P 视频帧 + ai-zh 字幕）]
#let src-path      = [https://www.bilibili.com/video/BV1SJ4m1W73g]
#let src-scale     = [51 分 49 秒（UP 主：一高数）]
#let cover-path    = "cover.jpg"

#show: ilm.with(
  title: note-title,
  authors: ("lecture-to-notes",),
  date: datetime.today(),
  abstract: [讲者在开场就点出本讲要"搞定三只鸡"：数量积（点积）、向量积（叉积）、混合积。三种运算对应三种完全不同的输出——数量积出来是一个*数*（可用来求夹角、判垂直），向量积出来是一个*向量*（可用来求同时垂直于两者的方向、算平行四边形与三角形面积），混合积出来又是一个*数*（用来算平行六面体体积、判定三向量共面）。全讲坚持"物理概念 + 坐标计算"的双轮驱动：数量积从"力做功"来，向量积从"力矩"来，混合积从"体积"来，而所有计算最终都落到坐标行列式上，并给出"前上后下写两遍、掐头去尾取中间、交叉相乘再相减"的口算口诀。五道例题（夹角、垂直单位向量、三角形面积、混合积恒等式、四点共面）全部给出完整数值过程与两个方向的陷阱提醒。],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

#v(2.0cm)
#align(center)[
  #text(size: 1.15em)[课程笔记]
  #v(1.1em)
  #text(size: 1.8em, weight: "bold")[#note-title]
  #v(0.35em)
  #text(size: 1.05em)[#note-subtitle]
  #v(0.6em)
  #text(size: 1.0em)[#note-author]
  #v(0.35em)
  #text(size: 1.0em)[#datetime.today().display("[year]-[month]-[day]")]
  #v(1.0em)
  #image(cover-path, width: 76%, fit: "contain")
  #v(0.6em)
  #block(width: 90%, stroke: 0.8pt + luma(120), inset: 10pt)[
    *材料类型*：#src-type \
    *材料来源*：#src-path \
    *时长/规模*：#src-scale
  ]
]
#pagebreak()
#outline(title: [目录])
#pagebreak()

// ═══════════════════════════════════════════════════════════════════════════
// 正文
// ═══════════════════════════════════════════════════════════════════════════

= 开篇：这一讲要搞定的"三只鸡"

老师开场就抛出一串问题，把这一讲的定位说清楚了：

> 如果已知随便两向量 $arrow(a), arrow(b)$ 的坐标，你会求它们的夹角吗？你会求和 $arrow(a), arrow(b)$ 都垂直的空间向量吗？你会求以 $arrow(a), arrow(b)$ 为邻边的平行四边形面积吗？如果再给你一个向量 $arrow(c)$，你能马上看出它们是否共面吗？又或者……叉乘、力矩到底都是什么鬼？

答案就是三种乘法：

#importantbox[
*三种"积"的输出类型（最容易混的一点）*
- *数量积*（点积）：$arrow(a) dot arrow(b)$ —— 结果是*一个数*；
- *向量积*（叉积）：$arrow(a) times arrow(b)$ —— 结果是*一个向量*；
- *混合积*：$[arrow(a) arrow(b) arrow(c)]$ —— 结果是*一个数*。

"数量积"和"向量积"这两个名字里，*数量*与*向量*都是定语，修饰后面那个"积"字——数量积是说积出来是个数量，向量积是说积出来是个向量。
]

= 数量积（点积、内积）

== 从"力做功"到数量积的定义

数量积也叫点积，视频里老师说"这个我们搞快点，高中都比较熟了"，但有一些新东西要一起温故知新。它的最佳理解背景是物理中的*功*：

一个小木块，给它施加一个恒力 $arrow(F)$，产生位移记作 $arrow(s)$，那么外力 $arrow(F)$ 所做的功 $W$ 等于什么？

$ W = arrow(F) dot arrow(s) = abs(arrow(F)) abs(arrow(s)) cos theta $

其中：
- $arrow(F)$：施加的恒力（向量）；
- $arrow(s)$：物体产生的位移（向量）；
- $theta$：$arrow(F)$ 与 $arrow(s)$ 的夹角；
- $abs(arrow(F)) cos theta$：力在位移方向上的*分力*大小；
- $W$：功，是一个*标量*（数量）。

物理上的说法是：力沿位移方向的分量大小，乘上运动的路程。$arrow(F)$ 与 $arrow(s)$ 夹钝角时，$cos theta < 0$，功就是负的——这也符合"做负功"的物理直觉。

数学上我们把这个关系*抽象*出来：对任意两个向量 $arrow(a)$ 与 $arrow(b)$，

$ arrow(a) dot arrow(b) = abs(arrow(a)) abs(arrow(b)) cos theta $

其中：
- $arrow(a), arrow(b)$：任意两个向量；
- $theta = <arrow(a), arrow(b)>$：两向量的夹角（$0 <= theta <= pi$）；
- 符号"$dot$"读作"点乘"，所以数量积也叫*点积*。

#figure(
  image("figures/fig_01_dot_def.png", width: 92%),
  caption: [由功的定义引出的数量积：画面左侧是"功 $W$"的物理图（力 $arrow(F)$ 作用在物体上、位移 $arrow(s)$、夹角 $theta$），右侧写出 $a dot b = abs(a) abs(b) cos theta$],
)
#footnote[来源：视频画面 00\:01\:45--00\:02\:00（BV1SJ4m1W73g）。]

== 投影：数量积的另一种读法

除了"功"，数量积还能怎么理解？注意公式里 $abs(arrow(b)) cos theta$ 这一部分——它在数学中是"带身份"的，有自己的名字：*向量 $arrow(b)$ 在向量 $arrow(a)$ 上的投影*。

直观看：把 $arrow(b)$ 的起点和终点分别向 $arrow(a)$ 引垂线——老师打了个很形象的比方，"好比是一束垂直的光打下来"，落在 $arrow(a)$ 上的那段长度，就是 $arrow(b)$ 在 $arrow(a)$ 上的投影。

#figure(
  cetz.canvas(length: 1.0cm, {
    import cetz.draw: *
    // 向量 a 水平放置，向量 b 斜着，展示投影
    line((0, 0), (5.0, 0), stroke: 1.3pt + c-blue, mark: (end: "stealth"))
    content((5.2, 0.0), $arrow(a)$, fill: c-blue)
    line((0.6, 0), (2.6, 2.0), stroke: 1.3pt + c-red, mark: (end: "stealth"))
    content((2.75, 2.15), $arrow(b)$, fill: c-red)
    line((2.6, 2.0), (2.6, 0), stroke: (paint: luma(130), dash: "dashed"))
    line((0.6, 0), (0.6, 2.0), stroke: (paint: luma(130), dash: "dotted"))
    line((0.6, -0.55), (2.6, -0.55), stroke: 1.6pt + c-green, mark: (both: "stealth"))
    content((1.6, -0.95), [投影长度], fill: c-green)
    // 夹角
    arc((1.7, 0), start: 0deg, stop: 45deg, radius: 1.1, stroke: 0.7pt + c-green)
    content((1.9, 0.35), $theta$, fill: c-green)
  }),
  caption: [投影的几何构造：把 $arrow(b)$ 的起点与终点分别向 $arrow(a)$ 所在直线作垂线，"垂直的光打下来"落在 $arrow(a)$ 上的那段有向长度就是投影，数值为 $abs(arrow(b)) cos theta$],
)
#footnote[来源：按视频讲解（00\:01\:50--00\:02\:35）重绘。]

#importantbox[
*投影的定义要点*
- 投影是*一个实数*，不是向量（这一点最容易搞错）；
- 它在数值上等于 $abs(arrow(b)) cos theta$；
- $arrow(b)$ 与 $arrow(a)$ 夹钝角时，投影是*负数*——所以投影一定程度也反映了 $arrow(b)$ 与 $arrow(a)$ 的方向关系；
- 记号有两种，随便选一种：$"Prj"_(arrow(a)) arrow(b)$（""Prj""是 project 的缩写），或者简写成 $(arrow(b))_arrow(a)$。*注意小写的那个才是"被投的向量"*，即被投影的基准。
]

老师坦白说这个记号"看起来是有点复杂"，但"这个符号确实也尽力了，你多看两眼就顺眼了"。

#figure(
  image("figures/fig_02_projection.png", width: 92%),
  caption: [投影的记号与线性运算法则页：上方给出 $b_a = "Prj"_a b = abs(b) cos theta$ 的定义，下方列出两条法则——$"Prj"_a (b + c) = "Prj"_a b + "Prj"_a c$ 与 $"Prj"_a (lambda b) = lambda "Prj"_a b$],
)
#footnote[来源：视频画面 00\:02\:15--00\:02\:30（BV1SJ4m1W73g）。]

投影的两条运算法则"了解一下，一会儿有用"：*两个向量和的投影可以拆开写*，*常数系数可以随便拿进拿出*。

$ "Prj"_(arrow(a)) (arrow(b) + arrow(c)) = "Prj"_(arrow(a)) arrow(b) + "Prj"_(arrow(a)) arrow(c) $

$ "Prj"_(arrow(a)) (lambda arrow(b)) = lambda "Prj"_(arrow(a)) arrow(b) $

其中：
- $arrow(a)$：投影的基准向量（"墙面"）；
- $arrow(b), arrow(c)$：被投影的向量；
- $lambda$：任意实数——常数可以自由地穿进穿出投影号。

#knowledgebox[
*为什么要信这两条？* 用图形看最清楚：把 $arrow(a) + arrow(b)$（用三角形法则做出来）整体投到 $arrow(c)$ 上，那段投影恰好等于"$arrow(a)$ 的投影"加"$arrow(b)$ 的投影"两段拼起来——因为投影是在同一条直线上的有向长度，可以直接相加。

同理，把 $arrow(a)$ 按相似三角形伸缩 $lambda$ 倍，它的投影也恰好跟着伸缩 $lambda$ 倍。
]

于是数量积有了第二种读法：

#importantbox[
$ arrow(a) dot arrow(b) = abs(arrow(a)) dot "Prj"_(arrow(a)) arrow(b) = abs(arrow(b)) dot "Prj"_(arrow(b)) arrow(a) $

即：*数量积 = 其中一个向量的模，乘上另一个向量在这个向量上的投影*。

⚠️ 老师特别提醒："*这个你别乱来，一定要看清楚谁往谁身上投*"——是*求模长的那个向量*作为基准，*另一个向量往它身上投*。不过话说回来，两种写法算出来的结果是一样的（内积是对称的），所以"谁往谁身上投都行"，只是在推导时要保持一致。
]

== 数量积的三大运算律

要能"口算"坐标形式，必须先有运算律。三条：

#figure(
  image("figures/fig_05_dot_laws.png", width: 92%),
  caption: [数量积的运算律页：① 交换律 $a dot b = b dot a$；② 分配律 $(a + b) dot c = a dot c + b dot c$；③ 数乘结合律 $(lambda a) dot b = lambda (a dot b)$],
)
#footnote[来源：视频画面 00\:06\:45--00\:07\:00（BV1SJ4m1W73g）。]

$ arrow(a) dot arrow(b) = arrow(b) dot arrow(a) quad "交换律" $

$ (arrow(a) + arrow(b)) dot arrow(c) = arrow(a) dot arrow(c) + arrow(b) dot arrow(c) quad "分配律" $

$ (lambda arrow(a)) dot arrow(b) = lambda (arrow(a) dot arrow(b)) quad "数乘结合律" $

其中：
- $arrow(a), arrow(b), arrow(c)$：任意三个向量；
- $lambda$：任意实数，可以在数量积里自由穿梭。

交换律为什么成立？因为点乘就是"模长相乘再乘夹角余弦"，而数的乘法可以交换（$abs(arrow(a)) abs(arrow(b)) = abs(arrow(b)) abs(arrow(a))$），夹角也是同一个角——"你们两个换过来完全平等"。

分配律的推导则用到了刚才的投影法则，非常漂亮：

#knowledgebox[
把 $arrow(c)$ 看作投影的基准，左边 = $abs(arrow(c)) dot "Prj"_(arrow(c)) (arrow(a) + arrow(b))$。
用"和的投影等于投影的和"，它等于 $abs(arrow(c)) dot ("Prj"_(arrow(c)) arrow(a) + "Prj"_(arrow(c)) arrow(b))$。
再把 $abs(arrow(c))$ 分配进去：第一项 $abs(arrow(c)) "Prj"_(arrow(c)) arrow(a)$ 就是 $arrow(a) dot arrow(c)$，第二项同理就是 $arrow(b) dot arrow(c)$——右边正是这两项之和。证毕。
]

== 由基本单位向量推出坐标公式

有了运算律，就可以把两个向量写成分解式直接点乘：

$ arrow(a) dot arrow(b) = (a_x arrow(i) + a_y arrow(j) + a_z arrow(k)) dot (b_x arrow(i) + b_y arrow(j) + b_z arrow(k)) $

按分配律展开是 *九项*。为了化简，需要三条关于基本单位向量的结论：

#figure(
  image("figures/fig_06_dot_results.png", width: 92%),
  caption: [数量积的三条运算结论：$a dot a = abs(a)^2$（由 $cos 0 = 1$ 得到）、$abs(a) = sqrt(a dot a)$、$0 dot a = 0$],
)
#footnote[来源：视频画面 00\:08\:45--00\:09\:00（BV1SJ4m1W73g）。]

#importantbox[
*数量积的三条基本结论*
1. $arrow(a) dot arrow(a) = abs(arrow(a))^2$：一个向量和它自己做内积，等于模长的平方（因为夹角为 $0$，$cos 0 = 1$，两个模相乘就是模的平方）。
2. 反过来，$abs(arrow(a)) = sqrt(arrow(a) dot arrow(a))$ ——两边开算术平方根。这是"由点乘反求模长"的桥梁。
3. $arrow(0) dot arrow(a) = 0$：零向量的模是 $0$，所以结果必然是 $0$，后面不用算。
]

把这套结论用到 $arrow(i), arrow(j), arrow(k)$ 上（它们是两两垂直的单位向量）：凡两个字母*不一样*的项（如 $arrow(i) dot arrow(j)$）都因为正交而内积为零，直接从九项里消失；只剩下"自己乘自己"的三项，而单位向量与自身的内积是 $1$。于是：

$ arrow(a) dot arrow(b) = a_x b_x + a_y b_y + a_z b_z $

其中：
- $arrow(a) = (a_x, a_y, a_z)$、$arrow(b) = (b_x, b_y, b_z)$：两个空间向量；
- 右边就是"*对应分量相乘再相加*"。

#figure(
  image("figures/fig_07_dot_coord_app.png", width: 92%),
  caption: [数量积坐标形式的两大应用（完整版）：求夹角 $cos <a,b> = (a_1 b_1 + a_2 b_2 + a_3 b_3) / (sqrt(a_1^2 + a_2^2 + a_3^2) sqrt(b_1^2 + b_2^2 + b_3^2))$；判垂直只要分子为零],
)
#footnote[来源：视频画面 00\:10\:45--00\:11\:00（BV1SJ4m1W73g）。]

#warningbox[
老师原话："以后*几乎所有*的数量积都用这个公式来算了。"也就是说：定义式 $abs(arrow(a)) abs(arrow(b)) cos theta$ 只在*理解*时用，*计算*时一律用坐标式。这两个式子的分工要分清。
]

== 数量积的两大应用

#figure(
  image("figures/fig_03_dot_applications.png", width: 92%),
  caption: [数量积的两大应用页：① 求夹角 $cos <a,b> = (a dot b)/(abs(a) abs(b))$；② 判垂直 $a perp b <==> a dot b = 0$],
)
#footnote[来源：视频画面 00\:05\:00--00\:05\:15（BV1SJ4m1W73g）。]

$ cos <arrow(a), arrow(b)> = (arrow(a) dot arrow(b)) / (abs(arrow(a)) abs(arrow(b))) $

$ arrow(a) perp arrow(b) <==> arrow(a) dot arrow(b) = 0 $

其中：
- 第一个公式由定义式反解得到，要求 $arrow(a), arrow(b)$ 都是非零向量；
- 第二个公式的推导：若 $arrow(a) dot arrow(b) = 0$，则 $cos theta = 0$；而在 $[0, pi]$ 上余弦值为零的角只有一个，就是 $pi/2$——也就是两向量成直角、互相垂直。

老师说得很直接：这个夹角公式"*不要现推啊，要当成基本常识直接用*"。

#figure(
  image("figures/fig_04_ex1_statement.png", width: 92%),
  caption: ["【例1】数量积运算练习"：已知三点 $M(1,1,1)$、$A(2,2,1)$、$B(2,1,2)$，求 $angle A M B$],
)
#footnote[来源：视频画面 00\:05\:45--00\:06\:00（BV1SJ4m1W73g）。]

有意思的是，视频在这里卖了个关子——刚讲完夹角公式就拿例题来考，结果发现："这例题我们能不能做呀？*不能做，还没学完*。"原因是：题里给的是*点*的坐标，要求夹角得先知道*向量*的坐标，而向量坐标怎么算（终点减起点）、坐标怎么点乘，都是后面才讲的。所以老师先记下这道题，等工具备齐了再"一雪前耻"。

（顺便说一句：这个"卡住"的设计很值得体会——先让你意识到手头的工具不够用，再补上工具，这正是一堂好课的节奏。）

== 例题1：求 $angle A M B$（一雪前耻）

#figure(
  image("figures/fig_08_ex1_solution.png", width: 92%),
  caption: ["【例1】解答页：解出 $arrow(M A) = (1,1,0)$、$arrow(M B) = (1,0,1)$，于是 $cos angle A M B = (arrow(M A) dot arrow(M B))/(abs(arrow(M A)) abs(arrow(M B))) = 1/(sqrt(2) sqrt(2)) = 1/2$"],
)
#footnote[来源：视频画面 00\:12\:30--00\:12\:45（BV1SJ4m1W73g）。]

工具齐了，现在把这道题做完。已知三点 $M(1,1,1)$、$A(2,2,1)$、$B(2,1,2)$，求 $angle A M B$。

*第一步：先把"角 $A M B$"翻译成"两个向量的夹角"*。角 $A M B$ 是顶点为 $M$、两条边分别指向 $A$ 与 $B$ 的角，所以它等于向量 $arrow(M A)$ 与 $arrow(M B)$ 的夹角。

*第二步：求这两个向量的坐标*（终点坐标减起点坐标）：

$ arrow(M A) = (2 - 1, 2 - 1, 1 - 1) = (1, 1, 0), quad arrow(M B) = (2 - 1, 1 - 1, 2 - 1) = (1, 0, 1) $

*第三步：分子用内积（对应分量相乘相加）*：

$ arrow(M A) dot arrow(M B) = 1 times 1 + 1 times 0 + 0 times 1 = 1 $

*第四步：分母用模长的乘积*：

$ abs(arrow(M A)) = sqrt(1^2 + 1^2 + 0^2) = sqrt(2), quad abs(arrow(M B)) = sqrt(1^2 + 0^2 + 1^2) = sqrt(2) $

*第五步：得到余弦值，再反推角*：

$ cos angle A M B = 1 / (sqrt(2) sqrt(2)) = 1/2 quad ==> quad angle A M B = pi/3 $

其中最后一步用到的常识是：在 $[0, pi]$ 上，余弦值为 $1/2$ 的角是 $pi/3$（即 $60 degree$）。

#warningbox[
这道题有两个高频错误：
1. *把 $arrow(M A)$ 写成 $arrow(A M)$*——方向反了，向量坐标整体变号（虽然本题恰好对称，结果不变，但换个题目就会错）；
2. *用错分母*：分母是"两个模长相乘"，不是"先求和再开方"。$abs(arrow(M A)) abs(arrow(M B)) = sqrt(2) dot sqrt(2) = 2$，而 $abs(arrow(M A) + arrow(M B)) = sqrt(1+1+1) = sqrt(3)$，完全是两码事。
]

== 本章小结

数量积（点积）这一节的核心就是"一个定义、两条法则、两个应用、一个坐标公式"：

1. *定义*：$arrow(a) dot arrow(b) = abs(arrow(a)) abs(arrow(b)) cos theta$（由力做功的物理背景抽象而来），结果是*数*。
2. *第二种读法*：$arrow(a) dot arrow(b) = abs(arrow(a)) "Prj"_(arrow(a)) arrow(b)$——一个向量的模乘另一向量在它上面的投影；投影 $"Prj"_(arrow(a)) arrow(b) = abs(arrow(b)) cos theta$ 是*实数*，可拆可提（$"Prj"_a (b+c) = "Prj"_a b + "Prj"_a c$，$"Prj"_a (lambda b) = lambda "Prj"_a b$）。
3. *运算律*：交换律、分配律、数乘结合律；配套结论 $arrow(a) dot arrow(a) = abs(arrow(a))^2$、$abs(arrow(a)) = sqrt(arrow(a) dot arrow(a))$、$arrow(0) dot arrow(a) = 0$。
4. *坐标公式*：$arrow(a) dot arrow(b) = a_x b_x + a_y b_y + a_z b_z$（对应分量相乘相加）。
5. *两大应用*：求夹角 $cos theta = (arrow(a) dot arrow(b))/(abs(arrow(a)) abs(arrow(b)))$；判垂直 $arrow(a) perp arrow(b) <==> arrow(a) dot arrow(b) = 0$。

数量积解决了"角"和"垂直"的问题，但它*求不出一个与两者都垂直的向量*——那个问题要交给下一节的向量积。

= 向量积（叉积、外积）

== 从"力矩"到向量积：物理概念先行

老师说得很明确："*大家不要怕物理概念啊，物理就是生活常识，其实非常非常有意思。*"这一节的物理入口是*力矩*。

问：给物体施加一个外力，可能产生哪些作用效果？老师列了三种——① 改变形状；② 改变运动状态（比如平动或变速）；③ *转动*。而"转动"这种效果，在物理上定义为*力矩*。

#figure(
  image("figures/fig_09_moment.png", width: 92%),
  caption: ["力矩 $M$（Moment of Force）"：真实场景演示——用手转动装水的杯子，说明"旋转猛不猛"取决于切向力大小与力臂长度],
)
#footnote[来源：视频画面 00\:13\:45--00\:14\:00（BV1SJ4m1W73g）。]

力矩应该是向量还是数量？它*肯定有大小*——就是"旋转猛不猛"，由两个因素决定：

#importantbox[
*力矩大小的两个决定因素*
1. *切向力的大小*：把作用点绕轴看成一个圆，力沿切线方向的那一份（垂直于力臂的分力）越大，转得越快——"推力大就转得快，切向推力小就转得慢"；
2. *力臂长度*：也就是作用点到轴的距离。老师说："你把它想象成一个门，你用同样的力是不是越靠边，这个门转得越快；你越靠近轴，它就推不动了。"

写成公式：$abs(arrow(M)) = abs(arrow(O P)) dot abs(arrow(F)) sin theta$，其中 $abs(arrow(O P))$ 是力臂长度，$abs(arrow(F)) sin theta$ 是垂直于力臂的那个分力大小。力矩和这两者都成正比。
]

那么力矩有没有方向？——"你就说转动有没有方向吧，肯定有啊"：向前平推它逆时针转，向后平推它顺时针转。所以转动是有方向的，力矩必须体现这个方向，因此力矩是*向量*。

#figure(
  image("figures/fig_10_moment_dir.png", width: 92%),
  caption: ["力矩的方向"：画面上用真实的手演示——同一个逆时针旋转，无论力的作用方向如何，四指顺着转动方向握，大拇指都竖直向上；顺时针旋转则竖直向下],
)
#footnote[来源：视频画面 00\:15\:45--00\:16\:00（BV1SJ4m1W73g）。]

方向怎么规定？老师的思路是"把*旋转的方向*和*向量的方向*关联起来"：右手四指握一下，正好是逆时针；那就规定*大拇指指向的就是力矩方向*。这样一来，只要是逆时针转，哪怕力的方向不一样，力矩的方向都统一向上；顺时针转则竖直向下。

"那位同学说，为啥不是左手规定啊？"——答案是：*规定方便学术交流*（所有人都用同一个约定，结论才能互通）。

于是力矩可以这样表述：*它的方向是按照右手规则从 $arrow(O P)$ 转向 $arrow(F)$*。什么叫"从 $arrow(O P)$ 转向 $arrow(F)$"？把两个向量的起点平移重合，右手四指先碰到 $arrow(O P)$ 的方向，再转到 $arrow(F)$ 的方向，握起来，大拇指的指向就是叉积的方向；在三维空间里，这个方向*垂直于它们所在的平面*。

== 向量积的定义

把上述大小与方向"打包"，就得到向量积的数学定义：

#figure(
  image("figures/fig_11_cross_def.png", width: 92%),
  caption: [由力矩抽象出的向量积定义：$arrow(M) = arrow(O P) times arrow(F)$，其模为 $abs(arrow(M)) = abs(arrow(O P)) abs(arrow(F)) sin theta$，方向按右手规则由 $arrow(O P)$ 转向 $arrow(F)$],
)
#footnote[来源：视频画面 00\:17\:00--00\:17\:15（BV1SJ4m1W73g）。]

$ arrow(c) = arrow(a) times arrow(b) $

$ abs(arrow(c)) = abs(arrow(a)) abs(arrow(b)) sin theta, quad arrow(c) perp arrow(a), quad arrow(c) perp arrow(b) $

其中：
- $arrow(a), arrow(b)$：参与运算的两个向量；
- $theta = <arrow(a), arrow(b)>$：两向量夹角；
- $abs(arrow(c))$：结果向量的*模*，等于两模长相乘再乘夹角*正弦*；
- 方向：按*右手规则*，四指先碰到 $arrow(a)$ 再碰到 $arrow(b)$ 转过去，大拇指指向就是 $arrow(c)$ 的方向；
- 由此可知 $arrow(c)$ 同时垂直于 $arrow(a)$ 与 $arrow(b)$（垂直于它们所在的平面）。

#warningbox[
*数量积 vs 向量积：三个易混点*
1. *结果类型*：$arrow(a) dot arrow(b)$ 是数，$arrow(a) times arrow(b)$ 是向量；
2. *三角函数*：数量积用 *$cos$*，向量积用 *$sin$*——写错这两个函数，后面的面积、体积全废；
3. *先后顺序*：叉乘*有顺序*，"$arrow(a) times arrow(b)$"和"$arrow(b) times arrow(a)$"差一个负号（下一节会细讲）。
]

== 几何意义：平行四边形的面积

向量积的模 $abs(arrow(a)) abs(arrow(b)) sin theta$ 在几何上是什么？老师提示："它是个*面积*"——以 $arrow(a)$ 和 $arrow(b)$ 为邻边补成一个完整的平行四边形，这个面积等于"一条边乘这条边上的高"：

$ S = abs(arrow(a)) dot h = abs(arrow(a)) dot abs(arrow(b)) sin theta = abs(arrow(a) times arrow(b)) $

其中：
- 取 $arrow(a)$ 为底边，$h$ 为这条边上的高；
- 而 $h = abs(arrow(b)) sin theta$（把 $arrow(b)$ 投影到垂直于 $arrow(a)$ 的方向上）；
- 于是平行四边形面积恰好等于叉乘的*模长*。

#figure(
  cetz.canvas(length: 1.0cm, {
    import cetz.draw: *
    // 平行四边形：a 为底，b 为斜边
    let o = (0, 0)
    let a = (4.2, 0)
    let b = (1.3, 2.0)
    let ab = (5.5, 2.0)
    line(o, a, stroke: 1.3pt + c-blue, mark: (end: "stealth"))
    content((1.6, -0.4), $arrow(a)$)
    line(o, b, stroke: 1.3pt + c-red, mark: (end: "stealth"))
    content((0.5, 1.2), $arrow(b)$)
    line(a, ab, stroke: (paint: luma(120), dash: "dashed"))
    line(b, ab, stroke: (paint: luma(120), dash: "dashed"))
    // 高
    line(b, (1.3, 0), stroke: (paint: c-green, dash: "dashed"))
    content((0.75, 1.0), $h$, fill: c-green)
    // 夹角
    arc((0.9, 0), start: 0deg, stop: 57deg, radius: 0.9, stroke: 0.7pt + c-green)
    content((1.15, 0.3), $theta$, fill: c-green)
    content((2.2, 2.6), [平行四边形面积 $= abs(arrow(a) times arrow(b))$])
  }),
  caption: [叉乘模长的几何意义：以 $arrow(a), arrow(b)$ 为邻边的平行四边形，其面积等于 $abs(arrow(a) times arrow(b))$；连接两个向量的终点所得三角形面积则是它的一半],
)
#footnote[来源：按视频讲解（00\:18\:26--00\:19\:10）重绘。]

#importantbox[
*向量积的三大应用（老师原话：我们在这儿学向量积，就是为了后续用来干这些活）*
1. *求方向*：已知 $arrow(a), arrow(b)$，需要找一个*同时与它们垂直*的向量——答案就是 $arrow(a) times arrow(b)$；
2. *求平行四边形面积*：$S_("平行四边形") = abs(arrow(a) times arrow(b))$；
3. *求三角形面积*：连接两个向量的终点，所得三角形的面积是平行四边形的一半，即 $S_("三角形") = 1/2 abs(arrow(a) times arrow(b))$。
]

#figure(
  image("figures/fig_12_cross_app.png", width: 92%),
  caption: [向量积的应用页：① 求与 $a, b$ 均垂直的向量 $c = a times b$；② 以 $a, b$ 为邻边的平行四边形面积为 $abs(a times b)$；③ 以 $a, b$ 为任意两边的三角形面积为 $1/2 abs(a times b)$],
)
#footnote[来源：视频画面 00\:19\:00--00\:19\:15（BV1SJ4m1W73g）。]

#warningbox[
三角形面积公式里的两条竖线是什么意思？"$arrow(a)$ 向量外面套竖线，它是*模*的意思"——注意与实数的绝对值区分（但写法一样，靠"套在谁外面"来判断）。
]

== 运算律与五条结论

先用分配律和数乘结合律把括号打开，才能推出坐标公式：

$ (arrow(a) + arrow(b)) times arrow(c) = arrow(a) times arrow(c) + arrow(b) times arrow(c) quad "分配律" $

$ lambda (arrow(a) times arrow(b)) = (lambda arrow(a)) times arrow(b) = arrow(a) times (lambda arrow(b)) quad "数乘结合律" $

其中：
- $arrow(a), arrow(b), arrow(c)$：任意三个向量；
- $lambda$：任意实数，可以在叉乘中到处穿梭。

#warningbox[
叉乘的分配律*必须注意顺序*："$arrow(c)$ 在右边，它自始至终都只能在叉乘符号的右边"；反过来 $arrow(c) times (arrow(a) + arrow(b))$ 也可以从左边分配进去，但*不能把顺序搞混*——因为叉乘不满足交换律。
]

老师还用量矩给了分配律一个直观解释：把 $arrow(c)$ 想成力臂（那根杆），$arrow(a) + arrow(b)$ 想成两个力合成的一个合力。两个力形成的合力产生的转动总效果，理应等于"把这两个分力分别研究、再把旋转效果相加"——所以分配律是符合物理直觉的。

接下来是五条必须刻进肌肉记忆的结论：

#figure(
  image("figures/fig_14_cross_results.png", width: 92%),
  caption: [向量积的运算结论：① $a times a = 0$；② $0 times a = 0$；③ $a parallel b <==> a times b = 0$；④ $b times a = -(a times b)$；⑤ $i times j = k$、$j times k = i$、$k times i = j$],
)
#footnote[来源：视频画面 00\:23\:15--00\:23\:30（BV1SJ4m1W73g）。]

#importantbox[
*向量积五条结论*
1. $arrow(a) times arrow(a) = arrow(0)$：自叉为零向量（因为 $sin 0 = 0$，长度为零）；
2. $arrow(0) times arrow(a) = arrow(0)$：零向量的模是 $0$，乘出来长度必为零；
3. $arrow(a) parallel arrow(b) <==> arrow(a) times arrow(b) = arrow(0)$：*叉乘为零就是平行（共线）*；证明用 $arrow(b) = lambda arrow(a)$ 代入，$lambda$ 可穿梭出去，剩下 $arrow(a) times arrow(a) = arrow(0)$；
4. $arrow(b) times arrow(a) = -(arrow(a) times arrow(b))$：*反交换律*，交换顺序要添负号——大小不变（都是 $abs(a) abs(b) sin theta$），方向相反（右手四指碰到顺序反了，拇指指向反过来，"垂直纸面向外"变成"垂直纸面向里"）；
5. $arrow(i) times arrow(j) = arrow(k)$，$arrow(j) times arrow(k) = arrow(i)$，$arrow(k) times arrow(i) = arrow(j)$：三个基本单位向量的*循环走位*（顺着 $arrow(i) -> arrow(j) -> arrow(k) -> arrow(i)$ 转，"大拇指就是下一个"）。顺序一旦反了，立刻添负号，例如 $arrow(j) times arrow(i) = -arrow(k)$。
]

#knowledgebox[
这条"走位"规律还有个漂亮的记忆法：$arrow(i) times arrow(j)$ 的方向就是右手四指从 $x$ 轴转向 $y$ 轴时大拇指的指向，也就是 $z$ 轴正方向——"这不就是右手系嘛！"而大小上，$abs(arrow(i)) abs(arrow(j)) sin 90 degree = 1 times 1 times 1 = 1$，所以结果正好是 $arrow(k)$ 本身。
]

== 行列式：叉乘的坐标公式与记忆口诀

#figure(
  image("figures/fig_15_determinant_rule.png", width: 92%),
  caption: [叉积的坐标公式写作三阶行列式：第一行 $i, j, k$；第二行写*前面*那个向量的坐标；第三行写*后面*那个向量的坐标。画面右侧是教材给出的展开结果与"前上后下写两遍、掐头去尾取中间、交叉相乘再相减"的口诀],
)
#footnote[来源：视频画面 00\:27\:15--00\:27\:30（BV1SJ4m1W73g）。]

把两个向量写成分解式做叉乘，用分配律展开成九项，再用上面的五条结论化简，最后合并同类项，就得到坐标公式。为了让这个结果好记，教材引入了*行列式*符号：

$ arrow(a) times arrow(b) = mat(delim: "|", arrow(i), arrow(j), arrow(k); a_1, a_2, a_3; b_1, b_2, b_3) = (a_2 b_3 - a_3 b_2, a_3 b_1 - a_1 b_3, a_1 b_2 - a_2 b_1) $

其中：
- $arrow(a) = (a_1, a_2, a_3)$、$arrow(b) = (b_1, b_2, b_3)$：参与叉乘的两个向量，*顺序不能颠倒*（颠倒会差一个负号）；
- 第一行的 $arrow(i), arrow(j), arrow(k)$ 是三个基本单位向量；
- 行列式按*对角线法则*展开：三条主对角线方向的乘积取正、三条副对角线方向的乘积取负。

#knowledgebox[
*三阶行列式的对角线法则*：从左上到右下是主对角线方向，沿它可找出三条"斜线"（$a e i$、$b f g$、$c d h$），每条的三个元素相乘再相加；从右上到左下是副对角线（次对角线）方向，同样三条（$c e g$、$b d i$、$a f h$），相乘后*做减法*。总共六项。

老师说："*你不要觉得这是什么高级的东西，这就是一个计算的规则*——加减乘除是计算的规则，行列式也是。"
]

#importantbox[
*口算口诀（老师给的三句）*
1. *前上后下写两遍*：把叉乘符号*前面*的向量坐标写在上面一行，*后面*的写在下面一行，各自写*两遍*（拉长成一串）；
2. *掐头去尾取中间*：从这串里取"中间"的三组相邻两项，作为结果向量的三个分量（第一个分量掐掉头、最后一个分量去掉尾）；
3. *交叉相乘再相减*：每一组都按二阶行列式的规则——主对角线相乘减副对角线相乘。

口诀要配套理解：*中间那一列的顺序是"三在前、一在后"*，这是最容易记乱的地方，写的时候对照一下行列式展开的结果。
]

== 例题2：求与两向量均垂直的单位向量

#figure(
  image("figures/fig_13_ex2_statement.png", width: 92%),
  caption: ["【例2】向量积运算练习"：设 $a = (2,1,-1)$、$b = (1,-1,2)$，求与 $a$、$b$ 均垂直的单位向量 $\\vec(e)$],
)
#footnote[来源：视频画面 00\:20\:15--00\:20\:30（BV1SJ4m1W73g）。]

思路很清楚：与 $arrow(a)$、$arrow(b)$ 都垂直的向量，就是叉乘 $arrow(a) times arrow(b)$。老师说这时候"大学根本不跟你玩几何，就是纯计算"——图可画可不画。

*第一步：算叉乘*。

$ arrow(c) = arrow(a) times arrow(b) = mat(delim: "|", arrow(i), arrow(j), arrow(k); 2, 1, -1; 1, -1, 2) $

按对角线法则展开（三项正、三项负）：

$ arrow(c) = arrow(i)(1 times 2 - (-1) times (-1)) - arrow(j)(2 times 2 - (-1) times 1) + arrow(k)(2 times (-1) - 1 times 1) $

$ arrow(c) = arrow(i)(2 - 1) - arrow(j)(4 + 1) + arrow(k)(-2 - 1) = (1, -5, -3) $

*第二步：验证它确实与两者都垂直*（内积法）：

$ arrow(a) dot arrow(c) = 2 times 1 + 1 times (-5) + (-1) times (-3) = 0 $

$ arrow(b) dot arrow(c) = 1 times 1 + (-1) times (-5) + 2 times (-3) = 0 $

两个内积都是零，说明 $arrow(c)$ 与 $arrow(a)$、$arrow(b)$ 都垂直 ✓。

*第三步：单位化*（复习上一讲的公式）。

$ abs(arrow(c)) = sqrt(1^2 + (-5)^2 + (-3)^2) = sqrt(1 + 25 + 9) = sqrt(35) $

$ arrow(e) = +- arrow(c) / abs(arrow(c)) = +- 1/sqrt(35) (1, -5, -3) $

#figure(
  image("figures/fig_16_ex2_solution.png", width: 92%),
  caption: ["【例2】解答页：$a times b = (1,-5,-3)$，$abs(a times b) = sqrt(35)$，于是 $\\vec(e) = +- (1,-5,-3)/sqrt(35)$——正负两个方向都要写"],
)
#footnote[来源：视频画面 00\:33\:30--00\:33\:45（BV1SJ4m1W73g）。]

#warningbox[
这道题老师反复强调的失分点：*只写一个方向拿不了满分*。"和 $a$、$b$ 都垂直的向量，$arrow(c)$ 是一个方向，事实上还有与它相反的那个方向。叉乘的结果只能反映一个方向。所以答案要么是 $arrow(c)$ 的对应单位向量，要么在前面添一个*正负号*——但是*不能缺这个正负号*。"

至于什么时候可以不写正负号？看题目的要求：有些题只求叉乘就够用，但这道题问的是"单位向量"，就必须把两个方向都考虑清楚。
]

== 例题3：用叉乘求三角形面积

题目：已知三角形 $A B C$ 的顶点分别是 $A(1,2,3)$、$B(3,4,5)$、$C(2,4,7)$，求三角形 $A B C$ 的面积。

#figure(
  image("figures/fig_17_ex3_solution.png", width: 92%),
  caption: ["【例3】解答页：$arrow(A B) = (2,2,2)$、$arrow(A C) = (1,2,4)$，叉乘得 $(4,-6,2)$，面积 $S = 1/2 abs(arrow(A B) times arrow(A C)) = 1/2 sqrt(56) = sqrt(14)$"],
)
#footnote[来源：视频画面 00\:36\:45--00\:37\:00（BV1SJ4m1W73g）。]

*第一步：把"顶点"变成"同起点的两条边向量"*。三角形面积公式用的是"任意两边的叉乘"，所以先让两条边共起点：

$ arrow(A B) = (3 - 1, 4 - 2, 5 - 3) = (2, 2, 2), quad arrow(A C) = (2 - 1, 4 - 2, 7 - 3) = (1, 2, 4) $

*第二步：叉乘*。

$ arrow(A B) times arrow(A C) = mat(delim: "|", arrow(i), arrow(j), arrow(k); 2, 2, 2; 1, 2, 4) = (2 times 4 - 2 times 2, 2 times 1 - 2 times 4, 2 times 2 - 2 times 1) = (4, -6, 2) $

*第三步：取模再折半*。

$ S_("三角形") = 1/2 abs(arrow(A B) times arrow(A C)) = 1/2 sqrt(4^2 + (-6)^2 + 2^2) = 1/2 sqrt(56) = sqrt(14) $

#importantbox[
*这套流程可以完全机械化*：顶点坐标 → 两条边向量（终点减起点）→ 叉乘 → 取模 → 除以 2。老师特意说："*这里面的向量不唯一，你随便写*，什么 $arrow(B C) times arrow(A C)$、$arrow(B C) times arrow(C A)$ 都行，结果全是一样的。"

（顺带一提：这正是"解析几何"的精神——"你大学再上一年两年，会发现几何的功能基本退化了，高中玩几何讲辅助线，大学里全是坐标；高中还会说'建系建系'，大学没有'建系'这两个字了，因为它就像呼吸、像空气一样。"）
]

== 本章小结

向量积（叉积）这一节可以做如下压缩：

1. *物理来源*：力矩 $arrow(M) = arrow(O P) times arrow(F)$，大小由切向力与力臂共同决定，方向由右手规定。
2. *定义*：$abs(arrow(a) times arrow(b)) = abs(arrow(a)) abs(arrow(b)) sin theta$，方向按右手规则由 $arrow(a)$ 转向 $arrow(b)$；结果同时垂直于两个向量。
3. *几何意义*：模长 = 以两向量为邻边的*平行四边形面积*；三角形面积是它的一半。
4. *运算律*：分配律、数乘结合律；*不满足交换律*，反而有 $arrow(b) times arrow(a) = -(arrow(a) times arrow(b))$。
5. *五条结论*：自叉为零、零向量叉乘为零、平行判据 $arrow(a) times arrow(b) = arrow(0)$、反交换律、单位向量循环 $arrow(i) times arrow(j) = arrow(k)$ 等。
6. *坐标公式*：三阶行列式 $mat(delim: "|", arrow(i), arrow(j), arrow(k); a_1, a_2, a_3; b_1, b_2, b_3)$，用"前上后下写两遍、掐头去尾取中间、交叉相乘再相减"口算。
7. *典型应用*：求垂直方向（例2，注意正负两个方向）、求面积（例3）。

向量积给出的是"方向"与"面积"。如果还想问"三个向量张成的体积"以及"三个向量是否共面"，就需要把点乘和叉乘结合起来——这就是最后一节。

= 混合积

== 定义：先叉后点的一个"数"

混合积属于选修内容，本身也不难：*三个向量*做的一种运算，记作 $[arrow(a) arrow(b) arrow(c)]$（用中括号套起来），定义是——*前两个先按顺序做叉乘，结果再与第三个做点乘*：

$ [arrow(a) arrow(b) arrow(c)] = (arrow(a) times arrow(b)) dot arrow(c) $

其中：
- $arrow(a), arrow(b), arrow(c)$：三个空间向量；
- $arrow(a) times arrow(b)$：先做叉乘，得到一个向量；
- 再与 $arrow(c)$ 做点乘：向量点乘向量，最终结果*是一个数*。

先考考你：这个结果是数还是向量？——*是数*。因为叉乘得到向量，两个向量再做点乘，最终结果只能是数字。

== 几何意义：平行六面体的体积

#figure(
  image("figures/fig_18_mixed_props.png", width: 92%),
  caption: ["混合积运算性质与结论"页：① 轮换对称性 $[a b c] = [b c a] = [c a b]$；② 对换变号（画面写"两对换"，即 $[a a b] = -[a b a] = -[b a a]$ 一类）；③ 三向量 $a, b, c$ 共面 $<==> [a b c] = 0$；④ 以 $a, b, c$ 为棱的平行六面体体积为 $abs([a b c])$],
)
#footnote[来源：视频画面 00\:42\:00--00\:42\:15（BV1SJ4m1W73g）。]

先直接记住结论，再来看为什么：

#importantbox[
*混合积的几何意义*：$abs([arrow(a) arrow(b) arrow(c)])$ 表示以 $arrow(a), arrow(b), arrow(c)$ 为*棱*的平行六面体的*体积*。
]

为什么？把定义展开：$[arrow(a) arrow(b) arrow(c)] = abs(arrow(a) times arrow(b)) dot abs(arrow(c)) dot cos theta$，这里把两个向量的点乘写成"模乘模乘夹角余弦"的形式。

- 第一因子 $abs(arrow(a) times arrow(b))$ 的几何意义是：以 $arrow(a), arrow(b)$ 为邻边的*平行四边形的面积*——它恰好是平行六面体的*一个底面*；
- 第二因子 $abs(arrow(c)) cos theta$ 是 $arrow(c)$ 在 $arrow(a) times arrow(b)$ 方向上的投影，而 $arrow(a) times arrow(b)$ *垂直于底面*，所以这个投影正是平行六面体的*高*。

底面积乘高就是体积——于是 $[arrow(a) arrow(b) arrow(c)]$ 的绝对值就是平行六面体的体积。

#figure(
  cetz.canvas(length: 0.85cm, {
    import cetz.draw: *
    ortho(x: -32deg, y: 58deg, {
      let o = (0, 0, 0)
      let a = (3.2, 0.6, 0)
      let b = (1.1, 2.6, 0)
      let c = (0.7, 1.0, 2.4)
      // 棱向量
      line(o, a, stroke: 1.2pt + c-blue, mark: (end: "stealth"))
      content((1.9, -0.5, 0), $arrow(a)$, fill: c-blue)
      line(o, b, stroke: 1.2pt + c-red, mark: (end: "stealth"))
      content((-0.5, 1.6, 0), $arrow(b)$, fill: c-red)
      line(o, c, stroke: 1.2pt + c-green, mark: (end: "stealth"))
      content((1.25, 1.0, 1.4), $arrow(c)$, fill: c-green)
      // 其余棱
      let ab = (a.at(0)+b.at(0), a.at(1)+b.at(1), 0)
      let ac = (a.at(0)+c.at(0), a.at(1)+c.at(1), a.at(2)+c.at(2))
      let bc = (b.at(0)+c.at(0), b.at(1)+c.at(1), b.at(2)+c.at(2))
      let abc = (a.at(0)+b.at(0)+c.at(0), a.at(1)+b.at(1)+c.at(1), a.at(2)+c.at(2))
      line(a, ab, stroke: 0.7pt + luma(150))
      line(b, ab, stroke: 0.7pt + luma(150))
      line(a, ac, stroke: 0.7pt + luma(150))
      line(b, bc, stroke: 0.7pt + luma(150))
      line(c, ac, stroke: 0.7pt + luma(150))
      line(c, bc, stroke: 0.7pt + luma(150))
      line(ab, abc, stroke: 0.7pt + luma(150))
      line(ac, abc, stroke: 0.7pt + luma(150))
      line(bc, abc, stroke: 0.7pt + luma(150))
      // 高：从 c 到底面
      line(c, (c.at(0), c.at(1), 0), stroke: (paint: c-green, dash: "dashed"))
      content((0.15, 1.1, 1.1), [$h$], fill: c-green)
    })
  }),
  caption: [混合积的立体图景：$abs(arrow(a) times arrow(b))$ 是底面平行四边形的面积，$abs(arrow(c)) cos theta$ 是高——两者相乘就是平行六面体的体积],
)
#footnote[来源：按视频讲解（00\:38\:40--00\:40\:15）重绘。]

#warningbox[
*注意"绝对值"在这里的含义*：混合积本身*可能是正的，也可能是负的*。当 $arrow(a), arrow(b), arrow(c)$ 组成*右手系*（右手四指从 $arrow(a)$ 转向 $arrow(b)$ 时，大拇指正好指向 $arrow(c)$）时，混合积为正，等于体积；当它们构成*左手系*时，混合积取*相反数*（负值）。

所以准确的说法是："*绝对值*是体积"，而不是"混合积永远非负"。
]

== 坐标公式与两条性质

计算混合积"依然主打坐标公式"，而且"非常好记"：把三个向量的坐标依次写成第一行、第二行、第三行，求这个三阶行列式即可。

$ [arrow(a) arrow(b) arrow(c)] = mat(delim: "|", a_x, a_y, a_z; b_x, b_y, b_z; c_x, c_y, c_z) $

其中：
- $arrow(a) = (a_x, a_y, a_z)$、$arrow(b) = (b_x, b_y, b_z)$、$arrow(c) = (c_x, c_y, c_z)$：三个空间向量；
- 行列式按对角线法则展开成六项求和。

怎么推的？"简单看一下：$arrow(a) times arrow(b)$ 这个向量前面介绍过了，再点乘 $arrow(c)$——两个向量做点乘就是*对应分量相乘相加*。用一点点线性代数的知识不难得到，它就是上面这个行列式。"（没学过线性代数的同学，"等学完了再回来看就能看懂"。）

#importantbox[
*混合积的两条核心性质*
1. *轮换对称性*：$[arrow(a) arrow(b) arrow(c)] = [arrow(b) arrow(c) arrow(a)] = [arrow(c) arrow(a) arrow(b)]$ ——三个向量"轮着向后走位"，混合积不变。原因还是右手系/左手系的判定：轮换不会改变三者的*相对旋转顺序*，所以要么一直是右手系（同为正），要么一直是左手系（同为负），符号与绝对值都不变。
2. *对换变号*：把*其中两个*向量的位置交换（而第三个不动），混合积*立刻变号*——右手系立刻变左手系，左手系立刻变右手系。
]

#knowledgebox[
对换变号这件事，用线性代数的语言解释最干净：*行列式交换两行（或两列），值立刻反号*。而混合积本来就是那三个坐标构成的行列式——交换两个向量，等于交换行列式的两行，于是变号。
]

== 共面判据：混合积最大的用处

老师明确说："第三条是*我们学习混合积最大的意义*——搞*向量共面*它是最好用的。"

$ [arrow(a) arrow(b) arrow(c)] = 0 quad <==> quad arrow(a), arrow(b), arrow(c) "共面" $

为什么？混合积等于零，说明平行六面体的*体积是零*——而"体积为零"就是"没有体积"：三个向量都拍在同一个平面上，你根本画不出一个立方体来。

换一个角度说：只要出现混合积为零，就说明三个向量共面；两个向量必然共面（随便怎么拼都在一个面上），只有引入第三个向量，才谈得上"共面"这个约束。

#figure(
  image("figures/fig_19_ex4_solution.png", width: 92%),
  caption: ["【例4】混合积运算练习"解答：设 $[a b c] = 2$，则 $[(a + b) times (b + c)] dot (c + a)$ 展开后只剩 $[a b c] + [b c a]$ 两项，等于 $2 + 2 = 4$（其余各项因含重复向量而为零）],
)
#footnote[来源：视频画面 00\:47\:30--00\:47\:45（BV1SJ4m1W73g）。]

#knowledgebox[
*这在线性代数里叫什么？* 混合积为零，等价于这三个向量*线性相关*——至少有一个向量能被其余两个表示出来。所以学混合积也能帮助我们从几何角度理解"行列式为零""线性相关"这些结论。老师补了一句很实在的话："*现代点到为止啊，听不懂就算了，听懂就赚了。*"
]

== 例题4：混合积的恒等变形（考研题）

题目：设 $[arrow(a) arrow(b) arrow(c)] = 2$，求 $[(arrow(a) + arrow(b)) times (arrow(b) + arrow(c))] dot (arrow(c) + arrow(a))$。

#figure(
  image("figures/fig_18_mixed_props.png", width: 92%),
  caption: ["【例4】"所属页面（混合积性质与结论）；解题时"轮换对称性"是主要工具],
)
#footnote[来源：视频画面 00\:44\:00--00\:44\:15（BV1SJ4m1W73g）。]

这类题看着复杂，其实"无非就那些运算法则"。策略是：*把叉乘先分配展开，再从中挑出"混合积"*。

*第一步：把中括号里的叉乘拆开*（叉乘满足分配律，注意顺序）：

$ (arrow(a) + arrow(b)) times (arrow(b) + arrow(c)) = arrow(a) times arrow(b) + arrow(a) times arrow(c) + arrow(b) times arrow(b) + arrow(b) times arrow(c) $

其中 $arrow(b) times arrow(b) = arrow(0)$（自叉为零），所以只剩三项。

*第二步：再与 $(arrow(c) + arrow(a))$ 逐项做点乘*（点乘满足分配律，八项全部展开），然后*逐项排查哪些为零*：

- $(arrow(a) times arrow(b)) dot arrow(c) = [arrow(a) arrow(b) arrow(c)] = 2$ ✓ 保留；
- $(arrow(a) times arrow(b)) dot arrow(a) = [arrow(a) arrow(b) arrow(a)] = 0$：*混合积里出现了重复向量 $arrow(a)$，三个向量必然共面，混合积为零*；
- $(arrow(a) times arrow(c)) dot arrow(c) = [arrow(a) arrow(c) arrow(c)] = 0$：出现了重复的 $arrow(c)$；
- $(arrow(a) times arrow(c)) dot arrow(a) = [arrow(a) arrow(c) arrow(a)] = 0$：又出现了重复的 $arrow(a)$；
- $(arrow(b) times arrow(c)) dot arrow(c) = [arrow(b) arrow(c) arrow(c)] = 0$：重复 $arrow(c)$；
- $(arrow(b) times arrow(c)) dot arrow(a) = [arrow(b) arrow(c) arrow(a)] = [arrow(a) arrow(b) arrow(c)] = 2$（用轮换对称性把 $arrow(a)$ 转到最前面）✓ 保留。

*第三步：把非零项相加*：

$ "原式" = [arrow(a) arrow(b) arrow(c)] + [arrow(b) arrow(c) arrow(a)] = 2 + 2 = 4 $

#importantbox[
*两条通用经验*
1. *混合积里出现重复向量，直接写 0*——"我看到重复向量了，就意味着这几个向量一定共面；两个向量随便怎么拼都在一个面上"；
2. *轮换对称性是把顺序"摆正"的工具*：看到 $[arrow(b) arrow(c) arrow(a)]$，记得它等于 $[arrow(a) arrow(b) arrow(c)]$，不用重新算。
]

== 例题5：四点共面与平面方程（三点式）

最后是一道教材例题，也是混合积几何意义的收官应用。

题目：已知四点 $A(1,2,0)$、$B(2,3,1)$、$C(4,2,2)$、$M(x,y,z)$ 共面，求点 $M$ 的坐标 $x, y, z$ 所满足的关系式。

#figure(
  image("figures/fig_20_ex5_solution.png", width: 92%),
  caption: ["【例5】解答页：$arrow(A B) = (1,1,1)$、$arrow(A C) = (3,0,2)$、$arrow(A M) = (x-1, y-2, z)$；三向量共面即混合积为零，展开整理得 $2x + y - 3z - 4 = 0$"],
)
#footnote[来源：视频画面 00\:49\:00--00\:49\:15（BV1SJ4m1W73g）。]

*第一步：把"四点共面"翻译成"三向量共面"*。三维空间中三个不共线的点永远能确定一个平面，但再加第四个点就不一定了。如果四点仍然共面，那么以其中一个点为公共起点，可以找出三个向量——这里选 $arrow(A B)$、$arrow(A C)$、$arrow(A M)$（*四个点全都用上了*）。

*第二步：写三个向量的坐标*。

$ arrow(A B) = (2 - 1, 3 - 2, 1 - 0) = (1, 1, 1) $

$ arrow(A C) = (4 - 1, 2 - 2, 2 - 0) = (3, 0, 2) $

$ arrow(A M) = (x - 1, y - 2, z - 0) = (x - 1, y - 2, z) $

#knowledgebox[
老师顺带讲了一个*选向量的技巧*："*三个向量里不要出现太多 $M$*"——因为凡是带 $M$ 的向量坐标都要写成 $x, y, z$ 的形式，未知量越多越难算。像这里，$arrow(A B)$、$arrow(A C)$ 都是纯数字，"常数多一点它不香吗"。
]

*第三步：三向量共面 ⟺ 混合积为零*，把三个坐标依次作为行列式的三行：

$ mat(delim: "|", x - 1, y - 2, z; 1, 1, 1; 3, 0, 2) = 0 $

其中：顺序可以随便排（共面时混合积无论怎么排都是零），但老师建议"*把有变量的那个写第一行，好算*"。

*第四步：按对角线法则展开*。主对角线方向三项：$2(x-1)$、$3(y-2)$、$z dot 1 dot 0$（含有因子 $0$，直接不写）；副对角线方向三项：$3z$、$2(y-2)$、$0 dot 1 dot (x-1)$（同样含 $0$，不写）。于是

$ 2(x - 1) + 3(y - 2) - 3z - 2(y - 2) = 0 $

整理同类项：

$ 2x + y - 3z - 4 = 0 $

#warningbox[
展开时"*只要有一个零，我们就能去掉两项*"——见到行列式里的零要主动利用，这是口算快慢的关键（本题六项里直接消掉两项）。
]

#importantbox[
*这个方程是什么？* 老师给出预告："*它其实就是 $A B C$ 所在这个平面的平面方程*。"——所谓"方程"，就是平面上任意一点 $(x,y,z)$ 永远满足的那个等式。通过三个已知点的坐标确定平面方程的这种形式，称为*三点式平面方程*，下一讲（空间平面与直线）会专门展开。
]

== 本章小结

混合积把"叉乘"和"点乘"串了起来：

1. *定义*：$[arrow(a) arrow(b) arrow(c)] = (arrow(a) times arrow(b)) dot arrow(c)$，*先叉后点*，结果是*一个数*。
2. *几何意义*：$abs([arrow(a) arrow(b) arrow(c)])$ 等于以三向量为棱的*平行六面体体积*（底面积 $abs(arrow(a) times arrow(b))$ 乘高 $abs(arrow(c)) cos theta$）；符号由三向量构成右手系还是左手系决定。
3. *坐标公式*：三个向量坐标依次作三行构成的三阶行列式。
4. *两条性质*：轮换对称 $[arrow(a) arrow(b) arrow(c)] = [arrow(b) arrow(c) arrow(a)] = [arrow(c) arrow(a) arrow(b)]$；对换变号。
5. *最强应用*：$[arrow(a) arrow(b) arrow(c)] = 0 <==> $ 三向量共面（等价于三行向量线性相关），可用来判定四点共面并直接写出平面方程。

= 总结与延伸

== 三种"积"的一页对照

#booktabs-table(
  columns: (auto, auto, 1fr, 1fr),
  table.header([运算], [记法], [结果类型与公式], [主要用途]),
  [数量积（点积）], [$arrow(a) dot arrow(b)$], [*数*：$abs(a) abs(b) cos theta$，坐标式 $a_x b_x + a_y b_y + a_z b_z$], [求夹角、判垂直、求投影、证共面（间接）],
  [向量积（叉积）], [$arrow(a) times arrow(b)$], [*向量*：模 $abs(a) abs(b) sin theta$，方向按右手规则；坐标式三阶行列式], [求同时垂直的方向、平行四边形/三角形面积],
  [混合积], [$[arrow(a) arrow(b) arrow(c)]$], [*数*：$(arrow(a) times arrow(b)) dot arrow(c)$，三阶行列式], [平行六面体体积、三向量（四点）共面判定],
)

== 讲者的三条"心法"

1. *名字就是答案*：数量积的"数量"、向量积的"向量"，都是在说明积出来的东西是什么类型——记不住结果类型时，回头读一遍名字。
2. *物理概念先吃透，计算交给坐标*：力矩讲清楚了，叉乘的方向规则就不用背；而真到做题，"大学根本不跟你玩几何，就是纯计算"。
3. *口诀与顺序*：叉乘的坐标公式用"前上后下写两遍、掐头去尾取中间、交叉相乘再相减"；而所有与叉乘相关的运算（包括混合积）都要*咬死顺序*，顺序一乱就要考虑负号。

== 与后续内容的接口

#importantbox[
1. *平面方程*：例5 得到的 $2x + y - 3z - 4 = 0$ 就是平面方程；而平面的一般式 $A x + B y + C z + D = 0$ 中的 $(A, B, C)$ 正是平面的*法向量*——下一讲的主角，求法向量的标准手段就是*叉乘*。
2. *直线方程*：直线可由"一点 + 方向向量"确定，而方向向量常常由两点做差得到（第一讲的 $arrow(A B) = $ 终点减起点）。
3. *距离公式*：点到平面、异面直线之间的距离，全部由叉乘与投影的模导出。
4. *曲面积分*：第二类曲面积分中的方向余弦、法向量定向，本质上是本讲"叉乘定方向"的进一步应用。
]

== 开放问题与下一步

- 本讲已经能由三点写出平面方程（三点式），但形式还不统一、也不便于识别几何特征——*平面的一般式、点法式、截距式*分别是什么样子？这是下一讲的问题。
- 空间中的直线如何用一个方程（或一组方程）表示？两条直线平行、垂直、相交、异面如何判别？
- 有了平面与直线的方程，*点到平面的距离、点到直线的距离、两个平面之间的夹角*如何计算？

下一关就是"空间平面与直线"——本讲准备的 $dot$、$times$、$[dot dot]$ 三件工具，都会在那里派上用场。
