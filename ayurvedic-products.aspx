<%@ Page Title="" Language="C#" MasterPageFile="~/SideMaster.master"
    AutoEventWireup="true" CodeFile="ayurvedic-products.aspx.cs"
    Inherits="ayurvedic_products" %>

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
            padding: 30px;
            border-radius: 16px;
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
        }

            .product-card.reverse {
                flex-direction: row-reverse;
            }

        .product-content {
            flex: 1;
            color: #ffffff;
        }

            .product-content h2 {
                font-size: 28px;
                font-weight: 600;
                margin-bottom: 10px;
                color: #ffffff;
                letter-spacing: 0.5px;
            }

            .product-content p {
                margin-bottom: 15px;
                color: #d1d1d1;
            }

            .product-content ul {
                padding-left: 20px;
                margin-bottom: 20px;
            }

                .product-content ul li {
                    margin-bottom: 8px;
                    color: #e0e0e0;
                }

                    .product-content ul li::marker {
                        color: #28a745;
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
            padding: 10px 24px;
            background: #28a745;
            color: #fff;
            border-radius: 6px;
            text-decoration: none;
            border: none;
            cursor: pointer;
            font-size: 15px;
            transition: background 0.3s;
        }

            .btn:hover {
                background: #218838;
            }

        @media (max-width: 768px) {
            .product-card, .product-card.reverse {
                flex-direction: column;
            }

            .product-image img {
                margin-top: 20px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section style="padding: 100px 48px; background: #0f172a;">
        <div class="container">
            <div class="section-header">
                <div class="section-header-center">
                    <h2 class="section-title" style="color: #fff;">Our Products</h2>
                </div>
            </div>
            <br />

            <div class="product-section">
                <asp:Repeater ID="rptServices" runat="server">
                    <ItemTemplate>
                        <%# Eval("div") %>
                        <div class="product-content">
                            <h2><%# Eval("kitname") %></h2>
                            <%# Eval("dis") %>
                            <asp:LinkButton
                                ID="btnBuyNow"
                                runat="server"
                                CssClass="btn"
                                CommandArgument='<%# Eval("KitID") %>'
                                OnCommand="btnBuyNow_Command">
                                    🛒 Add to Cart
                            </asp:LinkButton>
                        </div>
                        <div class="product-image">
                            <img src='<%# Eval("img") %>' alt='<%# Eval("kitname") %>' />
                        </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>
</asp:Content>
