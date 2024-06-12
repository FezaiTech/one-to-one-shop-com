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