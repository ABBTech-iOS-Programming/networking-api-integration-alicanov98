# 🛍️ Product Shop — Networking & API Integration

## 📱 Task

Figma dizaynına uyğun **Product List** və **Product Detail** ekranlarını SwiftUI ilə hazırlayın. Category siyahısı və məhsullar real API-dən alınmalıdır.

🎨 **Figma:** https://www.figma.com/design/tHfB8dgqiRr0B94DrgWqz4

## 🌐 API

```text
GET https://dummyjson.com/products/category-list
GET https://dummyjson.com/products/category/{categoryName}
```

📖 **Documentation:** https://dummyjson.com/docs/products

## ✅ Requirements

- Category siyahısını API-dən alın.
- Category seçildikdə həmin kateqoriyaya aid məhsulları API-dən gətirin.
- Search seçilmiş kateqoriya üzrə yüklənmiş məhsullar üzərində lokal işləməlidir.
- Loading, empty və error vəziyyətlərini göstərin. Error vəziyyətində retry imkanı olmalıdır.
- Məhsulları iki sütunlu grid-də göstərin.
- Hər məhsul kartında şəkil, ad, brand/category, rating və qiymət göstərilməlidir.
- Məhsul şəkillərini internetdən yükləyin və uyğun placeholder göstərin.
- Məhsula toxunduqda Product Detail ekranı açılmalı və seçilmiş məhsul həmin ekrana ötürülməlidir.
- Detail ekranında məhsul məlumatları, favorite funksiyası və minimum dəyəri `1` olan quantity seçimi olmalıdır.
- Networking və ekran state-i `@Observable` ViewModel-də idarə olunmalıdır.
- Təkrarlanan UI hissələrini reusable View-lara ayırın.

## 🚀 Submission

- Yeni branch yaradın.
- Mənalı commit-lər edin.
- İş tamamlandıqda yeni Pull Request açın.

## ⭐ Bonus

- `.refreshable` ilə məlumatları yeniləmək
- Məhsulun endirimli qiymətini hesablamaq
- Favorite məhsulları ayrıca tab-da göstərmək
