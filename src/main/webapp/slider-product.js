const row = document.getElementById('scrollable-row');
const leftBtn = document.getElementById('left-btn');
const rightBtn = document.getElementById('right-btn');


leftBtn.addEventListener('click', () => {
    row.scrollBy({ left: -260, behavior: 'smooth' });
});

rightBtn.addEventListener('click', () => {
    row.scrollBy({ left: 260, behavior: 'smooth' });
});

row.addEventListener('scroll', () => {
    leftBtn.disabled = row.scrollLeft === 0;
    rightBtn.disabled = row.scrollLeft + row.clientWidth >= row.scrollWidth;
});

document.addEventListener('DOMContentLoaded', () => {
    leftBtn.disabled = row.scrollLeft === 0;
    rightBtn.disabled = row.scrollLeft + row.clientWidth >= row.scrollWidth;
});