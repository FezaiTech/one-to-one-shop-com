document.addEventListener("DOMContentLoaded", function() {
    fetch('products.json')
        .then(response => response.json())
        .then(data => {
            const container = document.getElementById('productContainer');
            data.forEach(product => {
                const productDiv = document.createElement('div');
                productDiv.classList.add('product');
                productDiv.innerHTML = `
                    <h2>${product.name}</h2>
                    <p class="br-x-small">${product.description}</p>
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



const posters = document.querySelectorAll('.poster-img');
const indexes = document.querySelectorAll('.index');
let currentIndex = 0;
let interval;

function showPoster(index) {
    posters.forEach((poster, i) => {
        poster.classList.toggle('active', i === index);
    });
    indexes.forEach((indexElem, i) => {
        indexElem.classList.toggle('active', i === index);
    });
    currentIndex = index;
}

function startInterval() {
    interval = setInterval(() => {
        currentIndex = (currentIndex + 1) % posters.length;
        showPoster(currentIndex);
    }, 5000);
}

function stopInterval() {
    clearInterval(interval);
}

indexes.forEach((indexElem, i) => {
    indexElem.addEventListener('click', () => {
        stopInterval();
        showPoster(i);
        startInterval();
    });
});

let startX = 0;
let isDragging = false;

function handleGesture(offsetX) {
    if (offsetX < 0) {
        currentIndex = (currentIndex + 1) % posters.length;
    } else {
        currentIndex = (currentIndex - 1 + posters.length) % posters.length;
    }
    showPoster(currentIndex);
}

// Touch events
document.querySelector('.poster').addEventListener('touchstart', (e) => {
    startX = e.changedTouches[0].screenX;
});

document.querySelector('.poster').addEventListener('touchend', (e) => {
    const endX = e.changedTouches[0].screenX;
    if (endX !== startX) handleGesture(endX - startX);
});

// Mouse events
document.querySelector('.poster').addEventListener('mousedown', (e) => {
    startX = e.screenX;
    isDragging = true;
});

document.querySelector('.poster').addEventListener('mouseup', (e) => {
    if (isDragging) {
        const endX = e.screenX;
        if (endX !== startX) handleGesture(endX - startX);
        isDragging = false;
    }
});

document.querySelector('.poster').addEventListener('mouseleave', () => {
    if (isDragging) isDragging = false;
});

document.querySelector('.poster').addEventListener('mousemove', (e) => {
    if (isDragging) {
        const endX = e.screenX;
        if (endX !== startX) handleGesture(endX - startX);
        isDragging = false;
    }
});

showPoster(currentIndex);
startInterval();