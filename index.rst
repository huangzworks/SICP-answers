.. SICP 习题解答 documentation master file, created by
   sphinx-quickstart on Tue Apr 17 02:29:51 2012.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

SICP 解题集
=====================================

.. image:: image/cover.jpg
   :align: left
   :width: 408px
   :height: 580px
   :scale: 33

这个文档的目标是成为中文化的、完整的\ `《计算机程序的构造和解释》 <http://book.douban.com/subject/1148282>`_\ ( Structure and Interpretation of Computer Programs，简称 SICP )一书的解题集。

这个解题集的特色是：

| 对于每道习题，除了习题答案之外，还给出习题的讲解和相关资料(如果有的话)；
| 使用 MIT Scheme 作为编程环境，完全避免了代码不兼容的问题；
| 所有代码都经过测试，确保准确性。

:doc:`relate` 介绍了这个解题集中用到的程序和工具。


.. _chp1:

第一章： 构造过程抽象
------------------------

- 1.1 程序设计的基本元素

    - 1.1.1 表达式
    - 1.1.2 命名和环境
    - 1.1.3 组合式的求值
    - 1.1.4 复合过程
    - 1.1.5 过程应用的代换模型
    - 1.1.6 条件表达式和谓词(:doc:`chp1/1`\ ，\ :doc:`chp1/2`\ ，\ :doc:`chp1/3`\ ，\ :doc:`chp1/4`\ ，\ :doc:`chp1/5`\ )
    - 1.1.7 实例： 采用牛顿法求平方根(:doc:`chp1/6`\ ，\ :doc:`chp1/7`\ ，\ :doc:`chp1/8`)
    - 1.1.8 过程作为黑箱抽象

- 1.2 过程与它们所产生的计算

    - 1.2.1 线性的递归和迭代(:doc:`chp1/9`\ ，\ :doc:`chp1/10`)
    - 1.2.2 树形递归(:doc:`chp1/11`\ ，\ :doc:`chp1/12`\ ，\ :doc:`chp1/13`)
    - 1.2.3 增长的阶(:doc:`chp1/14`\ ，\ :doc:`chp1/15`)
    - 1.2.4 求幂(:doc:`chp1/16`\ ，\ :doc:`chp1/17`\ ，\ :doc:`chp1/18`\ ，\ :doc:`chp1/19`)
    - 1.2.5 最大公约数(:doc:`chp1/20`)
    - 1.2.6 实例： 素数检测(:doc:`chp1/21`\ ，\ :doc:`chp1/22`\ ，\ :doc:`chp1/23`\ ，\ :doc:`chp1/24`\ ，\ :doc:`chp1/25`\ ，\ :doc:`chp1/26`\ ，\ :doc:`chp1/27`\ ，\ :doc:`chp1/28`)

- 1.3 用高阶函数做抽象

    - 1.3.1 过程作为参数(:doc:`chp1/29`\ ，\ :doc:`chp1/30`\ ，\ :doc:`chp1/31`\ ，\ :doc:`chp1/32`\ ，\ :doc:`chp1/33`)
    - 1.3.2 用 lambda 构造过程(:doc:`chp1/34`)
    - 1.3.3 过程作为一般性的方法(:doc:`chp1/35`\ ，\ :doc:`chp1/36`\ ，\ :doc:`chp1/37`\ ，\ :doc:`chp1/38`\ ，\ :doc:`chp1/39`)
    - 1.3.4 过程作为返回值(:doc:`chp1/40`\ ，\ :doc:`chp1/41`\ ，\ :doc:`chp1/42`\ ，\ :doc:`chp1/43`\ ，\ :doc:`chp1/44`\ ，\ :doc:`chp1/45`\ ，\ :doc:`chp1/46`)


.. _chp2:

第二章： 构造数据抽象
---------------------------------

- 2.1 数据抽象导引

    - 2.1.1 实例： 有理数的算术运算(:doc:`chp2/1`)
    - 2.1.2 抽象屏障(:doc:`chp2/2`\ ，\ :doc:`chp2/3`)
    - 2.1.3 数据意味着什么(:doc:`chp2/4`\ ，\ :doc:`chp2/5`\ ，\ :doc:`chp2/6`)
    - 2.1.4 扩展练习： 区间算术(:doc:`chp2/7`\ ，\ :doc:`chp2/8`\ ，\ :doc:`chp2/9`\ ，\ :doc:`chp2/10`\ ，\ :doc:`chp2/11`\ ，\ :doc:`chp2/12`\ ，\ :doc:`chp2/13`\ ，\ :doc:`chp2/14`\ ，\ :doc:`chp2/15`\ ，\ :doc:`chp2/16`\)

- 2.2 层次性数据和闭包性质

    - 2.2.1 序列的表示(:doc:`chp2/17`\ ，\ :doc:`chp2/18`\ ，\ :doc:`chp2/19`\ ，\ :doc:`chp2/20`\ ，\ :doc:`chp2/21`\ ，\ :doc:`chp2/22`\ ，\ :doc:`chp2/23`)
    - 2.2.2 层次性结构(:doc:`chp2/24`\ ，\ :doc:`chp2/25`\ ，\ :doc:`chp2/26`\ ，\ :doc:`chp2/27`\ ，\ :doc:`chp2/28`\ ，\ :doc:`chp2/29`\ ，\ :doc:`chp2/30`\ ，\ :doc:`chp2/31`\ ，\ :doc:`chp2/32`)
    - 2.2.3 序列作为一种约定的界面(:doc:`chp2/33`\ ，\ :doc:`chp2/34`\ ，\ :doc:`chp2/35`\ ，\ :doc:`chp2/36`\ ，\ :doc:`chp2/37`\ ，\ :doc:`chp2/38`\ ，\ :doc:`chp2/39`\ ，\ :doc:`chp2/40`\ ，\ :doc:`chp2/41`\ ，\ :doc:`chp2/42`\ ，\ :doc:`chp2/43`)
 
最新项目进度
----------------

目前项目仍处于开发阶段，（你现在看到的）这个文档只会放出经过完整测试和修整后的习题解答，请到 `项目的 github 页面 <https://github.com/huangz1990/SICP-answers>`_ 查看最新的项目进度，也欢迎向项目进行贡献，提交建议或意见。


关于
-----

这个解题集的绝大部分练习由本人（huangz）独立完成，在我遇上解不出的问题时， `Eli Bendersky 的 SICP 解答 <http://eli.thegreenplace.net/category/programming/lisp/sicp/>`_ 和 `sicp.org.ua 上的 WIKI <http://sicp.org.ua/sicp>`_ 总能给我很大帮助，在此对他们表示感谢。

你可以免费下载、阅读、复制、传播和修改本文档及相应的代码示例，如果需要其他使用许可，请用以下任一方式联系本人： 
向 gmail 帐号 huangz1990 发送邮件 / `豆瓣 <http://www.double.com/people/i_m_huangz>`_ /  `twitter <http://www.twitter.com/huangz1990>`_


评论
-------
