# PrivatBank Money Sender

Это простой скрипт на Ruby для отправки платежей в ПриватБанке через их Мерчант API.

## Установка

```
bundle update --bundler
```

## Настройка

Откройте файл `send_money.rb` и измените эти строки своими данными мерчанта:

```
MERCHANT_ID = 'XXXXX'
MERCHANT_PASSWORD = 'YYYYYYYYYYYYYYYYYYYYYYYY'
```

## Использование

```
ruby send_money.rb --payment_id 12345 --card XXXXCCCCVVVVBBBB --amount 1.01 --details "It is a test payment"
```

Программа логирует все действия, их можно посмотреть в файле `send_payment.log`
