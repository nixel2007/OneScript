﻿Перем юТест;

Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
	
	юТест = ЮнитТестирование;
	СИ = Новый СистемнаяИнформация;
	
	ВсеТесты = Новый Массив;
	
	ВсеТесты.Добавить("ТестДолжен_ПроверитьЧтениеПострочно");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьЧтениеСОграничениемРазмераСтроки");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьЧтениеСНеобычнымРазделителем1");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьЧтениеСНеобычнымРазделителем2");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьЧтениеСНеобычнымРазделителем3");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьЧтениеПоУмолчаниюПриРазныхРазделителях");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьСовместимостьПоведения");
	
	Возврат ВсеТесты;
	
КонецФункции

Функция ЭкранироватьПереводыСтрок(Знач Строка)

	Возврат СтрЗаменить(СтрЗаменить(Строка, Символы.ПС, "\n"), Символы.ВК, "\r");

КонецФункции

Процедура ТестДолжен_ПроверитьЧтениеПострочно() Экспорт

	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("txt");

	З = Новый ЗаписьТекста(ИмяВременногоФайла);
	З.ЗаписатьСтроку("1");
	З.ЗаписатьСтроку("2");
	З.ЗаписатьСтроку("3");

	З.Закрыть();

	Ч = Новый ЧтениеТекста(ИмяВременногоФайла);
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "1", "Чтение строк");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "2", "Чтение строк");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "3", "Чтение строк");
	юТест.ПроверитьРавенство(Ч.ПрочитатьСтроку(), Неопределено, "Чтение строк");
	юТест.ПроверитьРавенство(Ч.ПрочитатьСтроку(), Неопределено, "Чтение строк");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтениеСОграничениемРазмераСтроки() Экспорт

	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("txt");

	З = Новый ЗаписьТекста(ИмяВременногоФайла);
	З.ЗаписатьСтроку("01234567890123456789"); // 20 символов
	З.ЗаписатьСтроку("01234567890123456789"); // 20 символов

	З.Закрыть();

	Ч = Новый ЧтениеТекста(ИмяВременногоФайла);
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.Прочитать(10)), "0123456789", "Чтение посимвольно");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.Прочитать(8)),  "01234567", "Чтение посимвольно");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.Прочитать(10)), ЭкранироватьПереводыСтрок("89
			|0123456"), "Чтение строк с переводом"
	);

	Ч.Прочитать(); // Читаем до конца файла

	юТест.ПроверитьРавенство(Ч.Прочитать(), Неопределено, "Чтение после конца файла");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтениеСНеобычнымРазделителем1() Экспорт

	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("txt");

	З = Новый ЗаписьТекста(ИмяВременногоФайла);
	З.ЗаписатьСтроку("123");
	З.ЗаписатьСтроку("123
		|45/6
		|789");

	З.Закрыть();

	Ч = Новый ЧтениеТекста(ИмяВременногоФайла,,,"/");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "123");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "123");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "45");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "6");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "789");
	юТест.ПроверитьРавенство(Ч.Прочитать(), Неопределено, "Чтение после конца файла");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтениеСНеобычнымРазделителем2() Экспорт

	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("txt");

	З = Новый ЗаписьТекста(ИмяВременногоФайла);
	З.ЗаписатьСтроку("123");
	З.ЗаписатьСтроку("1-2-3
		|45/6
		|789");

	З.Закрыть();

	Ч = Новый ЧтениеТекста(ИмяВременногоФайла,,"-","/");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "123\r\n1");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "2");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "3\r\n45\n6\r\n789\r\n");
	юТест.ПроверитьРавенство(Ч.Прочитать(), Неопределено, "Чтение после конца файла");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтениеСНеобычнымРазделителем3() Экспорт

	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("txt");

	З = Новый ЗаписьТекста(ИмяВременногоФайла);
	З.ЗаписатьСтроку("123");
	З.ЗаписатьСтроку("1-2-3
		|45/6
		|789");

	З.Закрыть();

	Ч = Новый ЧтениеТекста(ИмяВременногоФайла,,"-","/");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.Прочитать()), "123\r\n1-2-3\r\n45\n6\r\n789\r\n", "Чтение с необычными разделителями файла целиком");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьСовместимостьПоведения() Экспорт

	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("txt");

	З = Новый ЗаписьТекста(ИмяВременногоФайла);
	З.Записать("123123123" + Символы.ВК + "
		|45/645/645/6" + Символы.ВК + "
		|789789789");

	З.Закрыть();

	// В конструкторе не указываем конвертируемый перевод строк
	Ч = Новый ЧтениеТекста(ИмяВременногоФайла);
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "123123123\r", "\r в конце строки (через конструктор без параметров по-умолчанию)");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "45/645/645/6\r", "\r в конце строки (через конструктор без параметров по-умолчанию)");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "789789789");

	Ч.Закрыть();

	// В конструкторе указываем конвертируемый перевод строк "по-умолчанию"
	Ч = Новый ЧтениеТекста(ИмяВременногоФайла,,,);
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "123123123", "Нет \r в конце строки (через конструктор с параметрами по-умолчанию)");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "", "Пустая строка вместо \r (через конструктор с параметрами по-умолчанию)");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "45/645/645/6", "Нет \r в конце строки (через конструктор с параметрами по-умолчанию)");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "", "Пустая строка вместо \r (через конструктор с параметрами по-умолчанию)");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "789789789");

	Ч.Закрыть();

	// Используем конструктор по-умолчанию и открытие без указания конвертируемого перевода строк
	Ч = Новый ЧтениеТекста;
	Ч.Открыть(ИмяВременногоФайла);
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "123123123\r", "\r в конце строки (через открытие без параметров по-умолчанию)");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "45/645/645/6\r", "\r в конце строки (через открытие без параметров по-умолчанию)");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "789789789");

	Ч.Закрыть();

	// Используем конструктор по-умолчанию и открытие с указанием конвертируемого перевода строк "по-умолчанию"
	Ч = Новый ЧтениеТекста;
	Ч.Открыть(ИмяВременногоФайла,,,);
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "123123123\r", "\r в конце строки (через открытие с параметрами по-умолчанию)");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "45/645/645/6\r", "\r в конце строки (через открытие с параметрами по-умолчанию)");
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), "789789789");

	Ч.Закрыть();

КонецПроцедуры

Процедура ЗаписатьСтрокуТекстаИСравнить(Знач Разделитель, Знач Текст)

	// Запись с указанным разделителем
	ИмяФайла = ПолучитьИмяВременногоФайла("txt");
	З = Новый ЗаписьТекста(ИмяФайла,,,, Разделитель);
	З.Записать(Текст);
	З.Закрыть();

	// Чтение по-умолчанию
	Ч = Новый ЧтениеТекста(ИмяФайла);
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.Прочитать()), ЭкранироватьПереводыСтрок(Текст), "Равенство при записи с " + ЭкранироватьПереводыСтрок(Разделитель));

КонецПроцедуры

Процедура ЗаписатьСтрокуТекстаИСравнитьПострочно(Знач Разделитель, Знач Строка1, Знач Строка2, Знач Строка3)

	// Запись с указанным разделителем
	ИмяФайла = ПолучитьИмяВременногоФайла("txt");
	З = Новый ЗаписьТекста(ИмяФайла,,,, Разделитель);
	З.ЗаписатьСтроку(Строка1);
	З.ЗаписатьСтроку(Строка2);
	З.ЗаписатьСтроку(Строка3);
	З.Закрыть();

	// Чтение по-умолчанию
	Ч = Новый ЧтениеТекста(ИмяФайла);
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), ЭкранироватьПереводыСтрок(Строка1), "Равенство при записи с " + ЭкранироватьПереводыСтрок(Разделитель));
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), ЭкранироватьПереводыСтрок(Строка2), "Равенство при записи с " + ЭкранироватьПереводыСтрок(Разделитель));
	юТест.ПроверитьРавенство(ЭкранироватьПереводыСтрок(Ч.ПрочитатьСтроку()), ЭкранироватьПереводыСтрок(Строка3), "Равенство при записи с " + ЭкранироватьПереводыСтрок(Разделитель));
	юТест.ПроверитьРавенство(Ч.ПрочитатьСтроку(), Неопределено, "Равенство при записи с " + ЭкранироватьПереводыСтрок(Разделитель));

КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтениеПоУмолчаниюПриРазныхРазделителях() Экспорт

	Текст = "1
		|2
		|3"
	;

	ЗаписатьСтрокуТекстаИСравнить(Символы.ПС, Текст);
	ЗаписатьСтрокуТекстаИСравнить(Символы.ВК + Символы.ПС, Текст);
	// ЗаписатьСтрокуТекстаИСравнить(Символы.ВК, Текст); // с ВК заведомо не сработает - такова 1С

	ЗаписатьСтрокуТекстаИСравнитьПострочно(Символы.ПС, "1", "2", "3");
	ЗаписатьСтрокуТекстаИСравнитьПострочно(Символы.ВК + Символы.ПС, "1", "2", "3");

КонецПроцедуры
