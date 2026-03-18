# Let's Play – Social Party Game (Flutter Project)

**Môn học**: Lập trình cho thiết bị di động  
**Lớp**: 2025_2_LTTBDD_N03_Nhom_7  
**Giảng viên hướng dẫn**: ThS. Nguyễn Xuân Quế  

### Nhóm 7 - Thành viên thực hiện
| STT | Họ và tên | Mã sinh viên | Vai trò |
|---|---|---|---|
| 1 | **Nguyễn Thái Sơn** | 23010196 | Trưởng nhóm / Lead Developer |
| 2 | **Lê Phạm Thành Đạt** | 23010541 | Fullstack Developer / UI Designer |

---

### 🎮 Giới thiệu dự án
**Let's Play** là một ứng dụng **Social Party Game** vui nhộn, được lấy cảm hứng từ nền tảng WePlay. Ứng dụng tập trung vào việc tạo ra một không gian giải trí kết nối bạn bè thông qua các trò chơi mini đa dạng, đặc biệt là các trò chơi mang đậm nét văn hóa Tết Việt Nam.

**Công nghệ chính**: Flutter + Dart (Tối ưu hóa UI/UX & Animations).

---

### ✨ Chức năng chính
- **Hệ thống Game đa dạng**: Tích hợp các trò chơi từ truyền thống đến hiện đại.
- **Tương tác xã hội**: Hệ thống Chat cá nhân/nhóm và danh sách người dùng trực tuyến.
- **Vòng quay may mắn**: Nhận thưởng xu và phần quà hàng ngày với hiệu ứng sinh động.
- **Hồ sơ cá nhân**: Quản lý thông tin, điểm số và đội ngũ phát triển.
- **Đa ngôn ngữ**: Hỗ trợ Tiếng Việt, Tiếng Anh và Tiếng Trung.

---

### 🕹️ Danh sách trò chơi (Minigames)

| Game | Mô tả chi tiết | Trạng thái |
|:---|:---|:---:|
| **Bầu Cua** | Trò chơi may mắn truyền thống với 6 linh vật mang không khí Tết. | Hoàn thiện |
| **Xóc Đĩa** | Game dân gian với bộ bát đĩa và 4 đồng xu mô phỏng chân thực. | Hoàn thiện |
| **2048** | Thử thách ghép các ô số trí tuệ để đạt mốc 2048. | Hoàn thiện |
| **Memory Flip** | Trò chơi lật thẻ bài giúp luyện trí nhớ siêu phàm. | Hoàn thiện |
| **Quick Draw** | "Bạn vẽ tôi đoán" - Thử thách tài năng hội họa mock. | Hoàn thiện |
| **Riddle Master** | Giải đố hại não để trở thành bậc thầy thông thái. | Hoàn thiện |
| **Quay May Mắn** | Vòng quay với hiệu ứng vật lý, dùng xu để nhận quà tặng. | Hoàn thiện |

---

### 🎨 Đặc điểm thiết kế (Design Features)
- **Màu sắc**: Sử dụng Gradient (Tím-Hồng-Cam) rực rỡ, trẻ trung.
- **Hiệu ứng**: Tích hợp Confetti, các animation lắc xúc xắc, lật thẻ mượt mà (60fps).
- **Trải nghiệm**: Giao diện bo góc (Rounded corners), hỗ trợ cả hai nền tảng iOS & Android.

---

### 📂 Cấu trúc thư mục (Structure)
```text
lib/
├── core/          # Tiện ích, hằng số dùng chung
├── routes/        # Quản lý điều hướng (Routing)
├── screens/       # Các màn hình chính (Home, Chat, Game, Profile,...)
├── theme/         # Định nghĩa màu sắc, font chữ
└── widgets/       # Các thành phần giao diện tái sử dụng
```

---

### 🚀 Hướng dẫn chạy dự án
1. **Yêu cầu**: Đã cài đặt Flutter SDK (phiên bản > 3.10.4).
2. **Clone repo**: `git clone https://github.com/liliustwocout/2025_2_LTTBDD_N03_Nhom_7.git`
3. **Cài đặt thư viện**: `flutter pub get`
4. **Chạy ứng dụng**: `flutter run`

---
*Dự án được thực hiện bởi Nhóm 7 - Lớp Lập trình cho thiết bị di động N03.*
