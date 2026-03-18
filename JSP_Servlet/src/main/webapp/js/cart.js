function moneyToNumber(text) {
    return parseInt(String(text).replace(/[^\d]/g, "")) || 0;
}

function updateCartTotalsUI() {
    let subtotal = 0;

    document.querySelectorAll(".cart-item").forEach(itemEl => {
        const priceText = itemEl.querySelector(".current-price")?.textContent ?? "0";
        const qtyInput = itemEl.querySelector(".quantity-input");
        const price = moneyToNumber(priceText);
        const qty = parseInt(qtyInput?.value || "1", 10);

        subtotal += price * qty;
    });

    const discountEl = document.getElementById("discount");
    const discount = discountEl ? moneyToNumber(discountEl.textContent) : 0;

    const subtotalEl = document.getElementById("subtotal");
    const totalEl = document.getElementById("total");

    if (subtotalEl) subtotalEl.textContent = subtotal.toLocaleString("vi-VN") + "đ";
    const total = Math.max(0, subtotal - discount);
    if (totalEl) totalEl.textContent = total.toLocaleString("vi-VN") + "đ";
}

function increaseUI(productId) {
    const input = document.getElementById(`quantity-${productId}`);
    if (!input) return;
    input.value = (parseInt(input.value || "1", 10) + 1);
    updateCartTotalsUI();
}

function decreaseUI(productId) {
    const input = document.getElementById(`quantity-${productId}`);
    if (!input) return;
    const cur = parseInt(input.value || "1", 10);
    if (cur > 1) input.value = cur - 1;
    updateCartTotalsUI();
}

document.addEventListener("DOMContentLoaded", updateCartTotalsUI);
const promoInput = document.querySelector(".promo-input");

//input sẽ rung nhẹ khi nhập mã sai

function applyPromo() {
    const code = document.getElementById("promoCode").value.trim().toUpperCase();
    let discount = document.getElementById("discount");
    if (code === "CODE001") {
        Swal.fire({
            icon: "success",
            title: "Áp dụng giảm giá",
            text: "Mã giảm giá đã được áp dụng",
            timer: 1500,
            showConfirmButton: false,
        });
        discount.textContent = "1.500.000đ";
        updateCartTotalsUI();
    } else if (code === "") {
        Swal.fire({
            icon: "error",
            title: "Chưa nhập mã",
            text: "Vui lòng nhập mã giảm giá",
            timer: 1500,
            showConfirmButton: false,
        });
    } else {
        promoInput.classList.add("shake");
        setTimeout(() => promoInput.classList.remove("shake"), 500);
        Swal.fire({
            icon: "error",
            title: "Áp dụng giảm giá",
            text: "Mã giảm giá không tồn tại",
            timer: 1500,
            showConfirmButton: false,
        });
    }
}

// Add event listeners
document.addEventListener("DOMContentLoaded", () => {
    const promoBtn = document.querySelector(".promo-btn");
    if (promoBtn) {
        promoBtn.addEventListener("click", applyPromo);
    }

    if (promoInput) {
        promoInput.addEventListener("keydown", (e) => {
            if (e.key === "Enter" || e.key === " ") {
                applyPromo();
            }
        });
    }
});

async function submitPayment(e) {
    if (e) e.preventDefault();
    await Swal.fire({
        icon: "success",
        title: "Thanh toán thành công",
        text: "Cảm ơn bạn đã mua hàng!",
        timer: 2000,
        showConfirmButton: false,
    });
}
