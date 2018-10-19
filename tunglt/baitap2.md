Bài tập số 2
**************************************

Tạo 1  contract  Animals
	+ Lưu trữ thông tin  : Animals
		+ dna unit
		+ name string
		+ sex bool
		+ age uint 
		+ weight
		+ bornTime ( Thoi gian sinh ra )
		+ status: bool (trạng thái sleep default = false )
		+ coolDownTime : time
	+   lưu trữ thông tin animal vào contract

+ Tao 1 contract Zoo kế thừa Animals


	+  Tạo chức năng tạo mới  1 animals mới với 2 params là name(Dog, Cat, Fish ....), sex(true = female, false = male), Mỗi address chỉ được tạo 1 animals
		+ dna = với DNA random từ params name
		+ weigh default = 0, age = 0, bornTime = now;
		+ Tạo event khi tạo 1 zoombie thành công
	
	+ Tạo 3 abs function, Eat,Run,Sleep,Slain;
	+  Đếm số lượng animals của 1 address
	+  Xác định animals này của address nào 
	

+ Tạo 1 contract AnimalsGrown kế thừa Zoo
	
	- Implement 3 function Eat Run , Sleep;
	
	+ Tạo 1 function có chức năng ăn một animals khác . Ăn được khi trạng thái sleep là false và age phải lớn hơn. Nếu age bằng nhau thì xem con nào nặng hơn.
		+ Eat thi status = true
		+ Eat thành công thì age của chính nó tăng lên 2, weigth tăng lên 2 ,và cooldowntime 1 ngày ( 1 ngày sau mới được ăn tiếp )
	+ Function Luyện Tập , Luyện Tập thì age tăng lên 1, weight tăng lên 1 , status = true, cooldowntime sẽ là 1hours( 1 giờ sau mới được tập tiếp )

	+ function Sleep()
		+ Chuyển sang trạng thái ngủ ( Trạng thái ngủ sẽ không bị tấn công )
	+ function Slain()
		+ Chuyển sang trạng thái do sat ( Trạng thái ngủ có thể sẽ  bị tấn công )


***Note ( Tất cả các function đều phải kiểm tra xem animals đó thuộc quyền sở hữu của address nào mới được action )
