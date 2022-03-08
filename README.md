# テーブル設計

## Users Table

| column             | Type    | Option                    |
|--------------------|---------|---------------------------|
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name_zenkaku  | string  | null: false               |
| first_name_zenkaku | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| year_id            | integer | null: false               |
| month_id           | integer | null: false               |
| day_id             | integer | null: false               |

### Association

- has_many :items
- has_many :orders

## Items Table


| column            | Type       | Option                         |
|-------------------|------------|--------------------------------|
| name              | string     | null: false                    |
| text              | text       | null: false                    |
| category_id       | integer    | null: false                    |
| condition_id      | integer    | null: false                    |
| charge_id         | integer    | null: false                    |
| source_deliver_id | integer    | null: false                    |
| day_deliver_id    | integer    | null: false                    |
| price             | integer    | null: false                    |
| user_id           | references | null: false, foreign_key: true |

*imageはActiveStorageで実装するため含まない

### Association

- belongs_to :user
- has_one :order


## Orders Table

| column         | Type       | Option                         |
|----------------|------------|--------------------------------|
| post_code      | integer    | null: false                    |
| prefecture_id  | integer    | null: false                    | 
| city           | string     | null: false                    |
| address1       | string     | null: false                    |
| address2       | string     | null: false                    |
| phone          | integer    | null: false                    |
| user_id        | references | null: false, foreign_key: true |
| item_id        | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item