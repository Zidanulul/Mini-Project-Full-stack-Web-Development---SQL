# Digital Product Marketplace - SQL Database

Project ini merupakan implementasi database sederhana untuk **Digital Product Marketplace** menggunakan MySQL.

Database dirancang untuk mengelola data pengguna, produk, kategori produk, serta transaksi pembelian.

## 📌 Fitur Database

Database ini memiliki beberapa fitur utama:

* Mengelola data pengguna (`users`)
* Mengelola kategori produk (`product_category`)
* Mengelola data produk (`product`)
* Mengelola transaksi pembelian (`transactions`)
* Menampilkan data menggunakan `SELECT`
* Filtering menggunakan `WHERE`
* Pengurutan menggunakan `ORDER BY`
* Pencarian menggunakan `LIKE`
* Menggunakan `INNER JOIN` dan `LEFT JOIN`
* Menggunakan fungsi agregasi `COUNT`, `SUM`, dan `AVG`
* Menggunakan `GROUP BY` dan `HAVING`
* Menggunakan `CASE WHEN`
* Optimasi query menggunakan `INDEX`
* Analisis query menggunakan `EXPLAIN`

---

# 🗄️ Database Structure

Database menggunakan 4 tabel utama:

```text
users
   │
   │ 1 : M
   ▼
transactions
   ▲
   │ M : 1
   │
product
   ▲
   │ M : 1
   │
product_category
```

Selain itu terdapat relasi:

```text
users 1 ───── M product
```

Artinya satu seller dapat memiliki banyak produk.

## ERD

```text
┌──────────────────┐
│      USERS       │
├──────────────────┤
│ PK user_id       │
│ name             │
│ email            │
│ password         │
│ role             │
└───────┬──────────┘
        │
        │ 1 : M
        │
        ├──────────────────────┐
        │                      │
        ▼                      ▼
┌──────────────────┐   ┌──────────────────┐
│     PRODUCT      │   │   TRANSACTIONS   │
├──────────────────┤   ├──────────────────┤
│ PK product_id    │   │ PK transaction_id│
│ product_name     │   │ FK user_id       │
│ description      │   │ FK product_id    │
│ price            │   │ transaction_date │
│ stock            │   │ quantity         │
│ FK user_id       │   │ total_price      │
│ FK category_id   │   │ status           │
└────────┬─────────┘   └──────────────────┘
         │
         │ M : 1
         ▼
┌────────────────────┐
│ PRODUCT_CATEGORY   │
├────────────────────┤
│ PK category_id     │
│ category_name      │
│ description        │
└────────────────────┘
```

### Relasi

| Tabel              | Relasi | Tabel          | Keterangan                                     |
| ------------------ | ------ | -------------- | ---------------------------------------------- |
| `users`            | 1 : M  | `product`      | Satu seller dapat memiliki banyak produk       |
| `product_category` | 1 : M  | `product`      | Satu kategori dapat memiliki banyak produk     |
| `users`            | 1 : M  | `transactions` | Satu user dapat melakukan banyak transaksi     |
| `product`          | 1 : M  | `transactions` | Satu produk dapat muncul pada banyak transaksi |

Secara konseptual, `users` dan `product` memiliki hubungan **Many-to-Many (M:N)** melalui tabel `transactions`.

---

# 📋 Table Details

## 1. `users`

Menyimpan informasi pengguna marketplace.

| Column     | Type         | Key    | Description           |
| ---------- | ------------ | ------ | --------------------- |
| `user_id`  | INT          | PK     | ID pengguna           |
| `name`     | VARCHAR(100) | -      | Nama pengguna         |
| `email`    | VARCHAR(100) | UNIQUE | Email pengguna        |
| `password` | VARCHAR(255) | -      | Password              |
| `role`     | ENUM         | -      | `buyer` atau `seller` |

---

## 2. `product_category`

Menyimpan kategori produk.

| Column          | Type         | Key    | Description        |
| --------------- | ------------ | ------ | ------------------ |
| `category_id`   | INT          | PK     | ID kategori        |
| `category_name` | VARCHAR(100) | UNIQUE | Nama kategori      |
| `description`   | TEXT         | -      | Deskripsi kategori |

---

## 3. `product`

Menyimpan informasi produk yang dijual.

| Column         | Type          | Key | Description      |
| -------------- | ------------- | --- | ---------------- |
| `product_id`   | INT           | PK  | ID produk        |
| `product_name` | VARCHAR(100)  | -   | Nama produk      |
| `description`  | TEXT          | -   | Deskripsi produk |
| `price`        | DECIMAL(12,2) | -   | Harga produk     |
| `stock`        | INT           | -   | Jumlah stok      |
| `user_id`      | INT           | FK  | Seller produk    |
| `category_id`  | INT           | FK  | Kategori produk  |

---

## 4. `transactions`

Menyimpan data transaksi pembelian.

| Column             | Type          | Key | Description                   |
| ------------------ | ------------- | --- | ----------------------------- |
| `transaction_id`   | INT           | PK  | ID transaksi                  |
| `user_id`          | INT           | FK  | User yang melakukan pembelian |
| `product_id`       | INT           | FK  | Produk yang dibeli            |
| `transaction_date` | DATETIME      | -   | Tanggal transaksi             |
| `quantity`         | INT           | -   | Jumlah produk                 |
| `total_price`      | DECIMAL(12,2) | -   | Total harga                   |
| `status`           | ENUM          | -   | Status transaksi              |

Status transaksi:

```text
pending
paid
cancelled
```

---

# ⚙️ DDL

Membuat database:

```sql
CREATE DATABASE marketplace_db;
USE marketplace_db;
```

Membuat tabel:

```sql
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('buyer', 'seller') NOT NULL
);

CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(12,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    user_id INT NOT NULL,
    category_id INT NOT NULL,

    CONSTRAINT fk_product_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES product_category(category_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    transaction_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    quantity INT NOT NULL,
    total_price DECIMAL(12,2) NOT NULL,
    status ENUM('pending', 'paid', 'cancelled') NOT NULL DEFAULT 'pending',

    CONSTRAINT fk_transaction_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_transaction_product
        FOREIGN KEY (product_id)
        REFERENCES product(product_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_transaction_quantity
        CHECK (quantity > 0),

    CONSTRAINT chk_transaction_total
        CHECK (total_price >= 0)
);
```

---

# 📥 DML

Data awal terdiri dari:

* 10 users
* 10 product categories
* 15 products
* 15 transactions

Contoh insert data:

```sql
INSERT INTO users
(name, email, password, role)
VALUES
('Zidan Ulul', 'zidan@mail.com', '123456', 'seller'),
('Andi Pratama', 'andi@mail.com', '123456', 'seller'),
('Budi Santoso', 'budi@mail.com', '123456', 'seller'),
('Citra Ayu', 'citra@mail.com', '123456', 'buyer');
```

Contoh kategori:

```sql
INSERT INTO product_category
(category_name, description)
VALUES
('Elektronik', 'Produk elektronik'),
('Fashion', 'Produk fashion'),
('Makanan', 'Produk makanan'),
('Minuman', 'Produk minuman');
```

Contoh transaksi:

```sql
INSERT INTO transactions
(user_id, product_id, transaction_date, quantity, total_price, status)
VALUES
(4, 1, '2026-09-01 09:15:00', 1, 7500000, 'paid'),
(6, 3, '2026-09-01 10:20:00', 2, 700000, 'paid'),
(8, 4, '2026-09-02 11:30:00', 3, 255000, 'paid');
```



# 🧠 Kesimpulan

Database **Digital Product Marketplace** ini menggunakan 4 tabel utama:

```text
USERS
PRODUCT_CATEGORY
PRODUCT
TRANSACTIONS
```

Database menerapkan:

* Primary Key
* Foreign Key
* Relasi 1:M
* Relasi M:N melalui `transactions`
* DDL
* DML
* SELECT
* WHERE
* LIKE
* ORDER BY
* LIMIT
* INNER JOIN
* LEFT JOIN
* COUNT
* SUM
* AVG
* GROUP BY
* HAVING
* CASE WHEN
* INDEX
* EXPLAIN

Project ini dibuat sebagai implementasi konsep dasar **SQL dan Relational Database** untuk studi kasus Digital Product Marketplace.
