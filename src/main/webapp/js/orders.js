document.addEventListener("DOMContentLoaded", function() {
    fetch('orders.json')
        .then(response => response.json())
        .then(data => {
            const orderList = document.getElementById('orderList');
            const activeOrderCount = document.getElementById('activeOrderCount');
            let activeOrders = 0;

            data.forEach(order => {
                const orderItem = document.createElement('div');
                orderItem.classList.add('order-item');

                let buttonText = '';
                let operationColor = '';

                switch (order.order_state) {
                    case 0:
                        buttonText = 'Siparişi İptal Et';
                        operationColor =  "var(--orange-color-1)";
                        activeOrders++;
                        break;
                    case 1:
                        buttonText = 'Kargo Takip';
                        operationColor =  "var(--blue-color-1)";
                        activeOrders++;
                        break;
                    case 2:
                        buttonText = 'Değerlendir';
                        operationColor =  "var(--green-color-1)";
                        break;
                    default:
                        buttonText = 'İşlem Yapılamaz';
                        operationColor = "var(--grey-color-2)";
                }

                orderItem.innerHTML = `
                    <div class="order-info">
                        <div class="order-date">
                            <p class="order-info-title">Sipariş<br class="br-x-small">Tarihi</p>
                            <p class="order-info-date">${order.order_date}<br class="br-x-small">${order.order_time}</p>
                        </div>
                        <div class="order-line"></div>
                        <div class="order-details">
                            <div class="text-column">
                                <p class="order-info-title">${order.order_name}</p>
                                <p>${order.order_description}</p>
                                <p>${order.order_count}</p>
                                <p>Satıcı : ${order.order_seller_name}</p>
                            </div>
                            <div class="order-image">
                                <!-- Görsel buraya eklenecek -->
                            </div>
                        </div>
                    </div>
                    <div class="spacer"></div>
                    <div class="order-operation" style="background-color: ${operationColor};">
                        <div class="order-state">
                            <p class="order-operation-text">Sipariş<br class="br-x-small">Durumu</p>
                            <p class="order-operation-text text-align-end">${order.order_state === 0 ? 'Hazırlanıyor' : order.order_state === 1 ? 'Kargoya Verildi' : 'Teslim Edildi'}</p>
                        </div>
                        <div class="order-amount">
                            <p class="order-operation-text">Ödendi</p>
                            <p class="order-amount-text text-align-end">${order.amount} ₺</p>
                        </div>
                        <div class="order-button">
                            <p class="order-button-text" style="color: ${operationColor};">${buttonText}</p>
                        </div>
                    </div>
                `;

                orderList.appendChild(orderItem);
            });

            activeOrderCount.innerText = activeOrders;
        })
        .catch(error => console.error('Error fetching the orders:', error));
});