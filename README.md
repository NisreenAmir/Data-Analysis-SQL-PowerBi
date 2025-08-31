# Data-Analysis
Zara Sales Analysis by SQL And Power Bi
## About Dataset
This Zara sales dataset is a comprehensive resource for e-commerce analytics and retail performance analysis. It captures critical sales data over a defined period, offering granular insights into product sales trends within Zara stores.

The dataset features key attributes such as product ID, product name, product category, price, sales volume, sales date, and store location. This rich information enables in-depth sales forecasting, category performance analysis, and evaluation of promotional effectiveness.
## Objective
By leveraging this dataset, data Analyst can uncover customer purchasing patterns and identify factors influencing Zara's revenue streams. The insights derived are invaluable for Zara management in optimizing marketing strategies, refining inventory management, and making data-driven decisions to enhance overall profitability. This makes the dataset an excellent foundation for Industy models aimed at improving retail operations and driving business growth.
## Case Study 
### SQL — Data Prep & Analysis

1. أستكشاف البيانات: راجعت الـ schema وأنواع البيانات.
2. التعامل مع التكرارات: بحثت عن البيانات المكررة و Removed Duplicated.
3. Missing Values: حدّدت ال NULLs واستبدلتها بقيم مناسبة (Default/Business Rules).
4. التوحيد والتهيئة: حوّلت النصوص لـ lower وحذفت المسافات الزائدة بـ LOWER() وTRIM().
5. التحويلات: استخرجت السنة/الشهر/اليوم من التاريخ و حسبت الإيراد لكل منتج = sales_volume * price.
6. إحصاءات وصفية: MAX/MIN/AVG/STDDEV — الـ STDDEV كان كبير، فلترت الـ Outliers واتضح إن السبب 3 منتجات أغلى بكثير من باقي المنتجات.
7. الإجابة على أسئلة البيزنس:
* قسم Men يحقق ~91% من الإيرادات. السبب: قسم Women يحتوي منتج sweaters فقط.
* Seasonal vs Non‑seasonal: متقاربين جدًا في نسبة الإيرادات.
* Promotion vs No‑promotion: الفارق محدود والإيرادات متقاربة.
* المنتجات القريبة من aisle تحقق إيرادات أعلى.

* Jackets الأعلى إيرادًا، والأقل Jeans.
* عرضت Top 10 Products حسب الإيراد، وكررت التحليل على Sales Volume.

### Power BI — Visualization
1. صممت Dashboard تترجم كل أسئلة البيزنس إلى Visuals واضحة.
2. أضفت Filters على Section وTerms لسهولة الاستكشاف.
3. أبرز النتائج (Takeaways)

قوة مبيعات Men تشير لفرصة توسيع تشكيلة Women.
الموسمية والعروض الترويجية تأثيرهم محدود على الإيرادات الإجمالية.
موضع المنتج (Aisle) يؤثر بقوة على المبيعات.
منتجات Jackets تقود الإيرادات، وJeans تحتاج مراجعة تسعير/تشكيلة.
# 📊 Tooling: 
SQL (Cleaning, Transformations, Stats) + Power BI (Interactive Dashboards)
