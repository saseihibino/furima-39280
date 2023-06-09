# テーブル設計

## users テーブル

| Column             | Type   | option                                      |
| ------------------ | ------ | ------------------------------------------- |
| nick_name          | string | null: false                                 |
| email              | string | null: false, unique: true                   |
| encrypted_password | string | null: false                                 |
| first_name         | string | null: false                                 |
| last_name          | string | null: false                                 |
| first_name_kana    | string | null: false                                 |
| last_name_kana     | string | null: false                                 |
| birth_date         | date   | null: false                                 |

### Association

has_many :items
has_many :orders

## items テーブル

| Column              | Type       | option                         |
| ------------------- | ---------- | ------------------------------ |
| item_name           | string     | null: false                    |
| description         | text       | null: false                    |
| category_id         | integer    | null: false                    |
| condition_id        | integer    | null: false                    |
| delivery_charge_id  | integer    | null: false                    |
| prefecture_id       | integer    | null: false                    |
| day_to_send_id      | integer    | null: false                    |
| price               | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association

has_one :order
belongs_to :user

## orders テーブル
| Column    | Type       | option                         |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

has_one :address
belongs_to :user
belongs_to :item

## addresses テーブル
| Column           | Type       | option                         |
| ---------------- | ---------- | ------------------------------ |
| post_code        | string     | null: false                    |
| prefecture_id    | integer    | null: false                    |
| city             | string     | null: false                    | 
| house_number     | string     | null: false                    |
| building_name    | string     |                                |
| telephone_number | string     | null: false                    |
| order            | references | null: false, foreign_key: true |

### Association

belongs_to :order