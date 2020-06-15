# PrivatBank Money Sender

Это простой скрипт на Ruby для отправки платежей в ПриватБанке через их Мерчант API.

### ⚠️ ВНИМАНИЕ для PHP-разработчиков

> Существует библиотека https://github.com/sergeynezbritskiy/privatbank-api для отправки средств и она находится в топе поиска, если вам нужно отправлять средства через Мерчант API.

> Наши продолжительные попытки понять почему при отправке возникает ошибка `error: b_card_or_acc keyring fail` не привели к успеху (даже с запросом к самому ПриватБанку, они отправили нас в `/dev/null`). После изучения кода Ruby-библиотеки, которую использует скрипт в этом проекте мы пришли к выводу, что не нужно передавать в запросе параметры `b_crf`, `b_name`, `b_bic`. 

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

Программа логирует все действия, их можно посмотреть в файле `send_money.log`
