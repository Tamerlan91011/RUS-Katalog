# [![Typing SVG](https://readme-typing-svg.herokuapp.com?size=40&color=%2336BCF7&lines=RUS-Katalog)](https://git.io/typing-svg)
# Веб-сервис по отслеживанию товаров электронной и бытовой техники в магазинах-партнерах с возможностью оформления доставки на дом
Аналог [ECatalog](https://vk.com/ekatalog.official), 
Повторитель [Яндекс Маркета](https://market.yandex.ru), 
Магазин Электроники с возможностями [Сбермаркета](https://sbermarket.ru)
> Команда: Глазунов Тимур, Мантуленко Андрей, Костина Юлия
## Основные функции 

**Пользователя:**

- Искать товар (применяя фильтры); 
- сравнивать с другими товарами;
- добавление в избранное;
- уведомить о наличии в выбранном магазине;
- оставлять отзывы (оценки);
- отображение динамики цен.

**Админа:**

- Аккредитация магазина;
- изменение статуса магазина (активен/закрыт);
- редактирование товаров, магазинов, статуса пользователей, отзывов.


**Курьера:**

- Получение заказа - открытие сделки;
- Передача заказа - закрытие сделки.

## Основные сущности:
- товар;
- пользователь; 
- админ;
- курьер;
- магазин-партнер.

## Базы данных

- База данных 1 (SQL): Все, что касается товаров (их характеристики, наименования, цена, и так далее);

- База данных 2 (SQL): Все, что касается клиентов, заказов, магазинов-партнеров;

- База данных 3 (NOSQL): История заказов на веб-сервисе.
