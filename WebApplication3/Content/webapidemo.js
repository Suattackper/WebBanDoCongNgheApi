//load sản phẩm
$(document).ready(function () {
    const itemsPerPage = 9; // Số lượng sản phẩm trên mỗi trang
    let currentPage = 1; // Trang hiện tại
    var totalPages = 0;

    // Hàm để hiển thị dữ liệu cho trang hiện tại
    function displayData(products) {
        $('.data-products').empty(); // Xóa dữ liệu hiện tại trước khi hiển thị dữ liệu mới
        const startIndex = (currentPage - 1) * itemsPerPage;
        const endIndex = currentPage * itemsPerPage;
        const currentPageProducts = products.slice(startIndex, endIndex);
        currentPageProducts.forEach(product => {
            // Tạo HTML cho mỗi sản phẩm và thêm vào $('.data-products')
            /*var d = 0;*/
            /*var strPrice = '';*/
            var strHTML = `
                <div class="mix mix-main col-span-12 h-auto sm:col-span-6 lg:col-span-4">
                    <div class="card-container transition-all-300 translateY-2 relative flex h-full flex-col overflow-hidden rounded-lg bg-white p-5 shadow-md hover:z-[2] hover:shadow-xl">
                `;
            const detailUrl = '#!';
            product.Description = '';
            /*const imageData = product.ImageProduct;*/
            strHTML = strHTML + `
                        <div class="h-[190px] overflow-hidden rounded-lg">
                            <a href="${detailUrl}">
                                <img src="/Content/images/product/${product.ImageProduct}.jpg" class="card-object-fit h-full w-full" alt="${product.ProductName}" />
                            </a>
                        </div>
                        <div class="my-2 flex justify-between">
                            <div class="flex">`;
            if (product.Rate == 0) {
                strHTML = strHTML + `
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>`;
            }
            else if (product.Rate > 0 && product.Rate <= 1) {
                strHTML = strHTML + `
                    <i class="bi bi-star-fill flex text-base text-star"></i>
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>`;
            }
            else if (product.Rate > 1 && product.Rate <= 2) {
                strHTML = strHTML + `
                    <i class="bi bi-star-fill flex text-base text-star"></i>
                    <i class="bi bi-star-fill flex text-base text-star"></i>
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>`;
            }
            else if (product.Rate > 2 && product.Rate <= 3) {
                strHTML = strHTML + `
                    <i class="bi bi-star-fill flex text-base text-star"></i>
                    <i class="bi bi-star-fill flex text-base text-star"></i>
                    <i class="bi bi-star-fill flex text-base text-star"></i>
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>`;
            }
            else if (product.Rate > 3 && product.Rate <= 4) {
                strHTML = strHTML + `
                    <i class="bi bi-star-fill flex text-base text-star"></i>
                    <i class="bi bi-star-fill flex text-base text-star"></i>
                    <i class="bi bi-star-fill flex text-base text-star"></i>
                    <i class="bi bi-star-fill flex text-base text-star"></i>
                    <i class="bi bi-star-fill flex text-base text-gray-200"></i>`;
            }
            else {
                strHTML = strHTML + `
                    <i class="bi bi-star-fill flex text-base text-star"></i>
                    <i class="bi bi-star-fill flex text-base text-star"></i>
                    <i class="bi bi-star-fill flex text-base text-star"></i>
                    <i class="bi bi-star-fill flex text-base text-star"></i>
                    <i class="bi bi-star-fill flex text-base text-star"></i>`;
            }
            if (product.Quantity > 0) {
                strHTML = strHTML + `
                    </div>
                    <div>
                        <span class="rounded-md bg-green-300 py-1 px-2 text-xs font-bold uppercase text-white">instock</span>`;
            }
            else {
                strHTML = strHTML + `
                    </div>
                    <div>
                        <span class="rounded-md bg-green-300 py-1 px-2 text-xs font-bold uppercase text-white" style="background-color:red">saleout</span>`;
            }
            strHTML = strHTML + `
                            </div>
                        </div>
                        <div class="my-1">
                            <a class="clamp break-all font-medium" href="${detailUrl}">
                                ${product.ProductName}
                            </a>
                        </div>
                        <div class="my-1">
                            <p class="clamp-2 text-sm text-gray-400">
                                ${product.Description}
                            </p>
                        </div>
                        <div class="my-1">`;
            //if (d == 0) {
            //    strHTML = strHTML + `
            //    <span class="text-lg font-bold">₫${product.Price.toLocaleString()}</span>`;
            //}
            //else {
            //    strHTML = strHTML + strPrice;
            //}
            strHTML = strHTML + `
                    <span class="text-lg font-bold">₫${product.Price.toLocaleString()}</span>`;

            strHTML = strHTML + `
                        </div>
                        <div class="mt-auto">
                            <a  id="addtocart" data-productcode="${product.ProductCode}" class="btn-effect transition-all-300 flex w-full items-center justify-center rounded-lg bg-primary-color p-2" href="#!">
                                <i class="bi bi-cart-fill flex text-xl text-white"></i>
                                <span class="font-bold uppercase text-white">Add to cart</span>
                            </a>
                        </div>
                    </div>
                </div>`;
            $('.data-products').append(strHTML);
        });
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    // Hàm để tạo các nút phân trang
    function createPaginationButtons(totalPages) {
        $('.pagination').empty(); // Xóa các nút phân trang hiện tại trước khi tạo mới

        // Thêm các nút trang
        for (let i = 1; i <= totalPages; i++) {
            const button = `<li class="${i === currentPage ? 'active' : ''} cursor-pointer py-2 px-3" data-page="${i}">${i}</li>`;
            $('.pagination').append(button);
        }
    }
    var catecode = $('#category').data('category');
    if (catecode != 0) {
        // Gọi API để lấy dữ liệu sản phẩm
        $.ajax({
            url: '/Api/Product',
            type: 'GET',
            data: { 'catecode': catecode },
            success: function (response) {
                const products = response; // Dữ liệu sản phẩm từ API
                totalPages = Math.ceil(products.length / itemsPerPage); // Tính tổng số trang
                displayData(products); // Hiển thị dữ liệu cho trang đầu tiên
                createPaginationButtons(totalPages); // Tạo các nút phân trang
            },
            error: function (err) {
                console.log(err);
            }
        });
    }
    else {
        // Gọi API để lấy dữ liệu sản phẩm
        $.ajax({
            url: '/Api/Product',
            type: 'GET',
            success: function (response) {
                const products = response; // Dữ liệu sản phẩm từ API
                totalPages = Math.ceil(products.length / itemsPerPage); // Tính tổng số trang
                displayData(products); // Hiển thị dữ liệu cho trang đầu tiên
                createPaginationButtons(totalPages); // Tạo các nút phân trang
            },
            error: function (err) {
                console.log(err);
            }
        });
    }

    // Xử lý khi người dùng nhấn vào nút phân trang
    $(document).on('click', '.pagination li', function () {
        const clickedPage = parseInt($(this).attr('data-page')); // Lấy số trang từ thuộc tính data-page của nút
        if (!isNaN(clickedPage)) {
            currentPage = clickedPage;
            var catecode1 = $('#category').data('category');
            if (catecode1 != 0) {
                $.ajax({
                    url: '/Api/Product',
                    type: 'GET',
                    data: { 'catecode': catecode1 },
                    success: function (response) {
                        const products = response; // Dữ liệu sản phẩm từ API
                        displayData(products); // Hiển thị dữ liệu cho trang hiện tại
                        createPaginationButtons(totalPages);
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });
            }
            else {
                $.ajax({
                    url: '/Api/Product',
                    type: 'GET',
                    success: function (response) {
                        const products = response; // Dữ liệu sản phẩm từ API
                        displayData(products); // Hiển thị dữ liệu cho trang hiện tại
                        createPaginationButtons(totalPages);
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });
            }
        }
    });


    //xử lý tìm kiếm
    $(document).on('click', "#btn-search", function () {
        var name = document.getElementById("input-search").value;
        //Gọi API để lấy dữ liệu sản phẩm
        $.ajax({
            url: '/api/product/search',
            type: 'GET',
            data: { 'name': name },
            success: function (response) {
                const products = response; // Dữ liệu sản phẩm từ API
                totalPages = Math.ceil(products.length / itemsPerPage); // Tính tổng số trang
                displayData(products); // Hiển thị dữ liệu cho trang đầu tiên
                createPaginationButtons(totalPages); // Tạo các nút phân trang
            },
            error: function (err) {
                console.log(err);
            }
        });
        //if (name.trim() !== "") {
        //    window.location.href = `/Product/Shop`;
        //    alert(name);
        //    console.log(name);
        //    //Gọi API để lấy dữ liệu sản phẩm
        //    $.ajax({
        //        /*url: '/api/product/search',*/
        //        url ; '/Api/Product'
        //        type: 'GET',
        //        /*data: { 'name': name },*/
        //        data: { 'catecode': 1 },
        //        success: function (response) {
        //            console.log(response[0].ProductName);
        //            const products = response; // Dữ liệu sản phẩm từ API
        //            totalPages = Math.ceil(products.length / itemsPerPage); // Tính tổng số trang
        //            displayData(products); // Hiển thị dữ liệu cho trang đầu tiên
        //            createPaginationButtons(totalPages); // Tạo các nút phân trang
        //        },
        //        error: function (err) {
        //            console.log(err);
        //        }
        //    });
        //}
    });
});
//load khi tải trang
loadcart();
//load giở hàng
function loadcart() {
    var accountcode = $('#checkaccount').data('checkaccount');
    if (accountcode != 'NotUserId') {
        var strHTML = '';
        var price = 0;
        $.ajax({
            url: '/Api/Cart',
            type: 'GET',
            data: { 'AccountCode': accountcode },
            success: function (ress) {
                $('.data-carts').empty();
                if (ress.length > 0) {
                    for (var i = 0; i < ress.length; i++) {
                        const cart = ress[i];
                        price = price + cart.Price * cart.Quantity;
                        strHTML = strHTML + `
                                    <a class="transition-all-300 flex h-[100px] w-full items-center justify-between gap-5 bg-white p-2 hover:bg-gray-100"
                                           href="#">
                                            <div class="h-[80px] w-[80px] min-w-[80px] overflow-hidden rounded-lg border">
                                            <img class="h-full w-full object-cover" src="/Content/images/product/${cart.ImageProduct}.jpg" alt="product" />
                                        </div>
                                        <div class="flex w-full flex-col">
                                            <h6 class="clamp-2 break-all text-lg font-semibold">
                                                ${cart.ProductName}
                                            </h6>
                                            <div class="flex gap-2">
                                                <div class="flex gap-1 leading-7 text-gray-400">
                                                    <span>${cart.Quantity}</span>
                                                    <span>X</span>
                                                </div>
                                                <div class="flex items-center gap-2">
                                                    <span class="font-bold text-primary-color">₫${(cart.Price * cart.Quantity).toLocaleString()}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="deleteproductcart" data-deleteproductcart="${cart.ProductCode}" class="transition-all-300 flex text-slate-400 hover:text-primary-color">
                                            <i class="bi bi-trash-fill pointer-events-none text-2xl"></i>
                                        </div>
                                    </a>
                                `;
                    }
                }
                else {
                    strHTML = strHTML + `
                                <div class="flex flex-col items-center justify-center gap-4 p-5">
                                    <i class="bi bi-cart-x text-8xl text-gray-200"></i>
                                    <p class="font-semibold">There are no products in the cart.</p>
                                    <a class="btn-effect transition-all-300 flex items-center justify-center gap-2 rounded-lg bg-primary-color p-2"
                                       href="/Product/Shop">
                                        <span class="font-bold uppercase text-white">Go to the store</span>
                                    </a>
                                </div>
                            `;
                }
                $('#totalprice').text('₫' + price.toLocaleString()); // Cập nhật giá trị mới cho thẻ span
                $('.data-carts').append(strHTML);

                // Lấy tham chiếu đến phần tử cần cập nhật
                var element = document.getElementById('checkoutnow');
                element.setAttribute("href", "/Home/Checkout/?subtt=" + price.toString());
            },
            error: function (err) {
                console.log(err);
                alert("Đã xảy ra lỗi. Vui lòng thử lại sau.");
            }
        });
    }
    else {
        $('.data-carts').append(`
                    <div class="flex flex-col items-center justify-center gap-4 p-5">
                        <i class="bi bi-cart-x text-8xl text-gray-200"></i>
                        <p class="font-semibold">There are no products in the cart.</p>
                        <a class="btn-effect transition-all-300 flex items-center justify-center gap-2 rounded-lg bg-primary-color p-2"
                            href="/Product/Shop">
                            <span class="font-bold uppercase text-white">Go to the store</span>
                        </a>
                    </div>
                    `);
    }
}
//cật nhật thêm giỏ hàng
$(document).on('click', '#addtocart', (event) => {
    var accountcode = $('#checkaccount').data('checkaccount');
    if (accountcode == 'NotUserId') {
        alert('Vui lòng đăng nhập để thêm vào giỏ!');
        return;
    }
    //var code = $(event.currentTarget).data('productcode');
    var productcode = $(event.currentTarget).attr('data-productcode');
    $.ajax({
        url: '/Api/Cart',
        type: 'POST',
        data: { 'AccountCode': accountcode, 'ProductCode': productcode },
        success: function () {
            var badge = $('#shopingcartcount').text(); // .text() để lấy nội dung của thẻ span
            var newValue = parseInt(badge) + 1;
            $('#shopingcartcount').text(newValue); // Cập nhật giá trị mới cho thẻ span
            loadcart();
        },
        error: function (err) {
            console.log(err);
            alert("Đã xảy ra lỗi. Vui lòng thử lại sau.");
        }
    });
})
//cật nhật xóa giỏ hàng
$(document).on('click', '#deleteproductcart', function (event) {
    var accountcode = $('#checkaccount').data('checkaccount');
    var productcode = $(event.currentTarget).attr('data-deleteproductcart');
    $.ajax({
        url: '/Api/Cart/deleteclick',
        type: 'DELETE',
        data: { 'AccountCode': accountcode, 'ProductCode': productcode },
        success: function () {
            var badge = $('#shopingcartcount').text(); // .text() để lấy nội dung của thẻ span
            var newValue = parseInt(badge) - 1;
            $('#shopingcartcount').text(newValue); // Cập nhật giá trị mới cho thẻ span
            loadcart();
        },
        error: function (err) {
            console.log(err);
            alert("Đã xảy ra lỗi. Vui lòng thử lại sau.");
        }
    });
});
$('.dangkiform').submit(function () {
    event.preventDefault();
    dangki();
});
//xử lí đăng kí
function dangki() {
    //event.preventDefault(); // Ngăn chặn sự kiện mặc định của form

    var firstname = $('#firstname').val();
    var lastname = $('#lastname').val();
    var email = $('#email').val();
    var pass = $('#password').val();
    var passconf = $('#password-confirmation').val();
    if (!firstname || !lastname || !email || !pass || !passconf) {
        alert('Vui lòng nhập đầy đủ thông tin!');
        return;
    }
    if (pass.length < 8) {
        // Mật khẩu ít hơn 8 ký tự, thực hiện xử lý tương ứng
        alert("Mật khẩu cần ít nhất 8 ký tự.");
        return;
    }
    if (pass !== passconf) {
        alert('Mật khẩu xác nhận không đúng!');
        return;
    }
    $.ajax({
        url: '/Api/Account/create',
        type: 'POST',
        data: { 'Email': email, 'Password': pass, 'FirstName': firstname, 'LastName': lastname },
        success: (res) => {
            if (res != null) {
                alert('Tạo tài khoản thành công!');
                window.location.href = `/Home/Index/?code=${res.AccountCode}`;
            }
            else alert('Email không đúng hoặc đã tồn tại!');
        },
        error: (er) => {
            console.log(er);
            alert('Đã xảy ra lỗi khi đăng ký tài khoản!');
        }
    });
}
$('#dangnhapform').submit(function () {
    event.preventDefault();
    dangnhap();
});
//xử lí đăng nhập
function dangnhap() {
    //event.preventDefault(); // Ngăn chặn sự kiện mặc định của form
    var email = $('#email').val();
    var pass = $('#password').val();
    if (!email || !pass) {
        alert('Vui lòng nhập đầy đủ thông tin!');
        return;
    }
    $.ajax({
        url: '/Api/Account/check',
        type: 'POST',
        data: { 'Email': email, 'Password': pass },
        success: (ress) => {
            if (ress != null) window.location.href = `/Home/Index/?code=${ress.AccountCode}`;
            else alert("Tên đăng nhập hoặc mật khẩu không đúng");
        },
        error: (er) => {
            console.log(er);
            alert("Đã xảy ra lỗi. Vui lòng thử lại sau.");
        }
    });
}

$(document).on('click', "#checkoutnow", function () {
    var accountcode = $('#checkaccount').data('checkaccount');
    if (accountcode == 'NotUserId') {
        event.preventDefault();
        alert('Vui lòng đăng nhập!');
        return;
    }
    var badge = $('#shopingcartcount').text(); // .text() để lấy nội dung của thẻ
    var newValue = parseInt(badge);
    if (newValue == 0) {
        event.preventDefault();
        alert('Vui lòng thêm sản phẩm vào giỏ hàng!');
        return;
    }
});
//valid sdt
function isValidVietnamesePhoneNumber(phoneNumber) {
    var phonePattern = /^(0\d{9,10}|84\d{9,10})$/;
    return phonePattern.test(phoneNumber);
}
//xử lí thanh toán
//function checkout() {
//    event.preventDefault();
//    var accountcode = $('#checkaccount').data('checkaccount');
//    var phone = $('#telephone').val();
//    var address = $('#address').val();
//    var city = $('#city').val();
//    var selectElement = document.getElementsByClassName("form-payment")[0];
//    var payment = selectElement.value;
//    if (!phone || !address || !city) {
//        alert('Vui lòng nhập đầy đủ thông tin!');
//        return;
//    }
//    if (!isValidVietnamesePhoneNumber(phone)) {
//        alert('Số điện thoại không đúng!');
//        return;
//    }

//    //var ordercode;
//    //var addresscode;
//    $.ajax({
//        url: '/api/AccountAddress',
//        type: 'POST',
//        data: { 'PhoneNumber': phone, 'Address': address, 'City': city },
//        success: (resdiachi) => {

//            //addresscode = res.AccountAddressCode;
//            alert("1diachi!");
//            $.ajax({
//                url: '/api/Order/create',
//                type: 'POST',
//                data: { 'PaymentCode': payment, 'AccountCode': accountcode, 'AccountAddressCode': resdiachi.AccountAddressCode },
//                success: (resdonhang) => {
//                    //ordercode = res.OrderCode;
//                    alert("2donhang!");
//                    //window.location.href = `/Home/Index/?code=${ress.AccountCode}`;

//                    var totalorder = 30000;
//                    $.ajax({
//                        url: '/api/cart',
//                        type: 'GET',
//                        success: (res) => {
//                            alert("3cartl!");
//                            for (var i = 0; i < res.length; i++) {
//                                const cart = res[i];
//                                var total = cart.Price * cart.Quantity;
//                                $.ajax({
//                                    url: '/api/orderdetail',
//                                    type: 'POST',
//                                    data: { 'OrderCode': resdonhang.OrderCode, 'ProductCode': cart.ProductCode, 'Price': cart.Price, 'Quantity': cart.Quantity, 'Total': total },
//                                    success: () => { alert("4detail!"); },
//                                    error: (er) => {
//                                        console.log(er);
//                                        alert("Đã xảy ra lỗi ở orderdetail. Vui lòng thử lại sau.");
//                                    }
//                                });
//                                $.ajax({
//                                    url: '/Api/Cart',
//                                    type: 'DELETE',
//                                    data: { 'AccountCode': cart.AccountCode, 'ProductCode': cart.ProductCode },
//                                    success: function () {
//                                        alert("5deletecart!");
//                                    },
//                                    error: function (err) {
//                                        console.log(err);
//                                        alert("Đã xảy ra lỗi ở xóa cart. Vui lòng thử lại sau.");
//                                    }
//                                });
//                                totalorder = totalorder + total;
//                            }

//                            $.ajax({
//                                url: '/Api/Order',
//                                type: 'PUT',
//                                data: { 'OrderCode': resdonhang.OrderCode, 'OrderTotal': totalorder },
//                                success: function () {
//                                    $('#shopingcartcount').text('0');
//                                    loadcart();
//                                    alert("Đơn hàng đang được giao đến bạn!");
//                                    //window.location.href = `/Home/Index/?code=${ress.AccountCode}`;
//                                },
//                                error: function (err) {
//                                    console.log(err);
//                                    alert("Đã xảy ra lỗi ở cật nhật order. Vui lòng thử lại sau.");
//                                }
//                            });

//                        },
//                        error: (er) => {
//                            console.log(er);
//                            alert("Đã xảy ra lỗi ở cart. Vui lòng thử lại sau.");
//                        }
//                    });

//                },
//                error: (er) => {
//                    console.log(er);
//                    alert("Đã xảy ra lỗi ở order. Vui lòng thử lại sau.");
//                }
//            });

//        },
//        error: (er) => {
//            console.log(er);
//            alert("Đã xảy ra lỗi ở accountaddress. Vui lòng thử lại sau.");
//        }
//    });



//}
function checkout() {
    event.preventDefault();
    var accountcode = $('#checkaccount').data('checkaccount');
    var ordertotal = $('#total').data('total');
    var phone = $('#telephone').val();
    var address = $('#address').val();
    var city = $('#city').val();
    var selectElement = document.getElementsByClassName("form-payment")[0];
    var payment = selectElement.value;
    if (!phone || !address || !city) {
        alert('Vui lòng nhập đầy đủ thông tin!');
        return;
    }
    if (!isValidVietnamesePhoneNumber(phone)) {
        alert('Số điện thoại không đúng!');
        return;
    }
    if (payment == 3) {
        // Thêm địa chỉ
        $.ajax({
            url: '/api/AccountAddress',
            type: 'POST',
            data: { 'PhoneNumber': phone, 'AccountCode': accountcode, 'Address': address, 'City': city },
            success: (resdiachi) => {
                window.location.href = `/Account/UrlVnpay?accountaddresscode=${resdiachi.AccountAddressCode}&ordertotal=${ordertotal}`;
            },
            error: (er) => {
                console.log(er);
                alert("Đã xảy ra lỗi ở accountaddress. Vui lòng thử lại sau.");
            }
        });
        return;
    }

    createOrder(phone, accountcode, address, city, payment, ordertotal);
}
// Thêm địa chỉ, Tạo đơn hàng
function createOrder(phone, accountcode, address, city, payment, ordertotal) {
    // Thêm địa chỉ
    $.ajax({
        url: '/api/AccountAddress',
        type: 'POST',
        data: { 'PhoneNumber': phone, 'AccountCode': accountcode, 'Address': address, 'City': city },
        success: (resdiachi) => {
            // Tạo đơn hàng
            $.ajax({
                url: '/api/Order/create',
                type: 'POST',
                data: { 'PaymentCode': payment, 'AccountCode': accountcode, 'AccountAddressCode': resdiachi.AccountAddressCode,'OrderTotal': ordertotal },
                success: (resdonhang) => {
                    // Lấy giỏ hàng và xử lý chi tiết đơn hàng
                    processOrderDetails(resdonhang.OrderCode, accountcode);
                },
                error: (er) => {
                    console.log(er);
                    alert("Đã xảy ra lỗi ở order. Vui lòng thử lại sau.");
                }
            });
        },
        error: (er) => {
            console.log(er);
            alert("Đã xảy ra lỗi ở accountaddress. Vui lòng thử lại sau.");
        }
    });
}
// Hàm xử lý chi tiết đơn hàng
function processOrderDetails(orderCode, accountcode) {
    //var totalorder = 30000;
    $.ajax({
        url: '/api/cart',
        type: 'GET',
        data: { 'AccountCode': accountcode },
        success: (res) => {
            for (var i = 0; i < res.length; i++) {
                const cart = res[i];
                var total = cart.Price * cart.Quantity;
                $.ajax({
                    url: '/api/orderdetail',
                    type: 'POST',
                    data: { 'OrderCode': orderCode, 'ProductCode': cart.ProductCode, 'Price': cart.Price, 'Quantity': cart.Quantity, 'Total': total },
                    success: () => {},
                    error: (er) => {
                        console.log(er);
                        alert("Đã xảy ra lỗi ở orderdetail. Vui lòng thử lại sau.");
                    }
                });
                $.ajax({
                    url: '/Api/Cart',
                    type: 'DELETE',
                    data: { 'AccountCode': cart.AccountCode, 'ProductCode': cart.ProductCode },
                    success: function () {},
                    error: function (err) {
                        console.log(err);
                        alert("Đã xảy ra lỗi ở xóa cart. Vui lòng thử lại sau.");
                    }
                });
                //totalorder = totalorder + total;
            }

            // Sau khi xử lý các chi tiết đơn hàng, cập nhật tổng đơn hàng
            //updateOrderTotal(orderCode, totalorder);
            $('#shopingcartcount').text('0');
            loadcart();
            //alert("Đơn hàng đang được giao đến bạn!");
            //window.location.href = `/Home/Index/?code=${accountcode}`;
            window.location.href = `/Home/Complete`;

        },
        error: (er) => {
            console.log(er);
            alert("Đã xảy ra lỗi ở cart. Vui lòng thử lại sau.");
        }
    });
}

// Hàm cập nhật tổng đơn hàng
//function updateOrderTotal(orderCode, totalorder) {
//    $.ajax({
//        url: '/Api/Order',
//        type: 'PUT',
//        data: { 'OrderCode': orderCode, 'OrderTotal': totalorder },
//        success: function () {
//            $('#shopingcartcount').text('0');
//            loadcart();
//            alert("Đơn hàng đang được giao đến bạn!");
//            //window.location.href = `/Home/Index/?code=${accountcode}`;
//            window.location.href = `/Home/Complete`;
//        },
//        error: function (err) {
//            console.log(err);
//            alert("Đã xảy ra lỗi ở cật nhật order. Vui lòng thử lại sau.");
//        }
//    });
//}
//$(document).ready(function () {
//    createOrder(phone, accountcode, address, city, payment);
//});
