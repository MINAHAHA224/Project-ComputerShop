<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- JSP Path: admin/order/invoice-template.jsp -->
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <title>Hóa Đơn Điện Tử - Laptopshop</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f4f4f4;
        color: #333;
      }
      .container {
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        max-width: 800px;
        margin: auto;
      }
      .header {
        text-align: center;
        border-bottom: 1px solid #eee;
        padding-bottom: 10px;
        margin-bottom: 20px;
      }
      .header h1 {
        margin: 0;
        color: #007bff;
      }
      .header p {
        margin: 5px 0 0;
      }
      .invoice-details,
      .customer-details {
        margin-bottom: 20px;
      }
      .invoice-details p,
      .customer-details p {
        margin: 5px 0;
        line-height: 1.6;
      }
      .invoice-details strong,
      .customer-details strong {
        display: inline-block;
        width: 150px;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
      }
      th,
      td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: left;
      }
      th {
        background-color: #f8f8f8;
      }
      .total-section {
        text-align: right;
      }
      .total-section p {
        margin: 5px 0;
        font-size: 1.1em;
      }
      .total-section strong {
        font-size: 1.2em;
        color: #d9534f;
      }
      .footer {
        text-align: center;
        margin-top: 30px;
        padding-top: 10px;
        border-top: 1px solid #eee;
        font-size: 0.9em;
        color: #777;
      }
      .highlight {
        color: #007bff;
        font-weight: bold;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>Laptopshop</h1>
        <p>Cảm ơn bạn đã mua hàng!</p>
      </div>

      <div class="invoice-details">
        <h2>Hóa Đơn Điện Tử</h2>
        <p><strong>Mã đơn hàng:</strong> #${order.id}</p>
        <p>
          <strong>Ngày đặt hàng:</strong>
          <fmt:formatDate value="${order.time}" pattern="dd/MM/yyyy HH:mm:ss" />
        </p>
        <p>
          <strong>Phương thức thanh toán:</strong>
          <c:choose>
            <c:when test="${order.typePayment == 'COD'}"
              >Thanh toán khi nhận hàng (COD)</c:when
            >
            <c:when test="${order.typePayment == 'MOMO'}">Momo</c:when>
            <c:when test="${order.typePayment == 'VNPAY'}">VNPay</c:when>
            <c:otherwise>${order.typePayment}</c:otherwise>
          </c:choose>
        </p>
        <p>
          <strong>Trạng thái thanh toán:</strong>
          <span class="highlight">
            <c:choose>
              <c:when test="${order.statusPayment == 'UNPAID'}"
                >Chưa thanh toán</c:when
              >
              <c:when test="${order.statusPayment == 'PAID'}"
                >Đã thanh toán</c:when
              >
              <c:when test="${order.statusPayment == 'REFUNDED'}"
                >Đã hoàn tiền</c:when
              >
              <c:when test="${order.statusPayment == 'FAILED'}"
                >Thanh toán thất bại</c:when
              >
              <c:otherwise>${order.statusPayment}</c:otherwise>
            </c:choose>
          </span>
        </p>
      </div>

      <div class="customer-details">
        <h3>Thông tin khách hàng:</h3>
        <p><strong>Người nhận:</strong> ${order.receiverName}</p>
        <p><strong>Địa chỉ:</strong> ${order.receiverAddress}</p>
        <p><strong>Điện thoại:</strong> ${order.receiverPhone}</p>
        <p><strong>Email:</strong> ${order.userEmail}</p>
      </div>

      <h3>Chi tiết đơn hàng:</h3>
      <table>
        <thead>
          <tr>
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>Đơn giá</th>
            <th>Thành tiền</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="item" items="${order.orderDetails}">
            <tr>
              <td>${item.productName}</td>
              <%-- Giả sử ProductEntity có trường name --%>
              <td>${item.productQuantity}</td>
              <td>
                <fmt:formatNumber
                  value="${item.price / item.productQuantity}"
                  type="number"
                />
                đ
              </td>
              <td>
                <fmt:formatNumber value="${item.price}" type="number" /> đ
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <div class="total-section">
        <p>
          Tổng tiền hàng:
          <fmt:formatNumber value="${order.totalPrice}" type="number" /> đ
        </p>
        <p>Phí vận chuyển: <fmt:formatNumber value="0" type="number" /> đ</p>
        <%-- Cập nhật nếu có phí ship --%>
        <p>
          <strong
            >Tổng cộng thanh toán:
            <fmt:formatNumber value="${order.totalPrice}" type="number" />
            đ</strong
          >
        </p>
      </div>

      <div class="footer">
        <p>Cảm ơn quý khách đã tin tưởng và mua sắm tại Laptopshop.</p>
        <p>Nếu có bất kỳ thắc mắc nào, vui lòng liên hệ chúng tôi.</p>
      </div>
    </div>
  </body>
</html>
