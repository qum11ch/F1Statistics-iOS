# F1Statistics iOS

F1Statistics iOS — учебное клиент-серверное приложение для отображения данных о Формуле-1. Проект разработан в рамках курсовой работы по дисциплине «iOS-разработка» на тему «Исследование современных подходов и паттернов при разработке клиент-серверных мобильных приложений».

## Описание проекта

Приложение позволяет просматривать список гонок сезона, подробную информацию о гонке, таблицу личного зачёта пилотов и подробную информацию о выбранном пилоте.

Проект реализован с использованием архитектурного паттерна MVVM. Пользовательский интерфейс построен на UIKit и Storyboard. Для получения данных о гонках и личном зачёте используется Jolpica F1 API. Дополнительная информация о пилотах хранится в Firebase Realtime Database, а изображения трасс и пилотов загружаются из Firebase Storage.

## Основная функциональность

* получение списка гонок из Jolpica F1 API;
* отображение гонок в виде таблицы;
* переход на экран подробной информации о гонке;
* загрузка изображения трассы из Firebase Storage;
* получение таблицы личного зачёта пилотов из Jolpica F1 API;
* отображение списка пилотов;
* переход на экран подробной информации о пилоте;
* получение дополнительной информации о пилоте из Firebase Realtime Database;
* загрузка изображения пилота из Firebase Storage;
* обработка состояний loading, success, empty и error.

## Используемые технологии

* Swift;
* UIKit;
* Storyboard;
* MVVM;
* URLSession;
* async/await;
* Codable;
* Firebase Realtime Database;
* Firebase Storage;
* Kingfisher;
* Swift Package Manager.

## Структура проекта

```text
F1Statistics
├── Models
├── Services
│   ├── API
│   ├── Firebase
│   └── Network
├── ViewModels
├── Views
│   ├── Drivers
│   ├── Races
│   └── Standings
├── AppDelegate.swift
├── SceneDelegate.swift
├── Main.storyboard
├── LaunchScreen.storyboard
└── Info.plist
```

## Источники данных

### Jolpica F1 API

Используется для получения:

* списка гонок;
* таблицы личного зачёта пилотов.

Примеры endpoint:

```text
https://api.jolpi.ca/ergast/f1/2024/races.json
https://api.jolpi.ca/ergast/f1/2026/driverstandings.json
```

### Firebase Realtime Database

Используется для хранения расширенной информации о пилотах.

Пример структуры данных:

```json
{
  "drivers": {
    "Alex Albon": {
      "driverName": "Alex Albon",
      "driversCode": "ALB",
      "driversTeam": "Williams",
      "permanentNumber": "23",
      "championshipsCount": "0",
      "totalWins": "0",
      "totalPodiums": "2",
      "totalPoints": "240",
      "polesCount": "0",
      "firstEntry": "2019 Australian Grand Prix",
      "lastEntry": "2026 Abu Dhabi Grand Prix"
    }
  }
}
```

### Firebase Storage

Используется для хранения изображений трасс и пилотов.

Пример структуры:

```text
circuits/
    monza.jpg
    silverstone.jpg

drivers/
    ham_2026.jpg
    ver_2026.jpg
```

## Настройка и запуск проекта

1. Клонировать репозиторий:

```bash
git clone https://github.com/qum11ch/F1Statistics-iOS.git
```

2. Открыть проект в Xcode:

```text
F1Statistics.xcodeproj
```

3. Установить зависимости Swift Package Manager.

При открытии проекта Xcode автоматически загрузит зависимости. Если этого не произошло, необходимо выполнить:

```text
File → Packages → Resolve Package Versions
```

4. Создать проект Firebase или использовать существующий.

Для полной работы приложения необходимо подключить Firebase-проект с Realtime Database и Storage.

5. Скачать файл конфигурации Firebase:

```text
GoogleService-Info.plist
```

Файл можно скачать в Firebase Console в настройках iOS-приложения.

6. Добавить `GoogleService-Info.plist` в Xcode-проект.

Файл необходимо добавить в корень проекта и убедиться, что включён Target Membership для target приложения.

7. Настроить Firebase Realtime Database.

В базе данных должен быть узел:

```text
drivers
```

Ключ пилота должен соответствовать формату:

```text
Name Surname
```

Например:

```text
Alex Albon
Lewis Hamilton
Andrea Kimi Antonelli
```

8. Настроить Firebase Storage.

Изображения трасс должны храниться по пути:

```text
circuits/{circuitId}.jpg
```

Изображения пилотов должны храниться по пути:

```text
drivers/{driverCode}_{season}.jpg
```

Пример:

```text
drivers/ham_2026.jpg
```

9. Запустить проект в Xcode на симуляторе или физическом устройстве.

## Важное замечание

Файл `GoogleService-Info.plist` не включён в репозиторий, так как он относится к конфигурации Firebase-проекта. Для запуска приложения необходимо добавить собственный файл конфигурации Firebase.

Если Firebase Realtime Database или Firebase Storage не настроены, приложение сможет получать данные из Jolpica API, но экраны, использующие Firebase, могут отображать ошибку загрузки дополнительных данных или изображений.

## Автор

Никита Шарапатов
