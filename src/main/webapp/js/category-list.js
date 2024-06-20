document.addEventListener('DOMContentLoaded', () => {
    const images = document.querySelectorAll('.product-image');
    images.forEach(image => {
        image.addEventListener('click', (e) => {
            const productId = e.target.getAttribute('data-productid');
            window.location.href = `product-detail.jsp?id=${productId}`;
        });
    });
});

document.addEventListener("DOMContentLoaded", function() {
    /*
    fetch('products.json')
        .then(response => response.json())
        .then(data => {
            const container = document.getElementById('productContainer');
            data.forEach(product => {
                const productDiv = document.createElement('div');
                productDiv.classList.add('product');
                productDiv.innerHTML = `
                    <p class="item-name-text">${product.name}</p>
                    <p class="desc-text br-x-small">${product.description}</p>
                    <div class="image-center">
                        <img src="${product.path}" alt="" class="product-image" data-productid="${product.id}">
                    </div>
                    <div class="product-row">
                        <p class="product-price">${product.price} ₺</p>
                        <div class="add-cart-button">
                            <img src="assets/icons/add.png" class="cart-icon">
                        </div>
                    </div>
                `;
                container.appendChild(productDiv);
            });

            // Add event listener for clicking on product image
            const images = document.querySelectorAll('.product-image');
            images.forEach(image => {
                image.addEventListener('click', (e) => {
                    const productId = e.target.getAttribute('data-productid');
                    window.location.href = `detail.html?id=${productId}`;
                });
            });
        })
        .catch(error => console.error('Error fetching the products:', error));
*/
    const container = document.getElementById('productContainer');
    let isDown = false;
    let startX;
    let scrollLeft;

    container.addEventListener('mousedown', (e) => {
        isDown = true;
        container.classList.add('active');
        startX = e.pageX - container.offsetLeft;
        scrollLeft = container.scrollLeft;
    });

    container.addEventListener('mouseleave', () => {
        isDown = false;
        container.classList.remove('active');
    });

    container.addEventListener('mouseup', () => {
        isDown = false;
        container.classList.remove('active');
    });

    container.addEventListener('mousemove', (e) => {
        if (!isDown) return;
        e.preventDefault();
        const x = e.pageX - container.offsetLeft;
        const walk = (x - startX) * 1; //scroll-fast
        container.scrollLeft = scrollLeft - walk;
    });
});