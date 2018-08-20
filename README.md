# Xrates - Sample

:warning: Тестовая версия библиотеки для конвертации валют разными драйверами. Не документирована, тесты не дописаны. Функционал нуждается в откатке. Данная версия не готова для продакшена

## Introduction

Библиотека для конвертации валют разными провайдерами.
Реализованы 2 провайдера для Cbr.ru `Xrates::Adapter::Cbr` и для Fixer.io `Xrates::Adapter::Fixer`.
Реализованы 2 метода парсинга данных от провайдеров.
В случае получения результатов в виде `json` от `Xrates::Adapter::Cbr` или `Xrates::Adapter::Fixer` будет использован парсер `Xrates::Parser::Json::Cbr` и `Xrates::Parser::Json::Fixer` соответсвенно,
в случае получения резульата в виде `xml` для `Xrates::Adapter::Cbr` написан парсер `Xrates::Parser::Sax::Cbr`


## Configuration

Каждый драйвер можно настраивать отдельно,
для этого нужно использовать соответсвующие классы конфигураций
`Xrates::Config::Fixer` и `Xrates::Config::Cbr`

``` ruby
  Xrates::Config::Fixer.configure do |config|
    config.access_key = 212
  end

  Xrates::Config::Cbr.new.access_key = "568ce8a8fe8bb805ab5b84e2ce2a47"
```

Доступны следующий аттрибуты для настроек:

- `:endpoint` урл для апи в виде "https://www.cbr.ru/scripts/xml_daily.asp"
- `:access_key` аттрибут необходим адаптеру `Xrates::Adapter::Fixer`, дефолтное значение заведено (сугубо для ознакомления с апи)
- `:parser` парсер каким парсить результаты от апи.
- `:cache` класс, с каким будет работать кэш, доступен файловый кэш и кэш редиса `Xrates::Cache::FileStore`, `Xrates::Cache::RedisStore`

Для конфигурации кэша нужно использовать соответсвующие конфиги `Xrates::Config::Storage::File` и `Xrates::Config::Storage::Redis`.
Аттрибуты доступные для конфигурации:

- `:folder` путь к директории для стора `Xrates::Config::Storage::File`
- `:endpoint` урл для редиса
- `:db` база для редиса
- `:ttl` экспирэйшн для ключа редиса
- `:pwd` пароль подключения

Настройки задаются точно так же как и для адаптеров
``` ruby
  Xrates::Config::Storage::Redis.configure do |config|
    config.endpoint = "redis-15531.c55.eu-central-1-1.ec2.cloud.redislabs.com:15531"
    config.db = "Xrates"
    config.ttl = 24*60*60
    config.pwd = "Ageoqv4sWNySDbkosD8jtQ5DfqJJF2Kf"
  end

  Xrates::Config::Storage::File.new.folder = "/tmp"
```



### Notes
  Для работы либы необходимы `gem "json"`, `gem "ox"`, `gem "redis"`



## Usage
  Для первоначального импорта в кэш можно использовать метод `#import` обьекта класса `Xrates::Driver` , но это не обязательно потому как при работе с конвертацией идет проверка на получение кэша и если кэш не был засечен то либа произведет сохранение автоматически

``` ruby
driver = Xrates::Driver.new
driver << Xrates::Adapter::Cbr.new
driver << Xrates::Adapter::Fixer.new
driver.import
```
 Для работы по конвертации достаточно создать обьект класса `Xrates::Currency` передав ему значение, валюту, драйвер

 ``` ruby
Xrates::Currency.new(1000, "EUR", Xrates::Adapter::Cbr.new)
Xrates::Currency.new(1000, "EUR", Xrates::Adapter::Fixer.new)
```

Чтоб произвести конвертацию в конкретную валюту или в набор валют нужно использовать метод `#convert_to` и `#convert_list` соответственно. Возвращенное значение будет либо новым обьектом класса `Xrates::Currency` либо массивом обьектов этого класса

 ``` ruby
#
# Дефолтное значение round == 2
# Также необходимо доработать передачу направления (ceil, floor, возможно лямбдой)
#

cbr = Xrates::Adapter::Cbr.new
fixer = Xrates::Adapter::Fixer.new
round = 3

Xrates::Currency.new(1000, "EUR", cbr).convert_to("RUB", round)
Xrates::Currency.new(1000, "EUR", fixer).convert_to("USD")
```

Доступны также операции с валютами (`+`,`-`,`*`,`\/`), в будущем конечно необходимо добавить больше операций. Операции можно проводить как в рамках 1 драйвера так и в рамках разных. В таком случае значение второго члена арифметической операции будет приведено к курсу от драйвера первого члена.

 ``` ruby

cbr = Xrates::Adapter::Cbr.new
fixer = Xrates::Adapter::Fixer.new

Xrates::Currency.new(1000, "EUR", cbr) + Xrates::Currency.new(100, "USD", fixer)
```
