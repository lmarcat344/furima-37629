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
| birthday           | date    | null: false               |


### Association

- has_many :items
- has_many :orders

## Items Table


| column            | Type       | Option                         |
|-------------------|------------|--------------------------------|
| name              | string     | null: false                    |
| content           | text       | null: false                    |
| category_id       | integer    | null: false                    |
| condition_id      | integer    | null: false                    |
| charge_id         | integer    | null: false                    |
| prefecture_id     | integer    | null: false                    |
| day_deliver_id    | integer    | null: false                    |
| price             | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |

*imageはActiveStorageで実装するため含まない

### Association

- belongs_to :user
- has_one :order


## Orders Table

| column         | Type       | Option                         |
|----------------|------------|--------------------------------|
| post_code      | string     | null: false                    |
| prefecture_id  | integer    | null: false                    | 
| city           | string     | null: false                    |
| address1       | string     | null: false                    |
| address2       | string     | null: false                    |
| phone          | string     | null: false                    |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item