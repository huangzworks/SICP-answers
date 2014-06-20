Spring 
=====================

Spring 是 `《SICP 解题集》 <http://sicp.ReadTheDocs.org>`_ 所使用的 Sphinx 样式，
是一个非常简洁、美观的 Sphinx 样式。


使用方法
---------------------

1. 克隆本项目。

2. 修改 sphinx 项目 ``conf.py`` 文件中的 ``html_theme_path`` 变量，让它指向 ``spring`` 文件夹所在的位置。

3. 修改 sphinx 项目 ``conf.py`` 文件中的 ``html_theme`` 变量的值为 ``spring`` 。

4. 完成！


开启 disqus 支持
---------------------

要在 Spring 样式中开启对 disqus 的支持，
请编辑 ``spring`` 文件夹中的 ``theme.conf`` 文件，
将文件中的 ``disqus_shortname`` 变量的值设置为你的 disqus 论坛的名字。

举个例子，
如果你的 disqus 论坛的名字为 ``sicp`` ，
那么你需要将 ``disqus_shortname`` 的值设置为：

::

    disqus_shortname = sicp

这样就可以在 Spring 样式中开启对 ``sicp`` 论坛的支持了。

注意：
在本地进行调试的时候，
修改 ``disqus_shortname`` 变量之后请务必执行 ``make clean`` 命令清理旧的样式缓存，
否则 Sphinx 在构建样式的时候可能会沿用旧的样式缓存，
并造成一种“ ``disqus_shortname`` 变量设置之后根本没有生效“的误解。


使用许可
---------------------

Spring 样式修改自 `Sphinx <http://sphinx-doc.org/>`_ 项目自带的 `nature 样式 <http://sphinx-doc.org/theming.html#builtin-themes>`_ ，
使用与源项目同样的 BSD 协议发布。

| Copyright (c) 2014, huangz
| All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

- Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

- Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
