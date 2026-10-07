// ═══════════════════════════════════════════════════════════════════════════
// lec-01 向量与空间直角坐标系 — 一高数《高等数学（下）》8-1
// 素材：B 站 BV15A4m1G7zG（ai-zh 字幕 + 1080P 视频帧，图均已三方验证）
// 模板：lecture-to-notes 的 Typst 轨道（material-to-notes notes-template.typ）
// 版本：typst 0.15.1 / cetz 0.5.2 / ilm 2.1.1 / cetz-plot 0.1.4 / fletcher 0.5.8
// ═══════════════════════════════════════════════════════════════════════════
#import "@preview/ilm:2.1.1": *
#import "@preview/cetz:0.5.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/cetz-plot:0.1.4": plot, chart

// ═══ 四色判断框（lecture-to-notes tcolorbox 的 Typst 实现）═══
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
  title,
  body,
  bg: rgb("#eefaf1"),
  title-bg: rgb("#2e9e5b"),
  title-fg: white,
  stroke: 1pt + luma(70),
) = block(
  width: 100%, breakable: true, radius: 0pt,
  fill: bg, stroke: stroke, inset: 0pt,
)[
  #block(width: 100%, fill: title-bg, inset: (x: 8pt, y: 3pt), radius: 0pt)[
    #text(fill: title-fg, weight: "bold")[#title]
  ]
  #block(width: 100%, inset: (x: 9pt, y: 7pt))[#body]
]

// ═══ 行内机器符号样式 + 代码块 ═══
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
    fill: none,
    inset: (x: 8pt, y: 5pt),
    ..rows,
  )
]

#let unnumbered(body) = { set math.equation(numbering: none); body }

// ═══ 图示尺寸与配色 ═══
#let c-red = rgb("#c0392b")
#let c-blue = rgb("#2f6fd0")
#let c-green = rgb("#2e9e5b")

// ═══════════════════════════════════════════════════════════════════════════
// 元数据
// ═══════════════════════════════════════════════════════════════════════════
#let note-title    = [空间直角坐标系与向量及其线性运算]
#let note-subtitle = [一高数《高等数学（下）》8-1：向量代数与空间解析几何（上篇）]
#let note-author   = [lecture-to-notes]
#let src-type      = [B 站教学视频（1080P 视频帧 + ai-zh 字幕）]
#let src-path      = [https://www.bilibili.com/video/BV15A4m1G7zG]
#let src-scale     = [40 分 16 秒（UP 主：一高数）]
#let cover-path    = "cover.jpg"

#show: ilm.with(
  title: note-title,
  authors: ("lecture-to-notes",),
  date: datetime.today(),
  abstract: [以讲课叙事流架构展开。上半场把一切几何问题安放在空间直角坐标系上：从二维到三维的升级、右手系的两种判法、三个坐标面与八个卦限、对称点的分量规律，一直到用长方体体对角线两次勾股推出空间两点间距离公式。下半场回到向量本身：自由向量为什么可以平移、模与双竖线的三种含义、夹角给出的平行与垂直、加法减法数乘的几何解释与运算律，并落地为「$arrow(a) parallel arrow(b)$ 的充要条件是 $arrow(b) = lambda arrow(a)$」与单位化公式 $arrow(e) = arrow(a) / |arrow(a)|$。终场把向量搬进坐标系：分向量 $arrow(i), arrow(j), arrow(k)$ 给出分解式与坐标式，从此加减数乘、平行判别、求模全部变成坐标运算，最后进入方向角与方向余弦——它在曲线积分、曲面积分里无处不在。每个结论都配原始板书帧（含时间戳来源）与 CeTZ 重绘图，符号表逐条列出。],
  bibliography: none,
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

// ═══ 封面页 ═══
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

= 开篇：为什么高数下要先把"坐标系"重学一遍

老师开场就点明了这一讲的处境：也许有些同学不考这一块（不同专业对空间解析几何的要求不一样），但他的评价很直接——

> 不懂向量代数与空间解析几何就学高数下，你就像一只草履虫，对真正的三维世界一无所知。

这话说得糙，但背后的逻辑是硬的：高数上册我们研究的是一元函数，它结合的是*平面*解析几何，也就是二维世界的事情；到了下半场，研究对象升级为*多元函数*和*空间解析几何*，我们已经来到了三维甚至更高维度的世界。而多元函数的极限、偏导数、重积分、曲线曲面积分，全部要在三維空间里发生——你连"空间里的一个点怎么表示、两个点有多远、一条线朝哪个方向"都没搞清楚，后面的积分区域、曲面法向、方向导数就无从谈起。

所以这一讲干的事只有两件：第一，把空间直角坐标系建立起来；第二，把向量这种"有方向的量"重新认识一遍。第三部分（把向量放进坐标系）是这一讲的落点——从此几何问题可以当代数题做。

#importantbox[
本讲是全章的地基：后续的平面方程、直线方程、曲面方程、曲线方程，乃至二重积分换序、曲面积分的定向，全部建立在本讲的两样东西上——*空间直角坐标系*与*向量的坐标表示*。
]

= 空间直角坐标系

== 从二维到三维：为什么要第三条轴

在二维平面上，我们想定位一个点，只需要建立平面直角坐标系，就能用唯一的 $x, y$ 坐标把它表示出来，一一对应，没有歧义。但是三维空间不行了——空间中的一个点，需要*三条两两垂直的坐标轴* $x, y, z$ 才能锁定。

#figure(
  image("figures/fig_01_2d_vs_3d.png", width: 92%),
  caption: [二维与三维的对照：平面中一点 $P$ 与坐标 $(x, y)$ 一一对应（"二次元"），空间中一点 $M$ 与坐标 $(x, y, z)$ 一一对应（"三次元"）],
)
#footnote[来源：视频画面 00\:01\:00--00\:01\:15（BV15A4m1G7zG）。]

老师特意在这张图上做了个"次元"的玩笑：二维世界叫"二次元"，三维世界叫"三次元"——不是为了搞笑，而是要你把*多出来的那一维*刻在脑子里。因为后面所有容易错的地方，几乎都源于"忘了还有第三个分量"。

#figure(
  cetz.canvas(length: 1.0cm, {
    import cetz.draw: *
    ortho(x: -35deg, y: 55deg, {
      // 三条坐标轴
      line((0, 0, 0), (4.2, 0, 0), stroke: 0.9pt, mark: (end: "stealth"))
      line((0, 0, 0), (0, 4.2, 0), stroke: 0.9pt, mark: (end: "stealth"))
      line((0, 0, 0), (0, 0, 4.2), stroke: 0.9pt, mark: (end: "stealth"))
      content((4.6, 0, 0), $x$)
      content((0, 4.6, 0), $y$)
      content((0, 0, 4.6), $z$)
      content((0, 0, 0), $O$, anchor: "north-east")
      // 空间中的一点与其坐标
      line((0, 0, 0), (2.2, 2.0, 2.6), stroke: 1.2pt + c-red, mark: (end: "stealth"))
      content((2.4, 2.1, 2.8), $M(x, y, z)$)
      // 投影虚线
      line((2.2, 2.0, 2.6), (2.2, 2.0, 0), stroke: (paint: luma(140), dash: "dashed"))
      line((2.2, 2.0, 0), (0, 0, 0), stroke: (paint: luma(140), dash: "dashed"))
      line((2.2, 0, 0), (2.2, 2.0, 0), stroke: (paint: luma(140), dash: "dashed"))
      content((2.2, -0.45, 0), $x$, fill: c-blue)
      content((-0.45, 2.0, 0), $y$, fill: c-blue)
      content((2.2, 2.0, 0), $P$, anchor: "north")
    })
  }),
  caption: [空间直角坐标系与点的坐标：过 $M$ 向各坐标轴引垂线，三个垂足读数 $x, y, z$ 就是 $M$ 的坐标],
)
#footnote[来源：按视频讲解（00\:03\:00--00\:03\:45）重绘。]

#importantbox[
空间中一个点的坐标写作 $M(x, y, z)$，三个分量各有名字：
- $x$ 叫*横坐标*，
- $y$ 叫*纵坐标*，
- $z$ 叫*竖坐标*。

最后一个名字老师专门提醒："*竖坐标*这个以后会经常提到"，不要只记成"第三个坐标"——因为竖坐标的正负号，后面直接决定曲面积分里法向量的方向。
]

== 右手系：两条轴向第三条轴的唯一确定

三条轴不是随便摆的，它们的方向关系必须满足*右手系*。老师说得很形象：$x$ 轴朝前、$y$ 轴向右、$z$ 轴朝上，这个方向关系就叫右手系。为什么叫"右手"？因为它要靠你的右手来判定。

#figure(
  image("figures/fig_02_right_hand.png", width: 88%),
  caption: [右手定则的现场演示：一只右手配三条坐标轴，说明"四指从 $x$ 轴转向 $y$ 轴，大拇指指向 $z$ 轴正方向"的判法],
)
#footnote[来源：视频画面 00\:02\:15--00\:02\:30（BV15A4m1G7zG）。]

关于右手系，老师给了*两种解读*，考场上哪种顺手用哪种：

#importantbox[
*判法一（四指法）*：伸出右手，四指从 $x$ 轴的*正方向*沿 $90 degree$ 的方向转向 $y$ 轴的正方向，这时你的大拇指指向的就是 $z$ 轴的*正方向*。
*判法二（三指法）*：伸出右手，掌心向上，让大拇指指向 $x$ 轴正方向、食指指向 $y$ 轴正方向，然后弹出中指——只要长的是正常人的手，中指就只能唯一地指向一个方向，那就是 $z$ 轴的正方向（剩下两个指头窝在手心里即可）。
]

老师还补了一句反例，把"唯一确定"这四个字钉死：如果你规定 $x$ 轴正方向朝这边、$y$ 轴正方向朝那边，按照右手系来说，四指从 $x$ 轴沿 $90 degree$ 转向 $y$ 轴时，大拇指就只能竖直向*下*去——那就不是右手系了。也就是说：$x$ 轴与 $y$ 轴一经指定，$z$ 轴的正方向就没有自由度了。

#warningbox[
考试作图时，坐标轴的顺序要按右手系来画（通常 $x$ 轴朝左前、$y$ 轴朝右、$z$ 轴朝上）。一旦画成左手系，后面用"右手法则"判断向量积方向、判断曲面外侧法向时就会全盘反向——这是最隐蔽的一类失分点。
]

== 坐标轴上的点、坐标面上的点

知道了坐标系，就要练"看坐标说位置"的功夫。老师点了三类点：

#figure(
  cetz.canvas(length: 1.0cm, {
    import cetz.draw: *
    // 左：xOy 面上的点；右：z 轴上的点
    line((0, 0), (3.4, 0), stroke: 0.8pt, mark: (end: "stealth"))
    line((0, 0), (0, 3.0), stroke: 0.8pt, mark: (end: "stealth"))
    line((0, 3.0), (3.4, 3.0), stroke: (paint: luma(170), dash: "dashed"))
    line((3.4, 0), (3.4, 3.0), stroke: (paint: luma(170), dash: "dashed"))
    content((3.6, 0), $x$)
    content((0, 3.3), $y$)
    content((0, 0), $O$, anchor: "north-east")
    circle((2.0, 1.6), radius: 0.07, fill: c-red, stroke: none)
    content((2.1, 1.85), $P(x, y, 0)$)
    content((0.9, -0.5), [坐标面上的点：第三个分量为零], fill: c-red)
  }),
  caption: [坐标面上的点：落在 $x O y$ 面上的点，其 $z$ 分量必然为零——这正是"面上有一个约束，空间就少一维"的最直观体现],
)
#footnote[来源：按视频讲解（00\:04\:00--00\:04\:50）重绘。]

#importantbox[
三类点的分量特征（看一个坐标就能判断它在哪）：
- *坐标轴上的点*：只有该轴对应的分量可能非零，其他两个分量一定是零。例如 $z$ 轴上的点形如 $(0, 0, c)$，如字幕里的例子 $(0, 0, 3)$。
- *坐标面上的点*：只有一个分量恒为零，另两个任取。每两条坐标轴确定一个坐标面，分别是 $x O y$ 面、$y O z$ 面、$x O z$ 面。
- *一般位置的点*：三个分量都可以非零。
]

老师课上还考了大家一题："$x O z$ 面用 $x, y, z$ 的坐标怎么表示？也就是这个面上的点，它的 $x, y, z$ 会满足什么值呢？"答案是——

$x O z$ 面上的点，满足 $y = 0$；$x, z$ 没有任何限制，任取。

#warningbox[
三个坐标面的约束不要背混：$x O y$ 面是 $z = 0$，$y O z$ 面是 $x = 0$，$x O z$ 面是 $y = 0$。口诀是"*缺谁谁为零*"——面上的名字里没有哪个字母，那个字母对应的分量就等于零。
]

== 八个卦限：三维版的"象限"

三张坐标平面在空间中无限延展，会把整个空间分成几个部分？老师的答案：*八个部分*。

平面上两条坐标轴划分了四个象限，空间中就叫*八个卦限*。

#figure(
  image("figures/fig_04_quadrant_vs_octant.png", width: 88%),
  caption: [象限与卦限的对照图：平面两轴划出四个象限，空间三轴划出八个卦限；注意卦限编号多出了 $z$ 轴负半轴带来的那一半],
)
#footnote[来源：视频画面 00\:06\:15--00\:06\:30（BV15A4m1G7zG）。]

#figure(
  image("figures/fig_03_octants_5to8.png", width: 88%),
  caption: [卦限编号演示：$z$ 轴负半轴一侧的第五至第八卦限，与上半空间的编号规则完全平行],
)
#footnote[来源：视频画面 00\:06\:00--00\:06\:15（BV15A4m1G7zG）。]

八卦限的编号规则是：*从 $x, y, z$ 都为正开始，这里是第一卦限，然后逆时针转过去*，第二、第三、第四；$z$ 轴负半轴那一侧接着排第五、第六、第七、第八。也就是说，它的编号逻辑和平面上的四象限完全一致，只是多了一整个"下半空间"。

#knowledgebox[
老师在这里玩了个梗——讲到"八卦限"时突然说"咱不是在学微积分吗，怎么突然有内味儿了？什么味儿？易经对吧"。然后顺势给了个记忆法："太极生两仪，两仪生四象，四象生八卦"，所以你恍然大悟：原来"象限"这个词的真正含义不是英语或法语的音译，而是"四象"——平面两轴生四象（象限），空间三轴生八卦（卦限）。这个梗记住了，卦限是八个就再也忘不掉了。
]

不过老师也说了一句实在话：*平常你很少会看到书上或者答案解析说"第几卦限"*，一般就直接说"$x, y, z$ 都为正"就把方位描述清楚了。所以卦限这个概念重在理解，不必纠结书上的措辞。

== 例题：方位感与对称点

有了基本常识，老师出了两道题练手，并且给出了比"答案"更重要的*方法*。

=== 第一题：判断卦限

#figure(
  image("figures/fig_05_practice_position.png", width: 92%),
  caption: ["空间直角坐标系的基本常识与方位感培养·随手练"：第 (1) 问判断 $A(1, -2, 3)$ 在第几卦限，第 (2) 问写出 $(a, b, c)$ 关于 $x O y$ 面、$z$ 轴、原点的对称点；画面中已填入 $A$ 落在第 IV 卦限的结论],
)
#footnote[来源：视频画面 00\:08\:00--00\:08\:15（BV15A4m1G7zG）。]

这种题怎么做最快？老师的做法是：*先看平面部分，再看竖直方向*。

$A(1, -2, 3)$ 的 $x$ 为正、$y$ 为负——这正是我们熟悉的平面直角坐标系里*第四象限*的特征；这里 $z = 3 > 0$，落在上半空间，所以是第四卦限（如果 $z < 0$，同样的 $x, y$ 符号就属于第八卦限）。老师课堂上的原话很传神："$x$ 正 $y$ 负……四、八，那四八卦限你选谁呢？看 $z$ 的符号，$z$ 等于三大于零，所以是上面这个第四卦限。"

#figure(
  image("figures/fig_06_symmetry_summary.png", width: 92%),
  caption: [随手练的完成版与红字小结：关于坐标轴的对称点，该轴对应的分量不变，其余两个分量变成相反数],
)
#footnote[来源：视频画面 00\:09\:15--00\:09\:30（BV15A4m1G7zG）。]

=== 第二题：对称点

在空间直角坐标系中定位任意一点 $(a, b, c)$，求它关于三个对象的对称点。老师坚持"*从图中观察*"而不是背结论：

- *关于 $x O y$ 面的对称点*：垂直于 $x O y$ 面穿过去，你会发现 $z$ 值变成相反数（从正变负），而 $x, y$ 的坐标没什么变化，所以是 $(a, b, -c)$。
- *关于 $z$ 轴的对称点*：垂直于 $z$ 轴再穿过去。显然竖坐标 $c$ 维持不变，而本来正的 $x$ 变成负的、正的 $y$ 也变成负的，所以是 $(-a, -b, c)$。
- *关于原点的对称点*：连接 $(a, b, c)$ 与原点并延长，所有坐标全都要变成相反数，所以是 $(-a, -b, -c)$。

#figure(
  cetz.canvas(length: 1.0cm, {
    import cetz.draw: *
    ortho(x: -35deg, y: 55deg, {
      line((0, 0, 0), (3.6, 0, 0), stroke: 0.8pt, mark: (end: "stealth"))
      line((0, 0, 0), (0, 3.6, 0), stroke: 0.8pt, mark: (end: "stealth"))
      line((0, 0, 0), (0, 0, 3.4), stroke: 0.8pt, mark: (end: "stealth"))
      content((3.9, 0, 0), $x$)
      content((0, 3.9, 0), $y$)
      content((0, 0, 3.7), $z$)
      // 点 A(a,b,c) 与其关于 z 轴的对称点
      circle((1.6, 1.2, 2.2), radius: 0.06, fill: c-red, stroke: none)
      content((1.75, 1.3, 2.4), $A(a, b, c)$)
      line((1.6, 1.2, 2.2), (0, 0, 2.2), stroke: (paint: c-red, dash: "dashed"))
      circle((-1.6, -1.2, 2.2), radius: 0.06, fill: c-blue, stroke: none)
      content((-1.75, -1.3, 2.4), $A'_z (-a, -b, c)$)
      line((0, 0, 2.2), (-1.6, -1.2, 2.2), stroke: (paint: c-blue, dash: "dashed"))
      // 关于原点的对称点
      line((1.6, 1.2, 2.2), (-1.6, -1.2, -2.2), stroke: (paint: luma(150), dash: "dotted"))
      circle((-1.6, -1.2, -2.2), radius: 0.06, fill: c-green, stroke: none)
      content((-1.8, -1.4, -2.5), $A_O (-a, -b, -c)$)
    })
  }),
  caption: [对称点的一图看清：关于 $z$ 轴对称时，$z$ 分量保持不变、$x$ 与 $y$ 同时反号；关于原点对称时三个分量全部反号],
)
#footnote[来源：按视频讲解（00\:07\:40--00\:09\:20）重绘。]

看图像观察规律之后，老师做了一条小结，这是本节的*考点精华*：

#importantbox[
*对称点法则*
- 关于*坐标轴*对称：你关于哪个轴对称，*这个轴的分量不变*，其余两个分量*全部变成相反数*。
- 关于*坐标面*对称：你关于哪个面对称，*这个面的法向分量变号*（例如关于 $x O y$ 面，$z$ 变号），面上那两个分量不变。
- 关于*原点*对称：三个分量*全部变号*。
]

#warningbox[
最容易错的是"关于面对称"和"关于轴对称"混为一谈。判断的抓手永远是那句话：*"哪个轴/面变了，哪些没变"*——在图上画一次垂线，比背三个公式可靠得多。
]

== 两点间的距离公式

最后是这一节的压轴常识：在空间直角坐标系中，两点 $M_1(x_1, y_1, z_1)$ 与 $M_2(x_2, y_2, z_2)$ 之间的距离。

公式应该都还记得：*各分量差的平方和，再开算术平方根*。

$ |M_1 M_2| = sqrt((x_2 - x_1)^2 + (y_2 - y_1)^2 + (z_2 - z_1)^2) $

其中：
- $M_1 (x_1, y_1, z_1)$、$M_2 (x_2, y_2, z_2)$：空间中任意两点；
- $x_2 - x_1, y_2 - y_1, z_2 - z_1$：两点在三个坐标轴方向上的坐标增量；
- $|M_1 M_2|$：线段 $M_1 M_2$ 的长度（两点间的距离）。

但老师强调："你还记得它是*怎么来的*吗？"——这个推导值得复习，因为它是"把空间问题化成平面问题"的第一次示范。

#figure(
  image("figures/fig_07_box_diagonal.png", width: 92%),
  caption: [把 $M_1 M_2$ 看成某个长方体的体对角线，并且这个长方体的长宽高分别与各坐标轴平行],
)
#footnote[来源：视频画面 00\:09\:45--00\:10\:00（BV15A4m1G7zG）。]

推导的思路：*你永远可以以 $M_1 M_2$ 的连线为一个长方体的体对角线*，并且让这个长方体的长宽高和各坐标轴都平行。做完这一步，长度就变成了两次勾股定理：

1. 在底面（平行于 $x O y$ 面的那个面）的直角三角形中，两条直角边分别是 $|x_2 - x_1|$ 与 $|y_2 - y_1|$，于是底面那条对角线的平方是 $(x_2 - x_1)^2 + (y_2 - y_1)^2$；
2. 再把这条底面对角线当作直角边，与竖直方向的直角边（长度为 $|z_2 - z_1|$）组成第二个直角三角形，用第二次勾股定理得到 $M_1 M_2$ 的平方；最后开算术平方根即可。

$ |M_1 M_2|^2 = (x_2 - x_1)^2 + (y_2 - y_1)^2 + (z_2 - z_1)^2 $

#figure(
  image("figures/fig_08_distance_formula.png", width: 92%),
  caption: [距离公式推导的收口：画面上红笔写出 $|M_1 M_2| = sqrt((x_2 - x_1)^2 + (y_2 - y_1)^2 + (z_2 - z_1)^2)$，正是"两次勾股定理"的成品],
)
#footnote[来源：视频画面 00\:11\:00--00\:11\:15（BV15A4m1G7zG）。]

#importantbox[
空间两点间距离公式 $|M_1 M_2| = sqrt((x_2 - x_1)^2 + (y_2 - y_1)^2 + (z_2 - z_1)^2)$ 是本讲第一个"必背公式"。它的重要性在于：*向量的模、方向余弦、平面与直线的距离*全都由它派生。而且推导方式（构造长方体 + 两次勾股）本身就是考试里判断"这个点投影到哪"的通用手法。
]

== 本章小结

本节把三维空间"装进"了坐标系里，四件事必须形成肌肉记忆：

1. *右手系*：$x$ 轴、$y$ 轴一经指定，$z$ 轴正方向就唯一确定（四指法或三指法验证）。
2. *分量特征*：坐标轴上的点只有该轴分量非零；坐标面上的点只有一个分量恒为零（缺谁谁为零）；三张坐标面把空间分成八个卦限。
3. *对称点法则*：关于轴对称——该轴分量不变，其余反号；关于面对称——法向分量反号；关于原点对称——三个分量全反号。
4. *两点间距离公式*：$|M_1 M_2| = sqrt((x_2 - x_1)^2 + (y_2 - y_1)^2 + (z_2 - z_1)^2)$，由长方体体对角线与两次勾股定理得到。

至此，"空间中的位置"这件事解决了。但空间里的东西大多不是"静止的点"，而是"有方向的量"——下一节开始研究向量。

= 向量及其线性运算

坐标系解决的是"点的位置"，但空间里的东西更多是"有方向的量"。老师在这一节开头说得很轻松：*这里平面向量和空间向量就放到一起研究，不做区分了*——因为向量的所有定义与运算律在二维和三维中完全一样。接下来的内容"大部分是高中回忆杀"，但重点在于*大学中的规定和写法*。

== 向量是什么：大小与方向

所谓向量，就是*既有大小又有方向的量*；在物理当中也称为*矢量*。

老师的例子是位移：我们想研究从 $A$ 到 $B$ 的位移，这里既包含了从 $A$ 到 $B$ 的*移动方向*，也包含了移动的*距离*，所以必须用两个要素来描述——这正是向量与标量的根本区别。几何上，我们用一条*有方向的线段*来表示它：以 $A$ 为起点、$B$ 为终点的有向线段，就记作 $arrow(A B)$。

#figure(
  image("figures/fig_09_vector_def.png", width: 92%),
  caption: [向量的定义页：向量是既有大小又有方向的量；高数中只讨论自由向量，相等指大小相等且方向相同],
)
#footnote[来源：视频画面 00\:11\:30--00\:11\:45（BV15A4m1G7zG）。]

== 记号的几套体系（别在考场上被符号吓到）

同一个向量，不同教材、不同学科写法不同。老师把能见到的写法都列了一遍：

#importantbox[
*向量的记号一览*
- *有向线段式*：$arrow(A B)$，$A$ 为起点、$B$ 为终点，手写与印刷体都是"字母上画一个箭头"。
- *小写字母加箭头*：$arrow(a), arrow(b), arrow(c)$ 等等；物理中甚至写 $arrow(F)$ 表示力。
- *粗体正体*：教材中把字母印得粗粗的来表示向量（$bold(a)$），但手写时很不方便——"鬼知道是你的笔太粗了，还是它这是个向量"，所以一般不这么写。
- *线性代数的写法*：印刷体用*加粗的希腊字母* $bold(alpha), bold(beta)$ 表示向量，手写时*不加箭头*，直接写字母。
]

老师说得很清楚：到底用哪套，"根据学科不同或者大家老师的规定不同，自己去选择"——但在一份卷子里要自洽。

#knowledgebox[
同一套双竖线符号，在高数中至少有三种含义：*绝对值*、*向量的模*、*行列式*。老师的建议是不用死记"现在这个竖线是什么意思"，而是看它套在谁外面：只要双竖线是套在*一个向量*的外面，它一定是模——因为向量没有绝对值这个概念，也求不了行列式。本讲中我们见到的 $|arrow(a)|$ 全部是*模*。
]

== 自由向量：为什么可以把箭头搬来搬去

这是高数与中学的一个关键约定：*在高数中，我们所有的向量都认定为自由向量*。

什么叫自由向量？把 $arrow(A B)$ 平行移动到 $arrow(A' B')$，我们就认为 $arrow(A B)$ 与 $arrow(A' B')$ 是*完全相等*的向量——因为长度一样（大小相同）、方向一样，那么它们就是同一个向量。用位移来理解也很自然：位移的方向和距离都一样，这个位移就是一样的。

#importantbox[
*自由向量的三条推论（后面反复用）*
1. 向量可以在空间中任意平行移动，起点在哪儿不影响它是什么向量；
2. 比较两个向量"相等"时，只看*长度*与*方向*，不看位置；
3. 正因为可以平移，两个向量的*起点总能搬到一起*——后面的夹角、加法平行四边形法则、减法口诀全部建立在这一条上。
]

== 模、单位向量与零向量

向量的大小专门有一个名词，叫*模*。$arrow(A B)$ 的模记作 $|arrow(A B)|$，两边加竖线。

$ |arrow(a)| = sqrt(a_x^2 + a_y^2 + a_z^2) $

其中：
- $arrow(a)$：任意空间向量；
- $a_x, a_y, a_z$：向量 $arrow(a)$ 在三个坐标轴方向上的分量（本节末尾会给出它的来源）；
- $|arrow(a)|$：向量的*模*，即向量对应有向线段的长度，是一个非负实数。

#figure(
  image("figures/fig_10_norm_notation.png", width: 92%),
  caption: [模的记法页：$|arrow(a)|$ 表示向量的大小，画面中红字提示双竖线在高数中的三种含义——绝对值、模、行列式],
)
#footnote[来源：视频画面 00\:14\:00--00\:14\:15（BV15A4m1G7zG）。]

两个特殊向量必须分清：

#importantbox[
- *单位向量*：模等于 $1$ 的向量（$|arrow(e)| = 1$）。
- *零向量*：模等于 $0$ 的向量，记作 $arrow(0)$，它的*方向是任意的*。

"方向任意"这四个字不是随口说的——它直接导致零向量与任何向量都平行、也都垂直（下面马上会用到）。
]

== 夹角：从角度读出向量关系

两个向量还可以研究它们的*夹角*。怎么看？把两个向量的起点搬运到一起（这就是自由向量的好处），它们之间所夹的那个*大于等于 $0$、不超过 $pi$* 的角度，就叫做向量的夹角。

$ < arrow(a), arrow(b) > in [0, pi] $

其中：
- $arrow(a), arrow(b)$：两个非零向量；
- $< arrow(a), arrow(b) >$：两向量起点重合后所成的夹角，取值范围 $[0, pi]$；
- 若 $arrow(a), arrow(b)$ 中有零向量，因方向任意，认为夹角可以是 $0$ 到 $pi$ 之间的任意值。

手写时怎么表达夹角？把这两个向量先写在一起，两边用"尖尖的"符号套在一起即可。

#figure(
  image("figures/fig_11_angle.png", width: 92%),
  caption: [夹角的定义页：夹角规定*不超过 $pi$*，即 $< arrow(a), arrow(b) > in [0, pi]$；画面注明含零向量时夹角可取区间内任意值],
)
#footnote[来源：视频画面 00\:15\:00--00\:15\:15（BV15A4m1G7zG）。]

特殊的夹角可以提炼出特殊的向量关系：

#figure(
  image("figures/fig_12_parallel_perp.png", width: 92%),
  caption: [平行与垂直的夹角刻画：夹角为 $0$ 或 $pi$ 时称平行（共线），记作 $arrow(a) parallel arrow(b)$；夹角为 $pi/2$ 时称垂直（正交），记作 $arrow(a) perp arrow(b)$],
)
#footnote[来源：视频画面 00\:15\:30--00\:15\:45（BV15A4m1G7zG）。]

#importantbox[
- *平行（又称共线）*：$< arrow(a), arrow(b) > = 0$ 或 $pi$，记作 $arrow(a) parallel arrow(b)$。因为向量是自由的、可以随便移动，所以"平行"和"共线"这两个说法是一个意思——老师甚至说，"*共线才是更本质的那个意思*"。
- *垂直（又称正交）*：$< arrow(a), arrow(b) > = pi/2$，记作 $arrow(a) perp arrow(b)$。
- *零向量的特殊性*：因为零向量方向任意，所以可认为零向量 $arrow(0)$ 与任意向量*平行*，也与任意向量*正交*。
]

#warningbox[
"零向量与任何向量既平行又垂直"听起来矛盾，但它是考试中做判定题的关键前提（比如"$arrow(a) dot arrow(b) = 0$ 是否一定有 $arrow(a) perp arrow(b)$"这类命题）。记住它的出处是*零向量方向任意*这条约定，而不是几何直觉。
]

== 向量的加法：位移的合成

最"有特色"的运算是加法。老师先抛出一个预设的吐槽：你们要说"这题我会，三角形法则"，那平行四边形法则怎么说呢？

两条法则其实是一回事：

- *三角形法则*：把两个向量*首尾相接*，$arrow(a) + arrow(b)$ 就等于"把 $arrow(a)$ 的起点和最终 $arrow(b)$ 的终点连接在一起"得到的那条向量；
- *平行四边形法则*：把两个向量*起点重合*，以它们为邻边画一个平行四边形，它的*对角线*就是和。你只需要把其中一个向量平移过去，它就又变成首尾相接的三角形法则了。

#figure(
  image("figures/fig_13_addition.png", width: 92%),
  caption: [向量加法的两条法则与运算律：左边是三角形法则、中间是平行四边形法则，下方列出交换律与结合律],
)
#footnote[来源：视频画面 00\:16\:00--00\:16\:15（BV15A4m1G7zG）。]

老师坚持要解释"为什么两向量相加就变成那条红色向量"，用的还是位移的比喻：

#knowledgebox[
*拜年模型（位移解释）*：你家住在 $A$ 点，过年要去姥姥家拜年（位移从 $A$ 到 $B$），再从姥姥家去奶奶家（位移从 $B$ 到 $C$）。那么"今天拜年的总位移是多少"？当然是从 $A$ 直接连到 $C$——这就是 $arrow(A B) + arrow(B C) = arrow(A C)$。

理解了"向量本质是位移"，加法的三角形法则就不需要背了。
]

加法有两条运算律，作为基本常识：

$ arrow(a) + arrow(b) = arrow(b) + arrow(a), quad (arrow(a) + arrow(b)) + arrow(c) = arrow(a) + (arrow(b) + arrow(c)) $

其中：
- $arrow(a), arrow(b), arrow(c)$：任意三个向量；
- 第一式是*交换律*：正着加、反着加，最后的和都一样；
- 第二式是*结合律*：一堆向量相加时，先加谁都不影响最终结果。

结合律的几何解释仍然是那条位移链——从家出发，先去外婆家、再去奶奶家、最后去大爷家（三段位移相加），无论你先算哪一段，总位移都是把起点和终点直接连起来。所以老师总结了一句很到位的话：*向量加法最终玩的就是一个"首尾相接"*。

== 向量的减法：一句口诀解决

减法是由*负向量*和加法一起定义出来的。什么叫负向量？$-arrow(a)$ 指的是与 $arrow(a)$ 模长一样、方向相反的向量。于是

$ arrow(a) - arrow(b) = arrow(a) + (-arrow(b)) $

其中：
- $-arrow(b)$：$arrow(b)$ 的*负向量*，意思是与 $arrow(b)$ 模长相同、方向相反；
- 减法就是"加上对方的反向量"，所以减法的一切性质都可以由加法推得。

从几何上看：把两个向量的*起点放在一起*，再把它们的*终点连起来*，差向量 $arrow(a) - arrow(b)$ 的箭头*指向被减的那个向量* $arrow(a)$。

#figure(
  image("figures/fig_14_subtraction.png", width: 92%),
  caption: [向量减法：规定 $arrow(a) - arrow(b) = arrow(a) + (-arrow(b))$；画面红字给出负向量的定义与口诀"起点同，终点连，指被减"],
)
#footnote[来源：视频画面 00\:18\:30--00\:18\:45（BV15A4m1G7zG）。]

#importantbox[
*减法口诀*：*起点同，终点连，指被减*。
- "起点同"——把两个向量的起点搬到一起；
- "终点连"——连接两个终点；
- "指被减"——箭头指向被减数（也就是 $arrow(a) - arrow(b)$ 中写在前面的那个 $arrow(a)$）。
]

#warningbox[
口诀里最容易记反的就是"指被减"。考试中经常给出 $arrow(B A)$ 与 $arrow(B C)$ 做差，此时被减数是哪一个、箭头朝哪边，全看题目怎么写。稳妥的做法永远是：*先化成"起点重合"，再套口诀*；或者干脆化成 $arrow(a) + (-arrow(b))$ 用三角形法则走一遍。
]

== 数乘：只改变长度，不改变直线

所谓数乘，就是用一个*实数* $lambda$ 去乘向量 $arrow(a)$，记作 $lambda arrow(a)$。它表示什么意思？老师做了一个非常朴素的拆解：如果 $lambda = 2$，那 $2 arrow(a)$ 可以拆成 $arrow(a) + arrow(a)$——两个 $arrow(a)$ 首尾相接，说白了就是*方向不改变，长度变成原来的二倍*。

#figure(
  cetz.canvas(length: 1.0cm, {
    import cetz.draw: *
    let o = (0, 0)
    line(o, (2.6, 1.5), stroke: 1.3pt + c-blue, mark: (end: "stealth"))
    content((2.75, 1.65), $arrow(a)$)
    line(o, (-1.3, -0.75), stroke: 1.3pt + c-red, mark: (end: "stealth"))
    content((-1.45, -0.95), $-arrow(a)$)
    line(o, (3.9, 2.25), stroke: 1.3pt + c-green, mark: (end: "stealth"))
    content((4.05, 2.4), $2 arrow(a)$)
    content((0.0, -1.6), [$lambda > 0$ 得同向向量，$lambda < 0$ 得反向向量；长度按 $|lambda|$ 倍伸缩])
  }),
  caption: [数乘的几何效果：$lambda > 0$ 时与 $arrow(a)$ 同向，$lambda < 0$ 时与 $arrow(a)$ 反向，长度按 $|lambda|$ 倍伸缩——$arrow(a)$ 所在的那条直线方向始终不变],
)
#footnote[来源：按视频讲解（00\:19\:48--00\:20\:40）重绘。]

#importantbox[
*数乘的效果*：乘上一个大于零的数，得到一个与 $arrow(a)$ *同向*的向量；乘上小于零的数，得到一个与 $arrow(a)$ *反向*的向量。用老师的话说："相当于保住了 $arrow(a)$ 所在的这个直线的方向，而改变它的长度。"
]

紧接着是本节*极其重要*的一个公式——数乘的模：

$ |lambda arrow(a)| = |lambda| dot |arrow(a)| $

其中：
- $lambda$：任意实数（数量）；
- $arrow(a)$：任意向量；
- $|lambda|$：实数外面的双竖线表示*绝对值*（注意与向量外面的竖线区分）；
- $|arrow(a)|$：向量 $arrow(a)$ 的模。

直观上很好接受：用数字去乘向量，等于在原有模长的基础上再扩充相应的倍数。老师在这儿特意提醒："*你同意了啊，同意了，一会儿我们就要用起来了*"——马上就用，用在单位向量的推导上。

#figure(
  image("figures/fig_15_scalar_law.png", width: 92%),
  caption: [数乘运算律与平行定理页：结合律 $lambda (mu arrow(a)) = (lambda mu) arrow(a)$、分配律 $lambda (arrow(a) + arrow(b)) = lambda arrow(a) + lambda arrow(b)$，以及 "$arrow(a) != arrow(0)$ 时 $arrow(a) ∥ arrow(b)$ 的充要条件是存在唯一实数 $lambda$ 使 $arrow(b) = lambda arrow(a)$"],
)
#footnote[来源：视频画面 00\:21\:15--00\:21\:30（BV15A4m1G7zG）。]

数乘的运算律同样直接可用：

$ lambda (mu arrow(a)) = (lambda mu) arrow(a), quad lambda (arrow(a) + arrow(b)) = lambda arrow(a) + lambda arrow(b) $

其中：
- $lambda, mu$：任意实数；
- 第一式是*结合律*：先用哪个数字乘向量都行，先把数字乘在一起再乘向量也行；
- 第二式是*分配律*：数可以分配进括号内每一个向量；反过来，两个数字的和乘向量也可以把向量分配进去。

== 平行的充要条件与单位化公式

当我们想表达两个向量平行的时候，"其实就是*一个向量等于另外一个向量的数乘*"：

$ arrow(a) parallel arrow(b) quad <==> quad arrow(b) = lambda arrow(a) quad (arrow(a) != arrow(0)) $

其中：
- $arrow(a), arrow(b)$：两个向量，且 $arrow(a) != arrow(0)$；
- $lambda$：存在且*唯一*的实数——$arrow(b)$ 与 $arrow(a)$ 同向时 $lambda > 0$，反向时 $lambda < 0$；
- 这个"唯一实数 $lambda$"就是后面用坐标判别平行时的比例系数。

接着老师提出一个"重要常识"：我想求*和某个向量 $arrow(a)$ 同向的单位向量*，怎么表示它？

#importantbox[
*单位化公式*：$arrow(e) = arrow(a) / |arrow(a)|$（$arrow(a) != arrow(0)$）。

这个式子老师连用了三个"句"来强调其重要性："这个式子句句句重要啊，不仅在高数，在线代当中都可以说是一个*必考必会*的东西。"
]

为什么它成立？老师带着推了一遍，逻辑分成两关：

#figure(
  image("figures/fig_16_unit_vector.png", width: 92%),
  caption: [单位化公式的推导现场：先定下 $arrow(e) = arrow(a)/|arrow(a)|$，再用 $|lambda arrow(a)| = |lambda| |arrow(a)|$ 验证它的模等于 $1$],
)
#footnote[来源：视频画面 00\:23\:30--00\:23\:45（BV15A4m1G7zG）。]

*第一关——同向*：$arrow(a) / |arrow(a)|$ 相当于用 $arrow(a)$ 乘一个正数（$1/abs(arrow(a)) > 0$），这本质上就是数乘，而数乘的正数因子保持同向，所以第一关过了。

*第二关——模长等于 $1$*：把 $|arrow(a)/|arrow(a)||$ 拿出来算，这里有*两层竖线*，要分别盘清楚：里面那层竖线套在向量外面，表示*模长*；外面那层竖线套在一个数量外面，表示*绝对值*。于是

$ abs(arrow(a) / abs(arrow(a))) = abs(1 / abs(arrow(a))) dot abs(arrow(a)) = (1 / abs(arrow(a))) dot abs(arrow(a)) = 1 $

其中：
- $|arrow(a)|$：向量 $arrow(a)$ 的模，是一个正数；
- $|1 / |arrow(a)||$：一个正数的绝对值，仍是它本身；
- 中间一步用的是数乘的模公式 $|lambda arrow(a)| = |lambda| |arrow(a)|$，把数量因子提出去。

两个模长一约分，结果为 $1$，得证。"这个结论请务必熟记，一会儿还要考。"

== 例题：平行四边形中的四个向量（同济八版例题）

最后是一道教材例题：在平行四边形 $A B C D$ 中，$arrow(A B) = arrow(a)$，$arrow(A D) = arrow(b)$，$M$ 是对角线的交点，请用 $arrow(a)$、$arrow(b)$ 表示 $arrow(M A)$、$arrow(M B)$、$arrow(M C)$、$arrow(M D)$。

这道题"各种加减数乘就已经开始出现了"，解法上老师反复强调抓住一个基本常识：*平行四边形的对角线互相平分*。因为 $M$ 既是 $B D$ 的中点，也是 $A C$ 的中点。

#figure(
  image("figures/fig_17_parallelogram.png", width: 92%),
  caption: [练习 2.1 的解答页：由 $arrow(a) + arrow(b) = arrow(A C) = 2 arrow(M C)$ 得 $arrow(M C) = 1/2 (arrow(a) + arrow(b))$，其余三个向量由相反数与差向量推出],
)
#footnote[来源：视频画面 00\:26\:00--00\:26\:15（BV15A4m1G7zG）。]

推导分四步：

1. *先写最好写的 $arrow(M C)$*：由平行四边形法则，$arrow(A B) + arrow(A D) = arrow(A C)$，即 $arrow(a) + arrow(b) = arrow(A C)$；而 $arrow(A C)$ 与 $arrow(M C)$ 方向相同、长度是它的二倍，所以 $arrow(a) + arrow(b) = 2 arrow(M C)$，于是

$ arrow(M C) = 1/2 (arrow(a) + arrow(b)) $

2. *$arrow(M A)$ 由负向量得到*：$arrow(M A)$ 与 $arrow(M C)$ 长度相同、方向相反，是负向量关系：

$ arrow(M A) = -1/2 (arrow(a) + arrow(b)) $

3. *$arrow(M B)$ 用差向量*：两条邻边做差 $arrow(a) - arrow(b)$，几何上就是另一条对角线方向。由"起点同、终点连、指被减"，$arrow(a) - arrow(b)$ 指向 $arrow(D B)$ 的方向，即 $arrow(a) - arrow(b) = arrow(D B) = 2 arrow(M B)$，所以

$ arrow(M B) = 1/2 (arrow(a) - arrow(b)) $

4. *$arrow(M D)$ 再取一次反向*：$arrow(M D)$ 与 $arrow(M B)$ 是同长度、反方向的负向量关系：

$ arrow(M D) = -1/2 (arrow(a) - arrow(b)) = 1/2 (arrow(b) - arrow(a)) $

#warningbox[
这题的易错点有三个：
1. *方向写反*：$arrow(M A)$ 与 $arrow(M C)$ 谁带负号，取决于起点都是 $M$、终点谁在被减的位置。画图时把"指被减"三个字落实成箭头方向。
2. *漏掉二分之一*：$arrow(a) + arrow(b)$ 等于*对角线* $arrow(A C)$，而题目要的是*半条对角线* $arrow(M C)$，两者差一个系数 $2$。
3. *把 $arrow(M B)$ 写成 $1/2 (arrow(b) - arrow(a))$*：这等于 $arrow(M D)$ 而不是 $arrow(M B)$——$arrow(a) - arrow(b) = arrow(D B) = 2 arrow(M B)$，被减向量决定了方向。
]

== 本章小结

本节把向量的"内功"练完了，全部结论只有五条，但每条都是后面解题的发动机：

1. *定义与约定*：向量 = 大小 + 方向；高数中一律看作*自由向量*，可以平移，比较只看长度与方向。
2. *模与特殊向量*：$|arrow(a)|$ 是长度；模为 $1$ 是单位向量；模为 $0$ 是零向量且方向任意（因此与一切向量既平行又垂直）。
3. *夹角与关系*：$< arrow(a), arrow(b) > in [0, pi]$；夹角 $0$ 或 $pi$ 即平行（共线），夹角 $pi/2$ 即垂直（正交）。
4. *线性运算*：加法=首尾相接（三角形/平行四边形法则，满足交换律、结合律）；减法=加负向量（口诀"起点同、终点连、指被减"）；数乘=伸缩长度、保住直线（$|lambda arrow(a)| = |lambda| |arrow(a)|$）。
5. *两条核心公式*：平行的充要条件 $arrow(b) = lambda arrow(a)$（$arrow(a) != arrow(0)$，$lambda$ 唯一）；单位化公式 $arrow(e) = arrow(a) / |arrow(a)|$。

到这里，向量的运算还都是"几何操作"。下一节我们把两个工具合体——把向量搬进空间直角坐标系，从此加减、数乘、平行、求模，全部变成*算坐标*。

= 把向量放进空间直角坐标系（第三部分·正片开始）

老师在黑板上写下第三部分的标题时说："*最后我们把前两块内容融合在一起，从此可以通过几何来搞定各种复杂的空间向量几何问题——以下正片开始。*"

这一节的整个思路只有一句话：*给每个向量一个唯一的坐标，从此一切几何运算都变成坐标运算。*

== 分向量 $arrow(i), arrow(j), arrow(k)$ 与分解式

我们把向量 $arrow(O M)$ 放进空间直角坐标系，这时 $M$ 有唯一的坐标 $(x, y, z)$。引入三个特殊向量：

#importantbox[
*分向量（基本单位向量）*：$arrow(i), arrow(j), arrow(k)$ 分别表示沿着 $x$ 轴、$y$ 轴、$z$ 轴*正方向*的单位向量。它们两两垂直，模都为 $1$。
]

有了这三个基本向量，$arrow(O M)$ 就可以用*向量的加法*表示出来了。根据向量加法，把 $arrow(O P)$、$arrow(P Q')$、$arrow(Q' M)$ 三条向量首尾相接，加起来就是 $arrow(O M)$：

$ arrow(O M) = x arrow(i) + y arrow(j) + z arrow(k) $

其中：
- $x, y, z$：点 $M$ 的三个坐标，也就是向量 $arrow(O M)$ 的三个分量；
- $arrow(i), arrow(j), arrow(k)$：沿 $x, y, z$ 轴正方向的单位向量；
- $x arrow(i)$ 表示以 $x$ 为模长、沿 $x$ 轴方向的向量（$x$ 为负时方向取反），另外两项同理。

这个式子叫做向量的*分解式*——把一个斜着的向量，拆成三个沿坐标轴方向的分量之和。

#figure(
  cetz.canvas(length: 1.0cm, {
    import cetz.draw: *
    ortho(x: -35deg, y: 55deg, {
      line((0, 0, 0), (3.8, 0, 0), stroke: 0.8pt, mark: (end: "stealth"))
      line((0, 0, 0), (0, 3.8, 0), stroke: 0.8pt, mark: (end: "stealth"))
      line((0, 0, 0), (0, 0, 3.6), stroke: 0.8pt, mark: (end: "stealth"))
      content((4.1, 0, 0), $x$)
      content((0, 4.1, 0), $y$)
      content((0, 0, 3.9), $z$)
      content((0, 0, 0), $O$, anchor: "north-east")
      // M 与其三条分向量
      line((0, 0, 0), (2.0, 1.6, 2.4), stroke: 1.2pt + c-red, mark: (end: "stealth"))
      content((2.15, 1.75, 2.6), $M(x, y, z)$)
      line((0, 0, 0), (2.0, 0, 0), stroke: 1.0pt + c-blue, mark: (end: "stealth"))
      content((1.6, -0.35, 0), $x arrow(i)$, fill: c-blue)
      line((2.0, 0, 0), (2.0, 1.6, 0), stroke: 1.0pt + c-green, mark: (end: "stealth"))
      content((2.6, 1.0, 0), $y arrow(j)$, fill: c-green)
      line((2.0, 1.6, 0), (2.0, 1.6, 2.4), stroke: 1.0pt + rgb("#b8860b"), mark: (end: "stealth"))
      content((2.5, 1.9, 1.4), $z arrow(k)$)
      line((2.0, 0, 0), (2.0, 1.6, 0), stroke: (paint: luma(170), dash: "dashed"))
      line((0, 0, 0), (2.0, 1.6, 0), stroke: (paint: luma(170), dash: "dashed"))
    })
  }),
  caption: [分解式的几何来历：把 $arrow(O M)$ 拆成"沿 $x$ 轴走 $x arrow(i)$、再沿 $y$ 轴走 $y arrow(j)$、最后沿 $z$ 轴走 $z arrow(k)$"三段位移之和],
)
#footnote[来源：按视频讲解（00\:26\:47--00\:27\:56）重绘。]

#figure(
  image("figures/fig_18_decomposition.png", width: 92%),
  caption: [向量的分解式与坐标式：画面上并列写出 $arrow(O M) = x arrow(i) + y arrow(j) + z arrow(k)$ 与 $arrow(O M) = (x, y, z)$，并注明 $arrow(i), arrow(j), arrow(k)$ 是 $x, y, z$ 轴正向的单位向量],
)
#footnote[来源：视频画面 00\:28\:45--00\:29\:00（BV15A4m1G7zG）。]

== 坐标式：把系数抽出来

把 $arrow(i), arrow(j), arrow(k)$ 的系数——也就是 $M$ 对应到各坐标轴的坐标——抽出来，重新写成一个"坐标"，就得到向量的*坐标式*：

$ arrow(O M) = (x, y, z) $

#importantbox[
*分解式与坐标式完全相等*：$x arrow(i) + y arrow(j) + z arrow(k) = (x, y, z)$。

所以如果你做题时，答案给你写了个 $x arrow(i) + y arrow(j) + z arrow(k)$，而你自己写了个 $(x, y, z)$，那算不算对？老师回答得很干脆——"*完全正确，完全等价*"。
]

这里有一个必须留意的细节：

#warningbox[
向量 $arrow(O M)$ 的坐标 $(x, y, z)$ 与点 $M$ 的坐标 $(x, y, z)$ 长得一模一样，但*含义不同*：一个说的是"从原点出发的那个*向量*"，一个说的是"空间中的一个*点*"。当你看到 $(x, y, z)$ 这个形式时，要结合上下文判断它到底是向量的意思还是点的意思——这是最容易在解题中引起混淆的地方。
]

== 坐标的线性运算：几何法则全部退休

有了坐标，表达运算就变得特别直接。设 $arrow(a) = (a_x, a_y, a_z)$、$arrow(b) = (b_x, b_y, b_z)$，则

$ arrow(a) + arrow(b) = (a_x + b_x, a_y + b_y, a_z + b_z) $

$ arrow(a) - arrow(b) = (a_x - b_x, a_y - b_y, a_z - b_z) $

$ lambda arrow(a) = (lambda a_x, lambda a_y, lambda a_z) $

其中：
- $arrow(a), arrow(b)$：任意两个空间向量；
- $a_x, a_y, a_z$ 与 $b_x, b_y, b_z$：两个向量在三个坐标轴方向上的分量；
- $lambda$：任意实数。

为什么加法可以这样算？因为把两个向量都写成 $arrow(i), arrow(j), arrow(k)$ 的分解式之后，利用向量的交换律、结合律，可以把 $arrow(i)$ 与 $arrow(i)$ 合并、$arrow(j)$ 与 $arrow(j)$ 合并、$arrow(k)$ 与 $arrow(k)$ 合并，再把系数抽出来，就变成了"对应分量分别相加"。数乘同理——把 $lambda$ 分别乘到每一个分向量前面。

#importantbox[
*从此以后*：向量的加法、减法、数乘，全部不用再画三角形和平行四边形，直接*对应分量相加减、乘以倍数*即可。几何法则退居二线，只在理解意义时使用。
]

== 平行的坐标判别

从坐标的角度重新解释平行：当 $arrow(a) != arrow(0)$ 时，$arrow(b) parallel arrow(a)$ 意味着 $arrow(b) = lambda arrow(a)$，把两边都写成坐标形式，就得到

$ b_x / a_x = b_y / a_y = b_z / a_z = lambda $

其中：
- $arrow(a) = (a_x, a_y, a_z) != arrow(0)$，$arrow(b) = (b_x, b_y, b_z)$；
- 等式成立的含义是 $arrow(b)$ 的每一个分量都等于 $arrow(a)$ 的对应分量乘上*同一个*数 $lambda$；
- 换句话说：两个向量平行，当且仅当它们的*对应分量成比例*。

#figure(
  image("figures/fig_19_parallel_coords.png", width: 92%),
  caption: [平行的坐标判别：定理写成"存在唯一实数 $lambda$ 使 $arrow(b) = lambda arrow(a)$"，下方用 $arrow(b) = (2, 4, 6)$ 与 $arrow(a) = (1, 2, 3)$ 演示——对应分量成比例，比值都是 $2$],
)
#footnote[来源：视频画面 00\:31\:00--00\:31\:15（BV15A4m1G7zG）。]

#warningbox[
"对应分量成比例"这句话里，"*同一个*"三个字是灵魂。$b_x = 2 a_x$、$b_y = 3 a_y$ 这样比例不一致，就不平行。另外，如果 $arrow(a)$ 的某个分量为零，写法上要谨慎——此时不能简单约分，应该回到 $arrow(b) = lambda arrow(a)$ 的原式判断。
]

== 两点连线：$arrow(A B)$ 的坐标

复习一个问题：已知空间中的两点 $A(a_1, b_1, c_1)$ 与 $B(a_2, b_2, c_2)$，那么向量 $arrow(A B)$ 的坐标如何表示？

老师提醒："可能有同学知道答案，但是请想一想它是*怎么推出来的*。"推导仍旧是那个套路：

- 对空间中任何一个点，先连接它和坐标原点 $O$，于是 $arrow(O A)$ 的坐标就是点 $A$ 的坐标 $(a_1, b_1, c_1)$；同理 $arrow(O B)$ 的坐标就是 $(a_2, b_2, c_2)$；
- 从几何上看，$arrow(A B)$ 与 $arrow(O A)$、$arrow(O B)$ 构成*向量的减法*：$arrow(A B) = arrow(O B) - arrow(O A)$（被减的是 $arrow(O B)$，因为红色箭头的尖指向它）；
- 而由前面的结论，"两个向量做差就等于对应的坐标做差"，于是

$ arrow(A B) = (a_2 - a_1, b_2 - b_1, c_2 - c_1) $

其中：
- $A(a_1, b_1, c_1)$：起点；$B(a_2, b_2, c_2)$：终点；
- 记忆口诀：*终点坐标减起点坐标*。

#importantbox[
*向量 $arrow(A B)$ 的坐标 = 终点的坐标 − 起点的坐标*。这是本讲用得最频繁的一条，后面求平面方程、直线方程、法向量时几乎每题都要用。以后再做题就不必像上面那样绕一圈了，"直接上"。
]

== 由坐标求模

之前只讲了模的概念，没讲*怎么求*——"之前可能只能拿尺子量一下"。现在有了坐标就能算了。

设 $arrow(r) = (x, y, z)$，它对应的是从原点 $O$ 出发、终点为 $P(x, y, z)$ 的向量，那么求 $arrow(r)$ 的模，事实上就是求 $O$ 到 $P$ 两点间的*距离*。用上一节的公式（两点坐标差的平方和再开方），"这里 $0$ 都不用减了"：

$ abs(arrow(r)) = sqrt(x^2 + y^2 + z^2) $

$ abs(arrow(A B)) = sqrt((a_2 - a_1)^2 + (b_2 - b_1)^2 + (c_2 - c_1)^2) $

其中：
- $arrow(r) = (x, y, z)$：以原点为起点的向量；
- $A(a_1, b_1, c_1)$、$B(a_2, b_2, c_2)$：任意两点；
- 两个公式本质相同，后式是前式把起点平移到原点后的结果。

#figure(
  image("figures/fig_20_norm_formula.png", width: 92%),
  caption: [由坐标求模的页面：设 $arrow(r) = (x, y, z)$ 则 $abs(arrow(r)) = sqrt(x^2 + y^2 + z^2)$；设 $A(a_1, b_1, c_1)$、$B(a_2, b_2, c_2)$，则 $abs(arrow(A B)) = sqrt((a_2 - a_1)^2 + (b_2 - b_1)^2 + (c_2 - c_1)^2)$],
)
#footnote[来源：视频画面 00\:33\:30--00\:33\:45（BV15A4m1G7zG）。]

#importantbox[
有了坐标，"*以后也不用结合几何问题了*"——直接根号下把每个坐标平方相加即可。
]

== 方向角与方向余弦（本讲最"无处不在"的部分）

最后一块内容，老师称之为"非常神奇"，而且在整册书里的地位是——

> 它在高数下册的地位，是*举足轻重、无处不在*的。

给定一个向量 $arrow(O M)$，什么叫它的*方向角*？把起点移到原点处，这个向量一定会和每一个坐标轴的*正方向*产生一个 $0$ 到 $pi$ 之间的夹角：

#importantbox[
*方向角的标准记号*（三个字母是固定的，不能随意换）：
- 与 $x$ 轴正向的夹角记作 $alpha$；
- 与 $y$ 轴正向的夹角记作 $beta$；
- 与 $z$ 轴正向的夹角记作 $gamma$。

"比如说我一说到 $gamma$，就要想到是和 $z$ 轴正向夹的方向角了。"
]

围绕着方向角可以研究*方向余弦*——每个方向角都可以求它的余弦。推导全部靠直角三角形：

#figure(
  cetz.canvas(length: 1.0cm, {
    import cetz.draw: *
    ortho(x: -35deg, y: 55deg, {
      line((0, 0, 0), (3.4, 0, 0), stroke: 0.8pt, mark: (end: "stealth"))
      line((0, 0, 0), (0, 3.4, 0), stroke: 0.8pt, mark: (end: "stealth"))
      line((0, 0, 0), (0, 0, 3.4), stroke: 0.8pt, mark: (end: "stealth"))
      content((3.7, 0, 0), $x$)
      content((0, 3.7, 0), $y$)
      content((0, 0, 3.7), $z$)
      // 向量 OM
      line((0, 0, 0), (1.9, 1.5, 2.3), stroke: 1.2pt + c-red, mark: (end: "stealth"))
      content((2.05, 1.65, 2.5), $M(x, y, z)$)
      // γ 对应的直角三角形：M 向 z 轴引垂线
      line((1.9, 1.5, 2.3), (0, 0, 2.3), stroke: (paint: luma(150), dash: "dashed"))
      line((0, 0, 2.3), (0, 0, 0), stroke: 0.9pt + c-green, mark: (end: "stealth"))
      content((0.35, 0.25, 1.15), $z$)
      // α 的投影线（在 xOy 面上的投影）
      line((1.9, 1.5, 2.3), (1.9, 1.5, 0), stroke: (paint: luma(150), dash: "dotted"))
      line((0, 0, 0), (1.9, 1.5, 0), stroke: (paint: c-blue, dash: "dashed"))
      content((1.0, 0.8, 0.0), [投影])
      content((0.75, 0.6, 0.9), $alpha$, fill: c-blue)
      content((0.15, 0.15, 1.9), $gamma$, fill: c-green)
    })
  }),
  caption: [$gamma$ 的直角三角形：过 $M$ 向 $z$ 轴引垂线，垂足读数就是竖坐标 $z$；把这个直角三角形的斜边认成 $abs(arrow(r))$、邻边认成 $z$，$cos gamma$ 就是"邻边比斜边"；$cos alpha$ 同理在含 $x$ 轴的那条直角三角形里读出],
)
#footnote[来源：按视频讲解（00\:34\:37--00\:35\:40）重绘。]

以看得最清楚的 $gamma$ 着手：$gamma$ 是 $arrow(O M)$ 与 $z$ 轴的夹角，把它放进直角三角形，过 $M$ 向 $z$ 轴引垂线，余弦就等于*邻边比斜边*——邻边是向量在 $z$ 方向上的分量（竖坐标 $z$），斜边是向量的模 $abs(arrow(r))$。同理，$cos beta$ 是纵坐标比模长，$cos alpha$ 是横坐标比模长。总结成一句话：

#importantbox[
*方向余弦公式*：$cos alpha = x / abs(arrow(r))$, $quad cos beta = y / abs(arrow(r))$, $quad cos gamma = z / abs(arrow(r))$

说白了一句话：*把向量的每个坐标都除以它的模长，就得到对应各坐标轴的方向余弦。*
]

#figure(
  image("figures/fig_21_direction_cosine.png", width: 92%),
  caption: [方向余弦的两个内在结论：三个方向余弦排成的向量就是与 $arrow(r)$ 同向的单位向量（画面红字给出 $arrow(e) = arrow(r)/abs(arrow(r)) = (cos alpha, cos beta, cos gamma)$），并且 $cos^2 alpha + cos^2 beta + cos^2 gamma = 1$],
)
#footnote[来源：视频画面 00\:36\:45--00\:37\:00（BV15A4m1G7zG）。]

方向余弦的*正负号*本身就携带信息：

#importantbox[
若 $cos gamma < 0$，说明 $arrow(O M)$ 与 $z$ 轴正向夹的是*钝角*（因为 $z < 0$）；也就是向量的"走势"沿着 $z$ 轴的*反方向*。同样地，$cos alpha < 0$ 说明向量的 $x$ 分量为负。

老师特意强调了这件事的重要性："*这件事情在我们后续研究曲线积分、曲面积分的时候非常重要。*"——因为曲面积分里判断"内侧/外侧"、曲线积分里判断"方向"，用的就是这些余弦的正负。
]

=== 方向余弦的三个内在结论

把三个方向余弦*排成一个向量*，会得到一个漂亮的结论：

$ arrow(e) = (cos alpha, cos beta, cos gamma) = 1/abs(arrow(r)) (x, y, z) = arrow(r) / abs(arrow(r)) $

其中：
- $arrow(e)$：由三个方向余弦组成的向量；
- 最后一步把系数 $1/abs(arrow(r))$ 提出来，括号里剩下的正好是原来的向量 $arrow(r)$。

也就是说：*方向余弦组成的向量，恰好就是与 $arrow(r)$ 同向的单位向量*。这个"内在联系"老师称之为"*巨巨巨好用的*"。

进一步，既然它已经是单位向量，模长就是 $1$，而"向量的模长等于根号下平方相加"，所以三个方向余弦的平方和等于 $1$：

$ cos^2 alpha + cos^2 beta + cos^2 gamma = 1 $

其中：
- $cos alpha, cos beta, cos gamma$：向量与三个坐标轴正向的夹角余弦；
- 这条恒等式在题目中常被用来"已知两个方向余弦求第三个"，或者反过来检验算错没有。

== 例题：由两点求模、方向余弦与方向角

#figure(
  image("figures/fig_22_practice_direction.png", width: 92%),
  caption: [练习 3 的解答：$M_1(2, 2, sqrt(2))$、$M_2(1, 3, 0)$ 给出 $arrow(M_1 M_2) = (-1, 1, -sqrt(2))$、模等于 $2$、方向余弦为 $-1/2$、$1/2$、$-sqrt(2)/2$，方向角为 $2 pi/3$、$pi/3$、$3 pi/4$],
)
#footnote[来源：视频画面 00\:39\:00--00\:39\:15（BV15A4m1G7zG）。]

题目：已知两点 $M_1 (2, 2, sqrt(2))$ 和 $M_2 (1, 3, 0)$，计算向量 $arrow(M_1 M_2)$ 的模、方向余弦和方向角。

*第一步——先拿坐标*。终点坐标减起点坐标：

$ arrow(M_1 M_2) = (1 - 2, 3 - 2, 0 - sqrt(2)) = (-1, 1, -sqrt(2)) $

*第二步——求模*。模长公式是"根号下每一个分量平方再求和"：

$ abs(arrow(M_1 M_2)) = sqrt((-1)^2 + 1^2 + (-sqrt(2))^2) = sqrt(1 + 1 + 2) = sqrt(4) = 2 $

*第三步——求方向余弦*。把每个分量除以模长：

$ cos alpha = (-1)/2 = -1/2, quad cos beta = 1/2, quad cos gamma = (-sqrt(2))/2 = -sqrt(2)/2 $

老师还介绍了一个"更不直接"但更省事的想法：*索性把向量整体单位化*——直接求与它同向的单位向量，得到的三个分量就是三个方向余弦。

*第四步——由余弦值反推方向角*，全部落在 $[0, pi]$ 内：

$ alpha = 2 pi/3, quad beta = pi/3, quad gamma = 3 pi/4 $

其中：
- $alpha = 2 pi/3$（即 $120 degree$）：因为在 $[0, pi]$ 上余弦值为 $-1/2$ 的角是 $2 pi/3$；
- $beta = pi/3$（即 $60 degree$）：余弦值为 $1/2$ 的角；
- $gamma = 3 pi/4$（即 $135 degree$）：余弦值为 $-sqrt(2)/2$ 的角。

#warningbox[
这道题老师的原话是"*必须要滚瓜烂熟*"。易错点集中在两处：
1. *$arrow(M_1 M_2)$ 与 $arrow(M_2 M_1)$ 搞反*：永远是终点减起点，方向反了三个余弦全部变号；
2. *方向角写成了非 $[0, pi]$ 的值*：方向角规定在 $[0, pi]$ 内取值，比如 $cos gamma = -sqrt(2)/2$ 对应的是 $3 pi/4$，不是 $-pi/4$ 或 $5 pi/4$。
]

== 本章小结

第三部分把几何彻底"代数化"了，四组公式构成一个闭环：

1. *分解式与坐标式*：$arrow(O M) = x arrow(i) + y arrow(j) + z arrow(k) = (x, y, z)$，其中 $arrow(i), arrow(j), arrow(k)$ 是三个坐标轴正方向的单位向量。
2. *坐标运算*：加减法对应分量相加减，数乘对应分量乘 $lambda$；平行的充要条件是*对应分量成比例*（比例系数同为 $lambda$）。
3. *两点连线与模*：$arrow(A B) = (a_2 - a_1, b_2 - b_1, c_2 - c_1)$（终点减起点）；$abs(arrow(r)) = sqrt(x^2 + y^2 + z^2)$。
4. *方向角与方向余弦*：$cos alpha = x/abs(arrow(r))$、$cos beta = y/abs(arrow(r))$、$cos gamma = z/abs(arrow(r))$；三个方向余弦排成的向量就是单位向量，且满足 $cos^2 alpha + cos^2 beta + cos^2 gamma = 1$。

= 总结与延伸

== 讲者的收尾

视频的最后，老师给出了这一讲的定位："本期视频我们详细介绍了*空间直角坐标系*和*向量*，也是*多元函数微积分的基石*。"——这句话不是客套：接下来要学的多元函数极限、偏导数、方向导数、梯度、重积分、曲线曲面积分，全部建立在这一讲的两套语言（坐标系与向量）之上。

== 本讲知识地图（一张表看懂）

#booktabs-table(
  columns: (auto, 1fr, auto),
  table.header([板块], [核心结论], [考频]),
  [坐标系], [右手系判 $z$ 轴；坐标轴/坐标面的分量特征；八个卦限；对称点法则；$abs(M_1 M_2) = sqrt((x_2 - x_1)^2 + (y_2 - y_1)^2 + (z_2 - z_1)^2)$], [选择/填空],
  [向量的定义], [大小 + 方向；自由向量；模、单位向量、零向量（方向任意）], [概念题],
  [夹角与关系], [$theta in [0, pi]$；$theta = 0, pi$ 为平行（共线）；$theta = pi/2$ 为垂直（正交）], [判断题],
  [线性运算], [加法=首尾相接；减法=加负向量（起点同、终点连、指被减）；数乘=伸缩，$abs(lambda arrow(a)) = abs(lambda) abs(arrow(a))$], [计算题],
  [两条核心公式], [$arrow(b) = lambda arrow(a)$（平行充要条件）；$arrow(e) = arrow(a)/abs(arrow(a))$（单位化）], [必考必会],
  [坐标化], [$arrow(O M) = x arrow(i) + y arrow(j) + z arrow(k) = (x, y, z)$；坐标加减数乘；平行 ⟺ 分量成比例], [全章通用],
  [方向余弦], [$cos alpha = x/abs(arrow(r))$ 等；$cos^2 alpha + cos^2 beta + cos^2 gamma = 1$；余弦符号决定走向], [后续积分无处不在],
)

== 与后续内容的接口

本讲埋下的三条伏笔，会在后面反复出现：

#importantbox[
1. *对称点与坐标面的分量特征* → 下一讲求平面方程时，判断"平面过哪个轴/垂直于哪个轴"用的就是"哪个分量为零"。
2. *平行的充要条件 $arrow(b) = lambda arrow(a)$ 与分量成比例* → 直接派生出直线的方向向量、平面的法向量、两平面平行/垂直的判别。
3. *方向余弦与它组成的单位向量* → 在第二类曲面积分中，法向量的方向余弦 $"cos" alpha, "cos" beta, "cos" gamma$ 是把曲面积分化成二重积分的桥梁；在方向导数里，它就是"方向"本身。
]

== 开放问题与下一步

- 本讲所有的向量运算都是*两个向量之间*的。如果我想度量"两个向量有多像"（夹角多大、投影多长），需要引入新的运算——这就是下一讲的*数量积*。
- 如果我想从两个向量"生成"一个与它们都垂直的向量（平面法向量的来源），需要*向量积*。
- 如果我想度量"三个向量张成的平行六面体体积"，需要*混合积*。

这三个运算正是下一讲（8-2 数量积、向量积、混合积）的全部内容——而它们的坐标公式，全部建立在今天讲完的"向量 = 坐标"之上。
