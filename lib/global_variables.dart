import 'day.dart';

/*
  Ты используешь глобальные переменные как некоторое хранилище данных - так не стоит делать,
  во первых попробуй написать unit-тесты на какие-то логические свои функции из виджетов в отрыве
  от этих переменных
  Во вторых - ты теряешь контроль над тем, что происходит с этими переменными:
  - вас на проекте 5 человек, один из вас решил, что тоже что-то можно сюда запихать, запихал - твоя логика сломалась
  Раз появляются переменные, в которых ты что-то хранишь - это уже некое состояние, так сделай конкретное состояние, state,
  который и будешь использовать (не обязательно MobX, можно что угодно, хоть простой класс, который ты будешь прокидывать
  в свой виджет)
 */
List<Day> date = [];

Map<int, DateTime> indexDay = {};
