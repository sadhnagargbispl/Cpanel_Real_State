<%@ Page Title="" Language="C#" MasterPageFile="~/SideMaster.master" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="Main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .product-section {
            width: 100%;
        }

        .product-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 40px;
            margin-bottom: 60px;
        }

        .product-content {
            flex: 1;
        }

            .product-content h2 {
                font-size: 28px;
                margin-bottom: 10px;
            }

            .product-content p {
                margin-bottom: 15px;
                color: #555;
            }

            .product-content ul {
                padding-left: 20px;
                margin-bottom: 20px;
            }

                .product-content ul li {
                    margin-bottom: 8px;
                }

        .product-image {
            flex: 1;
        }

            .product-image img {
                width: 100%;
                border-radius: 12px;
            }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background: #28a745;
            color: #fff;
            border-radius: 6px;
            text-decoration: none;
        }

        /* Alternate layout (image left/right) */
        .product-card.reverse {
            flex-direction: row-reverse;
        }

        /* ðŸ“± Mobile Responsive */
        @media (max-width: 768px) {
            .product-card {
                flex-direction: column;
            }

                .product-card.reverse {
                    flex-direction: column;
                }

            .product-image img {
                margin-top: 20px;
            }
        }


        .type-card {
            display: block;
            text-decoration: none;
            padding: 20px;
            border-radius: 10px;
            transition: 0.3s;
        }

            .type-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }

            .type-card img {
                width: 100%;
            }

        .explore-btn {
            display: inline-block;
            margin-top: 10px;
            font-weight: 600;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section style="padding: 100px 48px; background: #0f172a;">
        <div class="container">

            <div class="section-header">
                <div class="section-header-center">
                    <h2 class="section-title" style="color: #fff;">Explore Our Smart Solutions</h2>
                </div>
            </div>

            <div class="types-grid">



                <asp:Repeater ID="rptServices" runat="server">
                    <ItemTemplate>
                        <a href='<%# Eval("RedirectUrl") %>' class="type-card">
                            <img src='<%# Eval("ImagePath") %>' alt="" style="border-radius: 8px; margin-bottom: 15px;">
                            <h3><%# Eval("Icon") %>
                                <%# Eval("ServiceName") %></h3>
                            <p><%# Eval("Description") %></p>
                            <span class="explore-btn">Explore →
                            </span>
                        </a>
                        <%--<a href='<%# Eval("RedirectUrl") %>' class="type-card">

                            <img src='<%# Eval("ImagePath") %>'
                                style="border-radius: 8px; margin-bottom: 15px;">

                            <h3>
                                <%# Eval("Icon") %>
                                <%# Eval("ServiceName") %>
                            </h3>

                            <p><%# Eval("Description") %></p>

                            <a href='<%# Eval("RedirectUrl") %>'
                                target='<%# Convert.ToBoolean(Eval("IsExternalLink")) ? "_blank" : "_self" %>'>Explore →
                            </a>

                        </a>--%>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </div>
    </section>
</asp:Content>
