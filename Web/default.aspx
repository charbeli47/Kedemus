<%@ Page Title="" Language="C#" MasterPageFile="~/default.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Web._default2" %>
<asp:Content ID="Content2" ContentPlaceHolderID="header" runat="server">
<link href="../css/contact-form.css" rel="stylesheet" />
    
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div id="slider_row">
                <div id="top_column" class="center_column">
                    <div id="homepage-slider">
                        <ul id="homeslider" style="max-height: 560px;">
                            <%foreach (var img in banners)
                                { %>
                            <li class="homeslider-container">
                                <a href="#">
                                    <img src="../Media/<%=img.thumb %>" width="1920" height="560" />
                                </a>
                            </li>
                            <%} %>
                        </ul>
                    </div>

                    <%--<div id="htmlcontent_top">
                        <ul class="htmlcontent-home clearfix row">
                            <li class="htmlcontent-item-1 col-xs-4">
                                <a href="index.php?id_category=5&amp;controller=category" class="item-link" title="">
                                    <div class="item-html">
                                        <div class="div1">
                                            <h2>Today's<br />
                                                Top 50 eBooks</h2>
                                            <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.</p>
                                            <p class="p1">
                                                <button class="btn btn-default" type="button">Shop now!</button></p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="htmlcontent-item-2 col-xs-4">
                                <a href="index.php?id_category=6&amp;controller=category" class="item-link" title="">
                                    <div class="item-html">
                                        <div class="div2">
                                            <h2>Recommended Reading</h2>
                                            <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.</p>
                                            <p class="p1">
                                                <button class="btn btn-default" type="button">Shop now!</button></p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="htmlcontent-item-3 col-xs-4">
                                <a href="index.php?id_category=7&amp;controller=category" class="item-link" title="">
                                    <div class="item-html">
                                        <div class="div3">
                                            <h2>-50%</h2>
                                            <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit.</p>
                                            <p class="p1">
                                                <button class="btn btn-default" type="button">Shop now!</button></p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>--%>
                </div>
            </div>
    <%--<%if(Session["UserId"]!=null) { %>
            <div id="columns" class="container">
                <div class="row">
                    <div class="large-left col-sm-12">
                        <div class="row">
                            <div id="center_column" class="center_column col-xs-12 col-sm-12">
                                <ul id="home-page-tabs" class="nav nav-tabs clearfix">
                                    <%foreach (var category in categories)
                                        { %>
                                    <li class="cat-<%=category.id %>"><a data-toggle="tab" href="#cat-<%=category.id %>" class="cat-<%=category.id %>"><%=lang=="en"?category.title:category.artitle %></a></li>
                                    
                                    <%} %>
                                </ul>
                                <div class="tab-content">
                                    <%foreach (var category in categories)
                                        {
                                            var items = category.ItemsCategories;%>
                                    <ul id="cat-<%=category.id %>" class="product_list grid row homefeatured tab-pane">
                                        <%foreach (var item in items)
                                            {
                                                if (item.Book.ItemsLevels.Where(x => x.LevelId == student.levelId).Count() > 0)
                                                {%>
                                        <li class="ajax_block_product col-xs-12 col-sm-3 col-md-2 last-item-of-mobile-line">
                                            <div class="product-container" itemscope itemtype="http://schema.org/Product">
                                                <div class="left-block">
                                                    <div class="product-image-container">
                                                        <a class="product_img_link" <%=item.Book.ItemsLevels.Where(x => x.LevelId == student.levelId).Count() > 0 ? "href='book-" + item.BookId + "'" : "" %>  title="<%=lang == "en" ? item.Book.title : item.Book.artitle %>n" itemprop="url">
                                                            <img class="replace-2x img-responsive" src="../Media/<%=item.Book.thumb %>" alt="<%=lang == "en" ? item.Book.title : item.Book.artitle %>" title="<%=lang == "en" ? item.Book.title : item.Book.artitle %>" itemprop="image" />
                                                            <img class="img-responsive hover-image" id="thumb-<%=item.BookId %>" src="../Media/<%=item.Book.thumb %>" alt="<%=lang == "en" ? item.Book.title : item.Book.artitle %>" title="<%=lang == "en" ? item.Book.title : item.Book.artitle %>" itemprop="image" />
                                                        </a>
                                                        <a class="quick-view" <%=item.Book.ItemsLevels.Where(x => x.LevelId == student.levelId).Count() > 0 ? "href='book-" + item.BookId + "'" : "" %> rel="">
                                                            <span><%=lang == "en" ? item.Book.title : item.Book.artitle %></span>
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="right-block">
                                                    
                                                </div>
                                            </div>
                                        </li>
                                        <%}
                                            } %>
                                    </ul>
                                    <%} %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    <%} %>--%>
            <div class="home-column">
                <div class="container">
                    
                    <section class="block" id="about">
                        <h4 class='title_block' style="text-align:center;<%=lang=="ar"?"font-family:Web-Font-Ar":"" %>"><%=lang=="en"?"Welcome to Kids Corner":"أهلاً و سهلاً" %></h4>
                        <div class="block_content">
                            <div class="row">
                                <%if (lang == "en")
                                                                                                 { %><p style="text-align:center;font-size:18px;line-height:25px">We seek to make learning fun and interactive. Kids can read books, watch videos, play games, and best of all, learn about animals, nature and the world around them. 
the most comprehensive learning site, Your kiddos can read or listen to books and music, play games and color as they accelerate through customizable learning levels designed by teachers and experts. 
a site that makes developing math, reading and literacy skills fun. Check out games like Math Baseball and Grammar Gorillas. Kids can even read books on the go.
Kids can trace numbers, learn about size relationships, colors, consonants, read books and more, all on a tablet
animation brings learning concepts to life for individuals or entire classrooms.
Technology entices most kids, right? If you have a phone or a tablet, engage your kids with a learning app. Playing an educational game is a great way to reinforce concepts over the years
                                </p>
                                <%}else { %>
                                <p style="text-align:center;font-size:18px;line-height:25px">
                                    نسعى الى جعل التعلّم مسلّي وتفاعلي.
باستطاعة الأطفال قراءة الكتب ومشاهدة فيديوهات واللعب، والأهم من ذلك، إكتشاف الحيوانات والطبيعة والعالم من حولهم، عبر موقعنا الإلكتروني التعليمي الشامل.
سيخوض أطفالكم تجربة جديدة وفريدة من نوعها، عبر قراءة والإصغاء الى الكتب والاستماع الى الموسيقى، واللعب والتلوين، ضمن مراحل تعليم محدّدة من قبل عدد من الأساتذة والمتخصصين.
كما يساعد الموقع على تطوير مستوى أولادكم في الرياضيات والقراءة والكتابة ببساطة وطريقة مسلية.
اكتشفوا ألعابنا التعليمية الترفيهية المسلية، كـ"Math Basketball" أو كرة سلة الرياضيات، و"Grammar Gorillas" أو قواعد الغوريلا والقراءة السريعة.
كما سيتعلّم الأطفال (أفراد أو مجموعة) رسم الأرقام، واكتشاف الألوان والأحجام والحروف الساكنة وحروف العلة، وأكثر من ذلك، عبر رسوم متحركة وحيّة، تعيد أسس التعلم الى الحياة.
زوّدوا هواتفكم ولوائحكم الإلكترونية، بتطبيق يراعي حاجات أطفالكم للتكنولوجيا والتعلم في الوقت نفسه.
الألعاب الترفيهية تعزّز مفاهيمهم عبر السنوات.

                                </p>
                                <%} %>
                            </div>
                        </div>
                    </section>
                    </div>
                    <section class="block" id="offerings" style="background-color:#4fb9e1">
                        <div class="container">
                        <h4 style="text-align:center;color:white;background-color:transparent;<%=lang=="ar"?"font-family:Web-Font-Ar":"" %>"><%=lang=="en"?"Our Offerings":"عروضاتنا" %></h4>
                        
                        <div style="margin:auto;float:none" class="col-xs-10">
                            <div class="row col-xs-12" style="float:none;margin-left:3%">
                                <div class="col-xs-4">
                                    <div class="col-xs-10" style="color:white;text-align:center">
                                        <img src="../img/offerings/1.png" />
                                        <h3><%=lang=="en"?"BOOKS & MORE":"كتب وأكثر" %></h3>
                                        <p><%=lang=="en"?"Beginning reader interactive books. Grade 1 to 6":"كتب حية للقراء المبتدئين من الدرجة الأولى حتى السادسة." %></p>
                                    </div>
                                </div> 
                                <div class="col-xs-4">
                                    <div class="col-xs-10" style="color:white;text-align:center">
                                        <img src="../img/offerings/2.png" />
                                        <h3><%=lang=="en"?"Kids Game Corner":"زاوية لألعاب الأطفال" %></h3>
                                        <p><%=lang=="en"?"A cool game of problem-solving, fun, spelling, and creative thinking":"ألعاب بسيطة لحلّ المسائل والتسلية، والتهجئة والتفكير الإبداعي." %></p>
                                    </div></div> 
                                <div class="col-xs-4"><div class="col-xs-10" style="color:white;text-align:center">
                                        <img src="../img/offerings/3.png" />
                                        <h3><%=lang=="en"?"ANIMATION & INTERACTIVE":"الرسوم المتحركة والتفاعلية" %></h3>
                                        <p><%=lang=="en"?"Free learning videos for kids. and for disabilities and special cases we have a customized learning system that helps":"فيديوهات مجانية لتعليم الأطفال، إضافةً الى نظام تعليمي خاص لذوي الإحتياجات الخاصة." %></p>
                                    </div></div> 
                                </div><div class="row  col-xs-12" style="margin-top:20px;float:none;margin-left:3%">
                                <div class="col-xs-4"><div class="col-xs-10" style="color:white;text-align:center">
                                        <img src="../img/offerings/4.png" />
                                        <h3><%=lang=="en"?"unusual teaching tools":"أدوات تعليم غير عادية واستثنائية" %></h3>
                                        <p><%=lang=="en"?"The ideal special education E-learn classroom":"قاعة دراسة خاصة ومثالية \"E- learn classroom\"." %></p>
                                    </div></div>
                                <div class="col-xs-4"><div class="col-xs-10" style="color:white;text-align:center">
                                        <img src="../img/offerings/5.png" />
                                        <h3><%=lang=="en"?"Extensive library":"مكتبة واسعة" %></h3>
                                        <p><%=lang=="en"?"our classes can go live with teachers around the world that will help you improve your English language and accent":"الصفوف المباشرة مع أساتذة من حول العالم لتحسين لغتكم ولهجتكم الإنكليزية." %></p>
                                    </div></div> 
                                <div class="col-xs-4"><div class="col-xs-10" style="color:white;text-align:center">
                                        <img src="../img/offerings/6.png" />
                                        <h3><%=lang=="en"?"Smart learning":"تعلم ذكي" %></h3>
                                        <p><%=lang=="en"?"we ensure to develop the English skills by 80% more effective ways that the traditional learning tools and system":"نضمن تطوير المهارات في اللغة الإنكليزية بحوالي 80%، عبر طرق فعّالة ومتطوّرة، بعيداً عن أدوات التعلم التقليدية." %></p>
                                    </div></div>  
                            </div>
                            <div class="clearfix" style="height:20px"></div>
                        </div>
                            </div>
                    </section>
                <div class="container">
                    <section class="block" id="smartlearning">
                        <h4 style="text-align:center;<%=lang=="ar"?"font-family:Web-Font-Ar":"" %>"><%=lang=="en"?"Smart Learning":"التعلم الذكي" %></h4>
                        <div class="block_content">
                            <div class="row">
                                <iframe width="100%" height="658" data-bgfit="cover" id="player" data-bgposition="center center" src="https://www.youtube-nocookie.com/embed/<%=content.SmartLearningVideo %>?version=3&rel=0&autoplay=0&controls=0&loop=0&showinfo=0" frameborder="0" allowfullscreen></iframe>
                            </div>
                        </div>
                    </section>
                    </div>
                    <section class="block" id="contactus" style="background-color:#4fb9e1">
                        <h4 style="text-align:center;color:white;background-color:transparent;<%=lang=="ar"?"font-family:Web-Font-Ar":"" %>"><%=lang=="en"?"Get in Touch":"تواصل معنا" %></a></h4>
                        <div class="container" style="color:white">
                            <div class="row" >
                                <p style="font-size:18px" <%=lang=="ar"?"dir='rtl'":"" %>><%=lang=="en"?"We are ready to assist you anytime by sending us an email in the box below.":"نحن مستعدون لمساعدتك في أي وقت عن طريق إرسال بريد إلكتروني إلينا في المربع أدناه."%></p>
                                <div class="col-xs-6">
                                    <h3><%=lang=="en"?"Contact Us":"تواصل معنا" %></h3>
                                    <table><tr><td style="vertical-align:top"><i class="fa fa-map-marker" style="font-size:20px"></i></td><td style="text-align:left">
                                        <%=lang=="en"?"Malaz district<br /> Riyadh<br /> KSA":"حي الملز <br /> الرياض <br /> السعودية" %>
                                                                                   </td></tr>
                                        <tr><td style="vertical-align:top"><i class="fa fa-envelope" style="font-size:20px"></i></td><td style="text-align:left">
                                        education@teachingkids.me
                                                                                   </td></tr>
                                        <tr><td style="vertical-align:top"><i class="fa fa-mobile" style="font-size:20px"></i></td><td style="text-align:left">
                                        +966 50 359 0404
                                                                                   </td></tr></table>
                                </div>
                                <div class="col-xs-6">
                                    <form action="../sendMail.ashx" method="post" id="submitForm">
                                        <p class="form-group">
<input class="form-control grey validate" placeholder="<%=lang=="en"?"Your Name":"الإسم" %>" <%=lang=="ar"?"dir='rtl'":"" %> type="text" required id="name" name="name" data-validate="isName" style="background-color:transparent;border:1px solid white;color:white">
</p>
                                    <p class="form-group">
<input class="form-control grey validate" placeholder="<%=lang=="en"?"Your Email":"البريد الإلكتروني" %>" <%=lang=="ar"?"dir='rtl'":"" %> type="email" required id="email" name="email" data-validate="isEmail" style="background-color:transparent;border:1px solid white;color:white">
</p>
                                        <p class="form-group">
<input class="form-control grey validate" type="number" id="phone" required placeholder="<%=lang=="en"?"Your Phone No.":"رقم الهاتف" %>" <%=lang=="ar"?"dir='rtl'":"" %> name="phone" data-validate="isPhoneNumber" style="background-color:transparent;border:1px solid white;color:white">
</p>
                                        <p class="form-group">
<textarea class="form-control grey validate" id="message" required placeholder="<%=lang=="en"?"Your Message...":"الرسالة" %>" <%=lang=="ar"?"dir='rtl'":"" %> name="message" data-validate="isMessage" style="background-color:transparent;border:1px solid white;color:white;height:200px"></textarea>
</p>
                                        <div class="submit">
<button type="submit" name="submitMessage" id="submitMessage" class="btn btn-default btn-md" style="background-color:transparent;border:1px solid white;color:white">
<span>
 <%=lang=="en"?"Send":"أرسل" %>
<i class="fa fa-chevron-right right"></i>
</span>
</button><br /><br />
</div>
                                        </form>
                                    <script>
                                        $('#submitForm').on('submit', (function (e) {
                                            document.getElementById("submitMessage").disabled = true;
                e.preventDefault();
                var formData = new FormData(this);
                $.ajax({
                    type: 'POST',
                    url: $(this).attr('action'),
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        
                        document.getElementById("submitMessage").disabled = false;
                        alert(data);
                    },
                    error: function (data) {
                        alert("Sorry, your message was not delivered, please try again later.");
                        document.getElementById("submitMessage").disabled = false;
                    }
                });

                                        }));
                                        $(function () {
                                            $('a').click(function () {
                                                if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
                                                    var target = $(this.hash);
                                                    target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                                                    if (target.length) {
                                                        $('html,body').animate({
                                                            scrollTop: target.offset().top
                                                        }, 1000);
                                                        return false;
                                                    }
                                                }
                                            });
                                        });
                                    </script>
                                </div>
                            </div>
                        </div>
                    </section>
                
            </div>
</asp:Content>
