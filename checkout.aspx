<%@ Page Title="" Language="C#" MasterPageFile="~/SideMaster.master"
    AutoEventWireup="true" CodeFile="checkout.aspx.cs" Inherits="checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
        }

        .section-title {
            text-align: center;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 30px;
        }

        .checkout-layout {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 25px;
        }

        .cart-container, .form-card, .summary-card {
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 20px;
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

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            outline: none;
            transition: 0.3s;
            box-sizing: border-box;
            font-size: 14px;
        }

            .form-control:focus {
                border-color: #28a745;
            }

        .form-row {
            display: flex;
            gap: 12px;
            margin-bottom: 14px;
        }

            .form-row .form-group {
                flex: 1;
            }

        .form-group {
            margin-bottom: 14px;
        }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-size: 13px;
                font-weight: 600;
                color: #444;
            }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 15px;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
            border-top: 2px solid #eee;
            padding-top: 10px;
            color: #28a745;
        }

        aside {
            position: sticky;
            top: 20px;
            height: fit-content;
        }

        .btn-confirm {
            display: block;
            width: 100%;
            text-align: center;
            background: linear-gradient(135deg, #28a745, #218838);
            color: #fff;
            padding: 14px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            border: none;
            cursor: pointer;
            transition: 0.3s;
        }

            .btn-confirm:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(40,167,69,0.3);
            }

        .error-msg {
            color: red;
            font-size: 13px;
            margin-bottom: 10px;
            display: block;
        }

        .price {
            color: #28a745;
            font-weight: bold;
        }

        @media (max-width: 768px) {
            .checkout-layout {
                grid-template-columns: 1fr;
            }

            .form-row {
                flex-direction: column;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section style="padding: 60px 20px;">
        <div class="container">
            <h2 class="section-title">Checkout</h2>

            <div class="checkout-layout">

                <!-- LEFT -->
                <div>
                    <!-- CART SUMMARY TABLE -->
                    <div class="cart-container">
                        <h3>🛒 Your Items</h3>
                        <br />
                        <asp:Repeater ID="rptCheckoutCart" runat="server">
                            <HeaderTemplate>
                                <table>
                                    <thead>
                                        <tr>
                                            <th align="left">Product</th>
                                            <th>Price</th>
                                            <th>Qty</th>
                                            <th>Total</th>
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
                                    <td><%# Eval("Qty") %></td>
                                    <td class="price">₹ <%# Convert.ToDecimal(Eval("Qty")) * Convert.ToDecimal(Eval("ProductPrice")) %>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>

                    <!-- BILLING FORM -->
                    <div class="form-card">
                        <h3>📋 Billing Details</h3>
                        <br />

                        <asp:Label ID="lblMsg" runat="server" CssClass="error-msg"></asp:Label>

                        <div class="form-row">
                            <div class="form-group">
                                <label>First Name *</label>
                                <asp:TextBox ID="txtFirstName" runat="server"
                                    CssClass="form-control" placeholder="First Name" />
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Email *</label>
                                <asp:TextBox ID="txtEmail" runat="server"
                                    CssClass="form-control" placeholder="Email" TextMode="Email" />
                            </div>
                            <div class="form-group">
                                <label>Phone *</label>
                                <asp:TextBox ID="txtPhone" runat="server"
                                    CssClass="form-control" placeholder="Phone" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Address *</label>
                            <asp:TextBox ID="TxtPostalAddress" runat="server"
                                CssClass="form-control" placeholder="Full Address"
                                TextMode="MultiLine" Rows="3" />
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label>City *</label>
                                <asp:TextBox ID="TxtPostCity" runat="server"
                                    CssClass="form-control" placeholder="City" />
                            </div>
                            <div class="form-group">
                                <label>State *</label>
                                <asp:DropDownList ID="ddlPostSate" runat="server" CssClass="form-control ">
                                </asp:DropDownList>
                                <%--  <asp:TextBox ID="txtState" runat="server"
         CssClass="form-control" placeholder="State" />--%>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>District *</label>
                                <asp:TextBox ID="TxtPostDistrict" runat="server"
                                    CssClass="form-control" placeholder="District" />
                            </div>
                            <div class="form-group">
                                <label>PIN Code *</label>
                                <asp:TextBox ID="TxtPostPincode" runat="server"
                                    CssClass="form-control" placeholder="PIN Code" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- RIGHT SIDEBAR -->
                <aside>
                    <div class="summary-card">
                        <h3>📦 Order Summary</h3>
                        <br />
                        <asp:Repeater ID="rptSummary" runat="server">
                            <ItemTemplate>
                                <div class="summary-row">
                                    <span><%# Eval("ProductName") %> x<%# Eval("Qty") %></span>
                                    <span>₹ <%# Convert.ToDecimal(Eval("Qty")) * Convert.ToDecimal(Eval("ProductPrice")) %></span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <div class="summary-row">
                            <span>Shipping</span>
                            <span style="color: green;">FREE</span>
                        </div>
                        <hr />
                        <div class="summary-total">
                            <span>Total</span>
                            <asp:Label ID="lblTotal" runat="server"></asp:Label>
                        </div>
                    </div>

                    <div class="summary-card">
                        <div class="form-card">
                            
                            <div class="payment-methods">

                                <label class="pay-box active">

                                    <div class="pay-content">

                                        <div>
                                            <strong>Available Balance :
                                                <asp:Label ID="AvailableBal" runat="server"></asp:Label></strong>
                                        </div>
                                    </div>
                                </label>
                            </div>
                        </div>
                        <asp:Button
                            ID="btnConfirmOrder"
                            runat="server"
                            Text="✅ Confirm Order →"
                            CssClass="btn-confirm"
                            OnClientClick="return validateCheckout();"
                            OnClick="btnConfirmOrder_Click" />
                    </div>
                </aside>

            </div>
        </div>
    </section>
    <script>
        function validateCheckout() {
            debugger;
            var totalText = document.getElementById('<%= lblTotal.ClientID %>').innerText.trim();

            // Extract numeric value from text
            var amount = totalText.replace(/[^\d.]/g, '');

            if (amount == "" || parseFloat(amount) == 0) {

                alert("⚠️Oops! You haven't added any products yet. Please choose a product to continue.");

                window.location.href = "ayurvedic-products.aspx"; // apna product page name yaha set karein
                return false;
            }
            return true;
        }
</script>
</asp:Content>
