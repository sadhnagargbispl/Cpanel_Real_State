<%@ Page Title="" Language="C#" MasterPageFile="~/SideMaster.master" 
    AutoEventWireup="true" CodeFile="order-thankyou.aspx.cs" 
    Inherits="order_thankyou" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .thankyou-section {
            padding: 80px 20px;
            background: #f4f6f9;
            text-align: center;
        }
        .thankyou-container {
            max-width: 560px;
            margin: auto;
            background: #fff;
            padding: 35px;
            border-radius: 14px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.08);
        }
        .success-icon { font-size: 60px; margin-bottom: 10px; }
        .thankyou-container h2 { margin-bottom: 5px; font-size: 26px; }
        .thankyou-container > p { color: #666; margin-bottom: 25px; }

        .order-box {
            text-align: left;
            background: #f9fafb;
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
        }
        .order-box h3 { margin-bottom: 15px; font-size: 17px; }

        .order-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
            border-bottom: 1px solid #eee;
            padding-bottom: 8px;
        }
        .order-row span:last-child { font-weight: 600; }

        .status-success { color: green !important; }

        .items-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        .items-table th {
            background: #f0fdf4;
            padding: 8px;
            font-size: 13px;
        }
        .items-table td {
            padding: 8px;
            font-size: 13px;
            border-bottom: 1px solid #eee;
            text-align: center;
        }

        .thankyou-actions {
            margin-top: 25px;
            display: flex;
            gap: 12px;
            justify-content: center;
        }
        .btn {
            padding: 12px 20px;
            border-radius: 7px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: opacity 0.3s;
        }
        .btn:hover { opacity: 0.85; }
        .btn-home { background: #6c757d; color: #fff; }
        .btn-shop { background: #28a745; color: #fff; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="thankyou-section">
        <div class="thankyou-container">

            <div class="success-icon">✅</div>
            <h2>Thank You! 🎉</h2>
            <p>Your order has been placed successfully. We'll contact you soon!</p>

            <div class="order-box">
                <h3>📦 Order Details</h3>

                <div class="order-row">
                    <span>Order ID:</span>
                    <asp:Label ID="lblOrderID" runat="server" CssClass="status-success"></asp:Label>
                </div>
                <div class="order-row">
                    <span>Name:</span>
                    <asp:Label ID="lblName" runat="server"></asp:Label>
                </div>
                <div class="order-row">
                    <span>Phone:</span>
                    <asp:Label ID="lblPhone" runat="server"></asp:Label>
                </div>
              <%--  <div class="order-row">
                    <span>Address:</span>
                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                </div>--%>
                <div class="order-row">
                    <span>Order Date:</span>
                    <asp:Label ID="lblDate" runat="server"></asp:Label>
                </div>
                <div class="order-row">
                    <span>Total Paid:</span>
                    <asp:Label ID="lblTotal" runat="server" CssClass="status-success"></asp:Label>
                </div>
                <div class="order-row">
                    <span>Status:</span>
                    <asp:Label ID="lblStatus" runat="server" CssClass="status-success"></asp:Label>
                </div>

                <!-- ORDER ITEMS -->
                <br />
                <h3>🧴 Items Ordered</h3>
                <asp:Repeater ID="rptOrderItems" runat="server">
                    <HeaderTemplate>
                        <table class="items-table">
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
                            <td align="left"><%# Eval("ProductName") %></td>
                            <td>₹ <%# Eval("Price") %></td>
                            <td><%# Eval("Qty") %></td>
                            <td>₹ <%# Convert.ToDecimal(Eval("Qty")) * Convert.ToDecimal(Eval("Price")) %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <div class="thankyou-actions">
                <a href="Main.aspx" class="btn btn-home">🏠 Go to Home</a>
                <a href="ayurvedic-products.aspx" class="btn btn-shop">🛒 Continue Shopping</a>
            </div>
        </div>
    </section>
</asp:Content>