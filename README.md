# Crowdfunding DApps using Ethereum and Flutter

### User Interface Rules
Setiap data yang diambil dari local/API memiliki beberapa state/kondisi tampilan, yaitu:
- Loading -> Tampilan ketika loading
- Loaded -> Tampilan ketika data berhasil didapatkan, dan ingin ditampilkan
- Empty (Opsional) -> Tampilan ketika data berhadil didapatkan tetapi tidak ada isi (null/empty)
- Error -> Tampilan ketika data gagal dimuat

Jika pada halaman yang sama terdapat beberapa request data dari api/local yang dipisahkan pada setiap widget, maka:
- Setiap widget terdapat tampilan untuk setiap state
- Jarak antar widget di atur pada widget yang bersangkutan dengan menambahkan jarak bottom/bawah

### Custom Widget
Beberapa custom widget menyesuaikan proyek yang bisa digunakan, yaitu:
- HorizontalCampaignCard
- VerticalCampaignCard

### Default Custom Widget
Beberapa custom widget default bawaan architecture yang bisa digunakan:
- ShowImageFile
- ShowImageLocalLogo
- ShowImageLocal
- ShowImageNetwork
- ConnectionScreen
- CustomBoxShadow
- CustomDialog
- CustomTextField
- WidgetWithDefaultHorizontalPadding