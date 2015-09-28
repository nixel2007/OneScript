﻿Перем юТест;

Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
	
	юТест = ЮнитТестирование;
	
	ВсеТесты = Новый Массив;
	
	ВсеТесты.Добавить("ТестДолжен_ПолучитьПутьКOscript");
	
	СИ = Новый СистемнаяИнформация;
	Если Найти(СИ.ВерсияОС, "Windows") > 0 Тогда
		ВсеТесты.Добавить("ТестДолжен_ПрочитатьВыводOscriptСразу");
		ВсеТесты.Добавить("ТестДолжен_ПрочитатьВыводOscriptПострочно");
		ВсеТесты.Добавить("ТестДолжен_ЗаписатьВоВходнойПотокПроцесса");
		ВсеТесты.Добавить("ТестДолжен_НайтиПроцессПоИмени");
		ВсеТесты.Добавить("ТестДолжен_НайтиПроцессПоPID");
		ВсеТесты.Добавить("ТестДолжен_ПроверитьЗапускСАргументамиСодержащимиПробелы");
	КонецЕсли;
	
	Возврат ВсеТесты;
	
КонецФункции

Процедура ТестДолжен_ПолучитьПутьКOscript() Экспорт
	
	Путь = Новый Файл(ПутьОСкрипт());
	
	юТест.ПроверитьИстину(Путь.Существует());
	
КонецПроцедуры

Процедура ТестДолжен_ПрочитатьВыводOscriptСразу() Экспорт
	
	Путь = ПутьОСкрипт();
	
	Процесс = СоздатьПроцесс("""" + Путь + """",,Истина);
	Процесс.Запустить();
	Поток = Процесс.ПотокВывода;
	
	Стр = НормализоватьПереводыСтрок(Поток.Прочитать());
	
	юТест.ПроверитьРавенство(ШтатныйВыводOscript(), Стр);
	
КонецПроцедуры

Процедура ТестДолжен_ПрочитатьВыводOscriptПострочно() Экспорт
	
	Путь = ПутьОСкрипт();
	
	Процесс = СоздатьПроцесс("""" + Путь + """",,Истина);
	Процесс.Запустить();
	Поток = Процесс.ПотокВывода;
	
	Стр = "";
	Пока Не Процесс.Завершен Цикл
		Пока Поток.ЕстьДанные Цикл
			Стр = Стр + Поток.ПрочитатьСтроку() + "
			|";
		КонецЦикла;
	КонецЦикла;
	
	юТест.ПроверитьРавенство(ШтатныйВыводOscript(), НормализоватьПереводыСтрок(Стр));
	
КонецПроцедуры

Процедура ТестДолжен_ЗаписатьВоВходнойПотокПроцесса() Экспорт

	Процесс = СоздатьПроцесс("sort",,Истина, Истина);
	Процесс.Запустить();
	
	Процесс.ПотокВвода.ЗаписатьСтроку("2");
	Процесс.ПотокВвода.ЗаписатьСтроку("1");
	Процесс.ПотокВвода.ЗаписатьСтроку("3");
	Процесс.ПотокВвода.Закрыть();
	
	Вывод = Процесс.ПотокВывода.Прочитать();
	
	Эталон = НормализоватьПереводыСтрок("1
			 |2
			 |3
			 |");
	
	юТест.ПроверитьРавенство(Эталон, НормализоватьПереводыСтрок(Вывод));

КонецПроцедуры

Процедура ТестДолжен_НайтиПроцессПоИмени() Экспорт
	
	МассивПроцессов = НайтиПроцессыПоИмени("oscript");
	юТест.ПроверитьБольшеИлиРавно(МассивПроцессов.Количество(), 1);
	
КонецПроцедуры

Процедура ТестДолжен_НайтиПроцессПоPID() Экспорт
	
	МассивПроцессов = НайтиПроцессыПоИмени("oscript");
	
	ИД = МассивПроцессов[0].Идентификатор;
	
	Процесс = НайтиПроцессПоИдентификатору(ИД);
	
	юТест.ПроверитьРавенство(Процесс.Идентификатор, ИД);
	
КонецПроцедуры

Функция ШтатныйВыводOscript()
	
	СИ = Новый СистемнаяИнформация;
	
	Текст = 
	"1Script Execution Engine. Version " + СИ.Версия + "
	|
	|Usage:
	|
	|I. Script execution: oscript.exe <script_path> [script arguments..]
	|
	|II. Special mode: oscript.exe <mode> <script_path> [script arguments..]
	|Mode can be one of these:
	|  -measure   measures execution time
	|  -compile   shows compiled module without execution
	|  -encoding=<encoding-name> set output encoding
	|
	|III. Build standalone executable: oscript.exe -make <script_path> <output_exe>
	|  Builds a standalone executable module based on script specified
	|
	|IV. Run as CGI application: oscript.exe -cgi <script_path> [script arguments..]
	|  Runs as CGI application under HTTP-server (Apache/Nginx/IIS/etc...)
	|";
	
	Возврат НормализоватьПереводыСтрок(Текст);
	
КонецФункции

Функция ПутьОСкрипт()
	Возврат КаталогПрограммы() + "/oscript.exe";
КонецФункции

Функция НормализоватьПереводыСтрок(Знач ИсходнаяСтрока)
	Возврат СтрЗаменить(ИсходнаяСтрока, Символы.ВК, "");
КонецФункции

Процедура ТестДолжен_ПроверитьЗапускСАргументамиСодержащимиПробелы() Экспорт
	
	ФайлЗапускаемогоСкрипта = ЗаписатьТестовыйСкрипт();
	ФайлВывода = ИмяФайлаВыводаТестовогоСкрипта();
	
	УдалитьФайлы(ФайлВывода);
	
	ПриложениеДляЗапуска = """" + КаталогПрограммы() + "/oscript.exe"""; //TODO: для Mono должно быть иначе
	ЗапуститьПриложение(ПриложениеДляЗапуска + " """ + ФайлЗапускаемогоСкрипта + """ """ + ФайлВывода + """ ""арг у мент1"" аргумент2", КаталогВременныхФайлов(), Истина);
	УдалитьФайлы(ФайлЗапускаемогоСкрипта);
	ФайлВыводаОбъект = Новый Файл(ФайлВывода);
	
	юТест.ПроверитьИстину(ФайлВыводаОбъект.Существует(), "должен был быть создан файл с результатами");
	
	ЧтениеТекста = Новый ЧтениеТекста(ФайлВывода, "utf-8");
	Данные = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть();
	УдалитьФайлы(ФайлВывода);
	юТест.ПроверитьРавенство(ФайлВывода 
			+ "," 
			+ "арг у мент1" + ","
			+ "аргумент2" + ","
			,Данные);
	
	
КонецПроцедуры

Функция ЗаписатьТестовыйСкрипт()
	
	ТекстСкрипта = "
	|Запись = Новый ЗаписьТекста(АргументыКоманднойСтроки[0], ""utf-8"");
	|Для Каждого Аргумент Из АргументыКоманднойСтроки Цикл
	|	Запись.Записать(Аргумент + "","");
	|КонецЦикла;
	|Запись.Закрыть();";
	
	ИмяФайла = КаталогВременныхФайлов() + "/" + СтрЗаменить(Строка(Новый УникальныйИдентификатор()), "-"," ");
	
	ЗаписьТекста = Новый ЗаписьТекста(ИмяФайла);
	ЗаписьТекста.Записать(ТекстСкрипта);
	ЗаписьТекста.Закрыть();
	
	Возврат ИмяФайла;
	
КонецФункции

Функция ИмяФайлаВыводаТестовогоСкрипта()
	Возврат юТест.ИмяВременногоФайла();
КонецФункции
