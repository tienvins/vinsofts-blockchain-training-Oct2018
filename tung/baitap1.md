- Xây dựng contract cho 1 ngân hàng (Bank) 
	+ Tên ngân hàng
	+ Tổng số tiền của ngân hàng 
	+ owner của ngân hàng
	+ Lưu trữ thông tin của ngân hàng vào contract 
- Tạo contructor Bank , 
	+ khởi tạo gồm 3 tham số trên, mặc định số tiền của ngân hàng = 1000
	+ tao 1 function đổi tên ngân hàng , trong đó chỉ chủ sở hữu ngân hàng mới có thể thay đổi
	+ Lấy ra thông tin của ngân hàng, ai cũng có thể xem thông tin 
	
	
- Tạo 1 interface gồm các function
	+ Gửi Tiền
	+ Rút Tiền

- Tạo contract Bank2 thừa kế Bank1, interface phía trên
	+ tao một chức năng đăng ký tài khoản cho người dùng	
		+ Gồm :  +tên
			 +id
			 +số dư (default = 0)
	+ lưu thông tin người dùng vào contract 
	
	+ Tạo 1 chức năng lấy ra thông tin tài khoản, chỉ lấy ra thông tin tài khoản của chính nó
	
	+ implement chức năng gửi tiền cho 1 tài khoản khác,  ( tạo event khi gửi thành công)
	+ implement rút tiền Tổng số tiền của ngân hàng sẽ bị trừ theo (tạo event khi rút tiền thành công )
	+ lấy ra danh sách khách hàng, chỉ owner mới được lấy ra
	 
	+ Lưu lịch sử giao dịch vào con tract gồm các thông tin 	+ from  
								+ to, 
								+ value
								+ time
