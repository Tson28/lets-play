# Let's Play – Mini Clone UI của WePlay (Flutter Project)

**Môn học**: Lập trình cho thiết bị di động  
**Giảng viên hướng dẫn**: ThS. Nguyễn Xuân Quế  

### Nhóm thực hiện
| STT | Họ và tên | Mã sinh viên | Vai trò |
|---|---|---|---|
| 1 | **Nguyễn Thái Sơn** | 23010196 | Lên ý tưởng, Thiết kế UI|
| 2 | **Lê Phạm Thành Đạt** | 23010541 | Hiện thực hóa ý tưởng, Code Flutter |

**Công nghệ**: Flutter + Dart (Tập trung **UI/UX**)  
**Mục tiêu**: Xây dựng giao diện người dùng giống phong cách WePlay (app party game + voice chat + minigame phổ biến ở Việt Nam), nhấn mạnh **minigame Tết** và hệ thống vui nhộn (quay may mắn, tặng quà, chat).


### Mô tả tổng quan
App là một **social party game** vui nhộn, lấy cảm hứng từ WePlay: giao diện màu sắc rực rỡ, cartoon, gradient tím-hồng-vàng, chủ đề Tết Việt Nam (đỏ-vàng, bao lì xì, pháo hoa).  
Người dùng có thể đăng nhập, chơi minigame casual, chat, tặng quà kết bạn, quay may mắn tích điểm, khám phá phòng chơi.

**Quan trọng**: Dự án **chỉ làm UI + mock logic** (dùng Provider/Riverpod + SharedPreferences để lưu điểm, user mock, ngôn ngữ). Không kết nối API thật, không voice thật, không multiplayer thật.

### Màu sắc chủ đạo (Color Palette)
- Primary gradient: Tím → Hồng → Vàng (#6B48FF → #FF5E7C → #FFD166)
- Accent: Xanh ngọc (#06D6A0), Xanh dương (#118AB2)
- Tết: Đỏ (#FF2E63), Vàng gold (#FFC107), Bao lì xì đỏ
- Nền: Dark mode nhẹ hoặc gradient sáng/tối tùy tab
- Font chính: Poppins (Google Fonts) hoặc Nunito – vui tươi, rounded

### Cấu trúc Bottom Navigation Bar (4 tab cố định)
1. **Game** (icon: gamepad hoặc dice) – Màn dọc scroll chính
2. **Discover** (icon: compass hoặc star) – Khám phá
3. **Chat** (icon: chat bubble hoặc message) – Tin nhắn + voice room mock
4. **Me** (icon: person hoặc avatar) – Hồ sơ cá nhân

### Chức năng chính (UI + mock)
- **Auth**: Splash → Onboarding (3-4 slide) → Login/Register (mock Google/FB)
- **Đổi ngôn ngữ**: Việt – Anh – Trung (dùng easy_localization hoặc flutter_localizations)
- **Tích điểm login hàng ngày** + **Quay may mắn** (đổi điểm lấy lượt quay, animation vòng quay + confetti)
- **Tặng quà** để kết bạn (bottom sheet chọn quà → animation bay quà)
- **Chat**: List chat + màn chat cá nhân (bubbles, emoji, gift button) + voice room mock (waveform animation)

### Tab Game – Nội dung chi tiết (màn dọc +++ scroll)
Header: Avatar + Tên + Điểm + Nút "Quay may mắn" lớn

Các game hiển thị dạng **GridView** hoặc **horizontal list cards**:

| Game              | Mô tả UI ngắn gọn                                      | Mock tương tác mong muốn                     |
|-------------------|--------------------------------------------------------|----------------------------------------------|
| Lật thẻ           | Grid 4x4 thẻ cute (động vật, hoa mai Tết)              | Tap lật thẻ, match thì highlight             |
| Đuổi hình bắt chữ | Ảnh lớn + 4-6 lựa chọn chữ cái                         | Chọn → animation đúng/sai + confetti         |
| Bạn vẽ tôi đoán   | Preview canvas vẽ + chat bên cạnh                      | Vẽ mock (CustomPaint), gửi đoán text         |
| 2048              | Grid 4x4 số classic                                    | Swipe di chuyển số (state đơn giản)          |
| **Game Tết**      | Section banner đỏ-vàng lớn                             |                                              |
| Chẵn Lẻ           | Nút Chẵn / Lẻ to + animation xúc xắc                   | Random số + hiện kết quả                     |
| Xóc Đĩa           | 3 đĩa + nút "Xóc" → lật animation                      | Hiện mặt ngửa/sấp                            |
| Bầu Cua Cá        | 6 ô (Bầu Cua Cá Gà...) + 3 xúc xắc                     | Đặt cược mock + lắc animation                |
| Đá Gà             | 2 con gà + progress bar máu + nút "Đá"                 | Animation đánh + random thắng thua           |

Mỗi game click → vào màn chơi full-screen (demo, không cần logic thắng thật phức tạp).

### Các màn hình quan trọng khác
- **Quay may mắn**: Vòng quay lớn (dùng flutter_fortune_wheel hoặc Custom), phần thưởng mock (điểm, quà, lượt chơi)
- **Tặng quà**: Bottom sheet danh sách quà (hoa, xe, bao lì xì Tết) → animation bay tới avatar người nhận
- **Discover**: Banner sự kiện Tết, list phòng chơi hot (card + số người + "Tham gia"), bạn bè gợi ý
  - Mới: khi kích "Tham gia sự kiện" chuyển trang sang **Room mẫu**.
  - Room mẫu gồm nền gradient tím/hồng pastel, hiệu ứng shimmer/lấp lánh cho tiêu đề, animation danh sách người chơi, nút xác nhận tham gia + quay lại.
- **Profile (Me)**: Avatar to + level badge, điểm số, nút quay may mắn, túi quà, ngôn ngữ switcher, settings

### Gợi ý package Flutter (dễ implement)
- State: provider / riverpod
- Navigation: go_router
- Animation: flutter_animate, lottie, confetti
- Wheel quay: fortune_wheel hoặc custom
- Drawing: flutter_drawing_board (nếu làm Bạn vẽ tôi đoán)
- Localization: easy_localization
- Storage: shared_preferences (lưu điểm, user mock, ngôn ngữ)
- Responsive: flutter_screenutil hoặc MediaQuery
- Icons: flutter_svg + icons8 / flaticon (cartoon style)

### Yêu cầu chất lượng UI/UX
- Joyful, youthful, addictive feel như WePlay
- Nhiều animation mượt (confetti, gift bay, lật thẻ, lắc xúc xắc)
- Rounded corners, glassmorphism nhẹ hoặc neumorphism
- Responsive trên iOS & Android (test iPhone 14 + Pixel)
- Hỗ trợ dark/light mode (tùy chọn)
