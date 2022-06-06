# Работа с сервером на Django (V4.0+)

> С файлом настройки проекта можно ознакомиться [здесь](rus_katalog/rus_katalog/settings.py)

* **Проект** - это большая программа, как правило веб-сервис, способный выполнять множество задач в рамках одной определенной тематики. Может включать в себя несколько **приложений**.
* **Приложение** - это модуль внутри **проекта**, направленый на выполнение некой *одной* задачи.


В данном проекте не предусмотрена работа с единственной стандартнной базой данных (она же default). На данный момент вместно неё предустановлено 4 базы данных: 

- **SQLite3.** Служебная база данных для управления *всем* проектом и миграциями внутри Django (**db_auth**)
- **PostgreSQL.** База данных для отображения основной информации на сайте и (или) вебсервисе (**db_web**)
- **SQL Server.** База данных для условного оформления заказов (**db_delivery**)
  
- **MongoDB.** База данных для хранения истории цен и медиафайлов (**db_nosql**)

</details>


Для организации корректной работы между несколькими базами данных в Django, потребовалось создать так называемый [маршрутизатор](rus_katalog/routers/db_routers.py). Это модуль с набором классов, которые перегружает методы для работы с базами данных **установленных приложений** (то есть, записанных в **INSTALLED_APP** в [настройках](rus_katalog/rus_katalog/settings.py)) внутри одного *проекта*. 

Определим подключения к базам данных: 

```python

DATABASES = {
    'default': {},

    'db_auth': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    },

    'db_web': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'products',
        'USER': 'postgres',
        'PASSWORD': '5432',
        'HOST': 'localhost',
        'PORT': '5432',
    },

    'db_delivery': {
        'ENGINE': 'mssql',
        'NAME': 'products',
        'HOST': "ACER-ASPIRE3",
        'PORT': '',
        #'COLLATION': 'Cyrillic_General_CI_AS',
        'OPTIONS': {
                'driver': 'ODBC Driver 17 for SQL Server'
                #'collation': 'Cyrillic_General_CI_AS',
        },
    }
```
Подключим наши приложения к проекту: 

```python

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'web',
    'delivery'
]

```

Укажем пути для маршуртизаторов:

```python
DATABASE_ROUTERS = ['routers.db_routers.AuthRouter',
'routers.db_routers.WebRouter', 
'routers.db_routers.DeliveryRouter']
```
где:
- routers - название модуля (директории) маршрутизатора
- db_routers - скрипт, что находится в модуле
- AuthRouter - название класса-маршрутизатора 

При определении маршрутизатора необходимо указать перечень приложений, доступ к которым он получает.

Чтобы основные процессы для взаимодействия с моделями в проекте Django работали корректно, необходимо определить **служебную базу данных**. В нашем случае это та база, что хранится в **SQLite3**.

Определим маршрутизатор служебной базы, указав в перечень приложений необходимые ему служебные: 

```python
class AuthRouter:
    """
    A router to control all database operations on models in the
    auth and contenttypes applications.
    """

    # ЭТА СТРОКА САМАЯ ВАЖНАЯ!!
    route_app_labels = {'auth', 'contenttypes', 'admin', 'sessions'}

    def db_for_read(self, model, **hints):
        if model._meta.app_label in self.route_app_labels:
            return 'db_auth'
        return None

    def db_for_write(self, model, **hints):
        # Определение внутри проекта

    def allow_relation(self, obj1, obj2, **hints):
        # Определение внутри проекта

    def allow_migrate(self, db, app_label, model_name=None, **hints):
        # Определение внутри проекта

```
где:
- route_app_labels - перечень приложений, к которым у маршрутизатора есть доступ. Для служебной таблицы нужны служебные приложения для работы с сессиями, админской панелью, аутификацией. Это приложения самого Django, они не реализованы пользавтелем

Для прочих таблиц, что используется в приложениях, реализованных пользователем, необходимо указать само приложение:

```python
class WebRouter:
    route_app_labels = {'web'}
    ...

```

После всего, что было выполнено выше, нужно внести изменения в служебные таблицы, указав их явно:

```bash
(venv).../rus_katalog$ python3 manage.py makemigrations 

(venv).../rus_katalog$ python3 manage.py migrate --database=db_auth
```

По имеющимся в проекте настройкам, если проект запущен в первый раз, и в первый раз выполняется миграция, в директории rus_katalog, где лежит файл [manage.py](rus_katalog/manage.py), будет создана база данных **db.sqlite3**, где будет храниться вся служебная информация о проекте django. Таблиц должно выйти 10 штук: 
- auth_group
- auth_group_permissions
- auth_permission
- auth_user
- auth_user_groups
- auth_user_user_permissions
- django_admin_log
- django_content_type
- django_migrations
- django_session    
  
Плюс еще одна таблица **sqlite_sequance** позднее, собирающая статистику об успешных миграциях