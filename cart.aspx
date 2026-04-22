<%@ Page Title="" Language="C#" MasterPageFile="~/SideMaster.master"
    AutoEventWireup="true" CodeFile="cart.aspx.cs" Inherits="cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
        }

        .section-title {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 30px;
        }

        .cart-container {
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

            table th {
                background: #f9fafb;
                font-weight: 600;
                padding: 12px;
                text-align: center;
            }

            table td {
                padding: 12px;
                border-bottom: 1px solid #eee;
                text-align: center;
            }

        .product-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

            .product-info img {
                width: 70px;
                border-radius: 8px;
                border: 1px solid #eee;
            }

        .qty-box {
            width: 65px;
            padding: 6px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 6px;
        }

        .price, .total {
            font-weight: bold;
            color: #28a745;
        }

        .grand-total-box {
            text-align: right;
            font-size: 20px;
            font-weight: bold;
            padding: 15px 0;
            color: #28a745;
        }

        .cart-footer {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            cursor: pointer;
            border-radius: 6px;
            font-size: 15px;
            text-decoration: none;
            display: inline-block;
            transition: 0.3s;
        }

        .btn-continue {
            background: #6c757d;
            color: #fff;
        }

            .btn-continue:hover {
                background: #5a6268;
            }

        .btn-checkout {
            background: linear-gradient(135deg, #28a745, #218838);
            color: #fff;
        }

            .btn-checkout:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(40,167,69,0.3);
            }

        .btn-delete {
            background: #dc3545;
            color: #fff;
            padding: 6px 12px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }

        .msg-label {
            color: green;
            font-weight: 600;
            margin-bottom: 10px;
            display: block;
        }

        @media (max-width: 768px) {
            .cart-footer {
                flex-direction: column;
            }

            .product-info img {
                width: 50px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section style="padding: 60px 20px;">
        <div class="container">
            <h2 class="section-title">🛒 Your Cart</h2>
            <div class="table-responsive">
                <div class="cart-container ">
                    <asp:Label ID="lblMsg" runat="server" CssClass="msg-label"></asp:Label>

                    <asp:Repeater ID="rptCart" runat="server"
                        OnItemCommand="rptCart_ItemCommand">
                        <HeaderTemplate>
                            <table>
                                <thead>
                                    <tr>
                                        <th align="left">Product</th>
                                        <th>Price</th>
                                        <th>Qty</th>
                                        <th>Total</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>

                        <ItemTemplate>
                            <tr>
                                <td>
                                    <div class="product-info">
                                        <img src='<%# Eval("ProductImage") %>' alt='<%# Eval("ProductName") %>' />
                                        <span><%# Eval("ProductName") %></span>
                                    </div>
                                </td>
                                <td class="price">₹ <%# Eval("ProductPrice") %></td>
                                <td>
                                    <asp:TextBox
                                        ID="txtQty"
                                        runat="server"
                                        Text='<%# Eval("Qty") %>'
                                        CssClass="qty-box"
                                        Width="65px" />
                                    <asp:LinkButton
                                        ID="btnUpdate"
                                        runat="server"
                                        CommandName="UpdateQty"
                                        CommandArgument='<%# Eval("KitID") %>'
                                        CssClass="btn"
                                        Style="padding: 4px 10px; font-size: 12px; margin-top: 4px;">
                                    Update
                                    </asp:LinkButton>
                                </td>
                                <td class="total">₹ <%# Convert.ToDecimal(Eval("Qty")) * Convert.ToDecimal(Eval("ProductPrice")) %>
                                </td>
                                <td>
                                    <asp:LinkButton
                                        ID="btnDelete"
                                        runat="server"
                                        CommandName="DeleteItem"
                                        CommandArgument='<%# Eval("KitID") %>'
                                        CssClass="btn-delete"
                                        OnClientClick="return confirm('Remove this item?');">
                                    <i class="fa fa-trash"></i>
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>

                        <FooterTemplate>
                            </tbody>
                        </table>
                        </FooterTemplate>
                    </asp:Repeater>

                    <div class="grand-total-box">
                        <asp:Label ID="lblGrandTotal" runat="server"></asp:Label>
                    </div>

                    <div class="cart-footer">
                        <a href="ayurvedic-products.aspx" class="btn btn-continue">← Continue Shopping</a>
                        <%--  <a href="checkout.aspx" class="btn btn-checkout">Proceed to Checkout →</a>--%>
                        <a href="javascript:void(0);"
                            onclick="return validateCheckout();"
                            class="btn btn-checkout">Proceed to Checkout →
</a>
                    </div>
                </div>
            </div>

        </div>
    </section>

    <script>
        function validateCheckout() {

            var totalText = document.getElementById('<%= lblGrandTotal.ClientID %>').innerText.trim();

            // Extract numeric value from text
            var amount = totalText.replace(/[^\d.]/g, '');

            if (amount == "" || parseFloat(amount) == 0) {

                alert("⚠️Oops! You haven't added any products yet. Please choose a product to continue.");

                window.location.href = "ayurvedic-products.aspx"; // apna product page name yaha set karein
                return false;
            }

            window.location.href = "checkout.aspx";
            return true;
        }
</script>
</asp:Content>
